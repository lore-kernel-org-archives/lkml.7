Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8B2C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1FE2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394494AbfIFU1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732382AbfIFU1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1ED22DA980;
        Fri,  6 Sep 2019 20:27:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61F0F60BF1;
        Fri,  6 Sep 2019 20:27:43 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 956AB2551B;
        Fri,  6 Sep 2019 20:27:41 +0000 (UTC)
Date:   Fri, 6 Sep 2019 16:27:41 -0400 (EDT)
From:   Frediano Ziglio <fziglio@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jaak Ristioja <jaak@ristioja.ee>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
Message-ID: <236676538.10995729.1567801661076.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190906055322.17900-1-hdanton@sina.com>
References: <20190906055322.17900-1-hdanton@sina.com>
Subject: Re: [Spice-devel] Xorg indefinitely hangs in kernelspace
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.33.32.2, 10.4.195.2]
Thread-Topic: Xorg indefinitely hangs in kernelspace
Thread-Index: KkczUG/O2oqvsTo9E9PUNbvyJKRlsA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 06 Sep 2019 20:27:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 6 Aug 2019 21:00:10 +0300 From:   Jaak Ristioja <jaak@ristioja.ee>
> > Hello!
> > 
> > I'm writing to report a crash in the QXL / DRM code in the Linux kernel.
> > I originally filed the issue on LaunchPad and more details can be found
> > there, although I doubt whether these details are useful.
> > 
> >   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1813620
> > 
> > I first experienced these issues with:
> > 
> > * Ubuntu 18.04 (probably kernel 4.15.something)
> > * Ubuntu 18.10 (kernel 4.18.0-13)
> > * Ubuntu 19.04 (kernel 5.0.0-13-generic)
> > * Ubuntu 19.04 (mainline kernel 5.1-rc7)
> > * Ubuntu 19.04 (mainline kernel 5.2.0-050200rc1-generic)
> > 
> > Here is the crash output from dmesg:
> > 
> > [354073.713350] INFO: task Xorg:920 blocked for more than 120 seconds.
> > [354073.717755]       Not tainted 5.2.0-050200rc1-generic #201905191930
> > [354073.722277] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [354073.738332] Xorg            D    0   920    854 0x00404004
> > [354073.738334] Call Trace:
> > [354073.738340]  __schedule+0x2ba/0x650
> > [354073.738342]  schedule+0x2d/0x90
> > [354073.738343]  schedule_preempt_disabled+0xe/0x10
> > [354073.738345]  __ww_mutex_lock.isra.11+0x3e0/0x750
> > [354073.738346]  __ww_mutex_lock_slowpath+0x16/0x20
> > [354073.738347]  ww_mutex_lock+0x34/0x50
> > [354073.738352]  ttm_eu_reserve_buffers+0x1f9/0x2e0 [ttm]
> > [354073.738356]  qxl_release_reserve_list+0x67/0x150 [qxl]
> > [354073.738358]  ? qxl_bo_pin+0xaa/0x190 [qxl]
> > [354073.738359]  qxl_cursor_atomic_update+0x1b0/0x2e0 [qxl]
> > [354073.738367]  drm_atomic_helper_commit_planes+0xb9/0x220
> > [drm_kms_helper]
> > [354073.738371]  drm_atomic_helper_commit_tail+0x2b/0x70 [drm_kms_helper]
> > [354073.738374]  commit_tail+0x67/0x70 [drm_kms_helper]
> > [354073.738378]  drm_atomic_helper_commit+0x113/0x120 [drm_kms_helper]
> > [354073.738390]  drm_atomic_commit+0x4a/0x50 [drm]
> > [354073.738394]  drm_atomic_helper_update_plane+0xe9/0x100 [drm_kms_helper]
> > [354073.738402]  __setplane_atomic+0xd3/0x120 [drm]
> > [354073.738410]  drm_mode_cursor_universal+0x142/0x270 [drm]
> > [354073.738418]  drm_mode_cursor_common+0xcb/0x220 [drm]
> > [354073.738425]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> > [354073.738432]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
> > [354073.738438]  drm_ioctl_kernel+0xb0/0x100 [drm]
> > [354073.738440]  ? ___sys_recvmsg+0x16c/0x200
> > [354073.738445]  drm_ioctl+0x233/0x410 [drm]
> > [354073.738452]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> > [354073.738454]  ? timerqueue_add+0x57/0x90
> > [354073.738456]  ? enqueue_hrtimer+0x3c/0x90
> > [354073.738458]  do_vfs_ioctl+0xa9/0x640
> > [354073.738459]  ? fput+0x13/0x20
> > [354073.738461]  ? __sys_recvmsg+0x88/0xa0
> > [354073.738462]  ksys_ioctl+0x67/0x90
> > [354073.738463]  __x64_sys_ioctl+0x1a/0x20
> > [354073.738465]  do_syscall_64+0x5a/0x140
> > [354073.738467]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [354073.738468] RIP: 0033:0x7ffad14d3417
> > [354073.738472] Code: Bad RIP value.
> > [354073.738472] RSP: 002b:00007ffdd5679978 EFLAGS: 00003246 ORIG_RAX:
> > 0000000000000010
> > [354073.738473] RAX: ffffffffffffffda RBX: 000056428a474610 RCX:
> > 00007ffad14d3417
> > [354073.738474] RDX: 00007ffdd56799b0 RSI: 00000000c02464bb RDI:
> > 000000000000000e
> > [354073.738474] RBP: 00007ffdd56799b0 R08: 0000000000000040 R09:
> > 0000000000000010
> > [354073.738475] R10: 000000000000003f R11: 0000000000003246 R12:
> > 00000000c02464bb
> > [354073.738475] R13: 000000000000000e R14: 0000000000000000 R15:
> > 000056428a4721d0
> > [354073.738511] INFO: task kworker/1:0:27625 blocked for more than 120
> > seconds.
> > [354073.745154]       Not tainted 5.2.0-050200rc1-generic #201905191930
> > [354073.751900] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [354073.762197] kworker/1:0     D    0 27625      2 0x80004000
> > [354073.762205] Workqueue: events qxl_client_monitors_config_work_func
> > [qxl]
> > [354073.762206] Call Trace:
> > [354073.762211]  __schedule+0x2ba/0x650
> > [354073.762214]  schedule+0x2d/0x90
> > [354073.762215]  schedule_preempt_disabled+0xe/0x10
> > [354073.762216]  __ww_mutex_lock.isra.11+0x3e0/0x750
> > [354073.762217]  ? __switch_to_asm+0x34/0x70
> > [354073.762218]  ? __switch_to_asm+0x40/0x70
> > [354073.762219]  ? __switch_to_asm+0x40/0x70
> > [354073.762220]  __ww_mutex_lock_slowpath+0x16/0x20
> > [354073.762221]  ww_mutex_lock+0x34/0x50
> > [354073.762235]  drm_modeset_lock+0x35/0xb0 [drm]
> > [354073.762243]  drm_modeset_lock_all_ctx+0x5d/0xe0 [drm]
> > [354073.762251]  drm_modeset_lock_all+0x5e/0xb0 [drm]
> > [354073.762252]  qxl_display_read_client_monitors_config+0x1e1/0x370 [qxl]
> > [354073.762254]  qxl_client_monitors_config_work_func+0x15/0x20 [qxl]
> > [354073.762256]  process_one_work+0x20f/0x410
> > [354073.762257]  worker_thread+0x34/0x400
> > [354073.762259]  kthread+0x120/0x140
> > [354073.762260]  ? process_one_work+0x410/0x410
> > [354073.762261]  ? __kthread_parkme+0x70/0x70
> > [354073.762262]  ret_from_fork+0x35/0x40
> > 
> 
> --- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> @@ -97,8 +97,9 @@ int ttm_eu_reserve_buffers(struct ww_acq
>  			   struct list_head *dups, bool del_lru)
>  {
>  	struct ttm_bo_global *glob;
> -	struct ttm_validate_buffer *entry;
> +	struct ttm_validate_buffer *entry, *last_entry;
>  	int ret;
> +	bool locked = false;
>  
>  	if (list_empty(list))
>  		return 0;
> @@ -112,7 +113,10 @@ int ttm_eu_reserve_buffers(struct ww_acq
>  	list_for_each_entry(entry, list, head) {
>  		struct ttm_buffer_object *bo = entry->bo;
>  
> +		last_entry = entry;
>  		ret = __ttm_bo_reserve(bo, intr, (ticket == NULL), ticket);
> +		if (!ret)
> +			locked = true;
>  		if (!ret && unlikely(atomic_read(&bo->cpu_writers) > 0)) {
>  			reservation_object_unlock(bo->resv);
>  
> @@ -151,6 +155,10 @@ int ttm_eu_reserve_buffers(struct ww_acq
>  				ret = 0;
>  			}
>  		}
> +		if (!ret)
> +			locked = true;
> +		else
> +			locked = false;
>  

locked = !ret; 

?

>  		if (!ret && entry->num_shared)
>  			ret = reservation_object_reserve_shared(bo->resv,
> @@ -163,6 +171,8 @@ int ttm_eu_reserve_buffers(struct ww_acq
>  				ww_acquire_done(ticket);
>  				ww_acquire_fini(ticket);
>  			}
> +			if (locked)
> +				ttm_eu_backoff_reservation_reverse(list, entry);
>  			return ret;
>  		}
>  
> @@ -172,6 +182,8 @@ int ttm_eu_reserve_buffers(struct ww_acq
>  		list_del(&entry->head);
>  		list_add(&entry->head, list);
>  	}
> +	if (locked)
> +		ttm_eu_backoff_reservation_reverse(list, last_entry);
>  
>  	if (del_lru) {
>  		spin_lock(&glob->lru_lock);

Where does it came this patch? Is it already somewhere?
Is it supposed to fix this issue?
Does it affect some other card beside QXL?

Frediano
