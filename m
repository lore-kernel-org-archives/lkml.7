Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D1AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F641214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ristioja.ee header.i=@ristioja.ee header.b="m53PpNdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504129AbfIXJL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:11:59 -0400
Received: from heh.ee ([213.35.143.160]:43810 "EHLO mx1.heh.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504101AbfIXJL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:11:59 -0400
Received: from [0.0.0.0] (unknown [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.heh.ee (Postfix) with ESMTPSA id 28C8816D1A8;
        Tue, 24 Sep 2019 12:11:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ristioja.ee; s=mail;
        t=1569316317; bh=+FTdeih0wbhelrsKafPiC+6qY12Mc34G72pLIoqYmiU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=m53PpNduD1hhf1kZVpM5uW3cjTbX/ZkAuZniKln+7rLOnqU+GWzphvKGHDB49Lh19
         vP4BxN9sfZmTzQbl5qCfm+/lyXwtR12dBPp56dszXqANLAorYn47JQfZAHZOn8QCsL
         tEZNkP0EVv5sJ66Er7Z5YaF4bEjrw59bzxW6C7VE=
Subject: Re: Xorg indefinitely hangs in kernelspace
From:   Jaak Ristioja <jaak@ristioja.ee>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
 <20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
 <e4b7d889-15f3-0c90-3b9f-d395344499c0@ristioja.ee>
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
Message-ID: <ccafdbaf-7f8e-8616-5543-2a178bd63828@ristioja.ee>
Date:   Tue, 24 Sep 2019 12:12:16 +0300
User-Agent: undefined
MIME-Version: 1.0
In-Reply-To: <e4b7d889-15f3-0c90-3b9f-d395344499c0@ristioja.ee>
Content-Type: text/plain; charset=utf-8
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.19 15:34, Jaak Ristioja wrote:
> On 05.09.19 10:14, Gerd Hoffmann wrote:
>> On Tue, Aug 06, 2019 at 09:00:10PM +0300, Jaak Ristioja wrote:
>>> Hello!
>>>
>>> I'm writing to report a crash in the QXL / DRM code in the Linux kernel.
>>> I originally filed the issue on LaunchPad and more details can be found
>>> there, although I doubt whether these details are useful.
>>
>> Any change with kernel 5.3-rc7 ?
> 
> Didn't try. Did you change something? I could try, but I've done so
> before and every time this bug manifests itself with MAJOR.MINOR-rc# I
> get asked to try version MAJOR.(MINOR+1)-rc# so I guess I could as well
> give up?
> 
> Alright, I'll install 5.3-rc7, but once more it might take some time for
> this bug to expose itself.

Just got the issue with 5.3.0-050300rc7-generic:

[124212.547403] INFO: task Xorg:797 blocked for more than 120 seconds.
[124212.548639]       Not tainted 5.3.0-050300rc7-generic #201909021831
[124212.549839] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[124212.547403] INFO: task Xorg:797 blocked for more than 120 seconds.
[124212.548639]       Not tainted 5.3.0-050300rc7-generic #201909021831
[124212.549839] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[124212.551329] Xorg            D    0   797    773 0x00404004
[124212.551331] Call Trace:
[124212.551336]  __schedule+0x2b9/0x6c0
[124212.551337]  schedule+0x42/0xb0
[124212.551338]  schedule_preempt_disabled+0xe/0x10
[124212.551340]  __ww_mutex_lock.isra.0+0x261/0x7f0
[124212.551345]  ? ttm_bo_init+0x6b/0x100 [ttm]
[124212.551346]  __ww_mutex_lock_slowpath+0x16/0x20
[124212.551347]  ww_mutex_lock+0x38/0x90
[124212.551352]  ttm_eu_reserve_buffers+0x1cc/0x2f0 [ttm]
[124212.551371]  qxl_release_reserve_list+0x6d/0x150 [qxl]
[124212.551373]  ? qxl_bo_pin+0xf4/0x190 [qxl]
[124212.551375]  qxl_cursor_atomic_update+0x1ab/0x2e0 [qxl]
[124212.551376]  ? qxl_bo_pin+0xf4/0x190 [qxl]
[124212.551384]  drm_atomic_helper_commit_planes+0xd5/0x220 [drm_kms_helper]
[124212.551388]  drm_atomic_helper_commit_tail+0x2c/0x70 [drm_kms_helper]
[124212.551392]  commit_tail+0x68/0x70 [drm_kms_helper]
[124212.551395]  drm_atomic_helper_commit+0x118/0x120 [drm_kms_helper]
[124212.551407]  drm_atomic_commit+0x4a/0x50 [drm]
[124212.551411]  drm_atomic_helper_update_plane+0xea/0x100 [drm_kms_helper]
[124212.551418]  __setplane_atomic+0xcb/0x110 [drm]
[124212.551428]  drm_mode_cursor_universal+0x140/0x260 [drm]
[124212.551435]  drm_mode_cursor_common+0xcc/0x220 [drm]
[124212.551441]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[124212.551447]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
[124212.551452]  drm_ioctl_kernel+0xae/0xf0 [drm]
[124212.551458]  drm_ioctl+0x234/0x3d0 [drm]
[124212.551464]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[124212.551466]  ? timerqueue_add+0x5f/0xa0
[124212.551469]  ? enqueue_hrtimer+0x3d/0x90
[124212.551471]  do_vfs_ioctl+0x407/0x670
[124212.551473]  ? fput+0x13/0x20
[124212.551475]  ? __sys_recvmsg+0x88/0xa0
[124212.551476]  ksys_ioctl+0x67/0x90
[124212.551477]  __x64_sys_ioctl+0x1a/0x20
[124212.551479]  do_syscall_64+0x5a/0x130
[124212.551480]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[124212.551481] RIP: 0033:0x7f07c79ee417
[124212.551485] Code: Bad RIP value.
[124212.551485] RSP: 002b:00007ffc6b1de1a8 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[124212.551486] RAX: ffffffffffffffda RBX: 00005612f109a610 RCX:
00007f07c79ee417
[124212.551487] RDX: 00007ffc6b1de1e0 RSI: 00000000c02464bb RDI:
000000000000000e
[124212.551487] RBP: 00007ffc6b1de1e0 R08: 0000000000000040 R09:
0000000000000004
[124212.551488] R10: 000000000000003f R11: 0000000000003246 R12:
00000000c02464bb
[124212.551488] R13: 000000000000000e R14: 0000000000000000 R15:
00005612f10981d0
[124333.376328] INFO: task Xorg:797 blocked for more than 241 seconds.
[124333.377474]       Not tainted 5.3.0-050300rc7-generic #201909021831
[124333.378609] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[124333.376328] INFO: task Xorg:797 blocked for more than 241 seconds.
[124333.377474]       Not tainted 5.3.0-050300rc7-generic #201909021831
[124333.378609] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[124333.380060] Xorg            D    0   797    773 0x00404004
[124333.380062] Call Trace:
[124333.380067]  __schedule+0x2b9/0x6c0
[124333.380068]  schedule+0x42/0xb0
[124333.380069]  schedule_preempt_disabled+0xe/0x10
[124333.380070]  __ww_mutex_lock.isra.0+0x261/0x7f0
[124333.380076]  ? ttm_bo_init+0x6b/0x100 [ttm]
[124333.380077]  __ww_mutex_lock_slowpath+0x16/0x20
[124333.380077]  ww_mutex_lock+0x38/0x90
[124333.380080]  ttm_eu_reserve_buffers+0x1cc/0x2f0 [ttm]
[124333.380083]  qxl_release_reserve_list+0x6d/0x150 [qxl]
[124333.380085]  ? qxl_bo_pin+0xf4/0x190 [qxl]
[124333.380087]  qxl_cursor_atomic_update+0x1ab/0x2e0 [qxl]
[124333.380088]  ? qxl_bo_pin+0xf4/0x190 [qxl]
[124333.380096]  drm_atomic_helper_commit_planes+0xd5/0x220 [drm_kms_helper]
[124333.380101]  drm_atomic_helper_commit_tail+0x2c/0x70 [drm_kms_helper]
[124333.380105]  commit_tail+0x68/0x70 [drm_kms_helper]
[124333.380109]  drm_atomic_helper_commit+0x118/0x120 [drm_kms_helper]
[124333.380128]  drm_atomic_commit+0x4a/0x50 [drm]
[124333.380132]  drm_atomic_helper_update_plane+0xea/0x100 [drm_kms_helper]
[124333.380140]  __setplane_atomic+0xcb/0x110 [drm]
[124333.380147]  drm_mode_cursor_universal+0x140/0x260 [drm]
[124333.380153]  drm_mode_cursor_common+0xcc/0x220 [drm]
[124333.380160]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[124333.380166]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
[124333.380171]  drm_ioctl_kernel+0xae/0xf0 [drm]
[124333.380176]  drm_ioctl+0x234/0x3d0 [drm]
[124333.380182]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
[124333.380184]  ? timerqueue_add+0x5f/0xa0
[124333.380186]  ? enqueue_hrtimer+0x3d/0x90
[124333.380188]  do_vfs_ioctl+0x407/0x670
[124333.380190]  ? fput+0x13/0x20
[124333.380192]  ? __sys_recvmsg+0x88/0xa0
[124333.380193]  ksys_ioctl+0x67/0x90
[124333.380194]  __x64_sys_ioctl+0x1a/0x20
[124333.380195]  do_syscall_64+0x5a/0x130
[124333.380197]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[124333.380198] RIP: 0033:0x7f07c79ee417
[124333.380202] Code: Bad RIP value.
[124333.380203] RSP: 002b:00007ffc6b1de1a8 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[124333.380204] RAX: ffffffffffffffda RBX: 00005612f109a610 RCX:
00007f07c79ee417
[124333.380204] RDX: 00007ffc6b1de1e0 RSI: 00000000c02464bb RDI:
000000000000000e
[124333.380205] RBP: 00007ffc6b1de1e0 R08: 0000000000000040 R09:
0000000000000004
[124333.380205] R10: 000000000000003f R11: 0000000000003246 R12:
00000000c02464bb
[124333.380206] R13: 000000000000000e R14: 0000000000000000 R15:
00005612f10981d0


Best regards,
J
