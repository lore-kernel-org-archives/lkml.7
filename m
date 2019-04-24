Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC531C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20F21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116465;
	bh=wS1qfhCXYwHztDJX6CNYfkP4qKv76frrncLK7qNAEzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdTCDbz7HnmgUq+yU0V8qJ1wvQ7vXm/BP1PwSgCPaFgilLnj4WLeQ4t0hh0hqKmt1
	 2EskVo2yi7RPFnr3dC5uvNK7Z/p6Ke8VV+r21SpwlCSzmxoGhskU4gmvCFND0MK3Ow
	 JGYPAZCGOEy6WOy0w1T7/569Cke1eEQCR/L1e0vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfDXOeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730968AbfDXOeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7512089F;
        Wed, 24 Apr 2019 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116458;
        bh=wS1qfhCXYwHztDJX6CNYfkP4qKv76frrncLK7qNAEzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pArs30we9AtT6gLebI8OTuhpv8x1CD69YwIzJPnnOkh2gVuga2Cw0gF7V+v6e6CPi
         axGWwIGzGbQaFOtSpzvQHCwrhL8Fo2v/MG1YTk2yXG48BncH2t8sg4gs5Bw+HdMjF2
         kCT6JEXvtYm7HtYSJInKWRdb5Z4/Lw50LrXUAEec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 15/66] i40e: fix i40e_ptp_adjtime when given a negative delta
Date:   Wed, 24 Apr 2019 10:32:49 -0400
Message-Id: <20190424143341.27665-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit b3ccbbce1e455b8454d3935eb9ae0a5f18939e24 ]

Commit 0ac30ce43323 ("i40e: fix up 32 bit timespec references",
2017-07-26) claims to be cleaning up references to 32-bit timespecs.

The actual contents of the commit make no sense, as it converts a call
to timespec64_add into timespec64_add_ns. This would seem ok, if (a) the
change was documented in the commit message, and (b) timespec64_add_ns
supported negative numbers.

timespec64_add_ns doesn't work with signed deltas, because the
implementation is based around iter_div_u64_rem. This change resulted in
a regression where i40e_ptp_adjtime would interpret small negative
adjustments as large positive additions, resulting in incorrect
behavior.

This commit doesn't appear to fix anything, is not well explained, and
introduces a bug, so lets just revert it.

Reverts: 0ac30ce43323 ("i40e: fix up 32 bit timespec references", 2017-07-26)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 5fb4353c742b..31575c0bb884 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -146,12 +146,13 @@ static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
-	struct timespec64 now;
+	struct timespec64 now, then;
 
+	then = ns_to_timespec64(delta);
 	mutex_lock(&pf->tmreg_lock);
 
 	i40e_ptp_read(pf, &now, NULL);
-	timespec64_add_ns(&now, delta);
+	now = timespec64_add(now, then);
 	i40e_ptp_write(pf, (const struct timespec64 *)&now);
 
 	mutex_unlock(&pf->tmreg_lock);
-- 
2.19.1

