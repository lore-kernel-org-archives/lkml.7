Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC94C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B0720835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d7lmU/4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCDNb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:31:27 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2550 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCDNb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:31:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7d28a60000>; Mon, 04 Mar 2019 05:31:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Mar 2019 05:31:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Mar 2019 05:31:25 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar
 2019 13:31:25 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 Mar 2019 13:31:25 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.11.127]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7d28ab0001>; Mon, 04 Mar 2019 05:31:25 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@google.com>,
        <linux-tegra@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ASoC: soc-core: Fix probe deferral following prelink failure
Date:   Mon, 4 Mar 2019 13:31:14 +0000
Message-ID: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551706278; bh=Vz67T5ayt32UqJCWkX7+PMkzBJTu2xAcpd/8k5rZPMQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=d7lmU/4sgpH6yllnSA+jD3pOa8B0RH1M78dZCgks7cjRpRA4+8z+Mux0AhmphBpWx
         y4Deg157NYNoPkr5ZbyasejxZSb8EYh6uAUWwBkcen78PYZNmpyRHoF1f98VSkEIdU
         3mBM3nWWOi+LCntnSul0bY/9RmaR3P6u/vgSsdkHYL+OOtgFnRrptUxbp3WehwKrRX
         1ndc2XQW79PCk1v5ADgurxK9mDQZ2OvA0fxzzq4SA5JM7fasZpJYNr7svICnh7JjWf
         kRgDBC/Eee+jOqpfXOZTt9Kp5ycAax0Zpgnny1MYVCF13dRBECFzMvhIoClEbzmcOt
         IixpGAHsrarnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Hunter <jonathanh@nvidia.com>

Commit 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
re-worked the clean-up of any platform pointers that may have been
initialised by the function snd_soc_init_platform(). This commit missed
one error path where if any of the prelinks for a soundcard failed to
initialise, then these platform pointers would not be cleaned-up. This
then prevents the soundcard from being initialised following a probe
deferral when any of the soundcard prelinks cannot be found.

Fix this by ensuring that soc_cleanup_platform() is called when
initialising the soundcard prelinks fails.

Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")

Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93d316d5bf8e..5a5764dba147 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2797,6 +2797,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
+			soc_cleanup_platform(card);
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
 			mutex_unlock(&client_mutex);
-- 
1.9.1

