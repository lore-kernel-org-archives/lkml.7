Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B50EC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577D7222C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="T3HSMOsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfJDSxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:53:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34801 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfJDSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so6793196qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XbQaUimD78vcQ5YhGt3SAqPD0eC6PCpt9aPKURlFvbA=;
        b=T3HSMOsCC7MVlPJHQkMuk8eh/ngyjURlVWD+pEyqUObu1vLcvCV1KihS2VJd5EHh4x
         6Gt9YscgCCnZlG2b2GH133S/moS24v0RANnkaZji6KEb2A2/AR1zs5HSLFNrE1crGVUO
         93+iAhb2NBRetq53GDzx6AuY0LshLWMb9Izo46ZT0WVt2vTHX5ZVbjROVUGiasHKRrg+
         8HSu/vmrHXeDgx9MBtTx1VTfpdJZ0Z6uu70TmlyVP5aTnkP/xIkgocR43XzFuMRfY7et
         k+/Gyh+HPhrUWHD2N2rLGbTWrRdbS1ipeYd2ReBRjSTHvsOPDXezAkX8q3k4bzd7fv1D
         nUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbQaUimD78vcQ5YhGt3SAqPD0eC6PCpt9aPKURlFvbA=;
        b=U16P/UV4gNoUDOniKra6mgf4oDLBzlNfhhpiwKdGGddiq3DFhNM9ERcss2vkxb7Uz1
         /tjeLCepcEMEcFf7LJKbAFnnjuxIaxW5VmAuI1OGZ2pG9f7D6T0S2n99eO/lwLtG0+ay
         Y2iLLMF2/haYIDdj3+tyKFzmmY8Xx1ne3CZfVC9tjh4itTEBcDFlbN3YetFzA3uM1mga
         x/qmOKIJrBUQPVFF/G5QtLm2DwjftU9V7Kecy05fm7pHKVIw38EVywSj6DSNcHA19Qg8
         z6B70ifTgErQW/hhrC0S2jsEtSLsE40Y5OGczhYYFmGPy2yRTLM+B2sM6g41MNM4z7G5
         0nfw==
X-Gm-Message-State: APjAAAX5HiwpltGbRnU+FQZzhyr2z/JL5JQepicuA/A6rmqZ5vAZov8v
        G+c3AAe1R+i7NBZh6zfBnNcWRw==
X-Google-Smtp-Source: APXvYqyXNbkCwVmR0CUBX2ljNW39KDWX97Q+N0JERDBOfmUDqQlQHHKsgP5kmx41XkPyxQ3t3F45eg==
X-Received: by 2002:a05:620a:13ce:: with SMTP id g14mr11609764qkl.199.1570215175626;
        Fri, 04 Oct 2019 11:52:55 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:55 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 13/17] kexec: add machine_kexec_post_load()
Date:   Fri,  4 Oct 2019 14:52:30 -0400
Message-Id: <20191004185234.31471-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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
index 79f252af7dee..5b7f802be177 100644
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
2.23.0

