Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C46C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1B62054F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180532;
	bh=IW9B/HeSgNw2BYZ4ZZx2Ue6CPKz5wPi/K6VoRd80Rnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/gZTgul9kRDNKKr/v5ivVZ68KH+2mOdjcXn1hjG5GuhAcVYmK9WuKSLMbgi5Zwqv
	 JxeHM9YmuzwwaDMX3qorOUx2v+wEWk9ezuhswlG92zDcPCI/U34tnjVz6mXeZuLYA9
	 wxJcxWyqVibXkD1nkdrSOnQRNOAYCMQMKsA313zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfIVT2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbfIVSud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:50:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED70214AF;
        Sun, 22 Sep 2019 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178232;
        bh=IW9B/HeSgNw2BYZ4ZZx2Ue6CPKz5wPi/K6VoRd80Rnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvE1RwNicYV0mMv5ZNMm39C5JxLwy92E1sF3OsU7z6cNLZldc6liIibBvwgf54m6m
         uvOnh34qaQoc50rrvDEOqif3PkDeOSHf3TsdpKCJwI1HdUtLfpOX/Lj8hT3z6Q00Ba
         fFSczruifwkxG7hGqe1xSKvxnv5yf7oDI7oL55nE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 030/185] ALSA: i2c: ak4xxx-adda: Fix a possible null pointer dereference in build_adc_controls()
Date:   Sun, 22 Sep 2019 14:46:48 -0400
Message-Id: <20190922184924.32534-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 2127c01b7f63b06a21559f56a8c81a3c6535bd1a ]

In build_adc_controls(), there is an if statement on line 773 to check
whether ak->adc_info is NULL:
    if (! ak->adc_info ||
        ! ak->adc_info[mixer_ch].switch_name)

When ak->adc_info is NULL, it is used on line 792:
    knew.name = ak->adc_info[mixer_ch].selector_name;

Thus, a possible null-pointer dereference may occur.

To fix this bug, referring to lines 773 and 774, ak->adc_info
and ak->adc_info[mixer_ch].selector_name are checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/i2c/other/ak4xxx-adda.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index 5f59316f982ae..7d15093844b92 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -775,11 +775,12 @@ static int build_adc_controls(struct snd_akm4xxx *ak)
 				return err;
 
 			memset(&knew, 0, sizeof(knew));
-			knew.name = ak->adc_info[mixer_ch].selector_name;
-			if (!knew.name) {
+			if (!ak->adc_info ||
+				!ak->adc_info[mixer_ch].selector_name) {
 				knew.name = "Capture Channel";
 				knew.index = mixer_ch + ak->idx_offset * 2;
-			}
+			} else
+				knew.name = ak->adc_info[mixer_ch].selector_name;
 
 			knew.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 			knew.info = ak4xxx_capture_source_info;
-- 
2.20.1

