Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17890C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06CE2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eY5Ijx4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfJNORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:17:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41129 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbfJNORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:17:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so4073691wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMvLKdMW2yszyQrYkGsmywM/YMlu6KRc8iq2yfQBOJU=;
        b=eY5Ijx4QWTlhlQGgOpdrVKEgjA20rWFw2eiZwRKaJUwJG/7aYuLbxNjxklme848/FJ
         bZIENnbseJ8mKmmwXVSzonk7Ng1vb6vhsbHBsJNqNAmUllpNX8AX1ucQG8nUQtVatNSn
         sFOIgOQ9gV9zZjtGU0jIjQTaRE9DBPg+HEMIyXkmO2VTK/khiMwWsvhrac4wYFbgq+Z3
         vE5xtZZ0RJ1pMA7JuOvXzAaOGtggmD2NXmqcdm4f6tWycPkf8RLCBBUsj+BrcLeomLtJ
         mR19XkB+Lfc1ufptniAr2amT/joX/dioGuQbWLAGoXf3f64nUyhxO6JQtw6i4rFn3BMz
         quqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMvLKdMW2yszyQrYkGsmywM/YMlu6KRc8iq2yfQBOJU=;
        b=NgH1t1sP7QSuCk6EY0PyUDPwF8TMk2JQyRSjrCFoODSweqbNHsBYAtbvdBX09Gu/Re
         TrT+vmL6Bo67wOn4f0ZVFoxJOX5xKqloTyPWsIi5OTkMremhYJA6cwYYvGWL0pvax7PS
         aBNrdYShxMn7lpmHaMLCIVuYWM5ZE72kEmAJKNqUQmIAFpAHmvNoi3yACRYbjSiScLrH
         BXpGMZtZ+7oVk8w9czpAjKLSJw4pL99lM26BLX59fUkDeammq25BFHM09o3aezQY1iJZ
         nPSzwflDZ+Qa0wbvOovFTL98Lpg8EHHPOAOSQB8AR7U4ejvvhVA5227EWYN5lYsGOyZJ
         sU3Q==
X-Gm-Message-State: APjAAAUH0k4dp6DfCfCKKdVsacqHg6VAkcVDEpOz/xuU5IRToviylQPu
        T48bWAi+kx3gJRT6Pa1gbswIu1w7Pbf4Tg==
X-Google-Smtp-Source: APXvYqxYpJiFTdR6oysIP3BylyvjHRtG6AcTsX9/NO35uydOOjXlwBQ3nkYdCfVqNkSILXSLfHU1UA==
X-Received: by 2002:adf:8526:: with SMTP id 35mr300767wrh.266.1571062641346;
        Mon, 14 Oct 2019 07:17:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t83sm42708624wmt.18.2019.10.14.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:17:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Tim <elatllat@gmail.com>
Subject: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for disabling SS instances in park mode
Date:   Mon, 14 Oct 2019 16:17:16 +0200
Message-Id: <20191014141718.22603-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191014141718.22603-1-narmstrong@baylibre.com>
References: <20191014141718.22603-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation with the information related
to the quirks that needs to be added for disabling all SuperSpeed XHCi
instances in park mode.

CC: Dongjin Kim <tobetter@gmail.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 66780a47ad85..c977a3ba2f35 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -75,6 +75,8 @@ Optional properties:
 			from P0 to P1/P2/P3 without delay.
  - snps,dis-tx-ipgap-linecheck-quirk: when set, disable u2mac linestate check
 			during HS transmit.
+ - snps,parkmode-disable-ss-quirk: when set, all SuperSpeed bus instances in
+			park mode are disabled.
  - snps,dis_metastability_quirk: when set, disable metastability workaround.
 			CAUTION: use only if you are absolutely sure of it.
  - snps,is-utmi-l1-suspend: true when DWC3 asserts output signal
-- 
2.22.0

