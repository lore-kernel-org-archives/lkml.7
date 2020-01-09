Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C9C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979952075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h0ow4VeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgAIKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:15:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33775 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgAIKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:15:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so6814998wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cskzhIjwtS0ZVRi8zMZa+kHk4M1kBjG50N69LQL60P8=;
        b=h0ow4VeStV9ER/XHasMs74E0+JCwgBvbicr55G654K+QgM0E3o7aCk/LftohaQ/mam
         K/oPl1DN9ogDVNFnXQbG619dEI3IiXEBVkaAAHXUe7T8aypF4zBkArvDclU6nylS3EZM
         RsYFqnDW/LsLHvnfFU1VGIYFweyPCIYpDVrRkeaGDhB5ogdRzQQHJFTmBSANZKatHOHJ
         l7suu9Wc/eeOJCwarOUn3veAcF3NA986bAtFIgIh/Xi8GhKX1w68ZtCg88Sk7IclgS5v
         FaOPmjwSuVB0QSRe/FpXDssCBKIP/At2DrBAd2pK7bu89NvewLGccxwZioH4NbNJ8yvW
         2kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cskzhIjwtS0ZVRi8zMZa+kHk4M1kBjG50N69LQL60P8=;
        b=OmFNIhG+Q9HGS8gsHbcWNehV7Bncxs/bA7cpmgWA3Kn2qaLLuCSXb30inAg7q1veOl
         DL4LoHaQ0Q3BPwGuWk2YVEimaMgECFgnfZia8f5o4MvuddK+qQmVz4Aw9kgd1+VxuFS/
         2GzBw6LL9645JUOy3XSQtlWhv1kvwTJ6K33oCGRGDezPcEzYvltQmsCbY1VYYm4eQfPd
         No6plj1WI1s0ASbZ6VomYIWp1PgSqc1koP8+n3xhidV6321SCv7kTFKYqNtBhuQ1m0+K
         cNxW113+JF1Y4NZ3t90neDPnFyZdeboxnUiCkuXg8V75GDx0Z/EBv7JFzgV/pV5WEj2t
         7KZw==
X-Gm-Message-State: APjAAAWjygWi4xFXWB7nxB5z5in3QnzkO8lxMd+4GWIYWFPpI8mYrWOY
        OaMlNK9Isi7Bcfg5nuBNDb720A==
X-Google-Smtp-Source: APXvYqwBJeqcb+JtzqfcXa3IBx+RAeZpEMUk+jeaEw1/iu/wKVv0xRKabBxEgIHfrQJo/hYAfvxhCQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr9833559wrx.102.1578564939054;
        Thu, 09 Jan 2020 02:15:39 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q19sm2250460wmc.12.2020.01.09.02.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:15:38 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>, Tim <elatllat@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] doc: dt: bindings: usb: dwc3: Update entries for disabling SS instances in park mode
Date:   Thu,  9 Jan 2020 11:15:33 +0100
Message-Id: <20200109101535.26812-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200109101535.26812-1-narmstrong@baylibre.com>
References: <20200109101535.26812-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation with the information related
to the quirks that needs to be added for disabling all SuperSpeed XHCI
instances in park mode.

Cc: Dongjin Kim <tobetter@gmail.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
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

