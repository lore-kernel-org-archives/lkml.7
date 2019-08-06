Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5D1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB7920B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ristioja.ee header.i=@ristioja.ee header.b="fWMaSV+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfHFSGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:06:52 -0400
Received: from heh.ee ([213.35.143.160]:53210 "EHLO mx1.heh.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbfHFSGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:06:52 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 14:06:50 EDT
Received: from [0.0.0.0] (unknown [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.heh.ee (Postfix) with ESMTPSA id 1F08D16BDB9;
        Tue,  6 Aug 2019 20:59:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ristioja.ee; s=mail;
        t=1565114396; bh=T2Y9CUN+uKC8gX7t4fAZkVpFPD9j4PDSZGpdx5uw5QM=;
        h=From:Subject:To:Date;
        b=fWMaSV+IJ12Gy5wgM8/J8SVZVhvyDfVQjz6G/XXYiUeVQVxqHAnw0XFMDBEXmBumz
         q10Iw6ZyNw/fMhetjDNy2n6cn2pnN7KubntwRgaz17XwDCNqMI7qLWl53fHnh0Rkye
         AMc9kqpgMZopS5yoGjCPCl1ozq6x++XOYo6llACI=
From:   Jaak Ristioja <jaak@ristioja.ee>
Subject: Xorg indefinitely hangs in kernelspace
Openpgp: preference=signencrypt
Autocrypt: addr=jaak@ristioja.ee; prefer-encrypt=mutual; keydata=
 mDMEWyjlXBYJKwYBBAHaRw8BAQdABEPNmQfWmwZZXSl5vKnpI1UVtS4l2N9kv7KqyFYtfLe0
 IEphYWsgUmlzdGlvamEgPGphYWtAcmlzdGlvamEuZWU+iJYEExYIAD4WIQTjaPCMFhRItZ2p
 iV/uxscoTrbt3AUCWyjlXAIbIwUJA8OZNAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDu
 xscoTrbt3OYPAP9l6ZjLh4qK2r/H1b+7a7qZIAjwf0o4AX6qvtX1WERxywEAhhtOHg+G8idL
 FR08XPW7nlobl2qEHMnqBTqteSsz1gG4OARbKOVcEgorBgEEAZdVAQUBAQdAU6y3a2gcxTI+
 bZgPkJjPXxr0tvuLpCqkIb/envF5ajADAQgHiH4EGBYIACYWIQTjaPCMFhRItZ2piV/uxsco
 Trbt3AUCWyjlXAIbDAUJA8OZNAAKCRDuxscoTrbt3OG5AP0cd6gLbKVSBvSEgRNQ+BNk/1a5
 lSQtocXAcwUx0X9h0gEAqIZ9u7pCWBlRTL+rij97VWWkB/jb1deZ2gExNhd6RAU=
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
Date:   Tue, 6 Aug 2019 21:00:10 +0300
User-Agent: undefined
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm writing to report a crash in the QXL / DRM code in the Linux kernel.
I originally filed the issue on LaunchPad and more details can be found
there, although I doubt whether these details are useful.

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1813620

I first experienced these issues with:

* Ubuntu 18.04 (probably kernel 4.15.something)
* Ubuntu 18.10 (kernel 4.18.0-13)
* Ubuntu 19.04 (kernel 5.0.0-13-generic)
* Ubuntu 19.04 (mainline kernel 5.1-rc7)
* Ubuntu 19.04 (mainline kernel 5.2.0-050200rc1-generic)

Here is the crash output from dmesg:

[354073.713350] INFO: task Xorg:920 blocked for more than 120 seconds.
[354073.717755]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354073.722277] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354073.738332] Xorg            D    0   920    854 0x00404004
[354073.738334] Call Trace:
[354073.738340]  __schedule+0x2ba/0x650
[354073.738342]  schedule+0x2d/0x90
[354073.738343]  schedule_preempt_disabled+0xe/0x10
[354073.738345]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354073.738346]  __ww_mutex_lock_slowpath+0x16/0x20
[354073.738347]  ww_mutex_lock+0x34/0x50
[354073.738352]  ttm_eu_reserve_buffers+0x1f9/0x2e0 [ttm]
[354073.738356]  qxl_release_reserve_list+0x67/0x150 [qxl]
[354073.738358]  ? qxl_bo_pin+0xaa/0x190 [qxl]
[354073.738359]  qxl_cursor_atomic_update+0x1b0/0x2e0 [qxl]
[354073.738367]  drm_atomic_helper_commit_planes+0xb9/0x220 [drm_kms_helper]
[354073.738371]  drm_atomic_helper_commit_tail+0x2b/0x70 [drm_kms_helper]
[354073.738374]  commit_tail+0x67/0x70 [drm_kms_helper]
[354073.738378]  drm_atomic_helper_commit+0x113/0x120 [drm_kms_helper]
[354073.738390]  drm_atomic_commit+0x4a/0x50 [drm]
[354073.738394]  drm_atomic_helper_update_plane+0xe9/0x100 [drm_kms_helper]
[354073.738402]  __setplane_atomic+0xd3/0x120 [drm]
[354073.738410]  drm_mode_cursor_universal+0x142/0x270 [drm]
[354073.738418]  drm_mode_cursor_common+0xcb/0x220 [drm]
[354073.738425]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354073.738432]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
[354073.738438]  drm_ioctl_kernel+0xb0/0x100 [drm]
[354073.738440]  ? ___sys_recvmsg+0x16c/0x200
[354073.738445]  drm_ioctl+0x233/0x410 [drm]
[354073.738452]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354073.738454]  ? timerqueue_add+0x57/0x90
[354073.738456]  ? enqueue_hrtimer+0x3c/0x90
[354073.738458]  do_vfs_ioctl+0xa9/0x640
[354073.738459]  ? fput+0x13/0x20
[354073.738461]  ? __sys_recvmsg+0x88/0xa0
[354073.738462]  ksys_ioctl+0x67/0x90
[354073.738463]  __x64_sys_ioctl+0x1a/0x20
[354073.738465]  do_syscall_64+0x5a/0x140
[354073.738467]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[354073.738468] RIP: 0033:0x7ffad14d3417
[354073.738472] Code: Bad RIP value.
[354073.738472] RSP: 002b:00007ffdd5679978 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[354073.738473] RAX: ffffffffffffffda RBX: 000056428a474610 RCX:
00007ffad14d3417
[354073.738474] RDX: 00007ffdd56799b0 RSI: 00000000c02464bb RDI:
000000000000000e
[354073.738474] RBP: 00007ffdd56799b0 R08: 0000000000000040 R09:
0000000000000010
[354073.738475] R10: 000000000000003f R11: 0000000000003246 R12:
00000000c02464bb
[354073.738475] R13: 000000000000000e R14: 0000000000000000 R15:
000056428a4721d0
[354073.738511] INFO: task kworker/1:0:27625 blocked for more than 120
seconds.
[354073.745154]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354073.751900] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354073.762197] kworker/1:0     D    0 27625      2 0x80004000
[354073.762205] Workqueue: events qxl_client_monitors_config_work_func [qxl]
[354073.762206] Call Trace:
[354073.762211]  __schedule+0x2ba/0x650
[354073.762214]  schedule+0x2d/0x90
[354073.762215]  schedule_preempt_disabled+0xe/0x10
[354073.762216]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354073.762217]  ? __switch_to_asm+0x34/0x70
[354073.762218]  ? __switch_to_asm+0x40/0x70
[354073.762219]  ? __switch_to_asm+0x40/0x70
[354073.762220]  __ww_mutex_lock_slowpath+0x16/0x20
[354073.762221]  ww_mutex_lock+0x34/0x50
[354073.762235]  drm_modeset_lock+0x35/0xb0 [drm]
[354073.762243]  drm_modeset_lock_all_ctx+0x5d/0xe0 [drm]
[354073.762251]  drm_modeset_lock_all+0x5e/0xb0 [drm]
[354073.762252]  qxl_display_read_client_monitors_config+0x1e1/0x370 [qxl]
[354073.762254]  qxl_client_monitors_config_work_func+0x15/0x20 [qxl]
[354073.762256]  process_one_work+0x20f/0x410
[354073.762257]  worker_thread+0x34/0x400
[354073.762259]  kthread+0x120/0x140
[354073.762260]  ? process_one_work+0x410/0x410
[354073.762261]  ? __kthread_parkme+0x70/0x70
[354073.762262]  ret_from_fork+0x35/0x40
[354194.557095] INFO: task Xorg:920 blocked for more than 241 seconds.
[354194.558311]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354194.559484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354194.560936] Xorg            D    0   920    854 0x00404004
[354194.560938] Call Trace:
[354194.560944]  __schedule+0x2ba/0x650
[354194.560946]  schedule+0x2d/0x90
[354194.560947]  schedule_preempt_disabled+0xe/0x10
[354194.560948]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354194.560950]  __ww_mutex_lock_slowpath+0x16/0x20
[354194.560950]  ww_mutex_lock+0x34/0x50
[354194.560956]  ttm_eu_reserve_buffers+0x1f9/0x2e0 [ttm]
[354194.560959]  qxl_release_reserve_list+0x67/0x150 [qxl]
[354194.560961]  ? qxl_bo_pin+0xaa/0x190 [qxl]
[354194.560963]  qxl_cursor_atomic_update+0x1b0/0x2e0 [qxl]
[354194.560971]  drm_atomic_helper_commit_planes+0xb9/0x220 [drm_kms_helper]
[354194.560975]  drm_atomic_helper_commit_tail+0x2b/0x70 [drm_kms_helper]
[354194.560979]  commit_tail+0x67/0x70 [drm_kms_helper]
[354194.560982]  drm_atomic_helper_commit+0x113/0x120 [drm_kms_helper]
[354194.560993]  drm_atomic_commit+0x4a/0x50 [drm]
[354194.560997]  drm_atomic_helper_update_plane+0xe9/0x100 [drm_kms_helper]
[354194.561011]  __setplane_atomic+0xd3/0x120 [drm]
[354194.561019]  drm_mode_cursor_universal+0x142/0x270 [drm]
[354194.561027]  drm_mode_cursor_common+0xcb/0x220 [drm]
[354194.561034]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354194.561041]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
[354194.561047]  drm_ioctl_kernel+0xb0/0x100 [drm]
[354194.561049]  ? ___sys_recvmsg+0x16c/0x200
[354194.561057]  drm_ioctl+0x233/0x410 [drm]
[354194.561080]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354194.561082]  ? timerqueue_add+0x57/0x90
[354194.561084]  ? enqueue_hrtimer+0x3c/0x90
[354194.561086]  do_vfs_ioctl+0xa9/0x640
[354194.561088]  ? fput+0x13/0x20
[354194.561089]  ? __sys_recvmsg+0x88/0xa0
[354194.561090]  ksys_ioctl+0x67/0x90
[354194.561091]  __x64_sys_ioctl+0x1a/0x20
[354194.561093]  do_syscall_64+0x5a/0x140
[354194.561094]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[354194.561096] RIP: 0033:0x7ffad14d3417
[354194.561100] Code: Bad RIP value.
[354194.561100] RSP: 002b:00007ffdd5679978 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[354194.561101] RAX: ffffffffffffffda RBX: 000056428a474610 RCX:
00007ffad14d3417
[354194.561102] RDX: 00007ffdd56799b0 RSI: 00000000c02464bb RDI:
000000000000000e
[354194.561102] RBP: 00007ffdd56799b0 R08: 0000000000000040 R09:
0000000000000010
[354194.561103] R10: 000000000000003f R11: 0000000000003246 R12:
00000000c02464bb
[354194.561103] R13: 000000000000000e R14: 0000000000000000 R15:
000056428a4721d0
[354194.561163] INFO: task kworker/1:0:27625 blocked for more than 241
seconds.
[354194.562474]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354194.563994] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354194.565474] kworker/1:0     D    0 27625      2 0x80004000
[354194.565479] Workqueue: events qxl_client_monitors_config_work_func [qxl]
[354194.565480] Call Trace:
[354194.565483]  __schedule+0x2ba/0x650
[354194.565484]  schedule+0x2d/0x90
[354194.565486]  schedule_preempt_disabled+0xe/0x10
[354194.565486]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354194.565488]  ? __switch_to_asm+0x34/0x70
[354194.565489]  ? __switch_to_asm+0x40/0x70
[354194.565490]  ? __switch_to_asm+0x40/0x70
[354194.565490]  __ww_mutex_lock_slowpath+0x16/0x20
[354194.565491]  ww_mutex_lock+0x34/0x50
[354194.565499]  drm_modeset_lock+0x35/0xb0 [drm]
[354194.565507]  drm_modeset_lock_all_ctx+0x5d/0xe0 [drm]
[354194.565514]  drm_modeset_lock_all+0x5e/0xb0 [drm]
[354194.565516]  qxl_display_read_client_monitors_config+0x1e1/0x370 [qxl]
[354194.565518]  qxl_client_monitors_config_work_func+0x15/0x20 [qxl]
[354194.565519]  process_one_work+0x20f/0x410
[354194.565521]  worker_thread+0x34/0x400
[354194.565522]  kthread+0x120/0x140
[354194.565523]  ? process_one_work+0x410/0x410
[354194.565524]  ? __kthread_parkme+0x70/0x70
[354194.565525]  ret_from_fork+0x35/0x40
[354315.400956] INFO: task Xorg:920 blocked for more than 362 seconds.
[354315.411626]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354315.422647] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354315.435897] Xorg            D    0   920    854 0x00404004
[354315.435899] Call Trace:
[354315.435923]  __schedule+0x2ba/0x650
[354315.435925]  schedule+0x2d/0x90
[354315.435927]  schedule_preempt_disabled+0xe/0x10
[354315.435928]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354315.435929]  __ww_mutex_lock_slowpath+0x16/0x20
[354315.435930]  ww_mutex_lock+0x34/0x50
[354315.435935]  ttm_eu_reserve_buffers+0x1f9/0x2e0 [ttm]
[354315.435939]  qxl_release_reserve_list+0x67/0x150 [qxl]
[354315.435941]  ? qxl_bo_pin+0xaa/0x190 [qxl]
[354315.435943]  qxl_cursor_atomic_update+0x1b0/0x2e0 [qxl]
[354315.435951]  drm_atomic_helper_commit_planes+0xb9/0x220 [drm_kms_helper]
[354315.435955]  drm_atomic_helper_commit_tail+0x2b/0x70 [drm_kms_helper]
[354315.435958]  commit_tail+0x67/0x70 [drm_kms_helper]
[354315.435962]  drm_atomic_helper_commit+0x113/0x120 [drm_kms_helper]
[354315.435974]  drm_atomic_commit+0x4a/0x50 [drm]
[354315.435977]  drm_atomic_helper_update_plane+0xe9/0x100 [drm_kms_helper]
[354315.435985]  __setplane_atomic+0xd3/0x120 [drm]
[354315.435993]  drm_mode_cursor_universal+0x142/0x270 [drm]
[354315.436001]  drm_mode_cursor_common+0xcb/0x220 [drm]
[354315.436009]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354315.436016]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
[354315.436021]  drm_ioctl_kernel+0xb0/0x100 [drm]
[354315.436023]  ? ___sys_recvmsg+0x16c/0x200
[354315.436029]  drm_ioctl+0x233/0x410 [drm]
[354315.436036]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354315.436038]  ? timerqueue_add+0x57/0x90
[354315.436040]  ? enqueue_hrtimer+0x3c/0x90
[354315.436042]  do_vfs_ioctl+0xa9/0x640
[354315.436043]  ? fput+0x13/0x20
[354315.436045]  ? __sys_recvmsg+0x88/0xa0
[354315.436046]  ksys_ioctl+0x67/0x90
[354315.436047]  __x64_sys_ioctl+0x1a/0x20
[354315.436049]  do_syscall_64+0x5a/0x140
[354315.436050]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[354315.436051] RIP: 0033:0x7ffad14d3417
[354315.436069] Code: Bad RIP value.
[354315.436070] RSP: 002b:00007ffdd5679978 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[354315.436071] RAX: ffffffffffffffda RBX: 000056428a474610 RCX:
00007ffad14d3417
[354315.436071] RDX: 00007ffdd56799b0 RSI: 00000000c02464bb RDI:
000000000000000e
[354315.436072] RBP: 00007ffdd56799b0 R08: 0000000000000040 R09:
0000000000000010
[354315.436072] R10: 000000000000003f R11: 0000000000003246 R12:
00000000c02464bb
[354315.436073] R13: 000000000000000e R14: 0000000000000000 R15:
000056428a4721d0
[354315.436103] INFO: task kworker/1:0:27625 blocked for more than 362
seconds.
[354315.451103]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354315.461927] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354315.477908] kworker/1:0     D    0 27625      2 0x80004000
[354315.477916] Workqueue: events qxl_client_monitors_config_work_func [qxl]
[354315.477918] Call Trace:
[354315.477924]  __schedule+0x2ba/0x650
[354315.477925]  schedule+0x2d/0x90
[354315.477927]  schedule_preempt_disabled+0xe/0x10
[354315.477928]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354315.477930]  ? __switch_to_asm+0x34/0x70
[354315.477931]  ? __switch_to_asm+0x40/0x70
[354315.477932]  ? __switch_to_asm+0x40/0x70
[354315.477933]  __ww_mutex_lock_slowpath+0x16/0x20
[354315.477933]  ww_mutex_lock+0x34/0x50
[354315.477947]  drm_modeset_lock+0x35/0xb0 [drm]
[354315.477955]  drm_modeset_lock_all_ctx+0x5d/0xe0 [drm]
[354315.477963]  drm_modeset_lock_all+0x5e/0xb0 [drm]
[354315.477965]  qxl_display_read_client_monitors_config+0x1e1/0x370 [qxl]
[354315.477967]  qxl_client_monitors_config_work_func+0x15/0x20 [qxl]
[354315.477969]  process_one_work+0x20f/0x410
[354315.477970]  worker_thread+0x34/0x400
[354315.477972]  kthread+0x120/0x140
[354315.477973]  ? process_one_work+0x410/0x410
[354315.477973]  ? __kthread_parkme+0x70/0x70
[354315.477975]  ret_from_fork+0x35/0x40
[354436.251965] INFO: task Xorg:920 blocked for more than 483 seconds.
[354436.253054]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354436.254109] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354436.255421] Xorg            D    0   920    854 0x00404004
[354436.255423] Call Trace:
[354436.255429]  __schedule+0x2ba/0x650
[354436.255431]  schedule+0x2d/0x90
[354436.255433]  schedule_preempt_disabled+0xe/0x10
[354436.255434]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354436.255435]  __ww_mutex_lock_slowpath+0x16/0x20
[354436.255435]  ww_mutex_lock+0x34/0x50
[354436.255441]  ttm_eu_reserve_buffers+0x1f9/0x2e0 [ttm]
[354436.255445]  qxl_release_reserve_list+0x67/0x150 [qxl]
[354436.255446]  ? qxl_bo_pin+0xaa/0x190 [qxl]
[354436.255448]  qxl_cursor_atomic_update+0x1b0/0x2e0 [qxl]
[354436.255456]  drm_atomic_helper_commit_planes+0xb9/0x220 [drm_kms_helper]
[354436.255459]  drm_atomic_helper_commit_tail+0x2b/0x70 [drm_kms_helper]
[354436.255463]  commit_tail+0x67/0x70 [drm_kms_helper]
[354436.255467]  drm_atomic_helper_commit+0x113/0x120 [drm_kms_helper]
[354436.255479]  drm_atomic_commit+0x4a/0x50 [drm]
[354436.255482]  drm_atomic_helper_update_plane+0xe9/0x100 [drm_kms_helper]
[354436.255490]  __setplane_atomic+0xd3/0x120 [drm]
[354436.255498]  drm_mode_cursor_universal+0x142/0x270 [drm]
[354436.255506]  drm_mode_cursor_common+0xcb/0x220 [drm]
[354436.255513]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354436.255520]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
[354436.255526]  drm_ioctl_kernel+0xb0/0x100 [drm]
[354436.255527]  ? ___sys_recvmsg+0x16c/0x200
[354436.255533]  drm_ioctl+0x233/0x410 [drm]
[354436.255540]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354436.255542]  ? timerqueue_add+0x57/0x90
[354436.255544]  ? enqueue_hrtimer+0x3c/0x90
[354436.255546]  do_vfs_ioctl+0xa9/0x640
[354436.255547]  ? fput+0x13/0x20
[354436.255548]  ? __sys_recvmsg+0x88/0xa0
[354436.255550]  ksys_ioctl+0x67/0x90
[354436.255551]  __x64_sys_ioctl+0x1a/0x20
[354436.255553]  do_syscall_64+0x5a/0x140
[354436.255554]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[354436.255555] RIP: 0033:0x7ffad14d3417
[354436.255559] Code: Bad RIP value.
[354436.255560] RSP: 002b:00007ffdd5679978 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[354436.255561] RAX: ffffffffffffffda RBX: 000056428a474610 RCX:
00007ffad14d3417
[354436.255561] RDX: 00007ffdd56799b0 RSI: 00000000c02464bb RDI:
000000000000000e
[354436.255562] RBP: 00007ffdd56799b0 R08: 0000000000000040 R09:
0000000000000010
[354436.255562] R10: 000000000000003f R11: 0000000000003246 R12:
00000000c02464bb
[354436.255563] R13: 000000000000000e R14: 0000000000000000 R15:
000056428a4721d0
[354436.255599] INFO: task kworker/1:0:27625 blocked for more than 483
seconds.
[354436.256802]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354436.257874] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354436.278727] kworker/1:0     D    0 27625      2 0x80004000
[354436.278735] Workqueue: events qxl_client_monitors_config_work_func [qxl]
[354436.278736] Call Trace:
[354436.278742]  __schedule+0x2ba/0x650
[354436.278743]  schedule+0x2d/0x90
[354436.278745]  schedule_preempt_disabled+0xe/0x10
[354436.278746]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354436.278747]  ? __switch_to_asm+0x34/0x70
[354436.278748]  ? __switch_to_asm+0x40/0x70
[354436.278749]  ? __switch_to_asm+0x40/0x70
[354436.278750]  __ww_mutex_lock_slowpath+0x16/0x20
[354436.278751]  ww_mutex_lock+0x34/0x50
[354436.278764]  drm_modeset_lock+0x35/0xb0 [drm]
[354436.278772]  drm_modeset_lock_all_ctx+0x5d/0xe0 [drm]
[354436.278779]  drm_modeset_lock_all+0x5e/0xb0 [drm]
[354436.278781]  qxl_display_read_client_monitors_config+0x1e1/0x370 [qxl]
[354436.278783]  qxl_client_monitors_config_work_func+0x15/0x20 [qxl]
[354436.278785]  process_one_work+0x20f/0x410
[354436.278786]  worker_thread+0x34/0x400
[354436.278787]  kthread+0x120/0x140
[354436.278788]  ? process_one_work+0x410/0x410
[354436.278789]  ? __kthread_parkme+0x70/0x70
[354436.278790]  ret_from_fork+0x35/0x40
[354557.088600] INFO: task Xorg:920 blocked for more than 604 seconds.
[354557.089689]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354557.090759] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354557.092075] Xorg            D    0   920    854 0x00404004
[354557.092077] Call Trace:
[354557.092083]  __schedule+0x2ba/0x650
[354557.092085]  schedule+0x2d/0x90
[354557.092086]  schedule_preempt_disabled+0xe/0x10
[354557.092087]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354557.092089]  __ww_mutex_lock_slowpath+0x16/0x20
[354557.092089]  ww_mutex_lock+0x34/0x50
[354557.092095]  ttm_eu_reserve_buffers+0x1f9/0x2e0 [ttm]
[354557.092098]  qxl_release_reserve_list+0x67/0x150 [qxl]
[354557.092100]  ? qxl_bo_pin+0xaa/0x190 [qxl]
[354557.092102]  qxl_cursor_atomic_update+0x1b0/0x2e0 [qxl]
[354557.092110]  drm_atomic_helper_commit_planes+0xb9/0x220 [drm_kms_helper]
[354557.092114]  drm_atomic_helper_commit_tail+0x2b/0x70 [drm_kms_helper]
[354557.092117]  commit_tail+0x67/0x70 [drm_kms_helper]
[354557.092121]  drm_atomic_helper_commit+0x113/0x120 [drm_kms_helper]
[354557.092133]  drm_atomic_commit+0x4a/0x50 [drm]
[354557.092137]  drm_atomic_helper_update_plane+0xe9/0x100 [drm_kms_helper]
[354557.092145]  __setplane_atomic+0xd3/0x120 [drm]
[354557.092154]  drm_mode_cursor_universal+0x142/0x270 [drm]
[354557.092162]  drm_mode_cursor_common+0xcb/0x220 [drm]
[354557.092170]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354557.092179]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
[354557.092185]  drm_ioctl_kernel+0xb0/0x100 [drm]
[354557.092187]  ? ___sys_recvmsg+0x16c/0x200
[354557.092193]  drm_ioctl+0x233/0x410 [drm]
[354557.092201]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[354557.092203]  ? timerqueue_add+0x57/0x90
[354557.092205]  ? enqueue_hrtimer+0x3c/0x90
[354557.092207]  do_vfs_ioctl+0xa9/0x640
[354557.092208]  ? fput+0x13/0x20
[354557.092209]  ? __sys_recvmsg+0x88/0xa0
[354557.092210]  ksys_ioctl+0x67/0x90
[354557.092212]  __x64_sys_ioctl+0x1a/0x20
[354557.092213]  do_syscall_64+0x5a/0x140
[354557.092215]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[354557.092216] RIP: 0033:0x7ffad14d3417
[354557.092220] Code: Bad RIP value.
[354557.092221] RSP: 002b:00007ffdd5679978 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[354557.092222] RAX: ffffffffffffffda RBX: 000056428a474610 RCX:
00007ffad14d3417
[354557.092223] RDX: 00007ffdd56799b0 RSI: 00000000c02464bb RDI:
000000000000000e
[354557.092223] RBP: 00007ffdd56799b0 R08: 0000000000000040 R09:
0000000000000010
[354557.092223] R10: 000000000000003f R11: 0000000000003246 R12:
00000000c02464bb
[354557.092224] R13: 000000000000000e R14: 0000000000000000 R15:
000056428a4721d0
[354557.092259] INFO: task kworker/1:0:27625 blocked for more than 604
seconds.
[354557.093464]       Not tainted 5.2.0-050200rc1-generic #201905191930
[354557.094520] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[354557.095834] kworker/1:0     D    0 27625      2 0x80004000
[354557.095838] Workqueue: events qxl_client_monitors_config_work_func [qxl]
[354557.095839] Call Trace:
[354557.095841]  __schedule+0x2ba/0x650
[354557.095843]  schedule+0x2d/0x90
[354557.095844]  schedule_preempt_disabled+0xe/0x10
[354557.095845]  __ww_mutex_lock.isra.11+0x3e0/0x750
[354557.095846]  ? __switch_to_asm+0x34/0x70
[354557.095847]  ? __switch_to_asm+0x40/0x70
[354557.095848]  ? __switch_to_asm+0x40/0x70
[354557.095849]  __ww_mutex_lock_slowpath+0x16/0x20
[354557.095850]  ww_mutex_lock+0x34/0x50
[354557.095858]  drm_modeset_lock+0x35/0xb0 [drm]
[354557.095866]  drm_modeset_lock_all_ctx+0x5d/0xe0 [drm]
[354557.095874]  drm_modeset_lock_all+0x5e/0xb0 [drm]
[354557.095876]  qxl_display_read_client_monitors_config+0x1e1/0x370 [qxl]
[354557.095878]  qxl_client_monitors_config_work_func+0x15/0x20 [qxl]
[354557.095880]  process_one_work+0x20f/0x410
[354557.095881]  worker_thread+0x34/0x400
[354557.095882]  kthread+0x120/0x140
[354557.095883]  ? process_one_work+0x410/0x410
[354557.095884]  ? __kthread_parkme+0x70/0x70
[354557.095885]  ret_from_fork+0x35/0x40

Please contact me if more information is needed.


Best regards,
Jaak Ristioja
