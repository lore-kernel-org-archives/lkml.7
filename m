Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9B8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287CA20706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mGHTcdRe";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="LVzs4zeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKVXcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:32:10 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:53282
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbfKVXbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574465511;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=LVP5fItJG7eJG5QBHWGLQQXnPsRB9cfJVZahjRJMFLw=;
        b=mGHTcdRemriWYt75WzlQNHsZfCpnifp/1e/fZv+o4jNFLaK9SHh4AALKqm9TOQFB
        cUbsmWjw0RP/4aA1DhLwYwrPY0Las1I3RWWAZ55RrEgOL+z0P0BUPZ1iAxRiAtr5J2F
        6NDtw6r29ER+YEHXLERP9QhUUbQFrNfUD4U/82do=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574465511;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=LVP5fItJG7eJG5QBHWGLQQXnPsRB9cfJVZahjRJMFLw=;
        b=LVzs4zeNbP00nw+uIJU4AYfhdXZFaW1qElxacrLQlKrybLtdTvppEQfAKZdAyaAD
        qV99Eba4lC0cl3cm+0Fv1U8W9/wwabxheUoCe1HvkzWKAdhJGSsYQtMkH01xaMPJZbU
        KgJsxxRwg90bQpeeA4/fNNOOfkqLbZr2TCCZPMZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26A8EC447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date:   Fri, 22 Nov 2019 23:31:51 +0000
Message-ID: <0101016e957520c8-d07e90d2-4906-4479-9e33-2231e8c45619-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new attribute to enable and query the state of split pagetables
for the domain.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f2223cb..18c861e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -126,6 +126,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_SPLIT_TABLES,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

