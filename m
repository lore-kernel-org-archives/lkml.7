Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3DCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1366B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451038;
	bh=oqcikNQaIlCTx7/PpLSFwH3TmCmGrsgNZ2IoEF/qXOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xf3cK++xwW3NhhqL6sVLUHddMcfM35LkoejkvULg/V/tMZCRkI6UiNqc814irbO2x
	 6nycuQ0a/yMFbYzSO3ZtlqvuRRbmAOObzO6iThKin8WdR+Y01+Iw7eUprPmM2g30n3
	 31wkeyoB6tiJqdfdbT5Q2kTxHpePWdHA46Q2pJg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfJ3P5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbfJ3P5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:57:10 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6757E2067D;
        Wed, 30 Oct 2019 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572451029;
        bh=oqcikNQaIlCTx7/PpLSFwH3TmCmGrsgNZ2IoEF/qXOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0op7C2LP26veenimR5aKmrm2dpt+YVWt563+aRq+8hcdCYtNQz+zJLfH4pMwlI1G
         DtLHxytnBZaBw9340ZiE6NHlhRIOzzEblfgI82doVQ/Icm3OjzqABqV1Qs04y4nXMp
         j0WN7gKIIEeBA2PwEd1fPzy6bCaGEbxGUnBDSdHI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stuart Henderson <stuarth@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.9 03/18] ASoC: wm_adsp: Don't generate kcontrols without READ flags
Date:   Wed, 30 Oct 2019 11:56:45 -0400
Message-Id: <20191030155700.10748-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155700.10748-1-sashal@kernel.org>
References: <20191030155700.10748-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 3ae7359c0e39f42a96284d6798fc669acff38140 ]

User space always expects to be able to read ALSA controls, so ensure
no kcontrols are generated without an appropriate READ flag. In the case
of a read of such a control zeros will be returned.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20191002084240.21589-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c03c9da076c2d..28eb55bc46634 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -948,8 +948,7 @@ static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
 	}
 
 	if (in) {
-		if (in & WMFW_CTL_FLAG_READABLE)
-			out |= rd;
+		out |= rd;
 		if (in & WMFW_CTL_FLAG_WRITEABLE)
 			out |= wr;
 		if (in & WMFW_CTL_FLAG_VOLATILE)
-- 
2.20.1

