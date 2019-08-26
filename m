Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F825C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F222CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fIiwM2dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfHZJZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:25:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38069 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:25:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so25552820edo.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZO8AbteKlDnbenLwdttIwUk2jVineZ9dTMFIq4Rq8ik=;
        b=fIiwM2dgadA1cMLcHt67f4Qo9bl8GB68NNkqqV74vxArzrrCbrpUyW7XH/EwZCdR+k
         QNYBIUXQ3Iz2wn2zLULk02tnL4BX7BpfNK7hUMQRncmWrdlqSG/8b++qSw5KyCPsX9lG
         pR7kBVMFJ5435PPwx/D6LcSyh1GVG9bV/ohk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZO8AbteKlDnbenLwdttIwUk2jVineZ9dTMFIq4Rq8ik=;
        b=ZHls+LXrQRrtKgpCzk7VoHZDIrUgoD7ZVeM/S22AEnPMujCsY6JAotyJB7k5/et+Gp
         /d0j4LmSR405waCno7hppRK/MRLqJ1rSy1HkxGI40Nww7kMILw9oG63jVsi90zOBz+Sw
         fn/XEHZqV3Uc3RBSzmg5glctB5wvQVrG5uzwxGXWV3lri2Q1aZb2ryarHDnxc3n1Sz0A
         2B0m6d4gws1HuzH4oxoYoG3U0Sr2CJpFnCXIYgthf+Hn0owqUPi/hqiSRiWIUH1Lg+iz
         OpoKtxvNdNMeywxoqCU3fcTQLATExheyJMidJkCIPvSzRknUbtIUycyECGtOjRnpD4ck
         3TJg==
X-Gm-Message-State: APjAAAWNORqD735goSW2I3L7lBSlDiXN1p9YElaSqukuERREWkh78eHw
        lIORwXnzljIOOS0ObDd9dv/1tQ==
X-Google-Smtp-Source: APXvYqzmWME8EYs7U4nS+IyGiFsRi8nOF8GJj5iEowz/URYb4zmpZ/uNNWXyJXg9ybAhr4N92XGf4w==
X-Received: by 2002:a50:d65e:: with SMTP id c30mr17485393edj.38.1566811497549;
        Mon, 26 Aug 2019 02:24:57 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id b18sm2895375eju.0.2019.08.26.02.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 02:24:56 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:24:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Message-ID: <20190826092408.GA2112@phenom.ffwll.local>
Mail-Followup-To: Hillf Danton <hdanton@sina.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190825141305.13984-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825141305.13984-1-hdanton@sina.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:13:05PM +0800, Hillf Danton wrote:
> 
> On Sun, 25 Aug 2019 04:28:01 -0700 Mikhail Gavrilov wrote:
> > Hi folks,
> > I left unblocked gnome-shell at noon, and when I returned at the
> > evening I discovered than monitor not sleeping and show open gnome
> > activity. At first, I thought that some application did not let fall
> > asleep the system. But when I try to move the mouse, I realized that
> > the system hanged. So I connect via ssh and tried to investigate the
> > problem. I did not see anything strange in kernel logs. And my last
> > idea before trying to kill the gnome-shell process was dumps tasks
> > that are in uninterruptable (blocked) state.
> > 
> > After [Alt + PrnScr + W] I saw this:
> > 
> > [32840.701909] sysrq: Show Blocked State
> > [32840.701976]   task                        PC stack   pid father
> > [32840.702407] gnome-shell     D11240  1900   1830 0x00000000
> > [32840.702438] Call Trace:
> > [32840.702446]  ? __schedule+0x352/0x900
> > [32840.702453]  schedule+0x3a/0xb0
> > [32840.702457]  schedule_timeout+0x289/0x3c0
> > [32840.702461]  ? find_held_lock+0x32/0x90
> > [32840.702464]  ? find_held_lock+0x32/0x90
> > [32840.702469]  ? mark_held_locks+0x50/0x80
> > [32840.702473]  ? _raw_spin_unlock_irqrestore+0x4b/0x60
> > [32840.702478]  dma_fence_default_wait+0x1f5/0x340
> > [32840.702482]  ? dma_fence_free+0x20/0x20
> > [32840.702487]  dma_fence_wait_timeout+0x182/0x1e0
> > [32840.702533]  amdgpu_fence_wait_empty+0xe7/0x210 [amdgpu]
> > [32840.702577]  amdgpu_pm_compute_clocks+0x70/0x5f0 [amdgpu]
> > [32840.702641]  dm_pp_apply_display_requirements+0x19e/0x1c0 [amdgpu]
> > [32840.702705]  dce12_update_clocks+0xd8/0x110 [amdgpu]
> > [32840.702766]  dc_commit_state+0x414/0x590 [amdgpu]
> > [32840.702834]  amdgpu_dm_atomic_commit_tail+0xd1e/0x1cf0 [amdgpu]
> > [32840.702840]  ? reacquire_held_locks+0xed/0x210
> > [32840.702848]  ? ttm_eu_backoff_reservation+0xa5/0x160 [ttm]
> > [32840.702853]  ? find_held_lock+0x32/0x90
> > [32840.702855]  ? find_held_lock+0x32/0x90
> > [32840.702860]  ? __lock_acquire+0x247/0x1910
> > [32840.702867]  ? find_held_lock+0x32/0x90
> > [32840.702871]  ? mark_held_locks+0x50/0x80
> > [32840.702874]  ? _raw_spin_unlock_irq+0x29/0x40
> > [32840.702877]  ? lockdep_hardirqs_on+0xf0/0x180
> > [32840.702881]  ? _raw_spin_unlock_irq+0x29/0x40
> > [32840.702884]  ? wait_for_completion_timeout+0x75/0x190
> > [32840.702895]  ? commit_tail+0x3c/0x70 [drm_kms_helper]
> > [32840.702902]  commit_tail+0x3c/0x70 [drm_kms_helper]
> > [32840.702909]  drm_atomic_helper_commit+0xe3/0x150 [drm_kms_helper]
> > [32840.702922]  drm_atomic_connector_commit_dpms+0xd7/0x100 [drm]
> > [32840.702936]  set_property_atomic+0xcc/0x140 [drm]
> > [32840.702955]  drm_mode_obj_set_property_ioctl+0xcb/0x1c0 [drm]
> > [32840.702968]  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
> > [32840.702978]  drm_ioctl_kernel+0xaa/0xf0 [drm]
> > [32840.702990]  drm_ioctl+0x208/0x390 [drm]
> > [32840.703003]  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
> > [32840.703007]  ? sched_clock_cpu+0xc/0xc0
> > [32840.703012]  ? lockdep_hardirqs_on+0xf0/0x180
> > [32840.703053]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> > [32840.703058]  do_vfs_ioctl+0x411/0x750
> > [32840.703065]  ksys_ioctl+0x5e/0x90
> > [32840.703069]  __x64_sys_ioctl+0x16/0x20
> > [32840.703072]  do_syscall_64+0x5c/0xb0
> > [32840.703076]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [32840.703079] RIP: 0033:0x7f8bcab0f00b
> > [32840.703084] Code: Bad RIP value.
> > [32840.703086] RSP: 002b:00007ffe76c62338 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [32840.703089] RAX: ffffffffffffffda RBX: 00007ffe76c62370 RCX: 00007f8bcab0f00b
> > [32840.703092] RDX: 00007ffe76c62370 RSI: 00000000c01864ba RDI: 0000000000000009
> > [32840.703094] RBP: 00000000c01864ba R08: 0000000000000003 R09: 00000000c0c0c0c0
> > [32840.703096] R10: 000056476c86a018 R11: 0000000000000246 R12: 000056476c8ad940
> > [32840.703098] R13: 0000000000000009 R14: 0000000000000002 R15: 0000000000000003
> > [root@localhost ~]#
> > [root@localhost ~]# ps aux | grep gnome-shell
> > mikhail     1900  0.3  1.1 6447496 378696 tty2   Dl+  Aug24   2:10 > /usr/bin/gnome-shell
> > mikhail     2099  0.0  0.0 519984 23392 ?        Ssl  Aug24   0:00 > /usr/libexec/gnome-shell-calendar-server
> > mikhail    12214  0.0  0.0 399484 29660 pts/2    Sl+  Aug24   0:00 > /usr/bin/python3 /usr/bin/chrome-gnome-shell
> > chrome-extension://gphhapmejobijbbhgpjhcjognlahblep/
> > root       22957  0.0  0.0 216120  2456 pts/10   S+   03:59   0:00 > grep --color=auto gnome-shell
> > 
> > After it, I tried to kill gnome-shell process with signal 9, but the
> > process won't terminate after several unsuccessful attempts.
> > 
> > Only [Alt + PrnScr + B] helped reboot the hanging system.
> > I am writing here because I hope some ampgpu hackers cal look in the
> > trace and understand that is happening.
> > 
> > Sorry, I dont know how to reproduce this bug. But the problem itself
> > is very annoying.
> > 
> > Thanks.
> > 
> > GPU: AMD Radeon VII
> > Kernel: 5.3 RC5
> > 
> Can we try to add the fallback timer manually?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,6 +322,10 @@ int amdgpu_fence_wait_empty(struct amdgp
>  	}
>  	rcu_read_unlock();
>  
> +	if (!timer_pending(&ring->fence_drv.fallback_timer))
> +		mod_timer(&ring->fence_drv.fallback_timer,
> +			jiffies + (AMDGPU_FENCE_JIFFIES_TIMEOUT << 1));

This will paper over the issue, but won't fix it. dma_fences have to
complete, at least for normal operations, otherwise your desktop will
start feeling like the gpu hangs all the time.

I think would be much more interesting to dump which fence isn't
completing here in time, i.e. not just the timeout, but lots of debug
printks.
-Daniel

> +
>  	r = dma_fence_wait(fence, false);
>  	dma_fence_put(fence);
>  	return r;
> --
> 
> Or simply wait with an ear on signal and timeout if adding timer seems
> to go a bit too far?
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -322,7 +322,12 @@ int amdgpu_fence_wait_empty(struct amdgp
>  	}
>  	rcu_read_unlock();
>  
> -	r = dma_fence_wait(fence, false);
> +	if (0 < dma_fence_wait_timeout(fence, true,
> +				AMDGPU_FENCE_JIFFIES_TIMEOUT +
> +				(AMDGPU_FENCE_JIFFIES_TIMEOUT >> 3)))
> +		r = 0;
> +	else
> +		r = -EINVAL;
>  	dma_fence_put(fence);
>  	return r;
>  }
> --
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
