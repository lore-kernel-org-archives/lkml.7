Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC621CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B820874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VTGm2FJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfJ3PLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:11:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41655 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfJ3PLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:11:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id j14so1838715lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ew4mPHzEDChjwZ6r+gSELsFP9TQqVpPuS742rIsS3aE=;
        b=VTGm2FJjHoT/ZAESegWwnI0GDBO1bZXjQqYVbwyRw9Qmae+24JA8Jy1DsEbFoaTm3F
         qpYKVPvWyqStm6Sp/Ef8wvmfeG9QCS3BmH7zxuTvsg40Tb95m1/Sqf8I4WrVBR+TqTfj
         8rSRXTZroyj7p1x9mdQUhAIEel0/gwZTm7VZnvq3bANLf4Y9y8l/9g8nccIC8dkmkDS9
         xggPgk2vedAK9zjZ4sZjF2471t0sXTVbboWmvxZiyQhqB77u08PCUwA2IT0Xve7r9cqb
         RWzqRlWM+4yQ75PyfXZrd6aHNzSW7gs2IZDcuWRj60dkfYocDaMSW0VWXBE/23Yk3lRS
         urEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ew4mPHzEDChjwZ6r+gSELsFP9TQqVpPuS742rIsS3aE=;
        b=XNhi0xlFGLRoPbP/VLtVbVeMgqU7fyOFrD46Zn3IuuFah5xfBN4HFO0+kFTvP+kKgh
         ZW+aWq9MlE+UFU4kE1W68VAXDZ+SjqbaGQz4jh/drrrv7zUA6bg/B0UY1Vy3OV4EBZMe
         sE0LThK88dqU55MTBkTl+E6qTxEixRODOb0GrK2hmY4wR/ns7YbSwZdgGhlWVflYaZz0
         0f+wY4n/NoguxjTGM1fR3by1NPKI3/Ll7d9Y+KV2sRANRxmNYNc/z8xMRPb32TC/tIGc
         RFyet+/PmB7XdooeQXxJxkFW3V/jGQhKVPY2pGYOhkAlIKiyr/VSfcxYmRy1o2+SBJ7u
         eAHQ==
X-Gm-Message-State: APjAAAXc0Vgo3ewSUOgpdDIotZOApLD1VzZWrEPTvs8Wqwnb21wpJU2l
        5Ham+KTCrrP/ccnz0hTa+porUw==
X-Google-Smtp-Source: APXvYqwcEExqFdUNonrfA4lX6RwYdiJdcOhGFj/HtekeESzr5IUyiQjiWsB5ozrcE1oDLfyAaoXuGw==
X-Received: by 2002:a19:7515:: with SMTP id y21mr6435911lfe.96.1572448299509;
        Wed, 30 Oct 2019 08:11:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x16sm102028ljd.69.2019.10.30.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:11:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C1CE0100C02; Wed, 30 Oct 2019 18:11:37 +0300 (+03)
Date:   Wed, 30 Oct 2019 18:11:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kirill Smelkov <kirr@nexedi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: sound/core/timer: Deadlock on register_mutex
Message-ID: <20191030151137.nret25uc5caak2z4@box>
References: <20191030141029.isw4y3tfmjp5azev@box.shutemov.name>
 <s5h1ruugtr2.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1ruugtr2.wl-tiwai@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:04:01PM +0100, Takashi Iwai wrote:
> On Wed, 30 Oct 2019 15:10:29 +0100,
> Kirill A. Shutemov wrote:
> > 
> > Hi,
> > 
> > I've stepped on this after pulling USB sound card:
> > 
> > 	 ============================================
> > 	 WARNING: possible recursive locking detected
> > 	 5.4.0-rc4-00090-g95b5dc072cc3-dirty #48 Not tainted
> > 	 --------------------------------------------
> > 	 xdg-screensaver/1321 is trying to acquire lock:
> > 	 ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > 
> > 	but task is already holding lock:
> > 	 ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_close (/sound/core/timer.c:416)
> > 
> > 	other info that might help us debug this:
> > 	  Possible unsafe locking scenario:
> > 
> > 		CPU0
> > 		----
> > 	   lock(register_mutex);
> > 	   lock(register_mutex);
> > 
> > 	*** DEADLOCK ***
> > 
> > 	  May be due to missing lock nesting notation
> > 
> > 	 2 locks held by xdg-screensaver/1321:
> > 	 #0: ffff9f74bbf5ef50 (&tu->ioctl_lock){+.+.}, at: snd_timer_user_release (/sound/core/timer.c:1467)
> > 	 #1: ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_close (/sound/core/timer.c:416)
> > 
> > 	stack backtrace:
> > 	 CPU: 27 PID: 1321 Comm: xdg-screensaver Not tainted 5.4.0-rc4-00090-g95b5dc072cc3-dirty #48
> > 	 Hardware name: Gigabyte Technology Co., Ltd. X299 AORUS Gaming 3 Pro/X299 AORUS Gaming 3 Pro-CF, BIOS F3 12/28/2017
> > 	 Call Trace:
> > 	 dump_stack (/lib/dump_stack.c:115)
> > 	 __lock_acquire.cold (/kernel/locking/lockdep.c:2371 /kernel/locking/lockdep.c:2412 /kernel/locking/lockdep.c:2955 /kernel/locking/lockdep.c:3955)
> > 	 ? __lock_acquire (/kernel/locking/lockdep.c:3962)
> > 	 lock_acquire (/arch/x86/include/asm/current.h:15 /kernel/locking/lockdep.c:4489)
> > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > 	 __mutex_lock (/include/linux/compiler.h:199 /arch/x86/include/asm/atomic64_64.h:22 /include/asm-generic/atomic-instrumented.h:837 /include/asm-generic/atomic-long.h:28 /kernel/locking/mutex.c:111 /kernel/locking/mutex.c:152 /kernel/locking/mutex.c:958 /kernel/locking/mutex.c:1103)
> > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > 	 ? __mutex_lock (/include/linux/compiler.h:199 /arch/x86/include/asm/atomic64_64.h:22 /include/asm-generic/atomic-instrumented.h:837 /include/asm-generic/atomic-long.h:28 /kernel/locking/mutex.c:111 /kernel/locking/mutex.c:152 /kernel/locking/mutex.c:958 /kernel/locking/mutex.c:1103)
> > 	 ? __mutex_lock (/arch/x86/include/asm/preempt.h:102 /kernel/locking/mutex.c:964 /kernel/locking/mutex.c:1103)
> > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > 	 ? lockdep_hardirqs_on (/kernel/locking/lockdep.c:3394 /kernel/locking/lockdep.c:3434)
> > 	 snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > 	 snd_timer_dev_free (/sound/core/timer.c:967)
> > 	 __snd_device_free (/sound/core/device.c:76)
> > 	 snd_device_free_all (/sound/core/device.c:228)
> > 	 release_card_device (/sound/core/init.c:471 /sound/core/init.c:140)
> > 	 device_release (/drivers/base/core.c:1105)
> > 	 kobject_put (/lib/kobject.c:697 /lib/kobject.c:722 /include/linux/kref.h:65 /lib/kobject.c:739)
> > 	 snd_timer_close_locked (/sound/core/timer.c:398)
> > 	 snd_timer_close (/sound/core/timer.c:417)
> > 	 snd_timer_user_release (/sound/core/timer.c:1469)
> > 	 __fput (/fs/file_table.c:281)
> > 	 task_work_run (/kernel/task_work.c:115 (discriminator 1))
> > 	 exit_to_usermode_loop (/include/linux/tracehook.h:188 /arch/x86/entry/common.c:163)
> > 	 do_syscall_64 (/arch/x86/entry/common.c:194 /arch/x86/entry/common.c:274 /arch/x86/entry/common.c:300)
> > 	 entry_SYSCALL_64_after_hwframe (/arch/x86/entry/entry_64.S:177)
> 
> OK, this looks like a deadlock that is via put_device() called at
> closing the timer device that is the last open instance while freeing
> the card.
> 
> Could you try the patch below?

I can, but I'm not sure if I can trigger the issue for the second time.

-- 
 Kirill A. Shutemov
