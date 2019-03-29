Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3DF2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwTUA268"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfC2HfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:35:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40597 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfC2HfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:35:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so639806pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HSlQuhhxJQNqTvovKtPtg7LYdrpkXuJ7inMO8+/ULd0=;
        b=NwTUA268CWHV6YGARCH/jUmkRbBL65Vone6jfLyYRSLaN0Qyi//k3U4l2Ad6vIPbFC
         6rsfPCOUHTa3PP3O6aywnNtl6/r9KzQnoGyxc6BikFoJbFThNcn3kvDZfvfTSvEGlBXp
         Qe9kpTu0KoLRXnYLnOmeXGIf57K1BwKMbhoRRlF6r7ApImMmIAZfIN97K+qCpZqk9gfz
         srMtCnrQ0bzCmMk4Svsdub2hJC/cvSo0UVi3/xybQ4PqVXqCDECByJRLCrTpwQxCKWx3
         tfzSvIWChq2NYFV6seOxE7DE4SEdR8JG374dkKh529w97uEVuKKsdCTaQqXlcQTp4g83
         pEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HSlQuhhxJQNqTvovKtPtg7LYdrpkXuJ7inMO8+/ULd0=;
        b=pz9oQHXGD1hxduyUrKgxIFkrsaze1WpoEB7on6WYb7BOYuaBMaL7pl3wiQdMaQVMSI
         E/shRbBId+oCpVrkeNIY844rl0gWAwUiVdeozEL10KFh6ScPW8k892w0eqS+La7iLxHS
         vDV8B17zvRLqLBOgkwe+FwK1ssXaJ+2pAar/b3outqOLBduduoMTUBz6aJngcHT6l02G
         4/O/YK431xmIi7dCs4Spz/411cXNG6ry7CCVXRzFXuyP1talBwq4xrjynUt7Qp6TQ/Qs
         +tdEdMreBXTs6S+aiGbixhOtMujPqgRrv9tqnWhD1CO72jOkJG5qThJmqnKsvUzF2WLi
         jRiA==
X-Gm-Message-State: APjAAAVdbioWvKFYSP+T5XHXVnGIJ5NISFfIeTJdDlCfYbai+gHjjnmq
        1f4FMxzgV1IPs+iBNDZG3f4=
X-Google-Smtp-Source: APXvYqxBEJ35boOyQygcMaZFw6kuotLbWrIix2SNKU1qWk/rJg6lMOtN2IP3kMFgPOsg1UJX8pUR8w==
X-Received: by 2002:a62:d2ca:: with SMTP id c193mr45702280pfg.247.1553844917974;
        Fri, 29 Mar 2019 00:35:17 -0700 (PDT)
Received: from localhost ([175.223.10.137])
        by smtp.gmail.com with ESMTPSA id w123sm3145599pfw.72.2019.03.29.00.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 00:35:16 -0700 (PDT)
Date:   Fri, 29 Mar 2019 16:35:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [linux next] tty/pty: possible circular locking dependency detected
Message-ID: <20190329073514.GA458@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.1.0-rc2-next-20190329

[    8.168722] ======================================================
[    8.168723] WARNING: possible circular locking dependency detected
[    8.168724] 5.1.0-rc2-next-20190329-dbg-00014-g4d25d68aaf88-dirty #3228 Not tainted
[    8.168725] ------------------------------------------------------
[    8.168726] bash/380 is trying to acquire lock:
[    8.168727] 00000000acce3dce (tty_mutex){+.+.}, at: pty_write+0x31/0xd0
[    8.168730] 
               but task is already holding lock:
[    8.168731] 00000000c4f3448a (&ldata->output_lock){+.+.}, at: n_tty_write+0x1b9/0x4a0
[    8.168733] 
               which lock already depends on the new lock.

[    8.168733] 
               the existing dependency chain (in reverse order) is:
[    8.168734] 
               -> #4 (&ldata->output_lock){+.+.}:
[    8.168737]        __mutex_lock+0x7e/0x8c0
[    8.168738]        n_tty_write+0x1b9/0x4a0
[    8.168739]        tty_write+0x192/0x2a0
[    8.168741]        vfs_write+0xb8/0x1a0
[    8.168742]        ksys_write+0x45/0xb0
[    8.168744]        do_syscall_64+0x59/0x3bb
[    8.168746]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    8.168746] 
               -> #3 (&tty->termios_rwsem){++++}:
[    8.168748]        down_write+0x38/0x70
[    8.168749]        tty_unthrottle+0x19/0x60
[    8.168750]        n_tty_open+0x86/0xa0
[    8.168751]        tty_ldisc_open.isra.0+0x2b/0x40
[    8.168752]        tty_ldisc_setup+0x1e/0x60
[    8.168753]        tty_init_dev+0xd9/0x1c0
[    8.168754]        tty_open+0x300/0x3c0
[    8.168756]        chrdev_open+0x97/0x1c0
[    8.168757]        do_dentry_open+0x12f/0x370
[    8.168758]        path_openat+0x2ce/0xaa0
[    8.168759]        do_filp_open+0x7e/0xd0
[    8.168760]        do_sys_open+0x15d/0x210
[    8.168762]        kernel_init_freeable+0x2ae/0x317
[    8.168764]        kernel_init+0xa/0x101
[    8.168765]        ret_from_fork+0x3a/0x50
[    8.168765] 
               -> #2 (&tty->ldisc_sem){++++}:
[    8.168767]        __ldsem_down_write_nested+0x55/0x280
[    8.168768]        tty_ldisc_lock+0x4b/0x70
[    8.168770]        tty_init_dev+0x93/0x1c0
[    8.168771]        tty_open+0x300/0x3c0
[    8.168772]        chrdev_open+0x97/0x1c0
[    8.168773]        do_dentry_open+0x12f/0x370
[    8.168774]        path_openat+0x2ce/0xaa0
[    8.168775]        do_filp_open+0x7e/0xd0
[    8.168776]        do_sys_open+0x15d/0x210
[    8.168777]        kernel_init_freeable+0x2ae/0x317
[    8.168778]        kernel_init+0xa/0x101
[    8.168779]        ret_from_fork+0x3a/0x50
[    8.168780] 
               -> #1 (&tty->legacy_mutex){+.+.}:
[    8.168781]        __mutex_lock+0x7e/0x8c0
[    8.168782]        tty_init_dev+0x50/0x1c0
[    8.168784]        tty_open+0x300/0x3c0
[    8.168785]        chrdev_open+0x97/0x1c0
[    8.168786]        do_dentry_open+0x12f/0x370
[    8.168787]        path_openat+0x2ce/0xaa0
[    8.168788]        do_filp_open+0x7e/0xd0
[    8.168789]        do_sys_open+0x15d/0x210
[    8.168790]        kernel_init_freeable+0x2ae/0x317
[    8.168791]        kernel_init+0xa/0x101
[    8.168792]        ret_from_fork+0x3a/0x50
[    8.168793] 
               -> #0 (tty_mutex){+.+.}:
[    8.168794]        lock_acquire+0x9a/0x170
[    8.168795]        __mutex_lock+0x7e/0x8c0
[    8.168796]        pty_write+0x31/0xd0
[    8.168797]        n_tty_write+0x130/0x4a0
[    8.168798]        tty_write+0x192/0x2a0
[    8.168800]        vfs_write+0xb8/0x1a0
[    8.168801]        ksys_write+0x45/0xb0
[    8.168802]        do_syscall_64+0x59/0x3bb
[    8.168803]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    8.168804] 
               other info that might help us debug this:

[    8.168804] Chain exists of:
                 tty_mutex --> &tty->termios_rwsem --> &ldata->output_lock

[    8.168806]  Possible unsafe locking scenario:

[    8.168806]        CPU0                    CPU1
[    8.168807]        ----                    ----
[    8.168807]   lock(&ldata->output_lock);
[    8.168808]                                lock(&tty->termios_rwsem);
[    8.168809]                                lock(&ldata->output_lock);
[    8.168810]   lock(tty_mutex);
[    8.168810] 
                *** DEADLOCK ***

[    8.168811] 4 locks held by bash/380:
[    8.168812]  #0: 0000000022cdab25 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x24/0x50
[    8.168814]  #1: 00000000033fee14 (&tty->atomic_write_lock){+.+.}, at: tty_write_lock+0x18/0x50
[    8.168815]  #2: 00000000135c3a23 (&o_tty->termios_rwsem/1){++++}, at: n_tty_write+0x8c/0x4a0
[    8.168817]  #3: 00000000c4f3448a (&ldata->output_lock){+.+.}, at: n_tty_write+0x1b9/0x4a0
[    8.168819] 
               stack backtrace:
[    8.168820] CPU: 1 PID: 380 Comm: bash Not tainted 5.1.0-rc2-next-20190329-dbg-00014-g4d25d68aaf88-dirty #3228
[    8.168821] Call Trace:
[    8.168823]  dump_stack+0x67/0x90
[    8.168825]  print_circular_bug.isra.0.cold+0x1c5/0x225
[    8.168826]  check_prev_add.constprop.0+0x5f5/0xd20
[    8.168828]  ? mutex_destroy+0x50/0x50
[    8.168829]  __lock_acquire+0xc28/0xf90
[    8.168830]  ? __lock_acquire+0xc28/0xf90
[    8.168831]  lock_acquire+0x9a/0x170
[    8.168833]  ? pty_write+0x31/0xd0
[    8.168834]  ? pty_write+0x31/0xd0
[    8.168835]  __mutex_lock+0x7e/0x8c0
[    8.168836]  ? pty_write+0x31/0xd0
[    8.168837]  ? n_tty_write+0x1b9/0x4a0
[    8.168838]  ? __mutex_lock+0x7e/0x8c0
[    8.168839]  ? pty_write+0x31/0xd0
[    8.168840]  ? n_tty_write+0x1b9/0x4a0
[    8.168842]  ? pty_write+0x31/0xd0
[    8.168843]  pty_write+0x31/0xd0
[    8.168844]  n_tty_write+0x130/0x4a0
[    8.168845]  ? wait_woken+0xa0/0xa0
[    8.168846]  tty_write+0x192/0x2a0
[    8.168847]  ? n_tty_open+0xa0/0xa0
[    8.168849]  vfs_write+0xb8/0x1a0
[    8.168850]  ksys_write+0x45/0xb0
[    8.168851]  do_syscall_64+0x59/0x3bb
[    8.168852]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[    8.168854]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

	-ss
