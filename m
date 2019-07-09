Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A2C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BC8214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Lxz1gcUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfGISUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:20:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41322 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfGISUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:20:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so21199931qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VdsesycGrscxvl9VUJv2OrYGiO6I5hjIVNNGDZpPz+A=;
        b=Lxz1gcUMBjd/teRSMIUe0VCxgzAsMdo3Rrn2b801LIo6TpuHTsRwusYzWVPRKkazNn
         aAdOj2lu6GpB5lRRJHygM5I8HppPYWYDQAaywxAfo2xqyv64cDjnnOeOHkGgezgBW6Nu
         djzd2PEL9D+Qec4rkUSmWz1H+lTOHJEjt7GhXcSO4imn4ddhyK3Hk7AQ70/qN00gW7hu
         wIEFtsDNWfbhO2cfJblKWFwp6D9W3cUBuqCUlw0F2/VglB2QrsaAsobfraWn1QISADWD
         dpJWu9FxbHD/vEFNL3NozHPeDPJcYEXDBomOxuPMe6xhnzj7RHJpqS2pUV7nuPeTWBA3
         oM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdsesycGrscxvl9VUJv2OrYGiO6I5hjIVNNGDZpPz+A=;
        b=HbS+NhLHOuESGtnP752fYg2Ajf1I0bIDrDWw7pUcX30e8G7NwQcxXJfuvAECXVGzrz
         IKh38BNotBKmn/Sy10l5Evks4gumzEtyHg1d3RG52hv47hxfLbTL76waSoOUR+u7tAg+
         GjMqbzMSTmkBt5I317PgV1SKnOK4QLgHOsnwrnTHzll+2ClJPuPnsYKZ7M46WjtM0VPZ
         L+OaSR0MXy6AWxMktniQWHIezbpjShLg4iek1WTjQg7mB4bp5YQIrwhxYSccyknHb5LF
         XO/8mC40Aat60unsBvs+s0MeurzC35pPm/gXdhOOAT9t4LazYgo0HNOez16aEJPGRH+A
         TK+A==
X-Gm-Message-State: APjAAAVXGhD1ppwk2qmvOSnxnxqULAvSpH29wbI+yXuuZSSKFRPOBPLa
        0TrufP7VokFdBrLj20DNGqM1Gg==
X-Google-Smtp-Source: APXvYqwAG4/7u8EKC7EBi9MHlMvmuFXHJunA2cypRFYP7aL7Lw7iEQ73R7gZHDrIdOHZAo9JKHhQaw==
X-Received: by 2002:ac8:35ae:: with SMTP id k43mr19635975qtb.259.1562696419082;
        Tue, 09 Jul 2019 11:20:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id k123sm9113056qkf.13.2019.07.09.11.20.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:20:18 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2 2/5] kexec: add resource for normal kexec region
Date:   Tue,  9 Jul 2019 14:20:11 -0400
Message-Id: <20190709182014.16052-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashk_res resource is used to reserve memory for crash kernel. There is
also, however, a benefit to reserve memory for normal kernel to speed up
reboot performance. This is because during regular kexec reboot, kernel
performs relocations to the final destination of the loaded segments, and
the relocation might take a long time especially if initramfs is big.

Therefore, similarly to crashk_res, add kexeck_res that will be used to
reserve memory for normal kexec kernel.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/ioport.h | 1 +
 include/linux/kexec.h  | 6 ++++--
 kernel/kexec_core.c    | 9 +++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..3b18a3c112f3 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -133,6 +133,7 @@ enum {
 	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
+	IORES_DESC_KEXEC_KERNEL			= 8,
 };
 
 /* helpers to define resources */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9b1bc5f9669..4c1121b385fb 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -303,12 +303,14 @@ extern int kexec_load_disabled;
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS)
 
-/* Location of a reserved region to hold the crash kernel.
- */
+/* Location of a reserved region to hold the crash kernel. */
 extern struct resource crashk_res;
 extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
+/* Location of a reserved region to hold normal kexec kernel. */
+extern struct resource kexeck_res;
+
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2c5b72863b7b..932feadbeb3a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -70,6 +70,15 @@ struct resource crashk_low_res = {
 	.desc  = IORES_DESC_CRASH_KERNEL
 };
 
+/* Location of the reserved area for the normal kexec kernel */
+struct resource kexeck_res = {
+	.name  = "Kexec kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_KEXEC_KERNEL
+};
+
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-- 
2.22.0

