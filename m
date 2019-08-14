Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E650C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C52620843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748651;
	bh=l/TesP6REABelbdAXxmIopwIlyUCPz4GgqUrAyCQXgM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SoCwogfwprkJnKUYafLeWsm74y0mTmmH09+8MYSr/KFui0haevcrOztTLMhM7/JWl
	 wH9Ca/hl5qGnLtKZZZnPHh+maGYfncAeBAqB18McJ01j1yYJzbpAYcGIYxuyENET3d
	 xXsqHrOOFgWCgtmRaVBcIb8hWB3Au5stw0tRnDNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfHNCKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfHNCKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:10:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F5520842;
        Wed, 14 Aug 2019 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748649;
        bh=l/TesP6REABelbdAXxmIopwIlyUCPz4GgqUrAyCQXgM=;
        h=From:To:Cc:Subject:Date:From;
        b=Vi4mYmcXEEfLm3GjKUsJmPHF50WAuuM7AllxTaUzC1m3R6QVCsRs31Uyw+I6Wytru
         wUIgEpb+FaM+YSeGo+z2wXu37+3Hr0hOT0tV6lEBnTHWSGTD7GvBy3eLCowUboIcVI
         QockemHUWBxtSVLpd96fKdmE3PlRH5cnQIwxRr4c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 001/123] ASoC: simple_card_utils.h: care NULL dai at asoc_simple_debug_dai()
Date:   Tue, 13 Aug 2019 22:08:45 -0400
Message-Id: <20190814021047.14828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 52db6685932e326ed607644ab7ebdae8c194adda ]

props->xxx_dai might be NULL when DPCM.
This patch cares it for debug.

Fixes: commit 0580dde59438 ("ASoC: simple-card-utils: add asoc_simple_debug_info()")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87o922gw4u.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/simple_card_utils.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 3429888347e7c..b3609e4c46e0f 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -149,6 +149,10 @@ inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 
+	/* dai might be NULL */
+	if (!dai)
+		return;
+
 	if (dai->name)
 		dev_dbg(dev, "%s dai name = %s\n",
 			name, dai->name);
-- 
2.20.1

