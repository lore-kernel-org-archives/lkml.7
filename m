Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47926C32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2FE21726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuFcTKxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfHBMkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:40:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38748 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfHBMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:40:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so33582591plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNi/nnM9HHWKbRYhA5SJtV0WOL7aCQ6fgci+sI44rYk=;
        b=VuFcTKxPiFikoaOaeaN3wnXTgdC/BrSU7WHN/INuG6RZYN5YDsvvKzcXg8IiYRKKyA
         F2+x1riP9LCT2SOrRYETDLkypkQAa2yYEMMTRRvBgJtpRf3L9YiLnwJpuzGXvgJOl4t/
         3ln3++H3r9Q6kn25Eju2mIvCELCFHrk2Ix6IfZzeDm7oe7YWiAcc+l5ZpHeUTVBtcXUh
         Q/V2DKB7GUmAzrleqpuvFnFik1pBAemExEdZwx3V7nD/9jS6Ah0t0CCA3gAjItR+IqXq
         yUia08u4zRiHbUCqBqxY79YKl4bl/Yzs0febAaa3LmTHBfROyJz9SqxmQsR8hSDn5iNQ
         ULOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNi/nnM9HHWKbRYhA5SJtV0WOL7aCQ6fgci+sI44rYk=;
        b=YdNy0Q+c/+l0WwMNwKqXuRdmgW6UiNZYpdk2fpBCiNoxdUKj+YG+7mzAp3STVPxW6O
         iXdOHf0NEW/GwTPgn77/PQpa8PYiFT18ybB7yWs7HiXKCC3N7OA1sdK5EMYjC6YW5sgO
         zsNz8e1I2vvpgncdSJdRFM5oH7Trua/dKKbnTCEo3uF7s4S70Pa7r0+4hA3EWPeAZ6o9
         NlmEpA9gfcQKtif7KqMR1VXpnzgk5kPuD/sMSRYeWVZ6meKkFOhuVvYFJgXzTD7v9BGB
         Yd7K/ZdgX51wJat7bREsgWKC4ptKPuZlORIMFWjvgtHI+vdmvksKpxRLEzt+ZGDQ3E59
         yKuA==
X-Gm-Message-State: APjAAAVf8oPxcDMmCcbM+2Z31rEk+nCwTZAd7MJoTHogxO1tlQH4aCQB
        sKG0wbvYaW0Qb4q5yzckGRc=
X-Google-Smtp-Source: APXvYqwLpuv8Zki5rxd/68GLoAJDtswRFf3FJLONOZgTh1nMnm+lQT6IbCFFFW/QgYstRBcGrM/HVg==
X-Received: by 2002:a17:902:2ac7:: with SMTP id j65mr132309416plb.242.1564749614370;
        Fri, 02 Aug 2019 05:40:14 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id o3sm3978851pje.1.2019.08.02.05.40.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 05:40:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 1/2] i915: convert to new mount API
Date:   Fri,  2 Aug 2019 21:39:55 +0900
Message-Id: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmpfs does not set ->remount_fs() anymore and its users need
to be converted to new mount API.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 PF: supervisor instruction fetch in kernel mode
 PF: error_code(0x0010) - not-present page
 RIP: 0010:0x0
 Code: Bad RIP value.
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

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 28 ++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 099f3397aada..cf05ba72df9d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -7,14 +7,17 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/fs_context.h>
 
 #include "i915_drv.h"
 #include "i915_gemfs.h"
 
 int i915_gemfs_init(struct drm_i915_private *i915)
 {
+	struct fs_context *fc = NULL;
 	struct file_system_type *type;
 	struct vfsmount *gemfs;
+	bool ok = true;
 
 	type = get_fs_type("tmpfs");
 	if (!type)
@@ -36,18 +39,29 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		struct super_block *sb = gemfs->mnt_sb;
 		/* FIXME: Disabled until we get W/A for read BW issue. */
 		char options[] = "huge=never";
-		int flags = 0;
-		int err;
 
-		err = sb->s_op->remount_fs(sb, &flags, options);
-		if (err) {
-			kern_unmount(gemfs);
-			return err;
+		fc = fs_context_for_reconfigure(sb->s_root, 0, 0);
+		if (IS_ERR(fc)) {
+			ok = false;
+			goto out;
 		}
+
+		if (!fc->ops->parse_monolithic ||
+				fc->ops->parse_monolithic(fc, options)) {
+			ok = false;
+			goto out;
+		}
+
+		if (!fc->ops->reconfigure || fc->ops->reconfigure(fc))
+			ok = false;
 	}
 
+out:
+	if (!ok)
+		pr_err("i915 gemfs reconfiguration failed\n");
+	if (!IS_ERR_OR_NULL(fc))
+		put_fs_context(fc);
 	i915->mm.gemfs = gemfs;
-
 	return 0;
 }
 
-- 
2.22.0

