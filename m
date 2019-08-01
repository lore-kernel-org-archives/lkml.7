Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76137C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8E4216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JNZ/KgcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfHAPYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:24:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37806 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbfHAPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:24:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so70630002qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R6/SxEPTIzTdE6W1Hx7mOa8dC1CKLzuuI3rK/m6KyjA=;
        b=JNZ/KgcYfb4dNpim+k2MOWWLFaur4nKwhjsoOoTJ+D9swbQ7WakCBsSE79BZJK5VUd
         TjaR5Fn6DG/7FS5/YK0BwQFEPkSVX+wxFzBFXOJHef1uJRGPIeUsvsLHJfXvbd1LGc58
         jSLve3ailjdQ/fS1b0OEFemmlrJeEh9hMrTcExWeVX2lAEBSKx0SywyPQV1LbcXFN+Qh
         bYGCXdm6pxLTRxasMToe/hcej2jpVrw92NRmHdvnSvfeQnxY+fK8ThuKP47ARnpprP5N
         YVNaR7JIkuxX+NzvFrcGZfJzUE20a9ytsxMazVrOY+8n2NC9P0G+nZoK1RtL9Sk5qgaS
         P7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6/SxEPTIzTdE6W1Hx7mOa8dC1CKLzuuI3rK/m6KyjA=;
        b=kl4lJvBryqHW5CPQvY0eBtU0fyi19s9ACyX1GPsN6IDOMuRoYg2/zls0z7iNUNlaU0
         jAEgWfWEAEoO2QZzPYFSvCvt1ff+Vb142CTpK3bYkdfQ/fqbfBu3QS2Jh9H8qOn9qvQn
         ZwLhRhSNaxxUuiQqmHsEz7eq+7UIqRtoAXxNqRCbZ7eM7RCfzPk1YdXUBuhnY9bS9NJ1
         8/HNkoEkD4EhqxUvukFQC2Q4l/Hi53aayfkTHEmCoII8iolTtoWZY1mgMRMLG0LA8zCz
         Y7Djf6EgGeADJsB94YFx6VgV1KtezVrpr9Wr3t5Y79aXT/jU1V6mpyXTTGuj5B/0Sm1F
         A0pw==
X-Gm-Message-State: APjAAAVPI9yWY0IgZkJsaUdDi/NmJCIHRv2VwHSSEE4SdOl/VD0lMOKB
        67/Oszmyuzca/nX0S2lECWA=
X-Google-Smtp-Source: APXvYqyqwg6VPHMO7J3bHZKnQ3bO0qH12fclYw4spACWNbJ1vUFrzBMweyq01CQXeNwF7FoAnD2faQ==
X-Received: by 2002:a0c:99e6:: with SMTP id y38mr92593639qve.42.1564673087348;
        Thu, 01 Aug 2019 08:24:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o5sm30899952qkf.10.2019.08.01.08.24.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:24:46 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v1 4/8] kexec: add machine_kexec_post_load()
Date:   Thu,  1 Aug 2019 11:24:35 -0400
Message-Id: <20190801152439.11363-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801152439.11363-1-pasha.tatashin@soleen.com>
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
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
2.22.0

