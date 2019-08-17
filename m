Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726AEC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453922133F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqntU7Qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfHQEcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:32:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41782 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfHQEcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:32:19 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so10379550ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 21:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZgzZCpDIRuYNI4rsUcoYKrHpCVfBSnxQC5KIpwxRrk=;
        b=mqntU7QdosCf34NpRFUhRvfJTPenC0urzJszWL8hgX+lez+r/0/VnstICJ1lHhOFB3
         36bXJUhUmAB0nApDJFFEqJ6GL73czg3U34yhSv6gjK6vH+N4uXYSDapt1+poh4oBG0Na
         geW2TddD+7AlnuJQlIGN4MPMI4VrCr8m3l8JGRJvz8ZmfCk7xoIkZLq6zT4Y7xJe/7md
         vjAyZ4+/kjpXz6xx04FhRQ7N0E51SZibeANTQcu8BQ7XZcBJSvxilCc+jRGhDvo0u+iG
         Ykpn7Lw4O72tWVc1itxClv7iDmn8NjDmw2RiVDGi11xKUia5xRuotzyl3BewiQstqykJ
         XhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZgzZCpDIRuYNI4rsUcoYKrHpCVfBSnxQC5KIpwxRrk=;
        b=hi757yfwLvw+j9omBZkbf5Nrl/VMrCRhSyF+dPWKJVo8aU9dcANKlxWZptvfjGls/7
         wB0QasEfMKPJd+iWzW8nacKq9PLOfNKfHs7RxJEaW9tGeKgwAGWKTpkONsRDW3JyTg0w
         U0bnH9tAnC6YV+nu4JVEtZUgGSIaJHx0GbHdcoOtuOxn9lQufKtavOQn5R1F2tEjrAJt
         wEmyu2FhgmOaFSpSK9QzyE76/dTl2HSPBiG3EkjmToR+6I8DteK/M04ZPuYWw54Xlzit
         PMev2khVPfTldbIXVVsYbw3nS0w8XQSCH81TUl6Z+icug93+aQg34o4fB7u0zKc0QtvC
         Vt5w==
X-Gm-Message-State: APjAAAUyPu3yFzLTymyjHKRLT7yrh7bvamKAiZhXW+OaN1hTTlssEKir
        Hi+hG0jSeX9cOV9ikh+lG8I=
X-Google-Smtp-Source: APXvYqxZ4v+ooEvYx6XqCPFcFfUXrei6ZbQ3InDv2xx+UX4w0j2LaJk6s4+n2vyT+l1L95YnNrZWyg==
X-Received: by 2002:a02:a492:: with SMTP id d18mr15323165jam.27.1566016338760;
        Fri, 16 Aug 2019 21:32:18 -0700 (PDT)
Received: from peng.science.purdue.edu (cos-128-210-107-27.science.purdue.edu. [128.210.107.27])
        by smtp.googlemail.com with ESMTPSA id q12sm4294754ioh.8.2019.08.16.21.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:32:17 -0700 (PDT)
From:   Hui Peng <benquike@gmail.com>
To:     security@kernel.org
Cc:     Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wenwen Wang <wang6495@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix an OOB bug in uac_mixer_unit_bmControls
Date:   Sat, 17 Aug 2019 00:32:07 -0400
Message-Id: <20190817043208.12433-1-benquike@gmail.com>
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

