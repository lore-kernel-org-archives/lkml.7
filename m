Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA21C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C9720700
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhUpMmGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfDBCOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:14:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34663 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:14:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so5527768pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V5kClZN3gwCZBMQtw2AaU2LaXAsiEsEQ3fSpzFADhis=;
        b=NhUpMmGQ6fNW/Yh5pGkA62Ycp3fzeLTZMD76oSIQNta7nDMAQfl40wwXRv4kJSXdld
         Gl8TF80+MB8RizsASw2INGsZ6DMQWbp0RRnRRHnfU1n9DWFgXmzp6KHwtKR6U/1Dl3qI
         vOdc1Pwva4Vr9yemTeDTtthWJnOxhwxpobdIGAdYrdvdS4i1L2SmJAORI9BzhT7ByoJq
         PKP9XVCpbPLPVn/3bgU0/2EcMRUSW3Cz4+irF5p0aHPAvQbWxK9KvRWt2BL3VFJUFyiZ
         0e+/hcAXceNeKAaSqrKiO5ykPSR5h3BBSoZE9vtoWoPr94MlPdZXoVGJqmNkcSmsry+K
         IiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V5kClZN3gwCZBMQtw2AaU2LaXAsiEsEQ3fSpzFADhis=;
        b=DaJzeVw+oHWOCjHbDaGgNvnBV7HrzHTHC3KdeD5dMVUu2QJOrzoWUKFwtxIHtK9vjj
         3sxpnvQg5BK58hbpzGDRIzuO2MJlVGssRZTKrbjEC88mivpfQkLyFIFlqc1hOKjS5ySV
         v+luod9AhnI3+Rts0/9lC63VOtLeK2xCYtBZSFWaMumLSKbTKUasIyxpO4PjJQdL3wOl
         QYCB9/dOWepLagpB+6SfcCcPAgRhJLaGC9WH9iUZUf45XVlxtChqc9ISEZWVSpQE3Gzy
         mRz61dPtq9c3s8qxJeobmK0kvvcNe4fmTlp5MaaMQ9qEaIjoJcZqUuCuLhnlQgMRIxk8
         1ssQ==
X-Gm-Message-State: APjAAAWz1HE50JNeDMlOJeei0QRCth+z1tDJ9nmRD6SXs5oRNiTIsynE
        lQF6F3rVaOv4tmu5o2zjVmZ1D8eq
X-Google-Smtp-Source: APXvYqyUtJkR5+QcEKXKg1hs17df/OyOfpNfHiP/c9XIfTmI/8DUuP1fIWPRdJKos5dQUkHJ99E8hw==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr65881900pfn.142.1554171263757;
        Mon, 01 Apr 2019 19:14:23 -0700 (PDT)
Received: from localhost ([175.223.14.1])
        by smtp.gmail.com with ESMTPSA id e4sm3169271pfh.146.2019.04.01.19.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:14:22 -0700 (PDT)
Date:   Tue, 2 Apr 2019 11:14:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] printk: Add an option to flush all messages on panic
Message-ID: <20190402021419.GA617@jagdpanzerIV>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/01/19 18:48), Feng Tang wrote:
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1fd45a8..58d9580 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -179,7 +179,7 @@ extern void panic_flush_kmsg_end(void)
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  	bust_spinlocks(0);
>  	debug_locks_off();
> -	console_flush_on_panic();
> +	console_flush_on_panic(false);
>  }
[..]
> @@ -277,7 +277,7 @@ void panic(const char *fmt, ...)
>  	 * panic() is not being callled from OOPS.
>  	 */
>  	debug_locks_off();
> -	console_flush_on_panic();
> +	console_flush_on_panic(false);
[..]
> -void console_flush_on_panic(void)
> +void console_flush_on_panic(bool flush_all)
>  {
>  	/*
>  	 * If someone else is holding the console lock, trylock will fail
> @@ -2539,6 +2540,12 @@ void console_flush_on_panic(void)
>  	 */
>  	console_trylock();
>  	console_may_schedule = 0;
> +
> +	/* User may want to see all the printk messages on panic */
> +	if (flush_all) {
> +		console_seq = log_first_seq;
> +		console_idx = log_first_idx;
> +	}
>  	console_unlock();

So my first thought was - let's not add a `bool flag', but instead add
an `enum' with clear flag names, e.g. DUMP_ALL/DUMP_PENDING, etc. Something
similar to what ftrace_dump(DUMP_ALL) does. And we already have panic_print
bit-mask and panic_print_sys_info(), which controls what we print when in
panic. So we can move console_flush_on_panic() to panic_print_sys_info()
and handle different types of console_flush_on_panic() there:

---

diff --git a/kernel/panic.c b/kernel/panic.c
index 0ae0d7332f12..e142faaebbcd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -134,6 +134,11 @@ EXPORT_SYMBOL(nmi_panic);
 
 static void panic_print_sys_info(void)
 {
+	if (panic_print & PANIC_PRINT_REPLAY_LOGBUF)
+		console_flush_on_panic(DUMP_ALL);
+	else
+		console_flush_on_panic(DUMP_PENDING);
+
 	if (panic_print & PANIC_PRINT_TASK_INFO)
 		show_state();
 
@@ -277,7 +282,6 @@ void panic(const char *fmt, ...)
 	 * panic() is not being callled from OOPS.
 	 */
 	debug_locks_off();
-	console_flush_on_panic();
 
 	panic_print_sys_info();
 
---

After looking at this more - DUMP_ALL/DUMP_PENDING clearly depend
on panic_print. So... May be we can move panic_print_sys_info() to
printk.c, and for PANIC_PRINT_REPLAY_LOGBUF case just reset console
seq/idx (console seq/idx are internal to printk) before we
flush_on_panic. This way we would not need to modify
console_flush_on_panic() prototype at all.

Let's hear from people.

	-ss
