Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93079C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6925F24049
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188359;
	bh=s6FEYyvu1TbYUCnhqVfPKx0CXV4TC8zXgKIEs96uMy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QCswOArmNbvz6fJXd/UDp/I3qfr3WHLW7TgK0htFIJP7MZP+Mm27UMAJRLYe3qSoq
	 FJ90Hiizc/xct4c9/wjXf06yk7TbdF1cYSZ84Uv5/hMA41ZWUr8dHE2gGiN0ucyJxt
	 L5ZkaVw5YcuFTBNNOLjBMgY4rWzla+NZCZoKXm5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfE3Dwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731942AbfE3DTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:19:35 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61DA248AB;
        Thu, 30 May 2019 03:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186374;
        bh=s6FEYyvu1TbYUCnhqVfPKx0CXV4TC8zXgKIEs96uMy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HP00cNMbwwhN7sOibAqJUybGwSDy1BiTL7Y1k0EMwc9porAV1lVmppBdLo1+UVP1s
         absKv86rFbo8u4PRuxvpOK7t2wdxCemVXhYEEkQbXqJ47ZSZwS7dHn2GM9y3/Dv/t3
         LQZ4UxBEAreOfiRcaRcgCoIq3U0b8GCz+lAMKvOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Scott Bauer <sbauer@plzdonthack.me>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 134/193] block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
Date:   Wed, 29 May 2019 20:06:28 -0700
Message-Id: <20190530030507.068785313@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 78bf47353b0041865564deeed257a54f047c2fdc ]

The implementation of IOC_OPAL_ENABLE_DISABLE_MBR handled the value
opal_mbr_data.enable_disable incorrectly: enable_disable is expected
to be one of OPAL_MBR_ENABLE(0) or OPAL_MBR_DISABLE(1). enable_disable
was passed directly to set_mbr_done and set_mbr_enable_disable where
is was interpreted as either OPAL_TRUE(1) or OPAL_FALSE(0). The end
result was that calling IOC_OPAL_ENABLE_DISABLE_MBR with OPAL_MBR_ENABLE
actually disabled the shadow MBR and vice versa.

This patch adds correct conversion from OPAL_MBR_DISABLE/ENABLE to
OPAL_FALSE/TRUE. The change affects existing programs using
IOC_OPAL_ENABLE_DISABLE_MBR but this is typically used only once when
setting up an Opal drive.

Acked-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/sed-opal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 4f5e70d4abc3c..c64011cda9fcc 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2078,13 +2078,16 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 					  struct opal_mbr_data *opal_mbr)
 {
+	u8 enable_disable = opal_mbr->enable_disable == OPAL_MBR_ENABLE ?
+		OPAL_TRUE : OPAL_FALSE;
+
 	const struct opal_step mbr_steps[] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_done, &opal_mbr->enable_disable },
+		{ set_mbr_done, &enable_disable },
 		{ end_opal_session, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
+		{ set_mbr_enable_disable, &enable_disable },
 		{ end_opal_session, },
 		{ NULL, }
 	};
@@ -2204,7 +2207,7 @@ static int __opal_lock_unlock(struct opal_dev *dev,
 
 static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 {
-	u8 mbr_done_tf = 1;
+	u8 mbr_done_tf = OPAL_TRUE;
 	const struct opal_step mbrdone_step [] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
-- 
2.20.1



