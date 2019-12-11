Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB72C2D0CB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C812467A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bj6k8Bc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfLKTqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:46:45 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54510 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfLKTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:46:42 -0500
Received: by mail-pf1-f201.google.com with SMTP id v14so1261980pfm.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A53ZaoyxJN+P/x/wFOv9wV4eF+QY9qPjvQKuh7OFwuU=;
        b=bj6k8Bc7Ef+j+rl6hUKv99wGBXII19pyqdKKrJI0g1qkHNJltGp6k0JofsUtU0Kfp5
         zqAhCWh68oY3h93QzByhJEA8pU1o8YBJo+oZ4HSt1YsvpskpVpaUEo0vSulRMxSeCpcr
         VZMZA/5XiHkKoc65RR/BTzy/O5rbh4JTkFVhARzzljaJcGSBo6eIXI40pSDGc9OWm4nY
         2DNHHpbEB4SbXmkypEr5D7aJOGGv7GJAj7D9dia2t2v0LIph2fUasLu3FP/R3OHplmre
         9qq6Pms+e1Jc5fZJodLfVRV3xImJzyCRQUsXrnZDuOPRBmbuOJFlmaGZ1+ax43KuK2ZG
         CN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A53ZaoyxJN+P/x/wFOv9wV4eF+QY9qPjvQKuh7OFwuU=;
        b=YyXir6tVLvBGOwKe0wmnA+MISjn1jxUvUqdasooco/Zsu3f+lhzpGb75vEpvJbMpAt
         FV/1fK4eczDn80FGBRZ3XewoITNPPtUIxEfBoIwctmy67YUN6Omv6E3RlaxS1emuXEVD
         Smv7aqtz2a34rTy+G3fiyGirVRcvHns/WNLEU3o4QIyekRApRKOgvk4XPlTpHXiWlZyy
         9IFU4ExrnFfqGhLSilqTQ6xtSc0qkDAaltpTVH45OpTqP4yTZi8ByoTpIlNhyLHU1jKg
         S4EbBeVKydCMklu+CTwYD6FbaNDrsqGGrWU5q4lXYUrEIYCmw7H5wt2mYESjQS/xuNE4
         GYhg==
X-Gm-Message-State: APjAAAXatdVXBa5u0unN2ABJ80sMAz2Q9qp5un8+hgp/8cxZJ3DA+CsF
        NqpDTCrxT0daggqV5azgp0Mrd4+n
X-Google-Smtp-Source: APXvYqxkWLsqIgmvHQiiMFxw4ZXKOkzE0dbenXYUwgiP/rqdexXMIIwgADKdnZ2MnxRj90Xlrt1a1MLn
X-Received: by 2002:a63:c013:: with SMTP id h19mr6078212pgg.447.1576093601550;
 Wed, 11 Dec 2019 11:46:41 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:46:04 -0500
In-Reply-To: <20191211194606.87940-1-brho@google.com>
Message-Id: <20191211194606.87940-2-brho@google.com>
Mime-Version: 1.0
References: <20191211194606.87940-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity check
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
entries.  They will not be mapped into the IOMMU, but the IOMMU can
still be utilized.  If anything, when the IOMMU is on, those devices
will not be able to clobber RAM that the kernel has allocated from those
regions.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f168cd8ee570..f7e09244c9e4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4316,7 +4316,7 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
 	ret = arch_rmrr_sanity_check(rmrr);
 	if (ret)
-		return ret;
+		return 0;
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
-- 
2.24.0.525.g8f36a354ae-goog

