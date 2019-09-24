Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF7C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF92920665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1qULRe6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbfIXPeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:34:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44060 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390040AbfIXPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:34:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so2451863wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYm2kdDHvuEumJRpwSMhohy7MyzS9ZQuphxUJlMOkY8=;
        b=1qULRe6omG7tKNNXNm+dQcTgpMI584y2Fh2bzeudpyBZ4D6qiX01AcAVXs1esn4voA
         dlNagVnwTHJV+hRZnAZ79iAKzsj6F5iH0gZ4eycvdIgDFAYZOavPpYyGD7tgaMOpJkng
         1lAVJtuLN6ZzunP3d/XrdTrr7A3fSgrwhMCyn26joFzK1EljQNjze9d0ZCY/BfO4HU/K
         12qQQ5VY2rCWUKhtUH/jdLtVsbzV51XNwy50P7iZbhrxAAqv6Rkv9o6p2RGctWsjULHu
         d1gCUwr4EtR48MxteDLPJ7D3rJeKPXZTKC7fW3eZJlo+9HsPX5kLfTFx8/a0ulTZVz/0
         K1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYm2kdDHvuEumJRpwSMhohy7MyzS9ZQuphxUJlMOkY8=;
        b=Ve+tLFYPDI669SYf+PNC4zpMv00oYNrEFcZhCSTzQR57W3NjKbVqfHyx+nabEaFLTo
         yHJPv/KFZgc0JUr3x+gdqkTT0secedjofYNsY4SCoEDeyXpyxWUgmYfHEIFQFIvOba67
         qa2PAZimV2iFc8oAJgMoGK15qqCwdNQ68MEaq1YYVVloDKDHoP5+bAgNhDEO9YbbikmH
         N4v4wqF2Z7Oodnwr+qfJQa8op2EyIlsjiV4/s4NiglMrJeHq1LdnNSFwUwpUMHT4+5ji
         WjA3/NQ3Ad6RDKs65xCuLfGPaKQ1gwkZRqr/z1ASvoAVKb1ym1B65P3IWHFsYKU6W7u7
         KOTw==
X-Gm-Message-State: APjAAAXbV+IeQnCuxgJ/o+T2rTC+RT0eEcrs86vv7HLq09FhfTHkESxr
        lICRF/XJ1IcLflJDF/jOwX9UmA==
X-Google-Smtp-Source: APXvYqyshR/vUVhXGPLNJD1mk9I+NwmcyWPq2RQfWHfHy++IjdyBaJOnVT7Rbzr4TRwoWgE4ZLeQsg==
X-Received: by 2002:adf:f406:: with SMTP id g6mr2805516wro.325.1569339246672;
        Tue, 24 Sep 2019 08:34:06 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d10sm144240wma.42.2019.09.24.08.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 08:34:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] clk: meson: axg-audio: remove useless defines
Date:   Tue, 24 Sep 2019 17:33:52 +0200
Message-Id: <20190924153356.24103-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924153356.24103-1-jbrunet@baylibre.com>
References: <20190924153356.24103-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining the number of each input type is no longer necessary since
we are not using the clk-input hack anymore

Fixes: 282420eed23f ("clk: meson: axg-audio: migrate to the new parent description method")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 18b23cdf679c..60ac71856e5e 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -20,10 +20,6 @@
 #include "clk-phase.h"
 #include "sclk-div.h"
 
-#define AUD_MST_IN_COUNT	8
-#define AUD_SLV_SCLK_COUNT	10
-#define AUD_SLV_LRCLK_COUNT	10
-
 #define AUD_GATE(_name, _reg, _bit, _phws, _iflags)			\
 struct clk_regmap aud_##_name = {					\
 	.data = &(struct clk_regmap_gate_data){				\
-- 
2.21.0

