Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C004DFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8953F222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239895;
	bh=LcaDl67Y4pCj301MYjZerPTQIELp2RQWnNCIQmsB/2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BU/PXvAKdx/Lss7isBcG9WYaUZAAu5R9ZG8uzqzYTw9SaXK36Ihul42fQ+dmjarIY
	 KJSMYrvD9JysLD+0tqE7NenuragTRsd5KrVGNXtfsAwz17d5U+NMOj7V20S9g6Pqgm
	 PJkUnWeYQCskeGYRDFNRgBFFRf6LnmfRwIqP58fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391094AbfKHTEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391081AbfKHTEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:04:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9CB218AE;
        Fri,  8 Nov 2019 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239892;
        bh=LcaDl67Y4pCj301MYjZerPTQIELp2RQWnNCIQmsB/2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksLZMpAKZSZ/sBipfHHBTBfO9IiITmruZw48eoho5vlymH9PBe5y3LIycnWHmOXey
         z7o8oyvm1lKuY6CiCul9jEQ3YexzGBysP3n2d0zczXDPd5YWQ2xHagjd6cMvFwUMG6
         bWs/0A5TQZF3TjQ0xqftpDpPTS9/egdlua4hFxTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaska Uimonen <jaska.uimonen@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 018/140] ASoC: intel: sof_rt5682: add remove function to disable jack
Date:   Fri,  8 Nov 2019 19:49:06 +0100
Message-Id: <20191108174903.658360587@linuxfoundation.org>
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



