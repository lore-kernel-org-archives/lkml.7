Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB88C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DA421D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642176;
	bh=n5k8+TCNH9B+qSI6yihNx4FPmGe+bGpxEcJW5s93Il8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ztji+wvL6P/tCE9bgA9P9nrI8pLafFV0mPSvh5ZGatzl0KAZOYH7lXy6xut8WiKGI
	 sO6MGsAHNqYrD33Hr2P5usb3X7vNygqOcfVvrVAVgA9ldjvwxsQYqUKFi20cKct6yI
	 9jKAO+XW4p9RyViqkgSqPSO2IJJvx3krpTjZaRx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfL2R4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbfL2R4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:56:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5007821744;
        Sun, 29 Dec 2019 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642167;
        bh=n5k8+TCNH9B+qSI6yihNx4FPmGe+bGpxEcJW5s93Il8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6XZWJQiDMP2xwkyEPNdfjRsjftKp313Bf+AXW74FH+2GOeZyopa+DM3EsxMuDrBd
         6hGnin/lK4YlWK2RB7LDGAdpD3xmSZ2Ozc/u8PCaBJgWCowMs6mXZqcoO2ynDpYLhM
         BUadDPngiZBaIN4IO/ZPWvjE93JO6w18BVL91fiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 5.4 368/434] iommu: set group default domain before creating direct mappings
Date:   Sun, 29 Dec 2019 18:27:01 +0100
Message-Id: <20191229172726.418027951@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

commit d360211524bece6db9920f32c91808235290b51c upstream.

iommu_group_create_direct_mappings uses group->default_domain, but
right after it is called, request_default_domain_for_dev calls
iommu_domain_free for the default domain, and sets the group default
domain to a different domain. Move the
iommu_group_create_direct_mappings call to after the group default
domain is set, so the direct mappings get associated with that domain.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: stable@vger.kernel.org
Fixes: 7423e01741dd ("iommu: Add API to request DMA domain for device")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2221,13 +2221,13 @@ request_default_domain_for_dev(struct de
 		goto out;
 	}
 
-	iommu_group_create_direct_mappings(group, dev);
-
 	/* Make the domain the default for this group */
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = domain;
 
+	iommu_group_create_direct_mappings(group, dev);
+
 	dev_info(dev, "Using iommu %s mapping\n",
 		 type == IOMMU_DOMAIN_DMA ? "dma" : "direct");
 


