Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB8DC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B1321019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cWRB2kBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfHQCq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37769 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfHQCqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so8226402qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gnt8yazO3N8sExIXY3j+u+ZqminYZIsiqJs/+B6OhTk=;
        b=cWRB2kBTWh4/y+MMGqB3R/WWgZ7sLaFYtihcnoSwSt6r7xSqwl4+S+IhqH4xOnp0vq
         ySf3411CzGXNQBIcDU+KzwjgmaJLR7fVjhfDpEJc1SruBOh25M0jDoOVJaEMEKNOil/3
         hVbjYxlfCLhJGujq6rLK9H6BlMLoTORcd81nvMdoc2GpMEtVkgD/aXP06Luk6cE/7pE8
         AB7O6RFL6XiMdpb3vCKLa1UAsgPUVEnO7Rmp5pIjbq7MYSSI6BvECvUA2YzN0rp2JTgy
         j2Ay7njDh/dyDW5KG1tPtOgqTCJkiwYA7wdLnaoHh8kHEsapZh1ufoTOsXnD8g9n8gc7
         LJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gnt8yazO3N8sExIXY3j+u+ZqminYZIsiqJs/+B6OhTk=;
        b=ujR9TW2S3YiE32j747m9NcC3NDD+wFz2swueneq3jNoRM4P0iLCLFnVA06l8NCoGYm
         pIG6u63hSvOBWWtbRnl3KHUTBkU+nUrm+4aRGQ7No7isMFvY8uzPI8S7Ft7SjLjpT6+3
         Qe8YlD7cQu0+WrtvMbh2KwxBWiIsmLS2t5sNcdFCSQGta4gmn/mNT3Z/qnMgptNgF1hH
         Q9GLeTwYqhiAWhn5SL4vHqNus19mELKR/Dx/Y+1KPiKVxnYSkbWBSoi+23u+9hn6sqdR
         4is4W6Konre0tOhPjzCtU25z0ugF+QThKawam235dYjvgD6mRU0WJUReD4+5qW0m7i8A
         SFSg==
X-Gm-Message-State: APjAAAWLQJnti6iFZ015ZffCB7NZ8oen7KKq8Z4i0v+BEL28qrkS7Ptw
        H+n54HrDtkpZtQ0y7UZC8jRYyA==
X-Google-Smtp-Source: APXvYqxszzLWkK2VLd5S53W8Fb3b8NJFaWMc7fwLM8sjAjZ7hGYnI41xlk+tqmjFr45dPKaJJpbf2w==
X-Received: by 2002:aed:31c2:: with SMTP id 60mr10402242qth.331.1566010005435;
        Fri, 16 Aug 2019 19:46:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:44 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 10/14] kexec: add machine_kexec_post_load()
Date:   Fri, 16 Aug 2019 22:46:25 -0400
Message-Id: <20190817024629.26611-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is the same as machine_kexec_prepare(), but is called after segments are
loaded. This way, can do processing work with already loaded relocation
segments. One such example is arm64: it has to have segments loaded in
order to create a page table, but it cannot do it during kexec time,
because at that time allocations won't be possible anymore.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec.c          | 4 ++++
 kernel/kexec_core.c     | 6 ++++++
 kernel/kexec_file.c     | 4 ++++
 kernel/kexec_internal.h | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1b018f1a6e0d..27b71dc7b35a 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -159,6 +159,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_terminate(image);
 
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		goto out;
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2c5b72863b7b..8360645d1bbe 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -587,6 +587,12 @@ static void kimage_free_extra_pages(struct kimage *image)
 	kimage_free_page_list(&image->unusable_pages);
 
 }
+
+int __weak machine_kexec_post_load(struct kimage *image)
+{
+	return 0;
+}
+
 void kimage_terminate(struct kimage *image)
 {
 	if (*image->entry != 0)
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b8cc032d5620..cb531d768114 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -391,6 +391,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		goto out;
+
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 48aaf2ac0d0d..39d30ccf8d87 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,6 +13,8 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
+int machine_kexec_post_load(struct kimage *image);
+
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.22.1

