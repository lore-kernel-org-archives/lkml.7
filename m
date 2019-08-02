Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3BC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D614E20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsZhqrgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394878AbfHBNuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:50:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33609 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfHBNuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:50:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so33603431plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQtLIJgj8qnmq16hHV2/Di60nqvabcpIT2vTK21437M=;
        b=hsZhqrgEi6dAqzOpjWJOvXYoTzsshkLCAgAiTytNSLPy48j75sU3Wss+dGI1RCJ7Gu
         0lB1sgp6Vtmaprc/rWNSSz0f9cFzB0p0iOH2MhvMCUAhQmPwELT+GtvkSe4gdSKkAiy6
         McxrTVLN8dPBY5JwfAkmhVWIf1go91hSOOyb1uy5m6m8PUxj5TqTeitDugYcVDapPgYC
         HvhD2XPmWoXmgfzBWAA4FhB9352AwaPB2c2NhMEYA2YC2lbrkK1RLNxYyDX1M8B40pOE
         XHTQ9zP9em0SuRbmiG+4fgjfN2F5CPQxYNPbIDo3CcOp1DtVgcd1G4MK8kK+Co+eshUq
         9+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQtLIJgj8qnmq16hHV2/Di60nqvabcpIT2vTK21437M=;
        b=OWMUiqUY77no8Pnzk01HHx7g0PsEyIkrzI0z4aCC7hRh3B7U8eNHn30Mi29k0gicpx
         W7NmRIeWHVtPdYKJ90owkV7HXBYIEGQMI2y4F3R0D2QyWhq6f/b7b4mFjys+RkJsZQTY
         AYOE/Z8Gi99Dsh6OtM0PlkNeFB22oxMbG9DfpGcSnKJJq4CydvBFM6PHCzsexai0bQS3
         XLW6yB5cnL0SfDmKTL6VhCW0nYPBkxXekQaYPIJdU88RpyfYoX78udRJ9RTNGQ0YVi9s
         zPc3m7u9v0/RgBZxBgM5ruu324w93C/m5PLAreO+k12bwJnzZrdH3ltgeaixzC935wNE
         Qmhg==
X-Gm-Message-State: APjAAAXZfx/9OjfgcfQyjJLK7OpEaQviegexbBfcoRbfdDPce5DxLUXh
        u2YX6Phlua88LInUZvJKAAI=
X-Google-Smtp-Source: APXvYqwZBcDnDQYwRDu0HUM/22nE7jgEVt0d2AijMAExL0f5PjopObxqzpla+GgxHcYOLzcB2qAMqg==
X-Received: by 2002:a17:902:d81:: with SMTP id 1mr136710123plv.323.1564753799488;
        Fri, 02 Aug 2019 06:49:59 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id c98sm8955254pje.1.2019.08.02.06.49.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:49:58 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 2 Aug 2019 22:49:55 +0900
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i915: do not leak module ref counter
Message-ID: <20190802134955.GA23032@tigerII.localdomain>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
 <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
 <156475141863.6598.6809215010139776043@skylake-alporthouse-com>
 <20190802131523.GB466@tigerII.localdomain>
 <20190802133503.GA18318@tigerII.localdomain>
 <156475327511.6598.417403815598052974@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156475327511.6598.417403815598052974@skylake-alporthouse-com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/02/19 14:41), Chris Wilson wrote:
[..]
> struct vfsmount *kern_mount(struct file_system_type *type)
> {
>         struct vfsmount *mnt;
>         mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
>         if (!IS_ERR(mnt)) {
>                 /*
>                  * it is a longterm mount, don't release mnt until
>                  * we unmount before file sys is unregistered
>                 */
>                 real_mount(mnt)->mnt_ns = MNT_NS_INTERNAL;
>         }
>         return mnt;
> }
> 
> With the exception of fiddling with MNT_NS_INTERNAL, it seems
> amenable for our needs.

Sorry, not sure I understand. i915 use kern_mount() at the moment.

Since we still need to put_filesystem(), I'd probably add one more
patch
	- export put_filesystem()

so then we can put_filesystem() in i915. Wonder what would happen
if someone would do
		modprobe i915
		rmmod i916
In a loop.

So something like this (this is against current patch set).

---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 5 ++---
 fs/filesystems.c                      | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index d437188d1736..4ea7a6f750f4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -24,10 +24,9 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		return -ENODEV;
 
 	gemfs = kern_mount(type);
-	if (IS_ERR(gemfs)) {
-		put_filesystem(type);
+	put_filesystem(type);
+	if (IS_ERR(gemfs))
 		return PTR_ERR(gemfs);
-	}
 
 	/*
 	 * Enable huge-pages for objects that are at least HPAGE_PMD_SIZE, most
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646e41ac..4837eda748b5 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -45,6 +45,7 @@ void put_filesystem(struct file_system_type *fs)
 {
 	module_put(fs->owner);
 }
+EXPORT_SYMBOL(put_filesystem);
 
 static struct file_system_type **find_filesystem(const char *name, unsigned len)
 {
@@ -280,5 +281,4 @@ struct file_system_type *get_fs_type(const char *name)
 	}
 	return fs;
 }
-
 EXPORT_SYMBOL(get_fs_type);
