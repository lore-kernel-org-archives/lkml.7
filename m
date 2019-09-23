Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65DAC11FF7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1CC20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hECEW80O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502817AbfIWUfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:35:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34889 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502800AbfIWUfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:35:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so9853055pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kCOV/SKGyCS/idoYOjNn3DaQRL2Ie2fUru8T4/v0tiY=;
        b=hECEW80OowucfYu/52sXrIDun1tK80j3pQv+b2fbBgabumiVdSJyvqrVXtrioJldNd
         urMLV5iHCV3KA3E/4qiZfwr6Z9WIteQzsU21H1akcamSGkDklOdO0o22VbxIYwDU4OII
         YXT7LW+oVJg2xvLIWYmceBLLXADhdoVm/He4N2R4NnICbF5ZpRvuBYeCnVE7KlBMmSy8
         sX4PsszBAesbNLnSIu9ancRbbrLfOiQySP1b1fnOWoPRtK4xURhLl+EDRFi/KjeM7c7i
         Rl8+8rDh0FeE7pU0wB4hm2pFfl4L7VoTGrmZJoK4y/ViGTtjNcJFT+ZwkhsfY4SBhnn5
         Phvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCOV/SKGyCS/idoYOjNn3DaQRL2Ie2fUru8T4/v0tiY=;
        b=S/9qK0Te42PFbYfRKTcx37zcSdVD1x7MSc1pLYQuzoWH4TYayFSGPzMIgBtcrm4FDd
         lAueFEx4k0iTNOC3De7WkQrm20iRjdddMUTWOoIkojB4stC0tkgCROHzSfxqGgvzi4uN
         EYwyiSjhQlLbJAwe5V4D/I85BF7NygfVvcRN7mZvrs5vPtpmWEn36QMMXAXOv3maCtpn
         OmWOthFqMIMch46br3btVZS477qm08C9/plZWSkwLlxU7LivWiwoDWNkewe+/pHLA7s1
         4/X72t65D6BRmCyMQ0cB1UOgH+5LD1XoLkKHbdX1ZI/sVx2ZyQOCJWLbbqd582lkLsua
         i0XQ==
X-Gm-Message-State: APjAAAWc+Vkyd93+xfhUGTLviy1WrnhLiC6X3Bi2iZ0BZGzc/A7Doz9t
        1KPUdBu6NySTrrKRhygEVTkWZA==
X-Google-Smtp-Source: APXvYqyh0pHM+T1vgCjrUaqwaXzl27erGlVnBJX3ECpzLMx0ZfHUDTjGJiel8N46eTWPvVx5gcFZhA==
X-Received: by 2002:aa7:953c:: with SMTP id c28mr1610359pfp.106.1569270911771;
        Mon, 23 Sep 2019 13:35:11 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:35:11 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 13/17] kexec: add machine_kexec_post_load()
Date:   Mon, 23 Sep 2019 16:34:23 -0400
Message-Id: <20190923203427.294286-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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
2.23.0

