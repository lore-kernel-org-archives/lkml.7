Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68554C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C60233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495027;
	bh=IN/nZGvTv+IWmyWlPX1jCsCv4O9I7p78v8IAgR1yvRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mj7Ki0Gak4O8yO39B+7gkY6T4m5bzJLcEAqLA9opTV2PYaa/51QC66+vjisyxkLXh
	 RZD2z3J05xzy11XE8f+gnOU3CU/3RzIaSyHQORrgMOgwzh+8vsW+Eb9pTyPW+qdN4K
	 eF7xfnMeFVGUpMjTHk/mQKnZIL3I0MwlRAP2aGf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404641AbfHVR0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391836AbfHVRZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:06 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1495023400;
        Thu, 22 Aug 2019 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494706;
        bh=IN/nZGvTv+IWmyWlPX1jCsCv4O9I7p78v8IAgR1yvRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=un8CDeYSpVlhR1r+pWfvI0sy3nBL5iro739CIP/fHbuSlq6Li+4Kh5jzZCakdhgyy
         KHXuJjQPLA2wsWRWIp1DbVx3XjPWp16z/vueHGlKK8g/ni5VYb+irFbOcR/uCypyP7
         /UyMqGq0faWt2iLzg5DghH/oKyKK2MY0v9amkm/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.14 60/71] iommu/amd: Move iommu_init_pci() to .init section
Date:   Thu, 22 Aug 2019 10:19:35 -0700
Message-Id: <20190822171730.372662146@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
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
@@ -1692,7 +1692,7 @@ static const struct attribute_group *amd
 	NULL,
 };
 
-static int iommu_init_pci(struct amd_iommu *iommu)
+static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
 	int cap_ptr = iommu->cap_ptr;
 	u32 range, misc, low, high;


