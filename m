Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E13C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE320879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="II4Ji0v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbfEXH4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:56:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55752 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388911AbfEXH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:56:10 -0400
Received: by mail-it1-f195.google.com with SMTP id g24so7372817iti.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6P/x1kqBeWImHah4qFZ8gzBP5+Hdih0J2M1ZiT9+J4Y=;
        b=II4Ji0v05/qYCfv302VU0PsJ6/mpVIE+OiOpQD6PVpCLXBwN7hdTe+0s+kHlB5hVff
         6qj8ZuD2r3ZZU133ZNAcMqPCs5ODmxgAgnvsIz7z1MSkk0h+aabelY2cH3LX0Q4/MusR
         HFa26YsNEgx9ckdtMKnJbvFh/adfB/0CTAYSDWVEFvaAeHhkP91LqSH/o+lEq45bz7ML
         +tfb6JfzkPhyZV+9qniBAbu0n+hA8kG6A5XAr7Rh1/d/seZA7/zB5oURiGYbIJwEzicF
         nqIg4bfbUg+zwXaDCAI1kJ/+HVEqEINg++jOoonOxLqxZQMqjOhn2LwmYT5WK0y40YHZ
         UITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6P/x1kqBeWImHah4qFZ8gzBP5+Hdih0J2M1ZiT9+J4Y=;
        b=ZkoxAPTHioFpxo4UyZCbm+/peWqAtWa4JrJlLFD5QDNtVqkOGOLLRh7Yev30sH9ZhK
         aRRNveX3wDle+yDDJ61i0lyx4p/5J7NN9r1Koqm9fmkLpR1Jz3JOWC6N4H42dvr3T6qW
         ZS7zXlX6wmvGK8xdtl6wGCwpMNDDbG2YxX/b9Umd+0rd9NgNmOEwY9LAkpir4haQVfhT
         wR/4xwAIPx/0sfNU1UXqdqNdGlCEvIck3GQOG4/Vtc/M0F1RSWMCVnGQOI0ePJcfmHto
         oDsL5QQmDmTSdMujk9wstbGe2GxLU5Dg0pI7Bus4o3feUDCA6w/gWXUarXKXAjHErkXj
         Nk3g==
X-Gm-Message-State: APjAAAU239OFO9R+j/Py2WrYGq0Aob4yRDTWt142wWAsU3UPu+l4kS2V
        wpHluaTFmlT9hjcrg7XzbbSIlIHNYQRV/wd8vCTPpQ==
X-Google-Smtp-Source: APXvYqyv4MEGSAQqPn6Kt/pWxvpx/23vDL1U0wgc6REDT6HCtELESpPqt4GWtXLGzVvVY1sh0G87NBYDoWrokLQKwHM=
X-Received: by 2002:a24:c204:: with SMTP id i4mr16514630itg.83.1558684569269;
 Fri, 24 May 2019 00:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190514091917.GA26804@jagdpanzerIV> <3e2cf31d-25af-e7c3-b308-62f64d650974@i-love.sakura.ne.jp>
 <4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp>
In-Reply-To: <4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 May 2019 09:55:57 +0200
Message-ID: <CACT4Y+YNNzsMHpjDUpfHNYJMqYA+foHtSBdrg_NSeKJKadoGwQ@mail.gmail.com>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:57 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Well, the culprit of this problem might be syz_execute_func().
>
>   https://twitter.com/ed_maste/status/1131165065485398016
>
> Then, blacklisting specific syscalls/arguments might not work.
> We will need to guard specific paths on the kernel side using
> some kernel config option...

Yes, that's a nasty issue. We could stop running random code, or
setuid into nobody, but then we will lose lots of test coverage...

> Anyway, Andrew, will you send this patch to linux-next.git ?
> syzbot would identify which syz_execute_func() call is triggering
> this problem.
>
> From 96e0741839f56c461f85d83e20bf5ae6baac9a3a Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Thu, 23 May 2019 05:57:52 +0900
> Subject: [PATCH] printk: Monitor change of console loglevel.
>
> We are seeing syzbot reports [1] where printk() messages prior to panic()
> are missing for unknown reason. To test whether it is due to some testcase
> changing console loglevel, let's panic() as soon as console loglevel has
> changed. This patch is intended for testing on linux-next.git only, and
> will be removed after we found what is wrong.
>
> [1] https://lkml.kernel.org/r/127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1888f6a..5326015 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3343,3 +3343,23 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>
>  #endif
> +
> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
> +static int initial_loglevel;
> +static void check_loglevel(struct timer_list *timer)
> +{
> +       if (console_loglevel < initial_loglevel)
> +               panic("Console loglevel changed (%d->%d)!", initial_loglevel,
> +                     console_loglevel);
> +       mod_timer(timer, jiffies + HZ);
> +}
> +static int __init loglevelcheck_init(void)
> +{
> +       static DEFINE_TIMER(timer, check_loglevel);
> +
> +       initial_loglevel = console_loglevel;
> +       mod_timer(&timer, jiffies + HZ);
> +       return 0;
> +}
> +late_initcall(loglevelcheck_init);
> +#endif
> --
> 1.8.3.1
