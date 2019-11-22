Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D5BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F0620672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402041;
	bh=pz78iwdXUENbZcbYUMALJIFQGQOKoTGxA9AdC7L3WZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFqqbBdJ8oga+FBXTaBqZIiTr9TIDPxasH0PBHdkv4osOw5AFrI5QYMpC80SLBA/+
	 QEU6QtvqE8EY/4vl6Aa3nyTdKtbcjuTTtniAT8cFmQh2Yvka/t2/htDCBml5T70h0W
	 TMdSypKofTuyH3gkgkx4OYwHm4jUDYo/C5ZRwljw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfKVFyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbfKVFxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:53:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E60207FA;
        Fri, 22 Nov 2019 05:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401997;
        bh=pz78iwdXUENbZcbYUMALJIFQGQOKoTGxA9AdC7L3WZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsry0BzOfr/ITWMcYzCLSjqO3Nel0KOHa6QWVsM+1FW6xC8ebcS6y7Ffd8gNcPAw4
         yF/G0oN5FehqIjZ5ofeuSKSj2jcbkJuyBykoBK3stQ7vStYfPj5ksYmtXgFMx611JY
         qQ/XRUZY+az3cRYkVu7Z5ubmbexZq8OB4VCG4wdY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hui Wang <hui.wang@canonical.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 215/219] ASoC: rt5645: Headphone Jack sense inverts on the LattePanda board
Date:   Fri, 22 Nov 2019 00:49:06 -0500
Message-Id: <20191122054911.1750-207-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit 406dcbc55a0a20fd155be889a4a0c4b812f7c18e ]

The LattePanda board has a sound card chtrt5645, when there is nothing
plugged in the headphone jack, the system thinks the headphone is
plugged in, while we plug a headphone in the jack, the system thinks
the headphone is unplugged.

If adding quirk=0x21 in the module parameter, the headphone jack can
work well. So let us fix it via platform_data.

https://bugs.launchpad.net/bugs/182459
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1dc70f452c1b9..f842db498c741 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3662,6 +3662,11 @@ static const struct rt5645_platform_data jd_mode3_platform_data = {
 	.jd_mode = 3,
 };
 
+static const struct rt5645_platform_data lattepanda_board_platform_data = {
+	.jd_mode = 2,
+	.inv_jd1_1 = true
+};
+
 static const struct dmi_system_id dmi_platform_data[] = {
 	{
 		.ident = "Chrome Buddy",
@@ -3759,6 +3764,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&intel_braswell_platform_data,
 	},
+	{
+		.ident = "LattePanda board",
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VERSION, "Default string"),
+		},
+		.driver_data = (void *)&lattepanda_board_platform_data,
+	},
 	{ }
 };
 
-- 
2.20.1

