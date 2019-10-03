Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C6F21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120542;
	bh=ZSB+bi5mbr3BV55s1umwo8go/XxMX3YmhZC4SEzUBMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SdXfFrwNj/5AFH1ElRMOIv7uABaapgKpX/P7KiDV7O3sv+hofokihp8XlXF410lLh
	 V0+YonDND1j1jMYiiRLrq5j6lDAdxbcE7Oz7j3o3reGLTFmVZyvH/ujRycTr1Ws5IF
	 qKzZj4ZYHyHivkkhcX9uIe22iwFLgOI3tK3dUWa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404295AbfJCQfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403914AbfJCQfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:35:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A7D20830;
        Thu,  3 Oct 2019 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120532;
        bh=ZSB+bi5mbr3BV55s1umwo8go/XxMX3YmhZC4SEzUBMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLclcfy0JXYO+mXXx4q/9hV0sPI6MtThZf1CC4wMEUkpwecl6DjIA0jrWC2/GImmP
         QlreX0CiTHCNf+n7dmsQ/N0Ox14swDw+uRtaPPScsogpN6+VxHfQAk4jf+Ko/ryC0z
         rKmMtxOsBQ79f8iaC/St4217NmUyiHdCgqt8rl4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.2 258/313] iommu/arm-smmu-v3: Disable detection of ATS and PRI
Date:   Thu,  3 Oct 2019 17:53:56 +0200
Message-Id: <20191003154558.449042558@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit b5e86196b83fd68e065a7c811ab8925fb0dc3893 upstream.

Detecting the ATS capability of the SMMU at probe time introduces a
spinlock into the ->unmap() fast path, even when ATS is not actually
in use. Furthermore, the ATC invalidation that exists is broken, as it
occurs before invalidation of the main SMMU TLB which leaves a window
where the ATC can be repopulated with stale entries.

Given that ATS is both a new feature and a specialist sport, disable it
for now whilst we fix it properly in subsequent patches. Since PRI
requires ATS, disable that too.

Cc: <stable@vger.kernel.org>
Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/arm-smmu-v3.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2817,11 +2817,13 @@ static int arm_smmu_device_hw_probe(stru
 	}
 
 	/* Boolean feature flags */
+#if 0	/* ATS invalidation is slow and broken */
 	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
 		smmu->features |= ARM_SMMU_FEAT_PRI;
 
 	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
 		smmu->features |= ARM_SMMU_FEAT_ATS;
+#endif
 
 	if (reg & IDR0_SEV)
 		smmu->features |= ARM_SMMU_FEAT_SEV;


