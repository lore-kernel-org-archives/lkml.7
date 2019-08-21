Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879BC3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6966A2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NH79btyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfHUKCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:02:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40204 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfHUKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:02:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id c5so1290928wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/D2OOa3rUCb1UxCtROHFgWT7WT32fJQ0RqabewlpP4=;
        b=NH79btyXC6dVG3wkr4Fdx1Yq1A2e9kJmz8GnS4AUbk05BLqhDM/T4FXlmBmPj+yea1
         INXWJGh6G3Om7sI6e+Mrri8adjfEu4PPc3WfgUiN3UxBQ3Ddvlst3wGWHUE2VFV/pxI1
         kzBNpMH9JwNPiEJ8rllBzIvIvHOjSB2lgHeL4kL9zFSIC1RTbqs2UEVu7/k3myQlYqdx
         VY5FAdjqWKhfXl06TAKYs6XkranuHu44+/dWSOZNAnf31G+d40FE3x0r9Y4LQNrXiIUV
         8EymqI3vlQg2CZAgP5U4dz2pZSUnoKdSDHjwZKaJ7mhWcanv+G6yX+4ovVVyYI+9feSs
         eNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/D2OOa3rUCb1UxCtROHFgWT7WT32fJQ0RqabewlpP4=;
        b=UZZ1GebxkZvEkwHJlEqvZA2DSJu+ebWTNuoawHNeqjYpa+6mmyclq2fOAaqa6rIU6T
         +c1gRFnPbe1LoeoH94vcVeSOJAsa75Api/XHAxt1pVDsNxOMC9P9dxXX13I6VEfyVNTU
         6EQSeXDKq8ac8BbmRKU0Tw/BSSCayUE5wDg0qmf5KcxvzZMsOS1AmSUSInmQ92U+Vc1s
         OXiiWfj1XN+PM+w7grgjZbhNsX3oyGvN3f9JIjpbSrm8IipSy72rkHkMJA6H2YaScr2v
         EC7sTisOTNWgHHYKpH3Bzqj40f21pichd8czSbNC1fPfJQYFld+Ecn/tuIh3avIZ13eA
         05Bg==
X-Gm-Message-State: APjAAAXOZnBKDJ1MSOjfepm4kfsWPMCRaDp9RdPs22hZ/3sMdwu2YSqZ
        6UvdwZRcH+l+a1N6NKEZoqDQGA==
X-Google-Smtp-Source: APXvYqzHE94cpljvv8xlZ6GRnFb9bVL8KuBZ7eNaqZt2v+ySmgDEtNXM67DGWWDrYyUuNQz3HJzGiw==
X-Received: by 2002:a1c:721a:: with SMTP id n26mr4968409wmc.88.1566381749694;
        Wed, 21 Aug 2019 03:02:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id j9sm24102676wrx.66.2019.08.21.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 03:02:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, Deepa Madiregama <dmadireg@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Meng Wang <mwang@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ALSA: usb-audio: Fix the mixer control range limiting issue
Date:   Wed, 21 Aug 2019 11:02:25 +0100
Message-Id: <20190821100225.9254-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepa Madiregama <dmadireg@codeaurora.org>

- mixer_ctl_set() function is limiting the volume level
  to particular range. This results in incorrect initial
  volume setting for that device.
- In USB mixer while calculating the dBmin/dBmax values
  resolution factor is hardcoded to 256 which results in
  populating the wrong values for dBmin/dBmax.
- Fix is to use appropriate resolution factor while
  calculating the dBmin/dBmax values.

Signed-off-by: Deepa Madiregama <dmadireg@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Meng Wang <mwang@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/usb/mixer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5070a6a76ab3..a67448327d07 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1248,8 +1248,10 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 	/* USB descriptions contain the dB scale in 1/256 dB unit
 	 * while ALSA TLV contains in 1/100 dB unit
 	 */
-	cval->dBmin = (convert_signed_value(cval, cval->min) * 100) / 256;
-	cval->dBmax = (convert_signed_value(cval, cval->max) * 100) / 256;
+	cval->dBmin =
+		(convert_signed_value(cval, cval->min) * 100) / (cval->res);
+	cval->dBmax =
+		(convert_signed_value(cval, cval->max) * 100) / (cval->res);
 	if (cval->dBmin > cval->dBmax) {
 		/* something is wrong; assume it's either from/to 0dB */
 		if (cval->dBmin < 0)
-- 
2.21.0

