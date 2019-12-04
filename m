Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC11FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD3820865
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZtlqW1OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfLDP7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:59:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35983 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfLDP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id v19so375785qkv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uS5983uJoHZy5JiqeIGQWhAtmT2ue7W1CVbOZjIqk6g=;
        b=ZtlqW1OByAmf47tXyRsopiX+BaNBesr84wke0vTVLOd+GkIrY+k3iBOCn8+k3BhroD
         UNPyg/sFg82rChe6aGKjY90pK15vcnyPSHWI/ntL/xrCb92iqtTCUuFQDgzNKJ3heYcj
         aamqSO5AfV4WR7UoOsASk9fB/ywo0S5VTXfuTqiZNofg+uS4jCiKICD+fWy0+/ahLoap
         dC7A63cF49Lmtymqy1AMRt03PDqSLFIz9dhvMvNL4HhZmvcOOqWAj0KpmU9tEjjVDK+Z
         LjhirTdzsonzWezv7RaT1Qz2fpdpTFzh8noDuDAhec1ZgziXt4/L1/RYgTO0O77TxhMn
         VFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uS5983uJoHZy5JiqeIGQWhAtmT2ue7W1CVbOZjIqk6g=;
        b=ZvsGRANRPQpX93JMamJ85z2uiIhCoOYCeOps4pedu2IqCoxV1wMB1TX0S8Gd0pUOpS
         +2x55D1UniSDXz14F8nJDGKwdZzHfpCg81nnt6JSjvMns5gPa4MbCHWBKYhRDNzqECSa
         bZVvJGcpE1OmlcSrfgfCQDUUU4qU2fuwhA1CHajXlp6kO/9l5nWw9lLNMAztLGktiDAW
         6A2Ojv4gtmHHZlXDvGLFE+6hemavwPG3BOGgiufP9fPhK/3Oh1VCChS4IodPkbM+iTSc
         zG2auFQmg/uzRcDm1KYwA2Aipt7dPjnS4opUpJB3Rrwlv2qHNeHCSQBuYZngjCmetRtZ
         77uA==
X-Gm-Message-State: APjAAAUgXddk5vMsEil5P/y8qajEbClU3IWH5zazSm09ap1pLBmBOYdy
        mPj9e7qEHRsZGV0zwqtvPaoxEg==
X-Google-Smtp-Source: APXvYqxd8yp8Dngio2HO2NRx40UjWPIBx2dPgEFDiwpELJdmzYKJ7ihFd7m3wohPBcadKXvewYRGxg==
X-Received: by 2002:a37:8e45:: with SMTP id q66mr3685650qkd.129.1575475183874;
        Wed, 04 Dec 2019 07:59:43 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:43 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v8 02/25] kexec: add machine_kexec_post_load()
Date:   Wed,  4 Dec 2019 10:59:15 -0500
Message-Id: <20191204155938.2279686-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
Acked-by: Dave Young <dyoung@redhat.com>
---
 kernel/kexec.c          | 4 ++++
 kernel/kexec_core.c     | 6 ++++++
 kernel/kexec_file.c     | 4 ++++
 kernel/kexec_internal.h | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index bc933c0db9bf..f977786fe498 100644
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
index f7ae04b8de6f..c19c0dad1ebe 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -589,6 +589,12 @@ static void kimage_free_extra_pages(struct kimage *image)
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
index a2df93948665..faa74d5f6941 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -441,6 +441,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
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
2.24.0

