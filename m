Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572EDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B26C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892939;
	bh=9UdBi8Lm4fpynGT55m3i75gNhsuv8d7zzSNBc9a+6Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w840j10s9HuTTQOYOgkn8iQ8WS47wi+5Y6szzUAQjyXbA5YIp9spfwrHjdcJ+WbzV
	 7SGzBM/SSNvLh2nup9M4/Ovs+a3zc2xsHyfYGP1Auzt5CqhelX8WgB0EZdeL/Ww19T
	 ONzPVm/1DShO1pdiTGKCQlVKGInijNoAioTaP1Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfH0ICS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbfH0IB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:01:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457A1206BA;
        Tue, 27 Aug 2019 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892917;
        bh=9UdBi8Lm4fpynGT55m3i75gNhsuv8d7zzSNBc9a+6Rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCvzcwqMh40tEnOmOaSyu1AKTcuO6lPwn2w1AUEPRlBRJ4v07PK2zXjg/uggpHqAi
         a2s/9xP0XByc8Zs+PvhC+nRAELQvC8jadvq0dy+XK3jbdpJm9DHOiDgVtElWlK5V+w
         8NYC0JMm/YhZaG8YKDbAeDP4UQVhomoBFJe63oRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 057/162] iwlwifi: dbg_ini: move iwl_dbg_tlv_load_bin out of debug override ifdef
Date:   Tue, 27 Aug 2019 09:49:45 +0200
Message-Id: <20190827072740.174362408@linuxfoundation.org>
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

[ Upstream commit 072b30642f90b01d139131ec7bf763778a3a3f41 ]

ini debug mode should work even if debug override is not defined.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Fixes: 68f6f492c4fa ("iwlwifi: trans: support loading ini TLVs from external file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index fba242284507b..efd4bf04d0162 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1627,6 +1627,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 	init_completion(&drv->request_firmware_complete);
 	INIT_LIST_HEAD(&drv->list);
 
+	iwl_load_fw_dbg_tlv(drv->trans->dev, drv->trans);
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* Create the device debugfs entries. */
 	drv->dbgfs_drv = debugfs_create_dir(dev_name(trans->dev),
-- 
2.20.1



