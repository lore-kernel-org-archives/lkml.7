Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFB6CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C637320679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="XBcYFS13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfJ3P21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:28:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45394 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJ3P21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:28:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so3119904ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6+1Ovu5C/Bgg+6JSL80oXmurHs8b7k01DUDVWs7V5Nw=;
        b=XBcYFS130JTeD/Xjt/YnNRBGwlmSgdDzpCoJTi1qf6ql2aX3M/OpKt1iWTLSRPPe7s
         3NiB5Z8akkWJ3AxZs6xVomdMiuvzSiTs3MIk+/FnHiEcZ5QgYof3hZ5uZ1sYhurMvD+2
         2A3A8DLOtnSAYJmj+jpflAgwj5r0dotRzXs/hRRuYrzPmhHAyXG2QIOdzeDWLcL3+gV3
         Q3tbkq55evjsQlANbn3jDvhArCt2aK4fAG34FCfkKK/D28jfDo7cl80U224yFFT1x4hr
         P9CJtK+oHCX6HSo8WEpuQQkj7Isyhm7v7l1KrN4z4pCxvTsS2mG8rWGZchjl4UeXSMg2
         zotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6+1Ovu5C/Bgg+6JSL80oXmurHs8b7k01DUDVWs7V5Nw=;
        b=cNx43owsJLXBoqsvSDPodOa5zAIjl0AtkyHUgnaOEibMn/f34m1DYnRimQVpMVXC4s
         3yIOl8QR9PJ04nzT3m7PzH6SyTYgrb/kSHuaqqqsUsKjjKh+yyOXOLavQcyZCiKugeYV
         uCMu737gXlImUHNjBDrpXJQVcO1m8pozo8qSGML2zZDXVwAZ0Xqp+tbL+ZeNlWCUDFe5
         fgK/206SgPiaA0FA7uiuxMaqXLY9ZpYTqjx5FbNALhyG8QSCoGW9LLcK1mXkjlfX093V
         dfO5HTrOp1UY+r96spJVjE4NCHtdnmWfKklNIlGQaFVTMtFf4cG5jwwam9h7Zo2jYfj2
         SAIA==
X-Gm-Message-State: APjAAAU293xaiRVP+9h8ENnHuCJCmgFre5qu3OSJc0EZAMSwHWDRRKL/
        CAPtBUb6cQWFSNNZnkD16G6t9g==
X-Google-Smtp-Source: APXvYqzH+WaOIrGvKaH9DZOUL8I3+/ld8bglNzSwlh0OSILONiiTfD9/CDJNOv68fl+OdptuqyOhsA==
X-Received: by 2002:a2e:9094:: with SMTP id l20mr214907ljg.246.1572449304546;
        Wed, 30 Oct 2019 08:28:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v10sm124178lji.46.2019.10.30.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:28:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A0978100C02; Wed, 30 Oct 2019 18:28:23 +0300 (+03)
Date:   Wed, 30 Oct 2019 18:28:23 +0300
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
Message-ID: <20191030152823.zg7qglzmpo2k2ynu@box.shutemov.name>
References: <20191030141029.isw4y3tfmjp5azev@box.shutemov.name>
 <s5h1ruugtr2.wl-tiwai@suse.de>
 <20191030151137.nret25uc5caak2z4@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030151137.nret25uc5caak2z4@box>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:11:37PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 30, 2019 at 04:04:01PM +0100, Takashi Iwai wrote:
> > On Wed, 30 Oct 2019 15:10:29 +0100,
> > Kirill A. Shutemov wrote:
> > > 
> > > Hi,
> > > 
> > > I've stepped on this after pulling USB sound card:
> > > 
> > > 	 ============================================
> > > 	 WARNING: possible recursive locking detected
> > > 	 5.4.0-rc4-00090-g95b5dc072cc3-dirty #48 Not tainted
> > > 	 --------------------------------------------
> > > 	 xdg-screensaver/1321 is trying to acquire lock:
> > > 	 ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > > 
> > > 	but task is already holding lock:
> > > 	 ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_close (/sound/core/timer.c:416)
> > > 
> > > 	other info that might help us debug this:
> > > 	  Possible unsafe locking scenario:
> > > 
> > > 		CPU0
> > > 		----
> > > 	   lock(register_mutex);
> > > 	   lock(register_mutex);
> > > 
> > > 	*** DEADLOCK ***
> > > 
> > > 	  May be due to missing lock nesting notation
> > > 
> > > 	 2 locks held by xdg-screensaver/1321:
> > > 	 #0: ffff9f74bbf5ef50 (&tu->ioctl_lock){+.+.}, at: snd_timer_user_release (/sound/core/timer.c:1467)
> > > 	 #1: ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_close (/sound/core/timer.c:416)
> > > 
> > > 	stack backtrace:
> > > 	 CPU: 27 PID: 1321 Comm: xdg-screensaver Not tainted 5.4.0-rc4-00090-g95b5dc072cc3-dirty #48
> > > 	 Hardware name: Gigabyte Technology Co., Ltd. X299 AORUS Gaming 3 Pro/X299 AORUS Gaming 3 Pro-CF, BIOS F3 12/28/2017
> > > 	 Call Trace:
> > > 	 dump_stack (/lib/dump_stack.c:115)
> > > 	 __lock_acquire.cold (/kernel/locking/lockdep.c:2371 /kernel/locking/lockdep.c:2412 /kernel/locking/lockdep.c:2955 /kernel/locking/lockdep.c:3955)
> > > 	 ? __lock_acquire (/kernel/locking/lockdep.c:3962)
> > > 	 lock_acquire (/arch/x86/include/asm/current.h:15 /kernel/locking/lockdep.c:4489)
> > > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > > 	 __mutex_lock (/include/linux/compiler.h:199 /arch/x86/include/asm/atomic64_64.h:22 /include/asm-generic/atomic-instrumented.h:837 /include/asm-generic/atomic-long.h:28 /kernel/locking/mutex.c:111 /kernel/locking/mutex.c:152 /kernel/locking/mutex.c:958 /kernel/locking/mutex.c:1103)
> > > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > > 	 ? __mutex_lock (/include/linux/compiler.h:199 /arch/x86/include/asm/atomic64_64.h:22 /include/asm-generic/atomic-instrumented.h:837 /include/asm-generic/atomic-long.h:28 /kernel/locking/mutex.c:111 /kernel/locking/mutex.c:152 /kernel/locking/mutex.c:958 /kernel/locking/mutex.c:1103)
> > > 	 ? __mutex_lock (/arch/x86/include/asm/preempt.h:102 /kernel/locking/mutex.c:964 /kernel/locking/mutex.c:1103)
> > > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > > 	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > > 	 ? lockdep_hardirqs_on (/kernel/locking/lockdep.c:3394 /kernel/locking/lockdep.c:3434)
> > > 	 snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
> > > 	 snd_timer_dev_free (/sound/core/timer.c:967)
> > > 	 __snd_device_free (/sound/core/device.c:76)
> > > 	 snd_device_free_all (/sound/core/device.c:228)
> > > 	 release_card_device (/sound/core/init.c:471 /sound/core/init.c:140)
> > > 	 device_release (/drivers/base/core.c:1105)
> > > 	 kobject_put (/lib/kobject.c:697 /lib/kobject.c:722 /include/linux/kref.h:65 /lib/kobject.c:739)
> > > 	 snd_timer_close_locked (/sound/core/timer.c:398)
> > > 	 snd_timer_close (/sound/core/timer.c:417)
> > > 	 snd_timer_user_release (/sound/core/timer.c:1469)
> > > 	 __fput (/fs/file_table.c:281)
> > > 	 task_work_run (/kernel/task_work.c:115 (discriminator 1))
> > > 	 exit_to_usermode_loop (/include/linux/tracehook.h:188 /arch/x86/entry/common.c:163)
> > > 	 do_syscall_64 (/arch/x86/entry/common.c:194 /arch/x86/entry/common.c:274 /arch/x86/entry/common.c:300)
> > > 	 entry_SYSCALL_64_after_hwframe (/arch/x86/entry/entry_64.S:177)
> > 
> > OK, this looks like a deadlock that is via put_device() called at
> > closing the timer device that is the last open instance while freeing
> > the card.
> > 
> > Could you try the patch below?
> 
> I can, but I'm not sure if I can trigger the issue for the second time.

Yeah, I was able to reproduce it without the patch and cannot with.

Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
