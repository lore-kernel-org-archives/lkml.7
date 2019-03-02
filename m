Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90C420851
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfCBCyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:54:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:61571 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbfCBCwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:52:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 18:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,430,1544515200"; 
   d="scan'208";a="148572595"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2019 18:52:28 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, kvm@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 03/17] wlcore: Align reg_ch_conf_pending and tmp_ch_bitmap to unsigned long for better performance
Date:   Fri,  1 Mar 2019 18:44:57 -0800
Message-Id: <1551494711-213533-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bit in reg_ch_conf_pending in wl271 and tmp_ch_bitmap is set atomically
by set_bit(). set_bit() sets the bit in a single unsigned long location. If
the variables are not aligned to unsigned long, set_bit() accesses two
cache lines and thus causes slower performance. On x86, this scenario is
called split lock and can cause overall performance degradation due to
locked BTSL instruction in set_bit() locks bus.

To avoid performance degradation, the two variables are aligned to
unsigned long.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/net/wireless/ti/wlcore/cmd.c    | 3 ++-
 drivers/net/wireless/ti/wlcore/wlcore.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index 903968735a74..8d15a6307d44 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -1707,7 +1707,8 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
 {
 	struct wl12xx_cmd_regdomain_dfs_config *cmd = NULL;
 	int ret = 0, i, b, ch_bit_idx;
-	u32 tmp_ch_bitmap[2];
+	/* Align to unsigned long for better performance in set_bit() */
+	u32 tmp_ch_bitmap[2] __aligned(sizeof(unsigned long));
 	struct wiphy *wiphy = wl->hw->wiphy;
 	struct ieee80211_supported_band *band;
 	bool timeout = false;
diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
index dd14850b0603..92d878f01fa5 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore.h
@@ -321,8 +321,10 @@ struct wl1271 {
 
 	/* Reg domain last configuration */
 	u32 reg_ch_conf_last[2]  __aligned(8);
-	/* Reg domain pending configuration */
-	u32 reg_ch_conf_pending[2];
+	/* Reg domain pending configuration. Aligned to unsigned long for
+	 * better performane in set_bit().
+	 */
+	u32 reg_ch_conf_pending[2] __aligned(sizeof(unsigned long));
 
 	/* Pointer that holds DMA-friendly block for the mailbox */
 	void *mbox;
-- 
2.7.4

