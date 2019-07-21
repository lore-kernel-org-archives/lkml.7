Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B41C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4482085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/dM8JvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfGUO3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 10:29:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39518 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfGUO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:29:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so16419670pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yHWPM2A483B1PZNTU1st8pnTTNAs2xN+6BFUgiVJMFo=;
        b=A/dM8JvSApyy0k2jvqWLMGfriCPKzB08cruBW99KLNKiKTAghXcZHNG33tD6/5fIrL
         TJx99kczxZfm2Y3Bd9eRykoMlCkxEKTyw4S9nAsQoSEgYGy47zlWzVa/8mtROXUXYNld
         fK/1iVE2Qqbb9db8cHw/9GiBg9JHAhXlrH4DU9IsjTcepZgAr47Z1Qk4GohtQAbbwTI6
         WLjxPNKrfU9E9RNUYuhk9/j343Ur1Q36lnrtwEtj5Je17F6AXTACPBPHjT9kcrXcz4IG
         dtnxEWfOZeVlYwtj/Kbc7LAAgAvfw38MkDGFF26gBGbyPyt/BPwlUeh7TYhi+tlCx226
         ZstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yHWPM2A483B1PZNTU1st8pnTTNAs2xN+6BFUgiVJMFo=;
        b=uiTz55Ixg5LQgxZtMuc8sDXMqzeeLsnsCPhu5FocTADHsl8uk4nE+VafTTgC0B680G
         5cr/PJmqZ4outBmSixw3Uh1O42iWCYmUzlnLpG2o7piSy/MPe8pToxr9YA7w7pQHJmVZ
         2BtwQt+qEwGaSL8rsTTMBdi62cm1BMYXaC/C1jVBqXzqvikG8Fc3CKzay9hJx2i/8eYI
         yAAKIget5lyKWcFtnfRuzwF/lzcMra7rOkR5XPkAuEBM1WomoAYzRn/sDidFjp4d4K6L
         cLJRHoAhTmCRbhKJvFDCdRNkAKgB6lJX6XnT22Q4C6Fb9xJfr8fGe58HCDG6Kt9s6puF
         +nPA==
X-Gm-Message-State: APjAAAU/L0jn6rNWcPEIEynAVtFQHrXdFbhZFp7/rejUoBelFw+6BRUU
        3+pRzgsJ0ngqbffapNZpHklphHO9
X-Google-Smtp-Source: APXvYqzJ70me8/YjG3iag5xCr5rToFb+3rKTVc2TFFdtKiTWAwKoD3L82P9u1aIVc3eW5aPZcOgdXg==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr65587674pgh.24.1563719373649;
        Sun, 21 Jul 2019 07:29:33 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id t9sm3493825pgj.89.2019.07.21.07.29.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 07:29:32 -0700 (PDT)
Date:   Sun, 21 Jul 2019 23:29:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hugh Dickins <hughd@google.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [linux-next] mm/i915: i915_gemfs_init() NULL dereference
Message-ID: <20190721142930.GA480@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My laptop oopses early on with nothing on the screen;
after some debugging I managed to obtain a backtrace:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 0 P4D 0 
 Oops: 0010 [#1] PREEMPT SMP PTI
 RIP: 0010:0x0
 Code: Bad RIP value.
 [..]
 Call Trace:
  i915_gemfs_init+0x6e/0xa0 [i915]
  i915_gem_init_early+0x76/0x90 [i915]
  i915_driver_probe+0x30a/0x1640 [i915]
  ? kernfs_activate+0x5a/0x80
  ? kernfs_add_one+0xdd/0x130
  pci_device_probe+0x9e/0x110
  really_probe+0xce/0x230
  driver_probe_device+0x4b/0xc0
  device_driver_attach+0x4e/0x60
  __driver_attach+0x47/0xb0
  ? device_driver_attach+0x60/0x60
  bus_for_each_dev+0x61/0x90
  bus_add_driver+0x167/0x1b0
  driver_register+0x67/0xaa
  ? 0xffffffffc0522000
  do_one_initcall+0x37/0x13f
  ? kmem_cache_alloc+0x11a/0x150
  do_init_module+0x51/0x200
  __se_sys_init_module+0xef/0x100
  do_syscall_64+0x49/0x250
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

RIP is at 0x00, which is never good

It sort of boils down to commit 144df3b288c4 (vfs: Convert ramfs,
shmem, tmpfs, devtmpfs, rootfs to use the new mount API), which
removed ->remount_fs from tmpfs' ops:

===
@@ -3736,7 +3849,6 @@ static const struct super_operations shmem_ops = {
        .destroy_inode  = shmem_destroy_inode,
 #ifdef CONFIG_TMPFS
        .statfs         = shmem_statfs,
-       .remount_fs     = shmem_remount_fs,
        .show_options   = shmem_show_options,
 #endif
        .evict_inode    = shmem_evict_inode,
===

So i915 init executes NULL

	get_fs_type("tmpfs");
	sb->s_op->remount_fs(sb, &flags, options);

For the time being the following (obvious and wrong) patch
at least boots -next:

---

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 099f3397aada..1f95d9ea319a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -39,6 +39,9 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		int flags = 0;
 		int err;
 
+		if (!sb->s_op->remount_fs)
+			return -ENODEV;
+
 		err = sb->s_op->remount_fs(sb, &flags, options);
 		if (err) {
 			kern_unmount(gemfs);
---

	-ss
