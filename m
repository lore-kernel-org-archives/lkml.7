Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D3217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427654;
	bh=NjlHdrYD8SEIGp3Pv0nvCnU+4Dwgg6GDZ3nj/qIUb2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1wKyuMMQ4DEA8WpnaEqswYto1DOrnX0K8gJr1ANC5TPKK3lCFCdZbwhJ6mqIfTt0
	 pAdGIFE6GWuWH/I5fBG4kmrREHajtc2YWvhu8XBCGA0n/JIIuBrsJ3zn71zvsagi1O
	 +ScJWUfAab1cFkQoNkcQ9svH1d7ViFUmAdvJPurg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfEISrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfEISrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:47:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E38217D7;
        Thu,  9 May 2019 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427644;
        bh=NjlHdrYD8SEIGp3Pv0nvCnU+4Dwgg6GDZ3nj/qIUb2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7tMIj+I8AlZhTn9RDBfu2Hp5YsRQrHhqyx5mvdmQ3j55vTRg0KF6zbrAlIddiZJ2
         s7O8b5rNpcwR2eQI8zo5xiR+AuMxNGyYLNzsq67MWYfC6upWXyszuMTcaelHyOLHR1
         w7VsgMDRZ1I6PyzadzPkQXp6sazG+1CjVHRZIb5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/66] ASoC: stm32: sai: fix iec958 controls indexation
Date:   Thu,  9 May 2019 20:41:44 +0200
Message-Id: <20190509181302.872416549@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5f8a1000c3e630c3ac06f1d664eeaa755bce8823 ]

Allow indexation of sai iec958 controls according
to device id.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 85c4b6d8e89db..e8df3cc341b5e 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -96,7 +96,7 @@
  * @slot_mask: rx or tx active slots mask. set at init or at runtime
  * @data_size: PCM data width. corresponds to PCM substream width.
  * @spdif_frm_cnt: S/PDIF playback frame counter
- * @snd_aes_iec958: iec958 data
+ * @iec958: iec958 data
  * @ctrl_lock: control lock
  */
 struct stm32_sai_sub_data {
@@ -888,11 +888,12 @@ static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	struct snd_kcontrol_new knew = iec958_ctls;
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
 		dev_dbg(&sai->pdev->dev, "%s: register iec controls", __func__);
-		return snd_ctl_add(rtd->pcm->card,
-				   snd_ctl_new1(&iec958_ctls, sai));
+		knew.device = rtd->pcm->device;
+		return snd_ctl_add(rtd->pcm->card, snd_ctl_new1(&knew, sai));
 	}
 
 	return 0;
-- 
2.20.1



