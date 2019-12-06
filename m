Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F1BC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170C62245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MObQOadh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLFKCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:02:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53275 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLFKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:02:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id n9so6649133wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cCfs61dLVx99fBZ8UFqKBrRs+hUJEpQvqJWKvBMa08=;
        b=MObQOadhYDBbu2EhvJplj3lYX23ZswIvvTlFgDEbGop7S13xO0RHWB3A9+o+ulvTMI
         a08eVr1T8OxYHDi5IiHrdP47EFegmSYJwFjaCYNt7KDdFkWgKQ2WXcswoHYFYNRdbaRq
         Ctytm+wjPnbLnYhfm6U6JYbN2vR1EuAel6sKkVRO5S9t2uv2OQR8saPMdNvcP7xC4kNP
         SqDCvR6r4kwHkSdZsCvW1WpPzmJMp6KTmniuSrMNnN/kHQKcaqEU+EFcz7t6arJ4a+kP
         2e67P2Qm49H2vHiZoIbD8PJTmEYVE1JWbHeCO2qeWbmPUw90J2xtTIPa6ZrFjA2B4R9e
         SfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cCfs61dLVx99fBZ8UFqKBrRs+hUJEpQvqJWKvBMa08=;
        b=Ra6qhC1SIlZJ+T3SnL/YkxpW9Re4hR+9z0KhSKt4g4r1lGwAJx4xf/AV9A9U+9q5A0
         2OWZsfFRIRgnIaeIx+h8VlemsxpL046+eWDZkO80lw/PNg9E98hW0qT41CnoPMuZpd90
         Gpxky9zB0832TNnfnm0Hi45UI3vvlYVOmCDaaCwt4G3Op8s3R2OALI6YkSCPFKgD9z0J
         3tuzmGqU9rbQt1XBGb1RtBtvQT7IkA6R7ALCvBlw9MZ2r7Blzk6wwWF3s67yg9d/4CbR
         XFOh9/DeOjsFwtrnYJn2DbgKM2ZsjuTpnCM3NGJdje3c1H3P7qlE50Gkii6z55b1LBl6
         iZxQ==
X-Gm-Message-State: APjAAAV/4JyDNPU/RdEtQG3MDv9l7ip5pi1j5EphrHtKa2ifhs1HcAVH
        k1vGzkTsRS9O0vfCEfqjKasvDFC1PzE=
X-Google-Smtp-Source: APXvYqwWyugvW9+TBQfgxQt0TCNZmAm9UhZCkAv4q7Ivnw90ziAaZT6TtZbHNwqGrrWBE5d8nIgB4w==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr9437306wmk.37.1575626547640;
        Fri, 06 Dec 2019 02:02:27 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d14sm16372314wru.9.2019.12.06.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:02:26 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: amlogic: add libretech-pc bindings
Date:   Fri,  6 Dec 2019 11:02:17 +0100
Message-Id: <20191206100218.480348-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206100218.480348-1-jbrunet@baylibre.com>
References: <20191206100218.480348-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the libretech PC form factor

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index c6a443352ef8..2660ba3b129b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -104,6 +104,7 @@ properties:
           - enum:
               - amlogic,p230
               - amlogic,p231
+              - libretech,aml-s905d-pc
               - phicomm,n1
           - const: amlogic,s905d
           - const: amlogic,meson-gxl
@@ -115,6 +116,7 @@ properties:
               - amlogic,q201
               - khadas,vim2
               - kingnovel,r-box-pro
+              - libretech,aml-s912-pc
               - nexbox,a1
               - tronsmart,vega-s96
           - const: amlogic,s912
-- 
2.23.0

