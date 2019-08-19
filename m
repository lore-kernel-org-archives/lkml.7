Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0640C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B92214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2Sj2DY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfHSWAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:00:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34531 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:00:43 -0400
Received: by mail-io1-f66.google.com with SMTP id s21so7780472ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZgzZCpDIRuYNI4rsUcoYKrHpCVfBSnxQC5KIpwxRrk=;
        b=a2Sj2DY/hIiVjiyTeltsCTax6Jr86BvQ1q20cGy89ezNAuCsp4oGSbglZYJmpvmlAR
         5XYEPUBp752xX3OqexzfWN1hPfOMiOC23tVax7ZJ/Mj4BzZy8MJw9vPxI+b/OtMO1TPD
         gAgbZP1u6kOn8hfc1CU44U5trPwTiUIZcnewTQDkKWe+urYKFH1JTGVUDCw3zcmUXUpK
         mqD2NDEZl2vpqUArI4lxwtIItziAmaYSzInQF0Qse4Ramd9mh5oWIPiOUE1xisFsnyrr
         DM5rw1+vQcfoqWXSszdg4pHo4koi80/6CQb4ud1BOXTGjuuACa3nnSFjNkKyGD4FfKYS
         LnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZgzZCpDIRuYNI4rsUcoYKrHpCVfBSnxQC5KIpwxRrk=;
        b=Kgzb9HzBNb02q1gI6gBSyQNYXqtUe8t36xxaPGrqWcDLEkmncaYfuADudPyekz18Xs
         ChxWPfgxewLzhpvsKhqcwZTOA7SWnlJAd12Yzv4pzJUpHwjRLKZgkRIAw3NGOBHTP4OI
         nBRp2wWJz4sggvpr3RZ6AkGuDY2QuGXsKuAVWX8NE6EIgkMRpgt9E4sg3vVCzelnSLJK
         EL5To1P9hwz6B1bnmOrAkjThVoAdH8O2u6oNYggQX7Y2DbdKMKtatqllRyEvAnrft2kz
         FBensC3gbYs1JrKeR2qA4KbcIudJl4CZjk0EGT02Na7Yd2fom/zbkdIq3oSwmNvWnx3P
         4/sA==
X-Gm-Message-State: APjAAAX7meJcqWiYEuF/oY8fGHWOxrMYtzsC14Dqd/UHkKzJc9MVFlt2
        fjiBal8JVZKLnb2kbHVAtDY=
X-Google-Smtp-Source: APXvYqyG6NoGLRNEmVz2lcQZxyJZfbnX3rJ3md+y4qEuCVLPqPQSoH2ZWTbShl1IYRPtzZPeMieQDw==
X-Received: by 2002:a02:a405:: with SMTP id c5mr6601jal.54.1566252042119;
        Mon, 19 Aug 2019 15:00:42 -0700 (PDT)
Received: from peng.science.purdue.edu (cos-128-210-107-27.science.purdue.edu. [128.210.107.27])
        by smtp.googlemail.com with ESMTPSA id f1sm19353759ioh.73.2019.08.19.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:00:41 -0700 (PDT)
From:   Hui Peng <benquike@gmail.com>
To:     security@kernel.org
Cc:     Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix an OOB bug in uac_mixer_unit_bmControls
Date:   Mon, 19 Aug 2019 18:00:04 -0400
Message-Id: <20190819220005.10178-1-benquike@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`uac_mixer_unit_get_channels` calls `uac_mixer_unit_bmControls`
to get pointer to bmControls field. The current implementation of
`uac_mixer_unit_get_channels` does properly check the size of
uac_mixer_unit_descriptor descriptor and may allow OOB access
in `uac_mixer_unit_bmControls`.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 sound/usb/mixer.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b5927c3d5bc0..00e6274a63c3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -738,28 +738,39 @@ static int get_cluster_channels_v3(struct mixer_build *state, unsigned int clust
 static int uac_mixer_unit_get_channels(struct mixer_build *state,
 				       struct uac_mixer_unit_descriptor *desc)
 {
-	int mu_channels;
+	int mu_channels = 0;
 	void *c;
 
-	if (desc->bLength < sizeof(*desc))
-		return -EINVAL;
 	if (!desc->bNrInPins)
 		return -EINVAL;
-	if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
-		return -EINVAL;
 
 	switch (state->mixer->protocol) {
 	case UAC_VERSION_1:
+		// limit derived from uac_mixer_unit_bmControls
+		if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 4)
+			return 0;
+
+		mu_channels = uac_mixer_unit_bNrChannels(desc);
+		break;
+
 	case UAC_VERSION_2:
-	default:
-		if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 1)
+		// limit derived from uac_mixer_unit_bmControls
+		if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 6)
 			return 0; /* no bmControls -> skip */
+
 		mu_channels = uac_mixer_unit_bNrChannels(desc);
 		break;
 	case UAC_VERSION_3:
+		// limit derived from uac_mixer_unit_bmControls
+		if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 2)
+			return 0; /* no bmControls -> skip */
+
 		mu_channels = get_cluster_channels_v3(state,
 				uac3_mixer_unit_wClusterDescrID(desc));
 		break;
+
+	default:
+		break;
 	}
 
 	if (!mu_channels)
-- 
2.22.1

