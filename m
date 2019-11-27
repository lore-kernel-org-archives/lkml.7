Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D7AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED672086A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888659;
	bh=wX4O2JHToNm4AF5thow3+D7uWZoA5jbNZGRyT/NCEgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MnDvcIv6voLTqUxk26JAA2gLMgLcq5esAgdEAcw4JZjztTpYi8oTzE4gFPmGxiw1R
	 gb3KV8C2QaDuk7u0YEZ+40y2kkGJHNO7kIm8UHmSdxKdShLEEtgYgDsyaIy1QIdsDX
	 dkS17P5A4FtdcFZONECgxt8f3eiuKid4oVyXMfJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfK0VES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbfK0VEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:04:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3FF62086A;
        Wed, 27 Nov 2019 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888652;
        bh=wX4O2JHToNm4AF5thow3+D7uWZoA5jbNZGRyT/NCEgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewHwGGK44y8Gs9z+JSlMCepYEPHKEtR9TP7Ap1/D6kgvJt39lzpC53mqEgoUpRrvO
         LGbYbnpjSn3ktmlFBLcRFqjoZrwhb+d7aW46OZfOC5QufriBbsrg2HiAsF1HyajeIj
         iCMrvzq8s9+oM6YsF3XrQ8VhtlRGf6z8PLQqpJn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Lucas Van <lucas.van@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 190/306] ntb: intel: fix return value for ndev_vec_mask()
Date:   Wed, 27 Nov 2019 21:30:40 +0100
Message-Id: <20191127203129.122203699@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 7756e2b5d68c36e170a111dceea22f7365f83256 ]

ndev_vec_mask() should be returning u64 mask value instead of int.
Otherwise the mask value returned can be incorrect for larger
vectors.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Lucas Van <lucas.van@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 6aa5732272791..2ad263f708da7 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -265,7 +265,7 @@ static inline int ndev_db_clear_mask(struct intel_ntb_dev *ndev, u64 db_bits,
 	return 0;
 }
 
-static inline int ndev_vec_mask(struct intel_ntb_dev *ndev, int db_vector)
+static inline u64 ndev_vec_mask(struct intel_ntb_dev *ndev, int db_vector)
 {
 	u64 shift, mask;
 
-- 
2.20.1



