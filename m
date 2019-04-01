Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9295420883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V8oBUCxg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="on4H3o5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfDALuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:50:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDALun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:50:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3012E6079C; Mon,  1 Apr 2019 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554119442;
        bh=Vjf6/KLvheOeJz9OENVZEJZ087lv2QKLj6okpgSAQ84=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V8oBUCxg0gpZj9vqnLRJMTmPS7Ner82nP6bCgFjrT2wlVIu32dJyWHPb7Q22OT14+
         R+z0WrgQBk68tIOV94RMHixf4N7T0+Zf0g1J3WwgpU89YZMGEx+v/VwZxeMUwQ1Io5
         B5uR8BbpjYoMxKa/XvuIk8EjslIrte+KWdAEGODU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3F8B602AE;
        Mon,  1 Apr 2019 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554119440;
        bh=Vjf6/KLvheOeJz9OENVZEJZ087lv2QKLj6okpgSAQ84=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=on4H3o5v+mLLNYQQCN1vsbP17IAqx1AfXdn/7+/d2ii8yHkRVKt9zlF6FubkimsoO
         qLERElmBShAcPXWXGhdWMg0SLo7jZSxZo6WKconanoEYFd9owLI36Gtfh+I0GgVBaU
         Dw5tdLLuqFDvOG0iD/SAvW/X/h6W1Zk1k7GqGj90=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3F8B602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/2] printk: Add an option to flush all messages on panic
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0020b526-ad88-309a-8dce-1c852f0ebb31@codeaurora.org>
Date:   Mon, 1 Apr 2019 17:20:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 4:18 PM, Feng Tang wrote:
> Current console_flush_on_panic() will only dump the new messages
> in buffer, and users may need an opportunity to check all the
> messages on panic which could help debugging, as user may haven't
> seen the log before panic due to loglevel settings.
>
> Add a flag for console_flush_on_panic() to chose whether to
> dump all messages.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>


Looks good to me.


But, Will it not be good if put it under a config and not change the 
prototype, as it is a debug feature?

Thanks,
Mukesh

> ---
>   arch/powerpc/kernel/traps.c | 2 +-
>   include/linux/console.h     | 2 +-
>   kernel/panic.c              | 2 +-
>   kernel/printk/printk.c      | 9 ++++++++-
>   4 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1fd45a8..58d9580 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -179,7 +179,7 @@ extern void panic_flush_kmsg_end(void)
>   	kmsg_dump(KMSG_DUMP_PANIC);
>   	bust_spinlocks(0);
>   	debug_locks_off();
> -	console_flush_on_panic();
> +	console_flush_on_panic(false);
>   }
>   
>   static unsigned long oops_begin(struct pt_regs *regs)
> diff --git a/include/linux/console.h b/include/linux/console.h
> index ec9bdb3..825ecf5 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -175,7 +175,7 @@ extern int console_trylock(void);
>   extern void console_unlock(void);
>   extern void console_conditional_schedule(void);
>   extern void console_unblank(void);
> -extern void console_flush_on_panic(void);
> +extern void console_flush_on_panic(bool flush_all);
>   extern struct tty_driver *console_device(int *);
>   extern void console_stop(struct console *);
>   extern void console_start(struct console *);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 0ae0d73..fb77e01 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -277,7 +277,7 @@ void panic(const char *fmt, ...)
>   	 * panic() is not being callled from OOPS.
>   	 */
>   	debug_locks_off();
> -	console_flush_on_panic();
> +	console_flush_on_panic(false);
>   
>   	panic_print_sys_info();
>   
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02ca827..8ff099b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2525,10 +2525,11 @@ void console_unblank(void)
>   
>   /**
>    * console_flush_on_panic - flush console content on panic
> + * @flush_all:	whether to print all messages in buffer
>    *
>    * Immediately output all pending messages no matter what.
>    */
> -void console_flush_on_panic(void)
> +void console_flush_on_panic(bool flush_all)
>   {
>   	/*
>   	 * If someone else is holding the console lock, trylock will fail
> @@ -2539,6 +2540,12 @@ void console_flush_on_panic(void)
>   	 */
>   	console_trylock();
>   	console_may_schedule = 0;
> +
> +	/* User may want to see all the printk messages on panic */
> +	if (flush_all) {
> +		console_seq = log_first_seq;
> +		console_idx = log_first_idx;
> +	}
>   	console_unlock();
>   }
>   
