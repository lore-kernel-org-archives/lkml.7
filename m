Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F264C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C35208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEShoLf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfGaQse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:48:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45592 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfGaQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:48:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so30754204plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0yU6+7Jqba/P/dYVUesQKoUXFUkl65XIpqFII+Vl9uI=;
        b=TEShoLf6suD1oowWqmx+9hD1Z9ME22dg6oXWv+TZC0a59DtmlQsXGcIFRaKjW67vdc
         xJuBNUNjTffMUMovFe3HEn12UKyKzcwMLSkUBMlxgvtMebyzn/R7rPDCUr1I5Humd5+0
         ZUnKpZrKA1v1nxnaoUKzg3Hr5b0cYcTNuqqc4b0ExTtOj6SLqQqk3qUZHWxihx0AoILp
         gUfNyHNB3ZWYYEgqiktawoBoqtMdZGnEp0p6A0BBZDVFA33JHeXqbE1n1ExBaJVPvRj7
         nf220LhYoSaWsrlEKCnOevK8tDqEOu5Y1VGm9PD0fpTLKJL5CWc030WyaecUdDqbhAQo
         QWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0yU6+7Jqba/P/dYVUesQKoUXFUkl65XIpqFII+Vl9uI=;
        b=GDN9+Ombb+/K85MPgyiS5VqQia4Jf221IipxRojlDBQvUfmML0r/KxjNiZmK1pTfB9
         S+OKLFx1I5ZfmL7dDC3SxYNmki5J6U4PxoASk+BhQTYpNkAwEaTnEmfYNFxAS0o0u5Ot
         BI/lh5v9j3TYPXwzMUH9ut0JqCz9ofyjPGFVhSGHPuBsfSzavZunow/6lLhdze/SSylB
         mSQb5wLAJZYtvCvRmAoBVHFIb95PojFfRVzl68TMkCbJ4TOrODGSjNerXuBjY6tIK2+5
         Y02Mx7keoMHT4Gre3nzpi8JxVfU4X7xMHB8/ua3sNPdA0htXBT82djpz3d5ekPBxRi+Q
         i3+A==
X-Gm-Message-State: APjAAAX1G3/cnXghFm7UH3LWGmuddabf378I5QILH4NA6apHgyritOSR
        dtr7/DMVVcP5Hj49j5iwN+E=
X-Google-Smtp-Source: APXvYqxFFgDlNniDL8CJHmZ07neF4gFczeMrZumpY8D33YQTsuHwvnRMvRsPvkoX1WVdvj5G5Yqdsg==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr123637304plp.18.1564591713720;
        Wed, 31 Jul 2019 09:48:33 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id d18sm24192770pgi.40.2019.07.31.09.48.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 09:48:32 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 1 Aug 2019 01:48:29 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hugh Dickins <hughd@google.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [linux-next] mm/i915: i915_gemfs_init() NULL dereference
Message-ID: <20190731164829.GA399@tigerII.localdomain>
References: <20190721142930.GA480@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721142930.GA480@tigerII.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/21/19 23:29), Sergey Senozhatsky wrote:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor instruction fetch in kernel mode
>  #PF: error_code(0x0010) - not-present page
>  PGD 0 P4D 0 
>  Oops: 0010 [#1] PREEMPT SMP PTI
>  RIP: 0010:0x0
>  Code: Bad RIP value.
>  [..]
>  Call Trace:
>   i915_gemfs_init+0x6e/0xa0 [i915]
>   i915_gem_init_early+0x76/0x90 [i915]
>   i915_driver_probe+0x30a/0x1640 [i915]
>   ? kernfs_activate+0x5a/0x80
>   ? kernfs_add_one+0xdd/0x130
>   pci_device_probe+0x9e/0x110
>   really_probe+0xce/0x230
>   driver_probe_device+0x4b/0xc0
>   device_driver_attach+0x4e/0x60
>   __driver_attach+0x47/0xb0
>   ? device_driver_attach+0x60/0x60
>   bus_for_each_dev+0x61/0x90
>   bus_add_driver+0x167/0x1b0
>   driver_register+0x67/0xaa
>   ? 0xffffffffc0522000
>   do_one_initcall+0x37/0x13f
>   ? kmem_cache_alloc+0x11a/0x150
>   do_init_module+0x51/0x200
>   __se_sys_init_module+0xef/0x100
>   do_syscall_64+0x49/0x250
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9


So "the new mount API" conversion probably looks like something below.
But I'm not 100% sure.

---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 32 +++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 099f3397aada..2e365b26f8ee 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -7,12 +7,14 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/fs_context.h>
 
 #include "i915_drv.h"
 #include "i915_gemfs.h"
 
 int i915_gemfs_init(struct drm_i915_private *i915)
 {
+	struct fs_context *fc;
 	struct file_system_type *type;
 	struct vfsmount *gemfs;
 
@@ -36,19 +38,35 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		struct super_block *sb = gemfs->mnt_sb;
 		/* FIXME: Disabled until we get W/A for read BW issue. */
 		char options[] = "huge=never";
-		int flags = 0;
 		int err;
 
-		err = sb->s_op->remount_fs(sb, &flags, options);
-		if (err) {
-			kern_unmount(gemfs);
-			return err;
-		}
+		fc = fs_context_for_reconfigure(sb->s_root, 0, 0);
+		if (IS_ERR(fc))
+			goto err;
+
+		if (!fc->ops->parse_monolithic)
+			goto err;
+
+		err = fc->ops->parse_monolithic(fc, options);
+		if (err)
+			goto err;
+
+		if (!fc->ops->reconfigure)
+			goto err;
+
+		err = fc->ops->reconfigure(fc);
+		if (err)
+			goto err;
 	}
 
 	i915->mm.gemfs = gemfs;
-
 	return 0;
+
+err:
+	pr_err("i915 gemfs init() failed\n");
+	put_fs_context(fc);
+	kern_unmount(gemfs);
+	return -EINVAL;
 }
 
 void i915_gemfs_fini(struct drm_i915_private *i915)
-- 
2.22.0

