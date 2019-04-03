Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDE8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96742054F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="KxpPi1pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfDCPkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:40:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36986 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDCPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:40:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so1558917edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1xMR/9Q0C8jWgb9kRzNsWH0J1NPSEpIL8blMn3oqwk8=;
        b=KxpPi1pK30yZaxIVjdQNzQAahgl5uzap4gjNzH+aI4Wl8auIi+s5hXbThhxt957j28
         vAZmC9VH8yyIQCgUKJ1KuOQ0sbCzbddJhh9Td0XKg32uKF7YeJm0AiJ33z/On+sE/uXM
         yXKEn4Ojv8fA6kPNnBR0HrTwoWlZ1x9YGmEaDwa6SJEpMUhXbZom4CyCgA48cq/q5C42
         ht5Yw9VXXg26VPwv4O5euqEECZ4iam1Jo+xi2C3KBM7eMbCc9SekdL+nj0SvkNE4aHYh
         S9BaTBwHNyoff7eqxgcTPAiUnCaeSeygmq9iQ3cvMxDIRPIm9Z8ZorAzbXGZudfjr+pW
         y/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1xMR/9Q0C8jWgb9kRzNsWH0J1NPSEpIL8blMn3oqwk8=;
        b=OT5TJ+8FKqzNg2Xj5CPCOJIWehVmwo+YPUsQK+Zb9lzgVk0ZrK8CkUDolDyco4G4mV
         yd66oReoOAoRDyBH1Pw8SglvkG1ZzyCiz79M/TxJFIR1ite4hBLenMWZdlcOCz/22HQb
         IDATlgSHGqmRtelE/vHB5qditQFpMxWmOuh2ifGye8C9ZLhCypwb5LYxOs+Cws/PHLBi
         8MEnTDE1MXo01rG1+yVQjflwBDErfwXeLYnZMPO/PC8fdp2i0rZqTSE9eIa8x89sybIL
         exDbel4lG79j4pL4zf0pKCVgmQPYRZQJVeI8zEoq8q5/CpHFv7MOp1TVrMhUbAm8Cw8T
         QN4g==
X-Gm-Message-State: APjAAAVTohA3KUSEogTZ4ET1VkCoNvSuLSvtOLdZ8SOMxeAg7/gW8kO1
        65QSbaXTsR6enJAKFxKO2Yk/dg==
X-Google-Smtp-Source: APXvYqyvdKYMzX69m0UTINpmERjdmoOdpILM6D8fz/KvrO15/hnSrtdAi9GgoXTcAJDbYLW/im59aQ==
X-Received: by 2002:a50:9745:: with SMTP id d5mr231074edb.66.1554306046710;
        Wed, 03 Apr 2019 08:40:46 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id l18sm4205871edc.17.2019.04.03.08.40.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Apr 2019 08:40:46 -0700 (PDT)
Date:   Wed, 3 Apr 2019 17:40:45 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, croce@redhat.com
Subject: Re: [PATCH] kernel/sysctl.c: Fix out-of-bounds access when setting
 file-max
Message-ID: <20190403154044.qejdbl7i2ny37jef@brauner.io>
References: <20190403153409.17307-1-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403153409.17307-1-will.deacon@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:34:09PM +0100, Will Deacon wrote:
> Commit 32a5ad9c2285 ("sysctl: handle overflow for file-max") hooked
> up min/max values for the file-max sysctl parameter via the .extra1
> and .extra2 fields in the corresponding struct ctl_table entry.
> 
> Unfortunately, the minimum value points at the global 'zero' variable,
> which is an int. This results in a KASAN splat when accessed as a long
> by proc_doulongvec_minmax on 64-bit architectures:
> 
>   | BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x5d8/0x6a0
>   | Read of size 8 at addr ffff2000133d1c20 by task systemd/1
>   |
>   | CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc3-00012-g40b114779944 #2
>   | Hardware name: linux,dummy-virt (DT)
>   | Call trace:
>   |  dump_backtrace+0x0/0x228
>   |  show_stack+0x14/0x20
>   |  dump_stack+0xe8/0x124
>   |  print_address_description+0x60/0x258
>   |  kasan_report+0x140/0x1a0
>   |  __asan_report_load8_noabort+0x18/0x20
>   |  __do_proc_doulongvec_minmax+0x5d8/0x6a0
>   |  proc_doulongvec_minmax+0x4c/0x78
>   |  proc_sys_call_handler.isra.19+0x144/0x1d8
>   |  proc_sys_write+0x34/0x58
>   |  __vfs_write+0x54/0xe8
>   |  vfs_write+0x124/0x3c0
>   |  ksys_write+0xbc/0x168
>   |  __arm64_sys_write+0x68/0x98
>   |  el0_svc_common+0x100/0x258
>   |  el0_svc_handler+0x48/0xc0
>   |  el0_svc+0x8/0xc
>   |
>   | The buggy address belongs to the variable:
>   |  zero+0x0/0x40
>   |
>   | Memory state around the buggy address:
>   |  ffff2000133d1b00: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
>   |  ffff2000133d1b80: fa fa fa fa 04 fa fa fa fa fa fa fa 04 fa fa fa
>   | >ffff2000133d1c00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
>   |                                ^
>   |  ffff2000133d1c80: fa fa fa fa 00 fa fa fa fa fa fa fa 00 00 00 00
>   |  ffff2000133d1d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Fix the splat by introducing a unsigned long 'zero_ul' and using that
> instead.
> 
> Fixes: 32a5ad9c2285 ("sysctl: handle overflow for file-max")
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Hey Will, thanks! For the record, there's another patch by Matteo (Cced)
for the same thing:
https://lore.kernel.org/lkml/20190328130306.25384-1-mcroce@redhat.com/

He's proposing a slightly different version for the fix. I don't care
very much but I like that you've used the explicit unsigned long so:

Acked-by: Christian Brauner <christian@brauner.io>

Thanks to both of you for fixing this!

> ---
>  kernel/sysctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e5da394d1ca3..c9ec050bcf46 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -128,6 +128,7 @@ static int zero;
>  static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
> +static unsigned long zero_ul;
>  static unsigned long one_ul = 1;
>  static unsigned long long_max = LONG_MAX;
>  static int one_hundred = 100;
> @@ -1750,7 +1751,7 @@ static struct ctl_table fs_table[] = {
>  		.maxlen		= sizeof(files_stat.max_files),
>  		.mode		= 0644,
>  		.proc_handler	= proc_doulongvec_minmax,
> -		.extra1		= &zero,
> +		.extra1		= &zero_ul,
>  		.extra2		= &long_max,
>  	},
>  	{
> -- 
> 2.11.0
> 
