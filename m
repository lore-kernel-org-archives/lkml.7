Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96F0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F82B217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427626;
	bh=Gwh41nZmDfw4nYEXVfodpYe0aoUT6LamN9NyEXlbUe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NhrGVoavNafI85s467FBc8rp0tWRB60aqC+8yMGJoZKs5T5yZVdwWXE0yH0odqVIT
	 R3qNhXcQnzjl4JMnhYXp5bvjM9gEZeeWf1IE3zI+6yMEsZogZtjnUSJe5Afh+0Rplr
	 Iq8BR47lI8i/8qfT8B7Vx9D5j2MlZSor4lZ0t8sU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfEISrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbfEISrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:47:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F32A217F5;
        Thu,  9 May 2019 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427621;
        bh=Gwh41nZmDfw4nYEXVfodpYe0aoUT6LamN9NyEXlbUe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKQNj3WxtdQKCFu3Jd+BlcmHsASUc+fZDEWOKBKGlhCmJsTmQ1jw7wv72pQ+gSxRF
         eHDXeEOhhRjcIGSUgacK4hXiiQHyBoM9DXxLgkypjcHlY9WIXXg/WUKJx//y97WuIo
         kIIpAZQW518/HkfX11Dh6ldk74qRDpeWCz9YWxg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/42] iommu/amd: Set exclusion range correctly
Date:   Thu,  9 May 2019 20:42:18 +0200
Message-Id: <20190509181258.545800665@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3c677d206210f53a4be972211066c0f1cd47fe12 ]

The exlcusion range limit register needs to contain the
base-address of the last page that is part of the range, as
bits 0-11 of this register are treated as 0xfff by the
hardware for comparisons.

So correctly set the exclusion range in the hardware to the
last page which is _in_ the range.

Fixes: b2026aa2dce44 ('x86, AMD IOMMU: add functions for programming IOMMU MMIO space')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 91d7718625a67..3884e82d24e91 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -355,7 +355,7 @@ static void iommu_write_l2(struct amd_iommu *iommu, u8 address, u32 val)
 static void iommu_set_exclusion_range(struct amd_iommu *iommu)
 {
 	u64 start = iommu->exclusion_start & PAGE_MASK;
-	u64 limit = (start + iommu->exclusion_length) & PAGE_MASK;
+	u64 limit = (start + iommu->exclusion_length - 1) & PAGE_MASK;
 	u64 entry;
 
 	if (!iommu->exclusion_start)
-- 
2.20.1



