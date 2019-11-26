Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53092C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EDF2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey3utnPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfKZONv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:13:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:45438 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKZONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:13:50 -0500
Received: by mail-pj1-f66.google.com with SMTP id r11so509184pjp.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DLvFLPDGfBrvBhBRm89ZhFfrc3GiYm8Y3odkqflTe7c=;
        b=Ey3utnPmhpjIwarKTbtypCzdxvZrbt4V/4dtb2vFtKYdiZN195KlQUCocszJ+CTI1U
         uLJA/py4sWzC1mG/WPE2Kea1iaB/XFoMwXt04UraewPhohu1AD8CVEYqGaTIubEuOTnq
         XRsCZ/hgb5Ddy78p3vIQWK3yv3Ivmyhkd2Hp+MHe9DHFw8oWghtIX6UaY0kfkNMuiNs5
         gjv7xu9/Yx3EkXYTW55RZAc5/8ocb/r+w7cH6aAnP9NsH0Xs6k3Qh/GIVrXjIPVxZnLh
         M4ZGzSt0wM4JqI9TLL7h6Y7l3uHS+run/6rYB/0U0eSW9WGU/VFEAksaGm/HeJxXN5uD
         YlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DLvFLPDGfBrvBhBRm89ZhFfrc3GiYm8Y3odkqflTe7c=;
        b=Z7hBY8LvWyjmLp5qu4ITptCihlob3ExopGDPNhdnC76PhrCJBkxU+sJmTurc4vD7AS
         lVqpHCFzhpHCNyW5MwOuhSHDr/2/fDCB1rQLTgOzHc8IXIAdMxy5lUskPAxc9rNhcjV7
         FYV4od7DqYOcdCw7RK9h5NKJV0BwyvewYm7Uqe5EBaUU0PgFGecigCbWlBCps1h9l+go
         E11T+MSOokyOWXoRL7uY5nRGIm7WOZSGLBvHeaG9qX4vHDRwgPTI08J65cz8lGLH+ZeK
         oPqt3bMHT3pdo2PguHlDCVIBbyulDg7lehVYuPLIiITDEWVwlcH9haWaDJGrJ9PlsbU6
         NXXw==
X-Gm-Message-State: APjAAAUaIkNR5FxaYHqTITmMazl0wGsDgPYXvTf3CCwyBy9gtlfgyFDE
        +O8dUi8Uk/2//C8iiE6sfPk=
X-Google-Smtp-Source: APXvYqw6cKU1dwZaAO/qheogl3rYrFTfmwuWu9iJr+qL2DQS0kggLra0colXmbC69nzBJKpbcM23LQ==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr7257955pjn.60.1574777628805;
        Tue, 26 Nov 2019 06:13:48 -0800 (PST)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id q6sm940718pfh.127.2019.11.26.06.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:13:48 -0800 (PST)
Date:   Tue, 26 Nov 2019 14:13:46 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@suse.de, anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH v2] mm: fix comments related to node reclaim
Message-ID: <20191126141346.GA22665@haolee.github.io>
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
 include/linux/mmzone.h      | 2 +-
 include/uapi/linux/sysctl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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

