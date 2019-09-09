Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD12EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA30121A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WSuiLH/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405599AbfIISNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:13:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44528 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405501AbfIISMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so17261859qth.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kCOV/SKGyCS/idoYOjNn3DaQRL2Ie2fUru8T4/v0tiY=;
        b=WSuiLH/ElypDjQ34fWlc09v2lQ92yg7ePKKlJT2R3aZtootAoUm4IJlQpYdsKPFreN
         dpG5qcVAh2mngZA1/2H4b0qLtReGH2MCcbrCPA5y+UV3P7a485AFcZBTegOCGdcJwBxo
         9gs19c4gMMRWJp1NC7ATV1U16xjnxBej7id2nho6TQv/fzuLv8JZgd6/4yoJ9bwRtY9c
         V4ZTGMI4qeZ5LWssLrlZGRTvgnWhESrHwINMyVrNSbBzIGRXVKmTUgk/uRCV9RLAnLqM
         YpdJMzCZEAoE3sGF08ftCMb9PiTGeH7cfVJBN2685ZTBKxUt8c5rcuUkGpWDtmKGR+fr
         jwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCOV/SKGyCS/idoYOjNn3DaQRL2Ie2fUru8T4/v0tiY=;
        b=q14/0QGYu5lgvMG8s6xLyH3vmKpyVCBV76ihkCF09SzeH7eCud6PirJEsfon+U9Dqu
         oLlByyKvHU/vwyxlQf0pC7/PomNB2wG3zfxz9RGGbOr943UTRMuBpXHaiPKmjIN6hyEz
         9REeB63Ybf/09WM0yv1gvxyBTJUsa2bFeb6/ozNN+ZbkOzKCfI33z70Bvo1C7V732vQx
         990MyB70cL10JjF0Z9LmuqS+Vi1LgT+qPQIJrnFJk48xtbMDuytu4DIHAYb56T4ixdt0
         uym4t01J4sl6S0zPPSDkIr9fjZ2gr3CJrEIycqRPyCW39iU4JaRDS8oFsmJ91jBuqtdF
         zPMw==
X-Gm-Message-State: APjAAAUIAYlBQlgMfA+2Lv2ENj2t2tRdwGins6aHN040c4iZATcoTe+b
        nr087/14MZW1zioFVsSFrJ8iQQ==
X-Google-Smtp-Source: APXvYqz2qIj5gN7e5Hvb6xiqAO3cyUStcV6SZ03no6qDeMeKeESePA5eLLwvVG4yIXOLRtT962e1Ig==
X-Received: by 2002:a0c:fc05:: with SMTP id z5mr8556570qvo.128.1568052763165;
        Mon, 09 Sep 2019 11:12:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:42 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 13/17] kexec: add machine_kexec_post_load()
Date:   Mon,  9 Sep 2019 14:12:17 -0400
Message-Id: <20190909181221.309510-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
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

