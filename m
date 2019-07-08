Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DEEC606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF99321743
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="mbcbklPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405339AbfGHVPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:15:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41657 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405282AbfGHVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:15:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so18109691qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VdsesycGrscxvl9VUJv2OrYGiO6I5hjIVNNGDZpPz+A=;
        b=mbcbklPnE9aSK5WgO3DjHoIPCmDRPu0y6gFhVqT2wERSQkqrlINfT1Dum/1YBHqVIA
         MHfCGiZYhNcyqdpiDNvMZSUSkBjk9mmUm2UzAXxyreXwkDarMe79+dMnFwRPOh7+l6Tk
         aB6rNkHgLO7Y1Jiz9NmlCAtxcQsnJZJn3GDc2qcLNW/H2zSoSBaJvjnwMgsVYjZasY6h
         wMgRHG4K4lnwl6PWSVbLTrSouwk/nknjx/sQIWAwaSwgSoByC78yhCB9mcQr5qM4iUFx
         zS5tOkS+Tj8MCjoQW99WEy4HdQ8WxAlpnEJNn0bceuRbwkIodt64QR6c1sZewin18v6i
         Sqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdsesycGrscxvl9VUJv2OrYGiO6I5hjIVNNGDZpPz+A=;
        b=pOwl+k+YjIfPluEa/odRic27IoC2ZSNlcOWwxfrDwF6o8LtPjbyw8C3o3brJOfs4LP
         D+SV56iTjX1aU3Y4ClKpwsi2uNKNovIEPeao2uN5AujIB8GKaYieqeGCzitYEbRlaJLh
         K8IOd+H3B1fQHcKzffsYYaWCQGc3Mg1kYAJTYz2BUmwn7LZkrZOGzKt77bKJI4qaPu8G
         dxfXjuxjc8bZ4NGt/gj98K3GaSaowy0yh2wGDolSP6CmZE4lWHhVHalsKjALrjvHXY3P
         dQjO2NyYKsN9GnubpZZuzUsyQI5MTF9KT0TBDBZRvYp/HbylE4LPDOVEE1OwJpIO9IaM
         081Q==
X-Gm-Message-State: APjAAAUjuyf0GZktrzsRSbIstkP7pEGTIPJG6dmq19oHPmabffiEjZy9
        /l84l7SzLzZ4Ual7X5T5EPqIag==
X-Google-Smtp-Source: APXvYqxh88FuDHDTA50xcvkZxoDS6gx6EQNHyyvXUFPd1oxFXlmv0rBVOQea/c8sZqigS6xV/quFaw==
X-Received: by 2002:a0c:89b7:: with SMTP id 52mr16660367qvr.199.1562620533833;
        Mon, 08 Jul 2019 14:15:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id b67sm8335620qkd.82.2019.07.08.14.15.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:15:33 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v1 2/5] kexec: add resource for normal kexec region
Date:   Mon,  8 Jul 2019 17:15:25 -0400
Message-Id: <20190708211528.12392-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708211528.12392-1-pasha.tatashin@soleen.com>
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
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

