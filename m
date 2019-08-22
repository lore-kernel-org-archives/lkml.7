Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C97C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AE223400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQLfaIFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfHVJ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:57:30 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53375 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbfHVJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:57:30 -0400
Received: by mail-wm1-f45.google.com with SMTP id 10so4983507wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kR3iAupDN1p7AjL90yYqFge/scd5U0HZbTAOmwv5vBY=;
        b=JQLfaIFK06F559EY6AH4ccrGgpz6GGzGoQebhRGkIa13tsCeTEuWwdL0tbtoVGoCah
         HuRdMzA4S3bME4wvTEqQzDYCAL6h9XBHOTaGKvhyrpIfxEh2rOl29K+Tyyqn2EUVwvxr
         ZfT5FrZ4NkWFE/PUKUrxUpq+uEuCjTczZeMWekq8M1MPZpEsdf4dDat2wZeP9FLj6fYa
         QFl/r3Asq+T0t8ue0DGxZt929HTapzab6u5tPd/VEUTrnJoXlburPfFAoAzOJroBQ6QM
         xr/m3yeIJInIpv0lozKqNlsWsWSQkrnFN3N424XyCRwfk0HtASRLqQZpLgAf8ocrLHqd
         9CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kR3iAupDN1p7AjL90yYqFge/scd5U0HZbTAOmwv5vBY=;
        b=C9HXXFY0M+wnsZBu2NZtqZZs54pdA9PHvgd5QCvCaRnj5N1g3s7slU0+Kr4n4L7vsb
         /qnfyw01vb1utLTEnSsx7PzpTZWRd1SEnx7y1XAwaUZLtzfvpMWOdgzqj1GMtI5TvTGS
         mcNr7eEHVtocAJUqYBRDYB506pTRXotS0CnJgNhZYTJjUJbHrxzhKSrZ3vZmHZXxKLEv
         qAa8ogdyE61Fo+Ll6lNx9QT2udW5jeZn3E2tPhZ1R3tswtczG8qy351sP1FYnObhtanw
         l3YIx9STQLp6+CwWbQd8p82nFk4S5m607Wux9QMP/eg9bUOo3Ht2y8CgCmtOJnfz2qnl
         bBNw==
X-Gm-Message-State: APjAAAUbT/wNYgcyVPKDZK2Ol4p+crptMGjS5zX3VIwrTmZisG5T/Yzt
        S/y1vfjzvFeu82BtInpmB6Y+saErcJM=
X-Google-Smtp-Source: APXvYqwk25RSa6y/DPXrHDkMQJCnorEmRKZ1BVgcYmt1o6XmCLCTzwjLVUHLtTPvHrdBZ8J4BmqVow==
X-Received: by 2002:a1c:7009:: with SMTP id l9mr5219091wmc.159.1566467848327;
        Thu, 22 Aug 2019 02:57:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t24sm3298909wmj.14.2019.08.22.02.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 02:57:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/4] ALSA: pcm: add support for 352.8KHz and 384KHz sample rate
Date:   Thu, 22 Aug 2019 10:56:49 +0100
Message-Id: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds missing support to 352.8KHz and 384KHz sample rates in
Qualcomm WCD9335 codec and QDSP dais.

First patch adds these new rates to known list of rates in pcm core and
also adds defines in pcm.h so that drivers can use it.

Changes since v1:
 - Added wcd and qdsp users of these new rates.

Srinivas Kandagatla (3):
  ASoC: wcd9335: Fix primary interpolator max rate
  ASoC: qdsp6: q6afe-dai: Update max rate for slim and tdm dais
  ASoC: qdsp6: q6asm-dai: fix max rates on q6asm dais

Vidyakumar Athota (1):
  ALSA: pcm: add support for 352.8KHz and 384KHz sample rate

 include/sound/pcm.h              |  5 ++
 sound/core/pcm_native.c          |  2 +-
 sound/soc/codecs/wcd9335.c       | 20 ++++---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 92 +++++++++++---------------------
 sound/soc/qcom/qdsp6/q6asm-dai.c | 18 +++----
 5 files changed, 59 insertions(+), 78 deletions(-)

-- 
2.21.0

