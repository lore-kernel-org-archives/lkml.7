Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A7C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A4A2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MYm3P8va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfLDQA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37048 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfLDQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so239184qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=caPojFU9C1Vw1ye7p06/lKzSTQslx3S8Kp3MSLulHf8=;
        b=MYm3P8vaLfZ2ogHotmHOsHIpSVg9cvTGh4ZQEOyCjA5nnY6mdFUFUhx5AXhN0j3XJS
         beL8d42BtYxbaySly0DTbhBk2AmxjdCf9WX7//T/oz7z9ge0aaEUqx8F8duzafWUbJxA
         LTWMB6kge+LbwPmEfP3BHmq/62hdxhna88Vx4NVqZnpyJA9KaibztPZdcbPVVexGs0TK
         VXDAMwSB0nPxu77i8MqaEa8xlHSAf6zthbzRNLnrCri77E4SthsQPlHK6M3Se5qr+myW
         OV4kg9RT446a+RXhFIUOoqksiJ7J/EBKXfRkS/JZPfLVcTLDgfMF5b5ZUPgxjQCSa4nD
         NWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caPojFU9C1Vw1ye7p06/lKzSTQslx3S8Kp3MSLulHf8=;
        b=XU3xOC+q/c4YdYoyPbsMsElVzQKPBLedTZ+xDUrax/77RcnhVb92v0E8fBsZYDIkJe
         5FBs3YeHrrw6xcQunXRyNIouu0PjmzluAhLcJlQK2uQSkJTfsblLO1LbT079rbMUzUL9
         7DohiuzlSodYFyyWQYXYcICOs2Hw49XNbEFVztSfnsSbSruyreSKInAhw9EzA78fJkid
         NCINZt8lafbZ6L5sMRdVoHrRRHXC8l3Tqo7AM6EBDX+Zz6iwXWD0Y7N4ymHKxTNZ45AA
         7z5QUJlp1NWpkUfenrN2o8JRAOgniiattxt4d1uC6eiRoWHk+6lQaFLfQHsVyliYS5Ve
         JJXA==
X-Gm-Message-State: APjAAAVdG7gENXzD5JDS/g2BIqvVaOhRWGIYVrSswoclQzJiPY0rMQtJ
        qg/JH52Azj++5Y4ONMcCM54A/w==
X-Google-Smtp-Source: APXvYqzTKumsWYSE0kFMpP6G187N4Bgp/ZpVRjk98+PQxso8eknOwr7Z6ZJIWc+kehL8rXWA6r44+w==
X-Received: by 2002:ac8:7b24:: with SMTP id l4mr3347748qtu.3.1575475204637;
        Wed, 04 Dec 2019 08:00:04 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.08.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:04 -0800 (PST)
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
Subject: [PATCH v8 16/25] arm64: kexec: call kexec_image_info only once
Date:   Wed,  4 Dec 2019 10:59:29 -0500
Message-Id: <20191204155938.2279686-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kexec_image_info() is called during load time, and
right before kernel is being kexec'ed. There is no need to do both.
So, call it only once when segments are loaded and the physical
location of page with copy of arm64_relocate_new_kernel is known.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 46718b289a6b..f94119b5cebc 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -66,6 +66,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
+	kexec_image_info(kimage);
 
 	return 0;
 }
@@ -80,8 +81,6 @@ int machine_kexec_post_load(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kexec_image_info(kimage);
-
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
 		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
 		return -EBUSY;
@@ -167,8 +166,6 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	kexec_image_info(kimage);
-
 	/* Flush the reboot_code_buffer in preparation for its execution. */
 	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
 
-- 
2.24.0

