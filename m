Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71008C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDAA2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KHSBv5wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCSVwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:52:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45479 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfCSVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:52:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so485221wra.12;
        Tue, 19 Mar 2019 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aX+bb8PFceeKnvljRRNWRZVPF9zpndQkTw/LqXznMw=;
        b=KHSBv5whuIBpgvpLhjjokLmLSTEZ/uXVHXIO27/PtQA77s/WyBD/kG45tsgx8EsgeL
         XigvDO3WEE3UEf1vW2WrXCYBESSs0LrdKuJendT0zMebn5BnZvr9x5XTPB1au2iQQK3t
         tf6MtK352ymubqR23+0h/SZgspopnqR2TTdATpIwFz+/I3H/IrHM6jjHwHSLfUB29PH0
         iSROYilOPuerMwV0rRGIAo2wA4vtz4IOZyrVsviIF89gDFTBPgHXJDL09gCkO6dN5TMH
         jVzFecNgq+epxyowJIrO4tkX62zMfd+ZDTaeJvkHlEIZdwDH+LdfP5bbEgZTJgu2/JFr
         UFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aX+bb8PFceeKnvljRRNWRZVPF9zpndQkTw/LqXznMw=;
        b=TeVd/yePJLEQvZ7TwWH1z5PIr3L/9iTUBAQT7Y18LtkdZMQNGIccmoOjXsDDYWvZp4
         kVSq38U4ePAdUlREoe2C08AE5hgUTcW2Z3kgV7/NsPt1e1X1UB2VL8mOqoXvQuHf5oVN
         uhCaLiKlUwQjbfAVqJMj4Dvguua1pUntWePjGWY8HpC9gnCFk1Fblt9ig0E8G6+STrMF
         9pauFa8zB72ze9nQCYOs3SoVqOE0uMD5kuQGNzU7EZKKyj5hsyi4zGXN/zmzk7tSY9Fz
         abIcQDB4z2kXDgJWhgFnO9m/ausuRecC2+psYNne6dFJxrgsz94sdpvk9kff9Qh4NaLm
         XavQ==
X-Gm-Message-State: APjAAAXm7mQQQGvFwknk4m4iSuAmAAY/WQP3xNC6Tgklqn2SWxRvTuTA
        AoZJmRYR+yx1+lmDxJ73dMDsO2Db
X-Google-Smtp-Source: APXvYqyQKqYVcz5jvdlqpOKm6it6HJfktMMvQuJooMU5aEuDoNCImynWbDshqwaRl65+djtMJlqqZA==
X-Received: by 2002:a05:6000:1110:: with SMTP id z16mr19302668wrw.28.1553032321847;
        Tue, 19 Mar 2019 14:52:01 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD739990039EE738515149D3E.dip0.t-ipconnect.de. [2003:dc:d739:9900:39ee:7385:1514:9d3e])
        by smtp.googlemail.com with ESMTPSA id c8sm56050wrx.6.2019.03.19.14.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:52:01 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/4] dt-bindings: clock: meson8b: export the VPU clock
Date:   Tue, 19 Mar 2019 22:51:18 +0100
Message-Id: <20190319215121.29340-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
References: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VPU clock is an input the the "VPU" (Video Processing Unit), which is
one of the components of the display controller.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index cd11628f50f8..2ac9469a1c27 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -107,5 +107,6 @@
 #define CLKID_PERIPH		126
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
+#define CLKID_VPU		190
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.21.0

