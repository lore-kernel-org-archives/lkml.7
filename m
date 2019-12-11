Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1496C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E73E24658
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077437;
	bh=PdlmG9XUjKuM3VuyWiRp3A54fgYsl5TasmkGMb0egoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3tOpb5dIvUbfYNpyVh6/pQGtSbVUJbh+lQn7X6T7lAvT2iDeBsI86/1fLWdmyZjl
	 rDPzKz+ggaEChKd8kXmlFzJFd+jP7rI/JOWCaDAmhMSCmHjt0mai+6fpgd2pPpqVCu
	 6R0KEOga293oikgRlfrjuN7B9lJkqijamMBGRYjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfLKPRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbfLKPRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:17:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AAA624658;
        Wed, 11 Dec 2019 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077433;
        bh=PdlmG9XUjKuM3VuyWiRp3A54fgYsl5TasmkGMb0egoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBN1/UKGUbed3+ayY/NftfE5sUQDBYI4oSuuBJ82/ARR+y6h1uOkbXOwPtFnEUkAw
         4YTsbLZkXHov8RPqc9+tPAu77xlv6LqUuchkSfgcs3+9UD1V2WDRAMINGIPQ8QfQGX
         GqaC8fnfD6t+BePwjQYot9GNt4Gtd9IThJCFTFfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lev Faerman <lev.faerman@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/243] ice: Fix NVM mask defines
Date:   Wed, 11 Dec 2019 16:03:20 +0100
Message-Id: <20191211150341.772612846@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lev Faerman <lev.faerman@intel.com>

[ Upstream commit 6263e811f4d4418660c20b36a08063c6d2c3fb9d ]

Fixes bad masks that would break compilation when evaluated.

Signed-off-by: Lev Faerman <lev.faerman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index a0614f472658a..328d293bc3ff5 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1056,10 +1056,10 @@ struct ice_aqc_nvm {
 #define ICE_AQC_NVM_LAST_CMD		BIT(0)
 #define ICE_AQC_NVM_PCIR_REQ		BIT(0)	/* Used by NVM Update reply */
 #define ICE_AQC_NVM_PRESERVATION_S	1
-#define ICE_AQC_NVM_PRESERVATION_M	(3 << CSR_AQ_NVM_PRESERVATION_S)
-#define ICE_AQC_NVM_NO_PRESERVATION	(0 << CSR_AQ_NVM_PRESERVATION_S)
+#define ICE_AQC_NVM_PRESERVATION_M	(3 << ICE_AQC_NVM_PRESERVATION_S)
+#define ICE_AQC_NVM_NO_PRESERVATION	(0 << ICE_AQC_NVM_PRESERVATION_S)
 #define ICE_AQC_NVM_PRESERVE_ALL	BIT(1)
-#define ICE_AQC_NVM_PRESERVE_SELECTED	(3 << CSR_AQ_NVM_PRESERVATION_S)
+#define ICE_AQC_NVM_PRESERVE_SELECTED	(3 << ICE_AQC_NVM_PRESERVATION_S)
 #define ICE_AQC_NVM_FLASH_ONLY		BIT(7)
 	__le16 module_typeid;
 	__le16 length;
-- 
2.20.1



