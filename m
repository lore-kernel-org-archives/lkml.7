Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC09C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0A2206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfJKMi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:38:56 -0400
Received: from david.siemens.de ([192.35.17.14]:60674 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfJKMi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:38:56 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x9BCclJW017188
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 14:38:48 +0200
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x9BCcleW014598;
        Fri, 11 Oct 2019 14:38:47 +0200
Subject: Re: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is
 set
To:     Joel Colledge <joel.colledge@linbit.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org
References: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20191011122409.23868-1-joel.colledge@linbit.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c4ae19a8-54c0-98a6-16bd-48f7ce5689f9@siemens.com>
Date:   Fri, 11 Oct 2019 14:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011122409.23868-1-joel.colledge@linbit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.19 14:24, Joel Colledge wrote:
> When CONFIG_PRINTK_CALLER is set, struct printk_log contains an
> additional member caller_id. This affects the offset of the log text.
> Account for this by using the type information from gdb to determine all
> the offsets instead of using hardcoded values.
> 
> This fixes following error:
> 
>    (gdb) lx-dmesg
>    Python Exception <class 'ValueError'> embedded null character:
>    Error occurred in Python command: embedded null character
> 
> Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
> ---
> Changes in v2:
> - use type information from gdb instead of hardcoded offsets
> 
> Thanks for the idea about using the struct layout info from gdb, Leonard. I can't see any reason we shouldn't use that here, since most of the other commands use it. LxDmesg has used hardcoded offsets since scripts/gdb was introduced, so I assume it just ended up like that during the initial development of the tool. Here is a version of the fix using offsets from gdb.

That's not unlikely, indeed. lx-dmesg was one of the very first features 
I've implemented back then, and it definitely predated things like 
CachedType.

> 
>   scripts/gdb/linux/dmesg.py | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
> index 6d2e09a2ad2f..8f5d899029b7 100644
> --- a/scripts/gdb/linux/dmesg.py
> +++ b/scripts/gdb/linux/dmesg.py
> @@ -16,6 +16,8 @@ import sys
>   
>   from linux import utils
>   
> +printk_log_type = utils.CachedType("struct printk_log")
> +
>   
>   class LxDmesg(gdb.Command):
>       """Print Linux kernel log buffer."""
> @@ -42,9 +44,14 @@ class LxDmesg(gdb.Command):
>               b = utils.read_memoryview(inf, log_buf_addr, log_next_idx)
>               log_buf = a.tobytes() + b.tobytes()
>   
> +        length_offset = printk_log_type.get_type()['len'].bitpos // 8

Does bitpos really use a non-int type? Otherwise, plain '/' suffices.

> +        text_len_offset = printk_log_type.get_type()['text_len'].bitpos // 8
> +        time_stamp_offset = printk_log_type.get_type()['ts_nsec'].bitpos // 8
> +        text_offset = printk_log_type.get_type().sizeof
> +
>           pos = 0
>           while pos < log_buf.__len__():
> -            length = utils.read_u16(log_buf[pos + 8:pos + 10])
> +            length = utils.read_u16(log_buf[pos + length_offset:pos + length_offset + 2])

Overlong line.

>               if length == 0:
>                   if log_buf_2nd_half == -1:
>                       gdb.write("Corrupted log buffer!\n")
> @@ -52,10 +59,11 @@ class LxDmesg(gdb.Command):
>                   pos = log_buf_2nd_half
>                   continue
>   
> -            text_len = utils.read_u16(log_buf[pos + 10:pos + 12])
> -            text = log_buf[pos + 16:pos + 16 + text_len].decode(
> +            text_len = utils.read_u16(log_buf[pos + text_len_offset:pos + text_len_offset + 2])

Here as well. Better use some temp vars to break up the expressions. 
Helps with readability.

> +            text = log_buf[pos + text_offset:pos + text_offset + text_len].decode(
>                   encoding='utf8', errors='replace')
> -            time_stamp = utils.read_u64(log_buf[pos:pos + 8])
> +            time_stamp = utils.read_u64(
> +                log_buf[pos + time_stamp_offset:pos + time_stamp_offset + 8])
>   
>               for line in text.splitlines():
>                   msg = u"[{time:12.6f}] {line}\n".format(
> 

Looks good otherwise.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
