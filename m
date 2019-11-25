Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE66C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FCA20748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBNkAIWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfKYOUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:20:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33170 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKYOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:20:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so2733438pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/jORnAlcsB1daMxnJzmULfdvfXi6vOqocPRyBnYdUVA=;
        b=hBNkAIWf8+LBWPlsDUD00QD9+AKz1qIs1x59fc1Nk5ly2W2wEO/TkCRAGG/OE/E2A9
         9eaNEM33oJTzQH/APVjsQsMcMHdLs+9r9WgLRmXM1ZMksDs7PzAQO033dgV3BHOWy2c6
         c+kBcNXlm9D1wI1DAOCRo6bFWpjZCEszr7o+01ph+ypMROwTnkMTG9SRYIsoK+rzzQp8
         uP09l3D7KfNLjbQ5+NjPxNkxZGK0hubGF3iLUEV1H/49cwxVh8jptNrH3r5cfq5lGxTI
         eRcKkup8sKnpjuRns4XxrCaGgHsOJLJrsR4a5VrQ5spzEC+zk0PjDJFh6hIoWTPlJVYq
         HF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/jORnAlcsB1daMxnJzmULfdvfXi6vOqocPRyBnYdUVA=;
        b=DAiInIHNZIS6+TFpKBY9CU2T8YyGgDmazdt2AVyVAhamkrIiDZRYb/JOTNf2nZGNUJ
         pdKBfvLtREfwfF3IEBqvYLPAMtQZZ1IBZE4EK3Z1aLGNZ9mHHWZbfqDwr0jhMqhVYM3h
         Iccibt05DusXHZU5PYIX7PA4AxYiLWGN+9hiGblPXDiHlj27yAcj6C575p+tPi85Dcdz
         7q/LuhcMWoTYQ+sSDE+F4lvtyfrQFnxJu6zStuC5zjjflTJD6+J1eH3uLbwoHgNo3421
         uRg9oI5yuD1YqglQocTNsXr/dL8F6FAV7epLYUv9i2TW9B2HwdzjmAd05EYmzwDsxqhz
         /8jA==
X-Gm-Message-State: APjAAAV88XgVRFZf3oAScDA4wwEBxxY2UHW+xTSNr4WOrhvHJEQtXvB1
        LHoG55VPy0eD5jv+F4nL1c2fwlHu
X-Google-Smtp-Source: APXvYqz34yPE6/0lcVzrz2QQP4L1aQrII4umO4xBoyJH+jffy/JCtTjy/PMCVhJoSiXGCHV9DWVVzw==
X-Received: by 2002:aa7:9f08:: with SMTP id g8mr35463808pfr.59.1574691621266;
        Mon, 25 Nov 2019 06:20:21 -0800 (PST)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id f59sm7930121pje.0.2019.11.25.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:20:20 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:20:18 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] mm: fix comments related to node reclaim
Message-ID: <20191125142018.GA21373@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As zone reclaim has been replaced by node reclaim, this patch fixes related
comments.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 include/linux/mmzone.h          | 2 +-
 include/uapi/linux/capability.h | 2 +-
 include/uapi/linux/sysctl.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9e47289a4511..7e3208f4f5bc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -747,7 +747,7 @@ typedef struct pglist_data {
 
 #ifdef CONFIG_NUMA
 	/*
-	 * zone reclaim becomes active if more unmapped pages exist.
+	 * node reclaim becomes active if more unmapped pages exist.
 	 */
 	unsigned long		min_unmapped_pages;
 	unsigned long		min_slab_pages;
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 240fdb9a60f6..dd6772f16eec 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -273,7 +273,7 @@ struct vfs_ns_cap_data {
 /* Allow enabling/disabling tagged queuing on SCSI controllers and sending
    arbitrary SCSI commands */
 /* Allow setting encryption key on loopback filesystem */
-/* Allow setting zone reclaim policy */
+/* Allow setting node reclaim policy */
 
 #define CAP_SYS_ADMIN        21
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 87aa2a6d9125..27c1ed2822e6 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -195,7 +195,7 @@ enum
 	VM_MIN_UNMAPPED=32,	/* Set min percent of unmapped pages */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
-	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
+	VM_MIN_SLAB=35,		 /* Percent pages ignored by node reclaim */
 };
 
 
-- 
2.14.5

