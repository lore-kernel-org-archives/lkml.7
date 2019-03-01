Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3346C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1F2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YVb1ilNN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PwVXLiHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfCATiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:38:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCATiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:38:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2F3B6119C; Fri,  1 Mar 2019 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469129;
        bh=p6rJfviH6BYGLAyw2gcf6WAOPbWlPGO+o6vz6rvdx9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVb1ilNNDEnsYDhOCZu0+ZKJhvKJoJn9e6mRAhSDN3yiGdW5+9ugFJGrU7J1XXVjG
         gpRIhD+ritm+ZE1uUs/7rlfFnELIVNBJWWVpLXv2JW5l06P0AHW93UU5PLNUCvQ99j
         KNJ7e7gxEWxwKFaVgCAXs5BXPq0dWHOXxCexNKIQ=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79DE2611BE;
        Fri,  1 Mar 2019 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469128;
        bh=p6rJfviH6BYGLAyw2gcf6WAOPbWlPGO+o6vz6rvdx9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwVXLiHOsTUjdJ5fHQvscvaq2lAkkMPL0NTtYOkawSCtjqeLbYUf+6yk8VZ8yWVwr
         Zz0w5oFYwzq0FAQyxgKc7DggpxoevliT09i6yMddxsy+3yk9JFLbWOZu8Jwsrtos7P
         qkyjXdDKaDbhxj2hqo9O8rio82pBZ2rdJnuwF8g8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79DE2611BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Date:   Fri,  1 Mar 2019 12:38:26 -0700
Message-Id: <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
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
index 3f2250b..dc60a71 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -126,6 +126,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_SPLIT_TABLES,
+	DOMAIN_ATTR_PTBASE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

