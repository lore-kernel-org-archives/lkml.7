Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9085C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE87F241B6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l6gTfJoS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kCF0pV8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfE2UzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:55:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfE2UzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:55:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C84B3609F3; Wed, 29 May 2019 20:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163320;
        bh=MNplseeIKAQ0I6ymvujag5Wo9kZnnfQJJGa0KJiYvTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6gTfJoSMrYl5TH3aNNHXFJTlII3aQimbOW5TFPGP4QOClPMcQYc3Vbdi1EmFuqbS
         Y/+UKJZhcr2YhF2n6tuhLiHyHvmqLMY/3I3KKnzN745qQWMmWt0ITWlJhLqL/kb6xz
         gEt0MYAd1ls7+XhPUzkXz4T7S2aNnaJdkpwTzTUI=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 316DD6133A;
        Wed, 29 May 2019 20:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163319;
        bh=MNplseeIKAQ0I6ymvujag5Wo9kZnnfQJJGa0KJiYvTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCF0pV8kDxPMcxpp+IyTex1gwg/kAHKVn4XAqB5esDSO93Xl+GZ/Y3itkDgvITbFW
         hsVAyZL2PjbfPvLGFb3/IQSk3xE/qZFsnXnioDQY2E/uCuCLzVdec4wzyCD0+mibcO
         paF/NvWuL6yXiI+I7DoQ//XSYK7/HmghFCVDIuNs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 316DD6133A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        hoegsberg@google.com, dianders@chromium.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/16] iommu: Add DOMAIN_ATTR_PTBASE
Date:   Wed, 29 May 2019 14:54:41 -0600
Message-Id: <1559163292-4792-6-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
References: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an attribute to return the base address of the pagetable. This is used
by auxiliary domains from arm-smmu to return the address of the pagetable
to the leaf driver so that it can set the appropriate pagetable through
it's own means.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a2f07cf..49639b7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -129,6 +129,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_SPLIT_TABLES,
+	DOMAIN_ATTR_PTBASE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

