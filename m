Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9FECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E87E206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfJKPly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:41:54 -0400
Received: from goliath.siemens.de ([192.35.17.28]:33725 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJKPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:41:54 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x9BFfkNj031898
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 17:41:47 +0200
Received: from [139.25.68.37] ([139.25.68.37])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x9BFfkjS028759;
        Fri, 11 Oct 2019 17:41:46 +0200
Subject: Re: [PATCH v3] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is
 set
To:     Joel Colledge <joel.colledge@linbit.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
References: <CAGNP_+U-5bUysiwLN9fL0+d__GKOc_5Ak9MDKi6EeeSzPCK-Lw@mail.gmail.com>
 <20191011142500.2339-1-joel.colledge@linbit.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <040babb5-e2fc-6a0f-50c0-2af5aafd0855@siemens.com>
Date:   Fri, 11 Oct 2019 17:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011142500.2339-1-joel.colledge@linbit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.19 16:25, Joel Colledge wrote:
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
> The read_u* utility functions now take an offset argument to make them
> easier to use.
> 
> Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
> ---
> Changes in v3:
> - fix some overlong lines and generally make the code more readable by
>    pushing the slicing down into the read_u* helper functions
> 
> In general, I would consider slicing to be more "pythonic" than passing
> around offsets. However, in this case we always want to slice with
> (offset, length), rather than (start, end), so the normal slicing syntax
> is not very helpful. Rather than writing [a:a+b] everywhere I just
> decided to pass the whole buffer and an offset to the read_u* helpers.

Agreed.

> 
>   scripts/gdb/linux/dmesg.py | 16 ++++++++++++----
>   scripts/gdb/linux/utils.py | 25 +++++++++++++------------
>   2 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
> index 6d2e09a2ad2f..2fa7bb83885f 100644
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
> +        text_len_offset = printk_log_type.get_type()['text_len'].bitpos // 8
> +        time_stamp_offset = printk_log_type.get_type()['ts_nsec'].bitpos // 8
> +        text_offset = printk_log_type.get_type().sizeof
> +
>           pos = 0
>           while pos < log_buf.__len__():
> -            length = utils.read_u16(log_buf[pos + 8:pos + 10])
> +            length = utils.read_u16(log_buf, pos + length_offset)
>               if length == 0:
>                   if log_buf_2nd_half == -1:
>                       gdb.write("Corrupted log buffer!\n")
> @@ -52,10 +59,11 @@ class LxDmesg(gdb.Command):
>                   pos = log_buf_2nd_half
>                   continue
>   
> -            text_len = utils.read_u16(log_buf[pos + 10:pos + 12])
> -            text = log_buf[pos + 16:pos + 16 + text_len].decode(
> +            text_len = utils.read_u16(log_buf, pos + text_len_offset)
> +            text_start = pos + text_offset
> +            text = log_buf[text_start:text_start + text_len].decode(
>                   encoding='utf8', errors='replace')
> -            time_stamp = utils.read_u64(log_buf[pos:pos + 8])
> +            time_stamp = utils.read_u64(log_buf, pos + time_stamp_offset)
>   
>               for line in text.splitlines():
>                   msg = u"[{time:12.6f}] {line}\n".format(
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index bc67126118c4..ea94221dbd39 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -92,15 +92,16 @@ def read_memoryview(inf, start, length):
>       return memoryview(inf.read_memory(start, length))
>   
>   
> -def read_u16(buffer):
> +def read_u16(buffer, offset):
> +    buffer_val = buffer[offset:offset + 2]
>       value = [0, 0]
>   
> -    if type(buffer[0]) is str:
> -        value[0] = ord(buffer[0])
> -        value[1] = ord(buffer[1])
> +    if type(buffer_val[0]) is str:
> +        value[0] = ord(buffer_val[0])
> +        value[1] = ord(buffer_val[1])
>       else:
> -        value[0] = buffer[0]
> -        value[1] = buffer[1]
> +        value[0] = buffer_val[0]
> +        value[1] = buffer_val[1]
>   
>       if get_target_endianness() == LITTLE_ENDIAN:
>           return value[0] + (value[1] << 8)
> @@ -108,18 +109,18 @@ def read_u16(buffer):
>           return value[1] + (value[0] << 8)
>   
>   
> -def read_u32(buffer):
> +def read_u32(buffer, offset):
>       if get_target_endianness() == LITTLE_ENDIAN:
> -        return read_u16(buffer[0:2]) + (read_u16(buffer[2:4]) << 16)
> +        return read_u16(buffer, offset) + (read_u16(buffer, offset + 2) << 16)
>       else:
> -        return read_u16(buffer[2:4]) + (read_u16(buffer[0:2]) << 16)
> +        return read_u16(buffer, offset + 2) + (read_u16(buffer, offset) << 16)
>   
>   
> -def read_u64(buffer):
> +def read_u64(buffer, offset):
>       if get_target_endianness() == LITTLE_ENDIAN:
> -        return read_u32(buffer[0:4]) + (read_u32(buffer[4:8]) << 32)
> +        return read_u32(buffer, offset) + (read_u32(buffer, offset + 4) << 32)
>       else:
> -        return read_u32(buffer[4:8]) + (read_u32(buffer[0:4]) << 32)
> +        return read_u32(buffer, offset + 4) + (read_u32(buffer, offset) << 32)
>   
>   
>   target_arch = None
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
