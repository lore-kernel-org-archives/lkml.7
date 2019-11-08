Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49347C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8EB2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214382;
	bh=etxpC8JZZJWPy8F/xgvTzSrSpq2DAsTTtvter5MD1QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ku00sXSfFncD5x+37RURgqT707kvEmbxdeFy8PPSF0K93nu4/b/Y583My9ob6IYvm
	 O5S/m4a2mgQjvpPvP8boIRSLr4kRRxvvsnGJ/HSjtrxUONqnWOvQQQ+UQVbT20Vwca
	 p1/nMbyDp1RRdswin8+VGB7phEMXW6R0n5o1Rv90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391277AbfKHL7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390666AbfKHLoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3991E21D6C;
        Fri,  8 Nov 2019 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213446;
        bh=etxpC8JZZJWPy8F/xgvTzSrSpq2DAsTTtvter5MD1QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1ZtLg4TqysK753qEV6z3F2Y4ua6kYjwC3Dlr3Uti1YXct9LIv9+EhKRQXWVpeKYB
         /iemsMQhdG19y1ho4sgw5euzxID0ZsC2wqt3dMrhnRFp0egbLY12Rm4PXNAkWUGsLm
         LmkGo40FcVqCCQIDijfb5I0Y+bpU5BnmLPON+nuc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 040/103] ASoC: sgtl5000: avoid division by zero if lo_vag is zero
Date:   Fri,  8 Nov 2019 06:42:05 -0500
Message-Id: <20191108114310.14363-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 9ab708aef61f5620113269a9d1bdb1543d1207d0 ]

In the case where lo_vag <= SGTL5000_LINE_OUT_GND_BASE, lo_vag
is set to zero and later vol_quot is computed by dividing by
lo_vag causing a division by zero error.  Fix this by avoiding
a zero division and set vol_quot to zero in this specific case
so that the lowest setting for i is correctly set.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 10764c1e854e2..ca8a70ab22a82 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1314,7 +1314,7 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	 * Searching for a suitable index solving this formula:
 	 * idx = 40 * log10(vag_val / lo_cagcntrl) + 15
 	 */
-	vol_quot = (vag * 100) / lo_vag;
+	vol_quot = lo_vag ? (vag * 100) / lo_vag : 0;
 	lo_vol = 0;
 	for (i = 0; i < ARRAY_SIZE(vol_quot_table); i++) {
 		if (vol_quot >= vol_quot_table[i])
-- 
2.20.1

