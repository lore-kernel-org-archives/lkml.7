Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22781C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF45520657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USkc3EZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCJVV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:21:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42624 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCJVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:21:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so1550381qkg.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DFDHAMjB2xnBCj3FMKzhM0TyschVnLH6AN/+wHtqHYM=;
        b=USkc3EZEgws2zAvOvCvCTxgU8mSefJhWrr+gjjQckW14B3E7dEvbze1tcCRU+QMqx7
         9jyqA10caj57XekG+iafnGctvENuWlGPnZsHErVlu9erH+p9eXKMkVk5WHPNgf29nllj
         WHkVQbPjPs1xwOhjePgZboQFphBst5Mm+cd7v9burnYm7dZJ0c5YfNbEQ+ug3lSqi2Oq
         dfi3G/ld3fGiYWhkzmN5dfCpcVuj64/DUTIgZKF83Pl3GiAtZaT+1+jZ2/QeauAHDvGi
         f15/SspegVe3K7wQZ5SXqpABz8iYVmEg6ZuRsYi6c1OtQ4Ex+Kj8DoUxCLvTvXaHhTz+
         CuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DFDHAMjB2xnBCj3FMKzhM0TyschVnLH6AN/+wHtqHYM=;
        b=eBijZAMRPtjgGT7MpPH5xrvafCveRVz9kcrcvVwRpVwpVZhkOXpirazsHrpcTZd9+D
         AiQjvab2VCMEp+wAW1L7DyEiMsv4JS4rAXctSBYbx+8I+RAVqozFhYDRvjG0eqoMZksS
         bFvEYaxZmV6TJRZQo+Gnty1ZZ+33/jghAZXNKdpWRqVRoT7xPNy++hzK1MhQZMRQJgWz
         jKEtFCB9Ztcmny3Ta4hGqihcX4RtVfgBAZrauZtoM7oUFrKn5b+h7pqw3SBC8Kl6LAZo
         G+D17Gj5u4iSf57sef8LMhowfuzhs8qlSC0jZG+rqZpenzo9r+vhaNRhV8ahvk+RsXHK
         RM6g==
X-Gm-Message-State: APjAAAVrHEgth/u++dHj9m+VjR3uyvtpD0Cxli5iGY5BYjIAd1Ip6PCE
        mUqywcyfTk/DC+5lgImKHFk=
X-Google-Smtp-Source: APXvYqwQt6wU74anxsFxE1XYm6cHUyzs0l7rKm6fUNYfHi3iCHV9I1g4/EG2z3jdPJoWQ0vMhB2/hw==
X-Received: by 2002:a05:620a:1110:: with SMTP id o16mr11442033qkk.221.1552252913850;
        Sun, 10 Mar 2019 14:21:53 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a43sm2546272qta.54.2019.03.10.14.21.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 14:21:53 -0700 (PDT)
Date:   Sun, 10 Mar 2019 18:21:50 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Message-ID: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the subtest basic-plain-flip from IGT project was executed on Bochs
driver, the following bug appears:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 0 P4D 0
Oops: 0010 [#1] PREEMPT SMP PTI
CPU: 0 PID: 423 Comm: kms_flip Not tainted 5.0.0-VM+ #102
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffffb6a6c0bdfb70 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff90467940bf00 RCX: ffff90467a730318
RDX: 000000000000001f RSI: 0000000000000003 RDI: ffff90467bf94050
RBP: ffff90467bf94050 R08: ffff904679424e00 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff90467a460000 R14: ffff90467946d400 R15: ffffffffc080d460
FS:  00007f259c1990c0(0000) GS:ffff90467c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000b97ec000 CR4: 00000000000006f0
Call Trace:
 ? drm_atomic_helper_commit_modeset_disables+0x396/0x3e0 [drm_kms_helper]
 ? drm_atomic_helper_commit_tail+0x19/0x60 [drm_kms_helper]
 ? commit_tail+0x58/0x70 [drm_kms_helper]
 ? drm_atomic_helper_commit+0x103/0x110 [drm_kms_helper]
 ? drm_atomic_helper_set_config+0x80/0x90 [drm_kms_helper]
 ? drm_mode_setcrtc+0x18d/0x690 [drm]
 ? tty_insert_flip_string_fixed_flag+0x85/0xe0
 ? drm_mode_getcrtc+0x180/0x180 [drm]
 ? drm_ioctl_kernel+0xb2/0xf0 [drm]
 ? drm_ioctl+0x25f/0x3f0 [drm]
 ? drm_mode_getcrtc+0x180/0x180 [drm]
 ? do_vfs_ioctl+0xa4/0x630
 ? ksys_ioctl+0x60/0x90
 ? ksys_write+0x4f/0xb0
 ? __x64_sys_ioctl+0x16/0x20
 ? do_syscall_64+0x5b/0x170
 ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

This commit adds an entry to atomic_disable in the drm_crtc_helper_funcs
to avoid the NULL pointer dereference.

Fixes: 0f0eb98e33c6 ("drm/bochs: atomic: add atomic_flush+atomic_enable callbacks")

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 9e7cd6b34106..7e821776727f 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -35,6 +35,11 @@ static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 }
 
+static void  bochs_crtc_atomic_disable(struct drm_crtc *crtc,
+				       struct drm_crtc_state *old_state)
+{
+}
+
 static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_crtc_state)
 {
@@ -66,6 +71,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
 static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.mode_set_nofb = bochs_crtc_mode_set_nofb,
 	.atomic_enable = bochs_crtc_atomic_enable,
+	.atomic_disable = bochs_crtc_atomic_disable,
 	.atomic_flush = bochs_crtc_atomic_flush,
 };
 
-- 
2.21.0
