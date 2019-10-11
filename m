Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8349C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816ED206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLcqMomL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfJKDrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:47:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43274 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJKDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:47:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so5219439pfo.10;
        Thu, 10 Oct 2019 20:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BFpgtLfpcuYnuHOZcClguxk/FizlRVOUrFmBGFft3Zc=;
        b=QLcqMomL195A0XFbz+6bmeHusd3RisVyozm1U6ZbnH9aFniTaqdqnyKC7dNvxtJX3x
         HK19zjIgzOfgQwXQDNp4IHbkwrsqsctxL6VgdOBZlTalLA2CQQ3Z2SNxkRz2MQRggiYJ
         NRZ1UL1syb8XfJPFupZoV2toUR6AkkJ8C0DBd/YD1fUE8Yxd6B5rImdVcmvNtywWA7W/
         IbkxT69IsFJZUiOq4I9WJnKe/WtK5ZYoSSxCWFOx97vfJkCjc4FBe0ln+hcfS9BVyEEp
         TuSgX62DRBym5hMIe0/UW0IU+w6vLpMK4gk2xFaDb5/UF3mI70O0MoAGDHqJwQd0oLO/
         W2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BFpgtLfpcuYnuHOZcClguxk/FizlRVOUrFmBGFft3Zc=;
        b=h9lXMcNg0SqFJVPy6dCCGDxR0+EDwlhfxTSaJ8Z3ke/kHzMXGFhPPTFVhNc6P5SQ+f
         8CvMQQREp/LDnCiQy1BqHUdQE/dCSwPPuWIXOqvPBCba25USuywyJ6GzafMPRHo+xc6C
         Ua3+Gd27lFZat4XNM15VFmTZvDbHs9f0MQTr1SIFlkqinPMmmWDwOODGQPJuH6DJEstT
         9xMgoej3uhpRDeDkFp64euMzlpxcEKa1DvwvVJN/tNH8LA35HyxkNPbWo2UdPRxYoAVS
         c7hvrw6EqPX1AUuKX29pOnIZl2eBlb+HEMNIOGYHCMCxkJMilfK7EsmbhEJvAZn3Vky3
         P4kw==
X-Gm-Message-State: APjAAAWQJflngd81ct2KDX8mUmN9L6uPsXZ7dOMo6cmqAFzQkqToBT0v
        K4u6LgniPydGJfxu3FDTLFw=
X-Google-Smtp-Source: APXvYqxmaqxpu7ohA7yHdWnf/4vQ5UFS1d9Fe43rR+v7KPX4qiC0Xq8qwegGxBu2z0qBDzrtwmo3WQ==
X-Received: by 2002:a65:53c4:: with SMTP id z4mr14216342pgr.155.1570765635475;
        Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u3sm7493267pfn.134.2019.10.10.20.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will@kernel.org, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add an optional "input-address-size" property
Date:   Thu, 10 Oct 2019 20:46:08 -0700
Message-Id: <20191011034609.13319-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011034609.13319-1-nicoleotsuka@gmail.com>
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SMMU instances may not connect all input address lines physically
but drive some upper address bits to logical zero, depending on their
SoC designs. Some of them even connect only 39 bits that is not in the
list of IAS/OAS from SMMU internal IDR registers.

Since this can be an SoC design decision, this patch adds an optional
property to specify how many input bits being physically connected.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 3133f3ba7567..a9373a2964a3 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -97,6 +97,13 @@ conditions.
 - power-domains:  Specifiers for power domains required to be powered on for
                   the SMMU to operate, as per generic power domain bindings.
 
+- input-address-size: Number of address bits being physically connected to an
+                  SMMU instance, as the input virtual address width. SoC might
+                  tie some upper address bits to logical zero inside the SMMU
+                  wrapper, so SMMU would only support a virtual address input
+                  size, corresponding to physically connected bits, instead of
+                  the reading from register.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
-- 
2.17.1

