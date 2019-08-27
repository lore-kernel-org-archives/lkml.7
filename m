Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CA92184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893075;
	bh=Rgc5XPUCe4JhID3HgAk8xc7xcB0L9xatm15Iygzvwq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1VQYNv9t6fr2h5yrtUPRt3CckprPBQoFrdjAqYqkOyR5Yu1bWm/XKAbx1lROn+2Eq
	 m1Fae24HGWrs2VHqj+acOiU779e41yZLENnkIw912E7u+pzfeyhORw5j1kweXpamGp
	 1xi/kwIbXY5PslSy9PyO+q8HZpMdCDHfYEXjk2hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbfH0IEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732582AbfH0IEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:04:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E67F2173E;
        Tue, 27 Aug 2019 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893069;
        bh=Rgc5XPUCe4JhID3HgAk8xc7xcB0L9xatm15Iygzvwq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/cgbezfDJyMOygshJS4ScdIanIJV2ZiylRJFMv1vu9YcgB9hNFZx81p1F19dBbdR
         flYAmmU9NnsKPc8vZtrPO9/OnMYZoCoSXcMpTwvgATITGYRdg2r7M4rskeq26Ip7kx
         sgJwT8alD/6JUeshYGSM5kIzVDpBXZh27wVhylO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 058/162] iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef
Date:   Tue, 27 Aug 2019 09:49:46 +0200
Message-Id: <20190827072740.204400175@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit abcbef5977df1fb61026ba429964cd6b9a085699 ]

The driver should call iwl_dbg_tlv_free even if debugfs is not defined
since ini mode does not depend on debugfs ifdef.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Fixes: 68f6f492c4fa ("iwlwifi: trans: support loading ini TLVs from external file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index efd4bf04d0162..fa81ad67539f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1649,8 +1649,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 err_fw:
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(drv->dbgfs_drv);
-	iwl_fw_dbg_free(drv->trans);
 #endif
+	iwl_fw_dbg_free(drv->trans);
 	kfree(drv);
 err:
 	return ERR_PTR(ret);
-- 
2.20.1



