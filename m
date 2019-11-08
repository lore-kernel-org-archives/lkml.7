Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2306FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205D20656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240829;
	bh=b//UH+s3fYDvEAbXVURjX5gByWgHF0L4NdI99WLliO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RMfVI4O/NTqczyAdu9sm78gZ1mOP5GLN+40vMjzKuc3dDM45IMVvvZ2X73Q07IVvX
	 y4U91e0wEdtxb6BZEw5et/wB/oIcW6/0DRfqcfjyiVtjdzKz4B3yhG2x7DRinp+spP
	 47JpxJP39/9lu2RLW2xZ1K4oPg8T2hVPBR58BFuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbfKHTU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389430AbfKHTAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B9421D7F;
        Fri,  8 Nov 2019 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239458;
        bh=b//UH+s3fYDvEAbXVURjX5gByWgHF0L4NdI99WLliO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8VvdP8i4vOrhbWy7lwQERFrssNqjOJiK57O04AKGUGf8LAB+tGh3AEpXE78dT5e3
         afS0Grh6doshn6AWlfjxDwROuhyXZlR0YJXMtG1MXhPurXhh+yumx1IvFoyy4Eb/QQ
         EBQij4Bkuy9/QHLRHDjWtgD4oufPG9zg47teUZ/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stuart Henderson <stuarth@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/62] ASoC: wm_adsp: Dont generate kcontrols without READ flags
Date:   Fri,  8 Nov 2019 19:49:52 +0100
Message-Id: <20191108174723.637296786@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d632a0511d62a..158ce68bc9bf3 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1169,8 +1169,7 @@ static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
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



