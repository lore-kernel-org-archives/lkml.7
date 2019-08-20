Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9200CC3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB532332B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BgVEfFgG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BgVEfFgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfHTTHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:07:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730670AbfHTTGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:06:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9825B61157; Tue, 20 Aug 2019 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328003;
        bh=+6w/KwG2LYGoBrIRsU609ZfylF5tzSCWZ9Tuvd8PIfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgVEfFgGDG1IbPnat3dicEvXT3N8r9lx6wQF57rhdBUnbG5G5hq1ZKmorgALQrxsy
         nUYRvmxx13e0XjG8BBLAPNfH1T5imBQXTzs+mrbjA8rDQwBgjLFeYTKNWBd7m2w4ic
         Jr0rr01UC1noThxVjIk7Is0m/T/nBSY8plnEHsYs=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D68FD60FE9;
        Tue, 20 Aug 2019 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328003;
        bh=+6w/KwG2LYGoBrIRsU609ZfylF5tzSCWZ9Tuvd8PIfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgVEfFgGDG1IbPnat3dicEvXT3N8r9lx6wQF57rhdBUnbG5G5hq1ZKmorgALQrxsy
         nUYRvmxx13e0XjG8BBLAPNfH1T5imBQXTzs+mrbjA8rDQwBgjLFeYTKNWBd7m2w4ic
         Jr0rr01UC1noThxVjIk7Is0m/T/nBSY8plnEHsYs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D68FD60FE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date:   Tue, 20 Aug 2019 13:06:29 -0600
Message-Id: <1566327992-362-5-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
References: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new attribute to query the state of split pagetables for the domain.

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

