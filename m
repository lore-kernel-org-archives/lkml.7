Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F561C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D8D21744
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDuMzPBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgAGTQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:16:32 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:43072 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:16:30 -0500
Received: by mail-qv1-f73.google.com with SMTP id z9so530487qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y/3Y+84X8KGEdDu3mHYqqD83QSqQOnGFBhxM1gmAosg=;
        b=DDuMzPBTfb5mTvk2tA0RozQW5ie2aNod7wT4RViu8B/nf9vMcTUrU7ULbhgLqQBN6r
         KDpUsLWDVLM4QYBI+8UBuswpKPwKpQnpknMuen5j0BiphGzq7teMMOLFy+e/ZY6jTqh/
         3/DYSfpKiP2S0EeuJgK0VDUxHz+92VyRWYeGMVYQ1moikKsJf6wuEr5nQIMuZOW1Bolo
         xqcaJ0eZ+JBMgJb79jhkbnOh3Ov2ZsCljwZ9aQetJM0UjKZt1sEEi1JzypSZ5epcWGji
         uPyALoRNMRPwe9iYTwsSzSMaXY1On2suH5Qdh8tiiZUZamEpBJQj/jHiwYyGaYulglN2
         Oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y/3Y+84X8KGEdDu3mHYqqD83QSqQOnGFBhxM1gmAosg=;
        b=j14WcGsrvhcBEQXHOLZDBK8rdvwmi/FraajXRCFVt42OkT1ReYqY8aBPr/sw/dE4Mt
         O9EPd2HZAzoXNuGH3uYCWbqG/79I55PVAZasbWplrvdbYcicciFhYkhCqZPlW7ptj3PY
         1TIRPUEZ0LjBdxe479uYNy+iFSZh8woid4v6w+bk5exq3raaZVuc9APy8BTL03FJzDP5
         CXkVnyYw5ncu+jvc6Y6T/AI71BspI4ENUO+fWoZWZapPFP0g6FLmp0cfIcMTF0EXrY4Q
         3ztZwqHuojbg89IR9pd9StXyNyZlDFdK2fVmrnFY9cb1MDg2E44PXaW6XM59ZOhDOuce
         G5Vg==
X-Gm-Message-State: APjAAAXXvQ8AURoLsOGilkDTqXSII11M86KfEDz3GuwF5d62xgM9p1SQ
        aCHowkJHdgEdyapAgHYpSP9QxHIq
X-Google-Smtp-Source: APXvYqzxgfDpppOV0rhBZT5hf3y4f+cubh/6cVj4eEfl3doeV+8L9UDvhdRPV0zPeLffKAyoDzGD3Xav
X-Received: by 2002:a05:620a:911:: with SMTP id v17mr822843qkv.251.1578424589791;
 Tue, 07 Jan 2020 11:16:29 -0800 (PST)
Date:   Tue,  7 Jan 2020 14:16:10 -0500
In-Reply-To: <20200107191610.178185-1-brho@google.com>
Message-Id: <20200107191610.178185-3-brho@google.com>
Mime-Version: 1.0
References: <20200107191610.178185-1-brho@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 2/2] iommu/vt-d: skip invalid RMRR entries
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

The VT-d docs specify requirements for the RMRR entries base and end
(called 'Limit' in the docs) addresses.

This commit will cause the DMAR processing to skip any RMRR entries that
do not meet these requirements and mark the firmware as tainted, since
the firmware is giving us junk.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a8bb458845bc..32c3c6338a3d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4315,13 +4315,25 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
+static int rmrr_validity_check(struct acpi_dmar_reserved_memory *rmrr)
+{
+	if ((rmrr->base_address & PAGE_MASK) ||
+	    (rmrr->end_address <= rmrr->base_address) ||
+	    ((rmrr->end_address - rmrr->base_address + 1) & PAGE_MASK)) {
+		pr_err(FW_BUG "Broken RMRR base: %#018Lx end: %#018Lx\n",
+		       rmrr->base_address, rmrr->end_address);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct dmar_rmrr_unit *rmrru;
 
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
-	if (arch_rmrr_sanity_check(rmrr)) {
+	if (rmrr_validity_check(rmrr) || arch_rmrr_sanity_check(rmrr)) {
 		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
 			   "Your BIOS is broken; bad RMRR [%#018Lx-%#018Lx]\n"
 			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-- 
2.24.1.735.g03f4e72817-goog

