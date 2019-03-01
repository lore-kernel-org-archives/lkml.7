Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC85EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D582070B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lf5NmI7H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="arb8UniZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfCATis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:38:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCATiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:38:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF2A861112; Fri,  1 Mar 2019 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469125;
        bh=vF0xCZZOughlC2imgburURfDjSE6IQaOBWN7xYbGbGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lf5NmI7Hx1O23amwdX/3Ct/hgMOKZdQ2xoORAEFlYVfdQfvXCSv9HXqmQNj2RMqYM
         oky65qYGU822itJYsGHelDn1CgkUOHLsFlsKrkN0LAw+iDLaxzeVJRq4QjSi+xAN8M
         L7t3BD1sEmNH3wkus2KXxurKgVuLLWMVaF37w0VY=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E49FF60CED;
        Fri,  1 Mar 2019 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469124;
        bh=vF0xCZZOughlC2imgburURfDjSE6IQaOBWN7xYbGbGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arb8UniZTQ1TcBo+5N/jk6r+TR5xhWDnDcMjNaA5AMOV6R+uPMZ39v5t2+p2mDCxp
         9yXDJai7tNGxAbNPkIhG0pJQIV+vPMqkTPQyXIjwJPyQeZxuE2ZC78PC+jOb1KeRNU
         JpvpLOseWUeTf/2lfjEVyWSERH39IA6CGysQXtds=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E49FF60CED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 01/15] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date:   Fri,  1 Mar 2019 12:38:23 -0700
Message-Id: <1551469117-3404-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
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
index e90da6b..3f2250b 100644
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

