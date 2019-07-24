Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0881C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E3A20659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996770;
	bh=FoCoZFSiAQ9WJnxZh/qFienzAuBw+JLuL7uejSyjtpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLR+/jrBA77lJ/fcAMouEpLjqYo7beHkKRK7B9qwHLQLNZReQybCrIdzqIl0TNOsX
	 g8tkSLCGOgSi5fNQomgF4FC3knUU5HOCEKZwgX4Wjc0TCtcwh7fevICuHgWbMSmUJb
	 C2fhuoKrLTRUhn5AKRd4hTllBs2Mt2VEjIQdlJyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbfGXTct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388683AbfGXTcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:32:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D29C2238C;
        Wed, 24 Jul 2019 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996761;
        bh=FoCoZFSiAQ9WJnxZh/qFienzAuBw+JLuL7uejSyjtpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+cf06NbQOwVWIRKsrxbcs74VAmlzeHibhhHC5N3G/UslsP1W5gwmxMrYsXrSSqQP
         jOUTXY2DKUCauozPfk2ljmenIf/fc2o5Ftacaxwm/hNXbqH93XXoqXFhA7u5duVy0A
         SoW+4kLh/IjzNSSr802nZsBGzAgFIMe75zGJpWtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 205/413] iwlwifi: dbg: fix debug monitor stop and restart delays
Date:   Wed, 24 Jul 2019 21:18:16 +0200
Message-Id: <20190724191749.177722386@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fc838c775f35e272e5cc7ef43853f0b55babbe37 ]

The driver should delay only in recording stop flow between writing to
DBGC_IN_SAMPLE register and DBGC_OUT_CTRL register. Any other delay is
not needed.

Change the following:
1. Remove any unnecessary delays in the flow
2. Increase the delay in the stop recording flow since 100 micro is
   not enough
3. Use usleep_range instead of delay since the driver is allowed to
   sleep in this flow.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Fixes: 5cfe79c8d92a ("iwlwifi: fw: stop and start debugging using host command")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 --
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 33d7bc5500db..c875e173771c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2303,8 +2303,6 @@ void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt)
 	/* start recording again if the firmware is not crashed */
 	if (!test_bit(STATUS_FW_ERROR, &fwrt->trans->status) &&
 	    fwrt->fw->dbg.dest_tlv) {
-		/* wait before we collect the data till the DBGC stop */
-		udelay(500);
 		iwl_fw_dbg_restart_recording(fwrt, &params);
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index fd0ad220e961..c5c015a66106 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -294,7 +294,10 @@ _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 	}
 
 	iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, 0);
-	udelay(100);
+	/* wait for the DBGC to finish writing the internal buffer to DRAM to
+	 * avoid halting the HW while writing
+	 */
+	usleep_range(700, 1000);
 	iwl_write_umac_prph(trans, DBGC_OUT_CTRL, 0);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	trans->dbg_rec_on = false;
@@ -324,7 +327,6 @@ _iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
 	} else {
 		iwl_write_umac_prph(trans, DBGC_IN_SAMPLE, params->in_sample);
-		udelay(100);
 		iwl_write_umac_prph(trans, DBGC_OUT_CTRL, params->out_ctrl);
 	}
 }
-- 
2.20.1



