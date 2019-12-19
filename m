Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C18C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2C227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLkjzbdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLSRVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:21:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37729 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:21:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so5290261qky.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmaASdN+fyGlEAB/n41jrDgKEHVzUdiRVPVYkhanzT8=;
        b=VLkjzbdqeF1Y/7abRB0Qpl3dnfpFPBxUaJOX2Hl+C+Nhw/BM6Nmg+v4A0W2QsfeK0L
         lcMSBEE/ME3OaezUIbJShpF4VRgRdRbgl8NU7odLWY62s0qZ3EE07LZdM/z3qhJD4j3a
         p3uF1d6WM5EfPAdTE3x+aVHfduRPBPJFlFn5nNncRiYqsAVA6GGFagpMQDOPGhRDbDrZ
         hOG568bOuaZN7QvzlXe6cLvD4CxYowBrO6iN41VgsT6r/jgZvek3BqE/WobVTgy44Oez
         s1tFniQA14DJXRoJB0do9RLBCR/sRayI6JSrvM0oJIT0nEP6fCHqkKfc2/9i4+92nzpm
         mQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmaASdN+fyGlEAB/n41jrDgKEHVzUdiRVPVYkhanzT8=;
        b=PANfeVneZfHJA6An+Y+EyG6qlAjYM7F2if1Ie3RLx4AHOa/ldfEOKTIf0kDE9V6rHR
         RmXiX0qqnTtRszuCw0nShD0dYLC0eb7kO15PY3C3YfW8fw0pa6m9cGydGldHzrXYKDxB
         WjJp+eRsLgp7oGipyLfDpF/3nD2U6rXjXrAYs06o3EO2rRdE59CHlmtmbf3rh4qPlRG9
         XjJBiVFQuGNg+lIWTsmfW4RKMp/Wa0FojxJLnVMZqixJ8btJyDs7EsMMP/RJpKAbxM8M
         z9CDAnjrolar+v8KUdSQIYWqRwDACm53/B4TWJVbW2wnhscp/hleK4eFRJfH5RoRFUQR
         6jrQ==
X-Gm-Message-State: APjAAAXZ9DFEZyJ8igUuj6yaFQXrwlxuv36Ku8AfDSyvVPyYUxV1DALx
        LHQ4ZqT/JSten4qIRWpTYGxQLGj1QPdh60OmEJjAFw==
X-Google-Smtp-Source: APXvYqxiDkmDJTDpwzh53k3zUeMi6OLAduLXPof9CXJMJ7fyNblHqPRu9Uwa1owOKchVJyUi0Vx6bRrOm3Rq+Dd2/Fk=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr9333906qkk.8.1576776103716;
 Thu, 19 Dec 2019 09:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com> <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu> <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com> <cca315b2-d2c0-0bcb-35d9-f830b028fb4d@i-love.sakura.ne.jp>
In-Reply-To: <cca315b2-d2c0-0bcb-35d9-f830b028fb4d@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Dec 2019 18:21:31 +0100
Message-ID: <CACT4Y+aRqZ7r-XedUS6P51Dpf+GRAuZABH6FuKDU19UepE6KCw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:30 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/12/17 17:36, Dmitry Vyukov wrote:
> > FWIW we've just disabled sysrq entirely:
> > https://github.com/google/syzkaller/blob/master/dashboard/config/bits-syzbot.config#L182
> > because random packets over usb can trigger a panic sysrq (again
> > almost impossible to reliably filter these out on fuzzer side).
>
> Excuse me, but CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0 helps only if show_state() etc. are
> called via the __handle_sysrq() handler in drivers/tty/sysrq.c .
>
>   static void sysrq_handle_showstate(int key)
>   {
>         show_state();
>         show_workqueue_state();
>   }
>   static struct sysrq_key_op sysrq_showstate_op = {
>         .handler        = sysrq_handle_showstate,
>         .help_msg       = "show-task-states(t)",
>         .action_msg     = "Show State",
>         .enable_mask    = SYSRQ_ENABLE_DUMP,
>   };
>
> The k_spec() handler in drivers/tty/vt/keyboard.c calls show_state() etc. without
> evaluating sysrq_enabled value.
>
>   #define FN_HANDLERS\
>         fn_null,        fn_enter,       fn_show_ptregs, fn_show_mem,\
>         fn_show_state,  fn_send_intr,   fn_lastcons,    fn_caps_toggle,\
>         fn_num,         fn_hold,        fn_scroll_forw, fn_scroll_back,\
>         fn_boot_it,     fn_caps_on,     fn_compose,     fn_SAK,\
>         fn_dec_console, fn_inc_console, fn_spawn_con,   fn_bare_num
>
>   typedef void (fn_handler_fn)(struct vc_data *vc);
>   static fn_handler_fn FN_HANDLERS;
>   static fn_handler_fn *fn_handler[] = { FN_HANDLERS };
>
>   static void fn_show_state(struct vc_data *vc)
>   {
>         show_state();
>   }
>
>   static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
>   {
>         if (up_flag)
>                 return;
>         if (value >= ARRAY_SIZE(fn_handler))
>                 return;
>         if ((kbd->kbdmode == VC_RAW ||
>              kbd->kbdmode == VC_MEDIUMRAW ||
>              kbd->kbdmode == VC_OFF) &&
>              value != KVAL(K_SAK))
>                 return;         /* SAK is allowed even in raw mode */
>         fn_handler[value](vc);
>   }
>
> Therefore, we need to guard at either callee side (e.g. show_state_filter())
> or caller side (e.g. k_spec()) using kernel config (or something equivalent)
> in order to avoid forever calling show_state() from timer function.

+Andrey, please take a look if CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE
covers everything we need, or we need to disable sysrq entirely.
