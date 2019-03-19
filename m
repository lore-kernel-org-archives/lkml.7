Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51ED2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="I/gX11nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCSA6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:58:14 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:37412 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCSA6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:58:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 2940FB6F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fo2Q5b3tk9Ha for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 19:58:12 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id EB5F3B12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:58:11 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id i1so15187758ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EXT644PQkCBEG/dhZ8I2hNm6TfAQA6jwWJOLS+hChA4=;
        b=I/gX11nR8IEHnYe0d2pXhNP1H1NEKzD2aRItZqZNODp1/59LAqu67FgKRhzV8f4bpH
         Js0aRcsxCaRwY2GA03Wb8MnL+h4fRFwNLHIouegt+U18DjBVmFZzop6FdV88dCD2ceHl
         y5oh2bQOzfcNazSTnF6E6F43jBtHlelTOOxy7MC2pyE9tTZuMcvCvOZCUOtAO7VYjtHX
         oGnhYcj96+PZwd5YHRnvUmpDS9h2a+Zr4WeBSBUyjxeC5S56jDe0OUV1aFLn6T43KkYP
         D4DkLFov37y2LJ/u6b0RiOo+ffSQoTJwXJyG9pi9j4ra9M13oubDjaxz4d2H/NWCdUBp
         5inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EXT644PQkCBEG/dhZ8I2hNm6TfAQA6jwWJOLS+hChA4=;
        b=nDkG7EVU7D/XkJD82w5fkJTOCZqlwjrCMEFiNr13poNX8cAjX7kQ9dHWl0qgLWTKcx
         GI23iG9AGIwe7MaHs9ctcabzgEN+Cxjv55EQEFaXPUL46oXCi+XX/C/lNp0tjH7vNH0V
         95ZBHflYjzVhUvWPs/eZ5J7L9pA96nMqEBc9R0TJS8770wVKLtTMy73PMGQul8dIWC4U
         QqhYyDERwA60R9nvgKg+QIzTAwKvYa5oT8TMeiYkQIkWedXFzB/OHtqyWYzr91z6ty1L
         rmLeXjv42CbCYokfeKkYN7R8no/zdRkTJcnwCFrqnnN6+UkDCYhknpQDSsFIZE3ZsJat
         CI1A==
X-Gm-Message-State: APjAAAUTqwuRBEoFf9kEdnzGhzS7y4iQkLdehF1OgZOlYTTeaLjPlFus
        y7p8p4KnP5+eKkVERUssaMgeW/3cZAl3x9cErqV9fjB6h7EKt5RyuJYl17iPU9YEofqtbMRvkTC
        mLHrcPELhEIm8I0FOv64zKajefY0h
X-Received: by 2002:a24:fc01:: with SMTP id b1mr1115138ith.104.1552957091608;
        Mon, 18 Mar 2019 17:58:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRkCEaTsHfrf5glbuyZk1++jz2MrzAh86/F71pokK7BXyHy1oGIKbyQ3AX/1giUyAnF/1BiQ==
X-Received: by 2002:a24:fc01:: with SMTP id b1mr1115124ith.104.1552957091440;
        Mon, 18 Mar 2019 17:58:11 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id w19sm507831ita.33.2019.03.18.17.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 17:58:10 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Barry Song <baohua@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: Fix to avoid potential NULL pointer dereferences
Date:   Mon, 18 Mar 2019 19:58:01 -0500
Message-Id: <20190319005805.13823-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sirf_audio_codec_driver_probe, of_match_node may fail and return a
NULL pointer. The patch avoids a potential NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/soc/codecs/sirf-audio-codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index e424499a8450..fd2bbd6a3c58 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -464,6 +464,8 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 
 	sirf_audio_codec = devm_kzalloc(&pdev->dev,
 		sizeof(struct sirf_audio_codec), GFP_KERNEL);
-- 
2.17.1

