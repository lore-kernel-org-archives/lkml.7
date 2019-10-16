Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79280ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5458321A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PmgVNinl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436839AbfJPUAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:00:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36500 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436828AbfJPUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so24012000qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bEALksuMGDCoXJUsPuJK9KjzrlYMPFHPnYP/iTi6nJA=;
        b=PmgVNinlAhKoCy38ovygoke5eHkmtndpc1qCG+WMEy9t9CEaDFzQKRRgmdC+/OTIAr
         cClxqiICWNaO9nHeEsZv1j3YqYY8c2OLUOt90mSsJlaqZ0yME3UdcMJnjBBcAFw/MxOB
         1gU5t4NkzRJAnW47EOb8ae4y2t+V1JiAo3wDbEYc0YRWeJM0RtUeU8C3aWxAqgm21r2X
         2TjH36zN66FahrRc6sj/m312DAfD5zn543Be9cOWsRTaprJZ2ao3oHfuJffHHQSvKTfH
         Y7lPKpfR61Aw+x4ek1rgWv3PvQp/5zoyFWjLSW5+KPcvj4n3qAvnRZospNLcs5gjEocg
         UXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEALksuMGDCoXJUsPuJK9KjzrlYMPFHPnYP/iTi6nJA=;
        b=F+CxN8b0KWBfsBMMNLsuLyaN3tRmLDdISXJmJQOSfs8IaLpPel1qm2j6PmfZVuBVC5
         T9/iiJpghT2tZ7onJqv6VoOz94NIrC8PKWHhb2xTKkXBfBoO2F8ZSDYLNUdJvSWbhMEZ
         SJ+AclEclg/kA+mC5holAEnS2ntY3O5bpTohLAJX6E1bnufQyA9VkL+2CX9Q+wDfClwM
         i1uGKRtW4oKxKj1doMxYfYlwsCZTeOWLgMFcRyUZAzIvaRUKQtrpJN+HCUWVHvxvOqUj
         4Ra5H2ASDqbvYZkQ3PT/2hgUv4rokxQP3VB34KwWlabiXqBCCPidwzz5fOSYSBBx83aF
         Wz9Q==
X-Gm-Message-State: APjAAAWiy7zJEyOI/BiLaUh6V0rFudGrXvRiRVvde+d9w26y4yt1/C2/
        obHQuClFgF/BdzgxYPt6BRstSg==
X-Google-Smtp-Source: APXvYqzyH+2jZ2ynpwq6pYQufa7x4iWmQOZSfM/oXRiz2GauBXOrA822WeZtbs4kkqeqKB/SnonOpw==
X-Received: by 2002:a37:56c6:: with SMTP id k189mr41781172qkb.124.1571256043570;
        Wed, 16 Oct 2019 13:00:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:42 -0700 (PDT)
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
Subject: [PATCH v7 04/25] arm64: kexec: make dtb_mem always enabled
Date:   Wed, 16 Oct 2019 16:00:13 -0400
Message-Id: <20191016200034.1342308-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dtb_mem is enabled only when CONFIG_KEXEC_FILE is
enabled. This adds ugly ifdefs to c files.

Always enabled dtb_mem, when it is not used, it is NULL.
Change the dtb_mem to phys_addr_t, as it is a physical address.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 4 ++--
 arch/arm64/kernel/machine_kexec.c | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 12a561a54128..ad6afed69078 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,14 +90,14 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
-#ifdef CONFIG_KEXEC_FILE
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
 	void *dtb;
-	unsigned long dtb_mem;
+	phys_addr_t dtb_mem;
 };
 
+#ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_image_ops;
 
 struct kimage;
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8e9c924423b4..ae1bad0156cd 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -203,11 +203,7 @@ void machine_kexec(struct kimage *kimage)
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
 	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
-#ifdef CONFIG_KEXEC_FILE
-						kimage->arch.dtb_mem);
-#else
-						0);
-#endif
+			 kimage->arch.dtb_mem);
 
 	BUG(); /* Should never get here. */
 }
-- 
2.23.0

