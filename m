Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E643FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA20218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239898;
	bh=4py+xzrfM5ohrANP39y//v96cgpB4cx/K0n1sj51s2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uh/cfMcWYCyKM96SVw4IjnOm5nc9cToezrgk6oyeOBe/vear1c4006NH9SfMTUrn+
	 159rO7jPaAU13v9bmdIn5zFJaFdbl0iwAJAnNmM9PkQtBD3q0dAqO2wQ78A1IV7F5n
	 ey2OOnK/FSOoKvPyGyUht6IJoS8iIWD824jtij54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbfKHTEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:04:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391066AbfKHTEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:04:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06B521D7E;
        Fri,  8 Nov 2019 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239889;
        bh=4py+xzrfM5ohrANP39y//v96cgpB4cx/K0n1sj51s2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phCnaWrMY+5XLH9D38DMq6SdsvrFNp6grFqaceek9CI73wlcfcH83XHqMMMn5IUCv
         ueUQMzqCvxct0+LmRAhHTiZS/9e9sFWAvditX3WaY+UTNXJnoHn9NSfL8dEcaOkaf8
         +7uPvNIyMPxax5hA/LhtyTqD7t3R44+PpIdUpZ5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaska Uimonen <jaska.uimonen@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 017/140] ASoC: rt5682: add NULL handler to set_jack function
Date:   Fri,  8 Nov 2019 19:49:05 +0100
Message-Id: <20191108174903.367881072@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaska Uimonen <jaska.uimonen@intel.com>

[ Upstream commit a315e76fc544f09daf619530a7b2f85865e6b25e ]

Implement NULL handler in set_jack function to disable
irq's.

Signed-off-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190927201408.925-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 1ef470700ed5f..c50b75ce82e0b 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -995,6 +995,16 @@ static int rt5682_set_jack_detect(struct snd_soc_component *component,
 {
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 
+	rt5682->hs_jack = hs_jack;
+
+	if (!hs_jack) {
+		regmap_update_bits(rt5682->regmap, RT5682_IRQ_CTRL_2,
+				   RT5682_JD1_EN_MASK, RT5682_JD1_DIS);
+		regmap_update_bits(rt5682->regmap, RT5682_RC_CLK_CTRL,
+				   RT5682_POW_JDH | RT5682_POW_JDL, 0);
+		return 0;
+	}
+
 	switch (rt5682->pdata.jd_src) {
 	case RT5682_JD1:
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_2,
@@ -1032,8 +1042,6 @@ static int rt5682_set_jack_detect(struct snd_soc_component *component,
 		break;
 	}
 
-	rt5682->hs_jack = hs_jack;
-
 	return 0;
 }
 
-- 
2.20.1



