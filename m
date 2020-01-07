Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9256BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68001208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTG3oakS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgAGTQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:16:27 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41368 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:16:27 -0500
Received: by mail-qk1-f202.google.com with SMTP id l7so450969qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0CZJko/qdfQtke3cSJ7hp5iCIDiC0gTMp9RSBpUuJOk=;
        b=rTG3oakSdnKidDuXwG4ZZs5fx3OQ+4GtXtAX3iWIs4Z9OLjOUGTuyOkhixGJ5wjqin
         jB9KfpGs26CsfP3NsA1aA/3ekAszm7fbstk9CB6gzSN5cbPzbhxca94l/V6O1Jmd2ouJ
         JGXH5EXr6vE+59a7yJehUo84xKsWJfzBSbaqiT6Jl6wDlufqvPj89kBecDvM1wZ2rQCG
         a2qzC6LTkRePvRi/b3RKNPRDPMkK+EyoIIYHT4yDs7ov6F43GSg13PkleH260MxdgPWj
         nZZ/yyWu/5Hg1fg3o/COD+Y7CNb3jUIzpLumKyILA9SjoEF5cymE6PAGeiOYf+0w4Amo
         9RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0CZJko/qdfQtke3cSJ7hp5iCIDiC0gTMp9RSBpUuJOk=;
        b=EvwFH1hLSS0t0hdTBehMKWA/vjap8huB4XY0c5ubMADhH7RWB1/DJEEMI9kHncitOp
         h3Pmp5vn9CqJaWEAPCNl6I4mJPF2W0BazOTVRI8NyurUoSGFg6S4iweuOEpR/RGYjCVV
         rnEZXhD8aIo/kumEXM/fAL3BM4049jDOZjNa9/ZXyS7boW2YX9s2IuKvnxG+L5V06FPz
         oqNQUIGkEunq7MY9Vn2vJTwZUZTG6iNr88tFaBVLdVr4rnBOOY/ilxfwPm/PNdn2nYKe
         7bVuXCXyKYygNX59TEMJB2VHjA/7OEy+OU/BILiMk5Jyv5fQL9Cq47QkRn0wDPdqbNzM
         2IYg==
X-Gm-Message-State: APjAAAVOcnFewWuoJHBYquAod11hgDzXQtRSqSO0YbnugP49R7R81lae
        lfsS7PmJTKWOjKtS3uacI53WN/R+
X-Google-Smtp-Source: APXvYqy1XuWeSkKDVL3EoMMtcHhFWGHomaPsgpaJfot96+/U98N9OEGR9ZJgyWYhVGpflnd/U05ZRLSm
X-Received: by 2002:a37:801:: with SMTP id 1mr885696qki.326.1578424585781;
 Tue, 07 Jan 2020 11:16:25 -0800 (PST)
Date:   Tue,  7 Jan 2020 14:16:09 -0500
In-Reply-To: <20200107191610.178185-1-brho@google.com>
Message-Id: <20200107191610.178185-2-brho@google.com>
Mime-Version: 1.0
References: <20200107191610.178185-1-brho@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 1/2] iommu/vt-d: skip RMRR entries that fail the sanity check
From:   Barret Rhoden <brho@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RMRR entries describe memory regions that are DMA targets for devices
outside the kernel's control.

RMRR entries that fail the sanity check are pointing to regions of
memory that the firmware did not tell the kernel are reserved or
otherwise should not be used.

Instead of aborting DMAR processing, this commit skips these RMRR
entries and marks the firmware as tainted.  They will not be mapped into
the IOMMU, but the IOMMU can still be utilized.  If anything, when the
IOMMU is on, those devices will not be able to clobber RAM that the
kernel has allocated from those regions.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..a8bb458845bc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4319,12 +4319,18 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct dmar_rmrr_unit *rmrru;
-	int ret;
 
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
-	ret = arch_rmrr_sanity_check(rmrr);
-	if (ret)
-		return ret;
+	if (arch_rmrr_sanity_check(rmrr)) {
+		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
+			   "Your BIOS is broken; bad RMRR [%#018Lx-%#018Lx]\n"
+			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
+			   rmrr->base_address, rmrr->end_address,
+			   dmi_get_system_info(DMI_BIOS_VENDOR),
+			   dmi_get_system_info(DMI_BIOS_VERSION),
+			   dmi_get_system_info(DMI_PRODUCT_VERSION));
+		return 0;
+	}
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
-- 
2.24.1.735.g03f4e72817-goog

