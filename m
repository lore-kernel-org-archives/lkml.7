Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F1C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E44F20842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748790;
	bh=lqGwCjPgydFZ6txMoyYeKha62yorusUGtlBCYkLLjKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ni1AgSdLrRYhgmYSuBRHz1O+dgijqP4wMlLM8gZR+z5RwTd/Rv/n4hepMNP2NdkI0
	 m50zMHQy5JodbGH/c9Ht3S89r4e6EVD7rYPcVcXgDu9RjO+xQeEyCBGlt7X3EHlxSC
	 kQDErwb97N08NXaFgnJ2gkaBOw5x9xfpQ3b0W2tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfHNCNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbfHNCNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:13:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F02214C6;
        Wed, 14 Aug 2019 02:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748784;
        bh=lqGwCjPgydFZ6txMoyYeKha62yorusUGtlBCYkLLjKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuwB7Sj0OKJ0GrQj8R0/5NfYOObgWbo/YebAqBmFpKKC/OuBMmry87dsPNPbd/0B6
         iXjmJveDp5kKANY9pGvgB51zeJUGMXO1Xin3RaIaMn9EMJaZZNSnLzVLWqfzHYw7Yj
         PDz0EZnldfFt1D07RyjvZI6ivVDl8SAK6bSbp1kU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 063/123] iwlwifi: dbg_ini: move iwl_dbg_tlv_load_bin out of debug override ifdef
Date:   Tue, 13 Aug 2019 22:09:47 -0400
Message-Id: <20190814021047.14828-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

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

