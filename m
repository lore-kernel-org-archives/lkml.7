Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5317B2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9s9oPlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfLQMRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:17:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfLQMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:17:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so6860739wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
        b=e9s9oPlqXY3bctDM3DAHIJFutY3Ax0XREhVRz8vU2/r0RE5AQiKlprlrrhlwjSUKnU
         I4MNJ6If8bH8sOZ/8V8co/C8+VmqvSH+0TE9JWQjAlvN5D8Hu1cYG72tuFzM72STIrIx
         8Z7L6qC+b+xgUl6hi7VzTgXqyOA/7TE2//DxOL1bg5v6g0P1Iu43cZPvXE4l5EsfOaTz
         381W/UqQI3VECNLJO1D8aX97tm+2wRw2dckwE25xta8py1wh4vBWgJ6TYVG86CLQah5v
         d0CvEauJ67z2iUN9K6EgAvlhrN3ky0wQKeqS4hhetqXQg/RDE0785FOABqsg2WjS5dkh
         dxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
        b=rhKzTkkH7yhxafTM2DVnCRhM0nHVWD7XY1gcILlc0esRzuT0vA0uo213TxlMrt4yiX
         XjP0EEmE8xlOdayKfIsgiOvIWkZeAZ1gNlI+aUKiDy/tSwkJ+BT2XXhdEcKQZ3FusVy0
         vH+f4T4kvdtuUZS+owbvLASa3qJG9VwP5EMLSxL7zDSx7Zp+n1bdVbvhrB5+UYblb8YR
         XnY554FktmarJwGv52c7I2yGdVzTNs+QLnz8wqbrt6MfQZ1kKpIZbBbFWQyGL9m+xDFm
         tvktAvrlzxxKoDHxn0B10or/3Fhx6/tw4VUyfvK6EzgXv0wblbuBsqaKgQtxXSKvHwjN
         b9Yg==
X-Gm-Message-State: APjAAAUZBiySF8k2dTrbIAkLnp/vE9zeDm6zVV5jcLdUVjwFOFDUkPcB
        CnJJVc13rDsVT5WTfmrYWdt2GJm/Htg=
X-Google-Smtp-Source: APXvYqwUd8iYagOOPCAYY210HLyKnjSRxtsp4sXkvd58+blKgW/ZwzPQFg9MOF97O4mj3QOzD6d58Q==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr35902104wrw.165.1576585033342;
        Tue, 17 Dec 2019 04:17:13 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f1sm25087270wru.6.2019.12.17.04.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:17:12 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 10/11] ASoC: qcom: dt-bindings: Add compatible for DB845c and Lenovo Yoga
Date:   Tue, 17 Dec 2019 12:16:41 +0000
Message-Id: <20191217121642.28534-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible strings for DB845c and Lenovo Yoga C630
soundcard. Based on this compatible strings common machine driver
will be in better position to setup board specific configuration.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,sdm845.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
index 408c4837e6d5..ca8c89e88bfa 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
@@ -5,7 +5,10 @@ This binding describes the SDM845 sound card, which uses qdsp for audio.
 - compatible:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "qcom,sdm845-sndcard"
+	Definition: must be one of this
+			"qcom,sdm845-sndcard"
+			"qcom,db845c-sndcard"
+			"lenovo,yoga-c630-sndcard"
 
 - audio-routing:
 	Usage: Optional
-- 
2.21.0

