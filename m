Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532E1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBAF207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214104;
	bh=7fjEwiSTXkaGr+C2UuO1PVeK6otW8t2730r5OGPfeSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ek1apkCnzzoFvKcmGGj2V/pf6OIE+PEau8UFSl7GBP7pNpE/1EzJKxgT2B7JQHsRX
	 VS3CHItJfTPLxC8zPPTfJyeBSH1LukrKUkv/VFOsfd0TCH2Es9ibFyYYP1YBgT55Ot
	 k/8s/tH/pD7nnBiB5P6w65cfRjFk+1tpGLTEoUhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391171AbfKHLzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391258AbfKHLqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8FC2245B;
        Fri,  8 Nov 2019 11:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213566;
        bh=7fjEwiSTXkaGr+C2UuO1PVeK6otW8t2730r5OGPfeSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRWiMpbMG2ajNh3pRDDsW5wm5/xHfMKNulRx+BnX3Fxo2J7OG3mjQ/eRgM7ESM6vg
         haHpv4FAXcI3Qe/CHnJzFIaz/0N65ZHf0DW1z95Vq19w7VaCMfkSv8RDzVaHfjuZDe
         GsmSzborbqPhUZnQC6m453zoCLoMD2KGwB5i7j3Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mitch Williams <mitch.a.williams@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 14/64] i40e: use correct length for strncpy
Date:   Fri,  8 Nov 2019 06:44:55 -0500
Message-Id: <20191108114545.15351-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitch Williams <mitch.a.williams@intel.com>

[ Upstream commit 7eb74ff891b4e94b8bac48f648a21e4b94ddee64 ]

Caught by GCC 8. When we provide a length for strncpy, we should not
include the terminating null. So we must tell it one less than the size
of the destination buffer.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index f1feceab758a5..41cbcb0ac2d94 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -604,7 +604,8 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
 	if (!IS_ERR_OR_NULL(pf->ptp_clock))
 		return 0;
 
-	strncpy(pf->ptp_caps.name, i40e_driver_name, sizeof(pf->ptp_caps.name));
+	strncpy(pf->ptp_caps.name, i40e_driver_name,
+		sizeof(pf->ptp_caps.name) - 1);
 	pf->ptp_caps.owner = THIS_MODULE;
 	pf->ptp_caps.max_adj = 999999999;
 	pf->ptp_caps.n_ext_ts = 0;
-- 
2.20.1

