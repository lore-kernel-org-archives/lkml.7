Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32BBC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A402F2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="a8S4mBC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfLDP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:59:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37006 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfLDP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so238055qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2gHoWz5U3gDvwOIWS+f4ZdY50s/vcrKHXb/YTJoNTqU=;
        b=a8S4mBC3Dt23xxnDE1I9wz9WiyUF1CmXE2b5cIfPza4Al587zhEJsQ3/UfRwm9U+G/
         rRRqctcvpDnT6sJ4PjIsg0jEuIdwrHHFaf9DZrY+XcZa5X5HqfADC4/ZE/fK2jOaAWgU
         W2eTwrnf5+BiTNu9IleEmtU0sXaYA1ww/f2Z04R08eCD67sNZB4PEOIQ3156ZCKhqt1Q
         F/b9ovj2Jub3p4xim85ROV4ZHUG0gj54u/9VbLyh6qveLWICy/KpXEvfQm/MlfKFqDLS
         8vFiPKLYJ57TxShn7SFwh0QWW3AfkDec3XUS+DjVhJwEFPhmbNHzu28bBSQFiNURWkoT
         4eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gHoWz5U3gDvwOIWS+f4ZdY50s/vcrKHXb/YTJoNTqU=;
        b=fTd6JIRjGyvOckWcrXllUlzUBt6eJXJOrfaB7M6QjktHAH2YoOvpmBxDX5N7Yde2/a
         rkC3UG830dBBA+o35THvZOrqrmpHWhu1KdmP0rOPqznYAvFA8XRQdltBEe2Yt2ZSK3Gi
         2H2UodustRR/LCJ0pjClIns+MylCKpOmkPGcAv8S8TWElqtilv38fMAs55bcSWwEfEF/
         lLYUYtaWwlKurA+vyOQU0r36gxp0UX+dP0elJV5409IBTytHfWdVsg3fEDdVxCUdyTEi
         kYedQFKJyRWqaLfEam+vaUo7h0SyDm66heqv4ogHPM6m+xBiWAmgaVjPNJTA3N1llEZZ
         iBrw==
X-Gm-Message-State: APjAAAWSjYgVzFl6ZSD+uU3LuuRr9YVU7bouNEapdg4urE+9E0BtGAdJ
        CFrl+KHqDneU8lTF91ZoS6J1FA==
X-Google-Smtp-Source: APXvYqx9KAIwGf5i0C+05hdOsoH1Qz53bF4Ua1D78Kp4D5OsFHhBK4l+6RncFcIz1n4N/yJalTasNg==
X-Received: by 2002:ac8:5319:: with SMTP id t25mr3419613qtn.242.1575475186888;
        Wed, 04 Dec 2019 07:59:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:46 -0800 (PST)
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
Subject: [PATCH v8 04/25] arm64: kexec: make dtb_mem always enabled
Date:   Wed,  4 Dec 2019 10:59:17 -0500
Message-Id: <20191204155938.2279686-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
2.24.0

