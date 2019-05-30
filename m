Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740BC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D782524C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189750;
	bh=txu5ml5e8wsR91hAxef7653W3qboAitQk1dj//Hsdek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sIIK2bs/9hzYewIrVLWCTTgCuAM+4XIXXtXWw0l3Z7hzZI2Jn2+ds3/URNRlWcAcv
	 kx0k6Jok7q9uLXUGYFP8dy19zfv+gkoZG484klVnGfnFXmnVsEJ9aByQryGjQXjIwa
	 DjGXO+IuZpgRqnJNOui+peix+Ld1sj9zS/TeN/QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfE3EPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbfE3DP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:57 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE7724590;
        Thu, 30 May 2019 03:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186156;
        bh=txu5ml5e8wsR91hAxef7653W3qboAitQk1dj//Hsdek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yr/x8Hzo/VlZrXVt7L9ZruTYiGJjInfS8SGEUu1aanW1WRwnT0J1dsanvuBtgKH+Z
         Zn9KsLrUQ3NdOmsdoDf6O6/8dHdLZaMxO32fZVbxw3s5GAiOJWbgILW0bLsNmCrv+/
         Lv/HGK2qEomdPAWHSBYYUX4py62uDLIVLHf5Vzxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 344/346] ice: Put __ICE_PREPARED_FOR_RESET check in ice_prepare_for_reset
Date:   Wed, 29 May 2019 20:06:57 -0700
Message-Id: <20190530030558.150540246@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5abac9d7e1bb9a373673811154774d4c89a7f85e ]

Currently we check if the __ICE_PREPARED_FOR_RESET bit is set prior to
calling ice_prepare_for_reset in ice_reset_subtask(), but we aren't
checking that bit in ice_do_reset() before calling
ice_prepare_for_reset(). This is not consistent and can cause issues if
ice_prepare_for_reset() is called prior to ice_do_reset(). Fix this by
checking if the __ICE_PREPARED_FOR_RESET bit is set internal to
ice_prepare_for_reset().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 43064b4176d38..f8801267502af 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -342,6 +342,10 @@ ice_prepare_for_reset(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
 
+	/* already prepared for reset */
+	if (test_bit(__ICE_PREPARED_FOR_RESET, pf->state))
+		return;
+
 	/* Notify VFs of impending reset */
 	if (ice_check_sq_alive(hw, &hw->mailboxq))
 		ice_vc_notify_reset(pf);
@@ -424,8 +428,7 @@ static void ice_reset_subtask(struct ice_pf *pf)
 		/* return if no valid reset type requested */
 		if (reset_type == ICE_RESET_INVAL)
 			return;
-		if (!test_bit(__ICE_PREPARED_FOR_RESET, pf->state))
-			ice_prepare_for_reset(pf);
+		ice_prepare_for_reset(pf);
 
 		/* make sure we are ready to rebuild */
 		if (ice_check_reset(&pf->hw)) {
-- 
2.20.1



