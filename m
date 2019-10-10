Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B4A206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfJJPOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:14:04 -0400
Received: from goliath.siemens.de ([192.35.17.28]:46516 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:14:03 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x9AFDvdJ011240
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 17:13:57 +0200
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x9AFDuI1025064;
        Thu, 10 Oct 2019 17:13:56 +0200
Subject: Re: [PATCH] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is
 set
To:     Joel Colledge <joel.colledge@linbit.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20190925150308.6609-1-joel.colledge@linbit.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a87e01b0-73f1-8a86-d7c0-2700e1032b92@siemens.com>
Date:   Thu, 10 Oct 2019 17:13:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190925150308.6609-1-joel.colledge@linbit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.19 17:03, Joel Colledge wrote:
> When CONFIG_PRINTK_CALLER is set, struct printk_log contains an
> additional member caller_id. As a result, the offset of the log text is
> different.
> 
> This fixes the following error:
> 
>   (gdb) lx-dmesg
>   Python Exception <class 'ValueError'> embedded null character:
>   Error occurred in Python command: embedded null character
> 
> Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
> ---
>  scripts/gdb/linux/constants.py.in | 1 +
>  scripts/gdb/linux/dmesg.py        | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
> index 2efbec6b6b8d..3c9794a0bf55 100644
> --- a/scripts/gdb/linux/constants.py.in
> +++ b/scripts/gdb/linux/constants.py.in
> @@ -74,4 +74,5 @@ LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
>  LX_CONFIG(CONFIG_HIGH_RES_TIMERS)
>  LX_CONFIG(CONFIG_NR_CPUS)
>  LX_CONFIG(CONFIG_OF)
> +LX_CONFIG(CONFIG_PRINTK_CALLER)
>  LX_CONFIG(CONFIG_TICK_ONESHOT)
> diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
> index 6d2e09a2ad2f..1352680ef731 100644
> --- a/scripts/gdb/linux/dmesg.py
> +++ b/scripts/gdb/linux/dmesg.py
> @@ -14,6 +14,7 @@
>  import gdb
>  import sys
>  
> +from linux import constants
>  from linux import utils
>  
>  
> @@ -53,7 +54,8 @@ class LxDmesg(gdb.Command):
>                  continue
>  
>              text_len = utils.read_u16(log_buf[pos + 10:pos + 12])
> -            text = log_buf[pos + 16:pos + 16 + text_len].decode(
> +            text_start = pos + (20 if constants.LX_CONFIG_PRINTK_CALLER else 16)
> +            text = log_buf[text_start:text_start + text_len].decode(
>                  encoding='utf8', errors='replace')
>              time_stamp = utils.read_u64(log_buf[pos:pos + 8])
>  
> 

Sorry for the delay:

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

I suspect we will see more in nearer future with upcoming printk rework...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
