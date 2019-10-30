Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D77CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF8320874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UHnwlO44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfJ3OKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:10:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44122 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3OKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:10:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id v4so1655093lfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vWvOPEIi1tbsZALaFAv0Uy0WFf8KUbbFXlv9R7bSARI=;
        b=UHnwlO44x8oRaD6wl7/Yv6WQXv1nR50giDX60GgPqV972Fr3GoJC1jnFvHS39TN0lh
         K1FCyNB9qwU19KxQWnJT8t3ZqipYusVSGv0kIsu2bQe+DttKFDB+gEaVKBWmDFYe2+ZZ
         R2x9Xh7y2zboI/vQPvmyxeMqqG4xNbMgg+TtpbJD2xbLrNnU1XPwyEiD6by/jvw3FUPK
         5FNDMJbN2F+IH1k0QWnhlFvisLiKCwcMqqTTL6TMGtFowemAQ0ATnXZd4r8txSCh//56
         uYpLiHnz2XAsPjgSGO2jXUTTOdpeNeqW+BxuLJa8DzD0LVjX64G9OQjQkEaOofO2FOMy
         QiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vWvOPEIi1tbsZALaFAv0Uy0WFf8KUbbFXlv9R7bSARI=;
        b=hHfFxY3n/JfHU4H9ouVmJFAQKryMC1/qXcrHLl4RTL7AYpwVWwruT/1PKKJeOOdg18
         995MS3aDkBctEr1RcAk3QpIHUKxuCmWBF8f5SAnvDzp9W1JYd4fGtn9MEkkMkIHOZ70Q
         jzO39GE92b1iIT1BB2tGL5o7KRJgCDvb11LgEn14/D/Enafb51c5OOExkYlml3NAib3r
         3YztN0mjcj2N/QfAmPEoxGu7hVxCYMDMNRNP3+YZ6rTvEpHKGE6LRmWFlhMjjzN13sv7
         b+o6yYwBh1ZJM5pzjVfKnPHbZ8VpMmIOjVSMRTyrO75rtp4H6Ps3HvPqKtY1uTYrmPQJ
         4zNg==
X-Gm-Message-State: APjAAAVr4EVYEeN7C7M/GpbTeRVhBXIVKPx9O3X6BCAkyX4q1F8IUP5m
        BQfLGH+BlKNW021WGY0HN+ARd1SMMto=
X-Google-Smtp-Source: APXvYqzFqjIdXhHgSDDwq/JhvWduZmLL2rp2GUtjDIt05HFFNvGaSxeJVxGJEMc+xOs+2ukKp+l/BQ==
X-Received: by 2002:ac2:569c:: with SMTP id 28mr443084lfr.139.1572444630933;
        Wed, 30 Oct 2019 07:10:30 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x187sm91633lfa.64.2019.10.30.07.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:10:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D5DEE100C02; Wed, 30 Oct 2019 17:10:29 +0300 (+03)
Date:   Wed, 30 Oct 2019 17:10:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>, Kirill Smelkov <kirr@nexedi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: sound/core/timer: Deadlock on register_mutex
Message-ID: <20191030141029.isw4y3tfmjp5azev@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've stepped on this after pulling USB sound card:

	 ============================================
	 WARNING: possible recursive locking detected
	 5.4.0-rc4-00090-g95b5dc072cc3-dirty #48 Not tainted
	 --------------------------------------------
	 xdg-screensaver/1321 is trying to acquire lock:
	 ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)

	but task is already holding lock:
	 ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_close (/sound/core/timer.c:416)

	other info that might help us debug this:
	  Possible unsafe locking scenario:

		CPU0
		----
	   lock(register_mutex);
	   lock(register_mutex);

	*** DEADLOCK ***

	  May be due to missing lock nesting notation

	 2 locks held by xdg-screensaver/1321:
	 #0: ffff9f74bbf5ef50 (&tu->ioctl_lock){+.+.}, at: snd_timer_user_release (/sound/core/timer.c:1467)
	 #1: ffffffffbaf6b3a0 (register_mutex){+.+.}, at: snd_timer_close (/sound/core/timer.c:416)

	stack backtrace:
	 CPU: 27 PID: 1321 Comm: xdg-screensaver Not tainted 5.4.0-rc4-00090-g95b5dc072cc3-dirty #48
	 Hardware name: Gigabyte Technology Co., Ltd. X299 AORUS Gaming 3 Pro/X299 AORUS Gaming 3 Pro-CF, BIOS F3 12/28/2017
	 Call Trace:
	 dump_stack (/lib/dump_stack.c:115)
	 __lock_acquire.cold (/kernel/locking/lockdep.c:2371 /kernel/locking/lockdep.c:2412 /kernel/locking/lockdep.c:2955 /kernel/locking/lockdep.c:3955)
	 ? __lock_acquire (/kernel/locking/lockdep.c:3962)
	 lock_acquire (/arch/x86/include/asm/current.h:15 /kernel/locking/lockdep.c:4489)
	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
	 __mutex_lock (/include/linux/compiler.h:199 /arch/x86/include/asm/atomic64_64.h:22 /include/asm-generic/atomic-instrumented.h:837 /include/asm-generic/atomic-long.h:28 /kernel/locking/mutex.c:111 /kernel/locking/mutex.c:152 /kernel/locking/mutex.c:958 /kernel/locking/mutex.c:1103)
	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
	 ? __mutex_lock (/include/linux/compiler.h:199 /arch/x86/include/asm/atomic64_64.h:22 /include/asm-generic/atomic-instrumented.h:837 /include/asm-generic/atomic-long.h:28 /kernel/locking/mutex.c:111 /kernel/locking/mutex.c:152 /kernel/locking/mutex.c:958 /kernel/locking/mutex.c:1103)
	 ? __mutex_lock (/arch/x86/include/asm/preempt.h:102 /kernel/locking/mutex.c:964 /kernel/locking/mutex.c:1103)
	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
	 ? snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
	 ? lockdep_hardirqs_on (/kernel/locking/lockdep.c:3394 /kernel/locking/lockdep.c:3434)
	 snd_timer_free.part.0 (/include/linux/compiler.h:199 /include/linux/list.h:268 /sound/core/timer.c:944)
	 snd_timer_dev_free (/sound/core/timer.c:967)
	 __snd_device_free (/sound/core/device.c:76)
	 snd_device_free_all (/sound/core/device.c:228)
	 release_card_device (/sound/core/init.c:471 /sound/core/init.c:140)
	 device_release (/drivers/base/core.c:1105)
	 kobject_put (/lib/kobject.c:697 /lib/kobject.c:722 /include/linux/kref.h:65 /lib/kobject.c:739)
	 snd_timer_close_locked (/sound/core/timer.c:398)
	 snd_timer_close (/sound/core/timer.c:417)
	 snd_timer_user_release (/sound/core/timer.c:1469)
	 __fput (/fs/file_table.c:281)
	 task_work_run (/kernel/task_work.c:115 (discriminator 1))
	 exit_to_usermode_loop (/include/linux/tracehook.h:188 /arch/x86/entry/common.c:163)
	 do_syscall_64 (/arch/x86/entry/common.c:194 /arch/x86/entry/common.c:274 /arch/x86/entry/common.c:300)
	 entry_SYSCALL_64_after_hwframe (/arch/x86/entry/entry_64.S:177)


--
 Kirill A. Shutemov
