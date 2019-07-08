Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1DFC606C8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2CB218A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TIPXG+vU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TIPXG+vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbfGHSK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:10:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbfGHSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:10:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C0CE60FEE; Mon,  8 Jul 2019 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562609425;
        bh=I0b5kpNA6visZ/gWW+mc9BO8uDwDyEu2oJKHrjDh8wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIPXG+vU4zIVWPgUws+qo8sFJCJmxQCzmjtMdPdf62G9rnfZca+VhPgMXeolUVAke
         TICjx5uUZm+lLkQdUrrKlEw6fLUDyEJd2CyQCk4U8wGavaef+Rjh/M5ebK5uLLuo+p
         kh50cQI0znRp1PkZmfXZOwj5zJw9fzbugsz5Ad+s=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4679B60E41;
        Mon,  8 Jul 2019 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562609425;
        bh=I0b5kpNA6visZ/gWW+mc9BO8uDwDyEu2oJKHrjDh8wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIPXG+vU4zIVWPgUws+qo8sFJCJmxQCzmjtMdPdf62G9rnfZca+VhPgMXeolUVAke
         TICjx5uUZm+lLkQdUrrKlEw6fLUDyEJd2CyQCk4U8wGavaef+Rjh/M5ebK5uLLuo+p
         kh50cQI0znRp1PkZmfXZOwj5zJw9fzbugsz5Ad+s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4679B60E41
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date:   Mon,  8 Jul 2019 12:10:16 -0600
Message-Id: <1562609418-25446-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562609418-25446-1-git-send-email-jcrouse@codeaurora.org>
References: <1562609418-25446-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new domain attribute to enable split pagetable support for devices
devices that support it.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fdc355c..b06db6c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -125,6 +125,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_SPLIT_TABLES,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

