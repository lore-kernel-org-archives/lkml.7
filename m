Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3630ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F15021D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CiaFl7Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437033AbfJPUBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43614 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfJPUBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:01:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so32647838qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2dB/JT7cpleUq4odQT8133EyCdo3KLVbNGsuR1ejXK0=;
        b=CiaFl7Mk/0Ai1uwEa1O2lGNLVpZo5+wb8v4pxmTWNb/dm2ro8mnYZnV8Edb/RXkgRm
         ki9I2+kYEPNZ+agtblWoi4KTtibPFfC2vJiQksWU9jlWzvdVmWqdIkA4Lb0g30wQcKQL
         vpQgAcBEBz8iFcDhWcWOcJFD4aLtX8PKUsr7KjYk5pXKwhCAV4dpCJ/hfY7qSm7PN9TL
         O2WTpHeLIh+12Q279PtAXhUhmTU/kr03dDQNBMsaRp6U/XSuSZ//IdFVQofebNWXkdPb
         7sUSw+IThgjUN6desgaUOBQdZufgn2uDSC9v6BTW3ULEOcUHxK+y1y0yRmtPvPsMsmeI
         wKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dB/JT7cpleUq4odQT8133EyCdo3KLVbNGsuR1ejXK0=;
        b=E0ffZV/P38+M/IPu83xpiTdXyay60aQL+8NySxgFa3c6Ve1m4s7FnoUm5Qd+RyAAf1
         wohlnph2weQZhZysYRyCq3IQYt4nirmn01RpO2AmLRQr8Cf5YrmqZIdNFnkr0IUJKLzh
         5TWkOR/I3v01fIjaTV2jDJ1HmsVHVNWA+S1NeMW2QZafxY2gSu2ipgHVXBLzh4ClNaes
         L20uvkZheym6IRetqo7XxydbLFRtZOb8YBcStfkUoxJWaYCF23dLk/sIQQSvdJgXKA1P
         zkfzxPbwpwvEiybv/VVtQHLAlTiJCpYbyT+U1uY7Pkq5JWFzo0HWxFpOdKIk6K7SC2PJ
         0Myg==
X-Gm-Message-State: APjAAAUGJ7Tr5Z78KCKnRCf2F65/yCDp1PXu5BGJOz177YW66jwRZYkS
        3BEOvOdsztqfgm0qyPE9cqEfQg==
X-Google-Smtp-Source: APXvYqwMAUjRlLpWrrpgx3tDKuFsAxRFXePefh3P5/JOzZtFez2e3nLHNDhNVIJG5zsuWzwbBLXj9g==
X-Received: by 2002:ad4:51cc:: with SMTP id p12mr29646954qvq.243.1571256062832;
        Wed, 16 Oct 2019 13:01:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:01:02 -0700 (PDT)
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
Subject: [PATCH v7 16/25] arm64: kexec: call kexec_image_info only once
Date:   Wed, 16 Oct 2019 16:00:25 -0400
Message-Id: <20191016200034.1342308-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
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
2.23.0

