Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D724CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6350D217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450670;
	bh=LcaDl67Y4pCj301MYjZerPTQIELp2RQWnNCIQmsB/2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NLOgjNW+w1sx1+PNX12j4eRjcXId6quNcyZ+GXVSn6o9rLFk9dZbT5snCiiIBHPcK
	 aclfKmpsWkU8PJTwF7R4etp3jt4crmbd1dWUtKNij8lVAIhHRRWJPymC1m8i1CIRL2
	 Ip/A9jJCv6OFQRJiyZK3eeNVtUp+QDoPdHQFyclM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfJ3PvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfJ3PvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:51:08 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B424920856;
        Wed, 30 Oct 2019 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450668;
        bh=LcaDl67Y4pCj301MYjZerPTQIELp2RQWnNCIQmsB/2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2iPDCOrcoDmf9zji+AweDKmeDVjFSpC3PBkBgQzmIRmm38CxfQGl+jxknacQ/vRq
         /ciBcSAxxrMBT6WQxNmQt9O2mVWlXILEIX439UBsu6xmSx4Dqh2tNzwe57aRILrCbo
         gODWWzKXLMXTIF4VbEBVy1sUrvP+T0A3T3JzF4rc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaska Uimonen <jaska.uimonen@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 18/81] ASoC: intel: sof_rt5682: add remove function to disable jack
Date:   Wed, 30 Oct 2019 11:48:24 -0400
Message-Id: <20191030154928.9432-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaska Uimonen <jaska.uimonen@intel.com>

[ Upstream commit 6ba5041c23c1062d4e8287b2b76a1181538c6df1 ]

When removing sof module the rt5682 jack handler will oops
if jack detection is not disabled. So add remove function,
which disables the jack detection.

Signed-off-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190927201408.925-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index daeaa396d9281..239eef128c2b7 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -618,8 +618,24 @@ static int sof_audio_probe(struct platform_device *pdev)
 					  &sof_audio_card_rt5682);
 }
 
+static int sof_rt5682_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct snd_soc_component *component = NULL;
+
+	for_each_card_components(card, component) {
+		if (!strcmp(component->name, rt5682_component[0].name)) {
+			snd_soc_component_set_jack(component, NULL, NULL);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static struct platform_driver sof_audio = {
 	.probe = sof_audio_probe,
+	.remove = sof_rt5682_remove,
 	.driver = {
 		.name = "sof_rt5682",
 		.pm = &snd_soc_pm_ops,
-- 
2.20.1

