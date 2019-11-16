Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0980C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A26221479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921492;
	bh=AEKuXHxzOlWw1jjhUhJvnxQdyfazbBauDavrgiai+r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o5klDA++BEp/izqq3a90/PGO0uP5Ve5Bh22a0J2qvl7HDSNNLGiDmpbep6gGBOWVB
	 ykR19ku7XBmL1fvpthdQ0zoJ6xWCslVe9v4QRhg8LJkIq+3T8ajuj5wJQw3QBrwlJm
	 xUnrxRTu8tEKuR0odJobqDAEwaJ4+vNY87GUnjmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfKPQYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfKPPmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:20 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D778A2072D;
        Sat, 16 Nov 2019 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918940;
        bh=AEKuXHxzOlWw1jjhUhJvnxQdyfazbBauDavrgiai+r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pM3U4VlUblagR2RXpQHQaPHodkDMOo32UAwuSiKXyCv6Uld/cvr6Rd2kQy2M9F5tr
         /FTcnt3sXv2lpWK7e4BCkbb7gQTJW/nmio9Iekl1PkwVptkc0bqDK6dkZelJKGls/e
         wm5xyQ+Uy9K7LaUEHMvPcshOl+lNShiLV/vDL42A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 062/237] ASoC: tegra_sgtl5000: fix device_node refcounting
Date:   Sat, 16 Nov 2019 10:38:17 -0500
Message-Id: <20191116154113.7417-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit a85227da2dcc291b762c8482a505bc7d0d2d4b07 ]

Similar to the following:

commit 4321723648b0 ("ASoC: tegra_alc5632: fix device_node refcounting")

commit 7c5dfd549617 ("ASoC: tegra: fix device_node refcounting")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/tegra/tegra_sgtl5000.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
index 45a4aa9d2a479..901457da25ec3 100644
--- a/sound/soc/tegra/tegra_sgtl5000.c
+++ b/sound/soc/tegra/tegra_sgtl5000.c
@@ -149,14 +149,14 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing/invalid\n");
 		ret = -EINVAL;
-		goto err;
+		goto err_put_codec_of_node;
 	}
 
 	tegra_sgtl5000_dai.platform_of_node = tegra_sgtl5000_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
-		goto err;
+		goto err_put_cpu_of_node;
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
@@ -169,6 +169,13 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&machine->util_data);
+err_put_cpu_of_node:
+	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
+	tegra_sgtl5000_dai.cpu_of_node = NULL;
+	tegra_sgtl5000_dai.platform_of_node = NULL;
+err_put_codec_of_node:
+	of_node_put(tegra_sgtl5000_dai.codec_of_node);
+	tegra_sgtl5000_dai.codec_of_node = NULL;
 err:
 	return ret;
 }
@@ -183,6 +190,12 @@ static int tegra_sgtl5000_driver_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
+	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
+	tegra_sgtl5000_dai.cpu_of_node = NULL;
+	tegra_sgtl5000_dai.platform_of_node = NULL;
+	of_node_put(tegra_sgtl5000_dai.codec_of_node);
+	tegra_sgtl5000_dai.codec_of_node = NULL;
+
 	return ret;
 }
 
-- 
2.20.1

