Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E6BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7842064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495032;
	bh=Q94eA7juBZ1wPh7HFqVy/uB0bkDoo3w9xL16ej9JAEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YAu8Hjbmc3ynMkCsm11gOz9FKJBYJi+7bjBW4n4x/FWnfn7cEfbfH1KMHULk1o2RY
	 e3jvWdbMQPSqDx8Jjs6DAU94ZUCw69fmjk60nLlo+BJVEgrgfSj8d+9b1T+P0puyyj
	 Mlrwb3RI4rHBs+yTbfd6cZM/ZTGSbDFzsmA6VXJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbfHVRab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404626AbfHVR0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:09 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2EF32064A;
        Thu, 22 Aug 2019 17:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494768;
        bh=Q94eA7juBZ1wPh7HFqVy/uB0bkDoo3w9xL16ej9JAEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMcmtFtTTwc5M1PVig+ZmrMn08f0quu6Bpls345uqw/br1cq5TNVBTL40Kb2AB1I0
         WhJmMKj7hytQ9Z9fZbRmkfRwv6pApnAf+YW/mU+yJZPPLzjnf54Ka+DPxW6gJjF8Pz
         7ed1sayjyNjV3uiibx2QGjzylSypzxwzOPNJtdB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.19 72/85] iommu/amd: Move iommu_init_pci() to .init section
Date:   Thu, 22 Aug 2019 10:19:45 -0700
Message-Id: <20190822171734.281810393@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit 24d2c521749d8547765b555b7a85cca179bb2275 upstream.

The function is only called from another __init function, so
it should be moved to .init too.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/amd_iommu_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1710,7 +1710,7 @@ static const struct attribute_group *amd
 	NULL,
 };
 
-static int iommu_init_pci(struct amd_iommu *iommu)
+static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
 	int cap_ptr = iommu->cap_ptr;
 	u32 range, misc, low, high;


