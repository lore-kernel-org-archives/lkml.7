Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20313C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88AF22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mVmbh45b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392531AbfHWHD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:03:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34296 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405019AbfHWHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so7632357wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQGMBKaIheYnXF/WLoo5OGX0tV7WLbdJIx9rXGOlw/k=;
        b=mVmbh45be4lh02qKYGB1ppWPUAXqpYSlKJfU62Y7zJ1xdVVEmByScDchKh+pHwEFRb
         5oAhmWgIVQibnTwD9F21vmyPl2JHo+goiEn3kA36QXesSw6b4tQelRGrTJ/mdPn5WGpi
         IazIx87rcse7UykBS/zFCfoQmR174qxqGeYUXDAXhiTkGrGMoOWgB5gHqKWQjh5zczK0
         Tdc3b3WJSAgyvnZlF6SGFhcd7F4KuIj/8otVnrc/SZjAdChl3RB8qgpXP3EUbwQEDUdg
         QlpVdTTr8ADEMzrwyA5MWOkVarTraqRMKR/Y8i1ZDTFGrSbwKSoprGIUh/0e2pmAEtN7
         uCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQGMBKaIheYnXF/WLoo5OGX0tV7WLbdJIx9rXGOlw/k=;
        b=k8ab1cBvd6slTNYdUZhw7i2QevCTs9DDjYAl8o+2oAIXZQI7TusFAa034SO0hR+kvp
         d4832J4aWasSpm+eBJoBuOSfF8VGbW919RVSHWYHq4PtzYf5U3yRM/ELTePt9rDuS5q9
         3BbsM4AdX5P8k4ws0puOBOGOAgWfHCcb6vZyo4zt4oeCFGoAT8dnTcfqtjzwYZ1Z83X9
         ABf08amxkTXiPFYs/Xzdu48Xmrd2ROyiIkjb9hR3Lh46xbiZ9/TkjuJd5hnufWW4txcF
         f5dLPJ4bA4LWxeDIgF6tYs05UK2ANVrQQAuaPpynwOdKc6j2w2zz6/qxVNgnItza75Ac
         OWsQ==
X-Gm-Message-State: APjAAAXEgkVR4hcNFIjrkBdErmGhf9xq+PDwGqGD2uqKFlKybr5sDplR
        Zi2uzuNx3Y2IRJbB8VVhQvn12A==
X-Google-Smtp-Source: APXvYqzwxUVLowuS3xao7n+i7OlRwLWmah+4GSU46RDQCt7NTemeu1LZlIIg7p8uweotJYEbZaHFCA==
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr2982750wrm.315.1566543782721;
        Fri, 23 Aug 2019 00:03:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:03:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH v2 09/14] arm64: dts: meson-axg: fix MHU compatible
Date:   Fri, 23 Aug 2019 09:02:43 +0200
Message-Id: <20190823070248.25832-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-axg-s400.dt.yaml: mailbox@ff63c404: compatible:0: 'amlogic,meson-gx-mhu' is not one of ['amlogic,meson-gxbb-mhu']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index acc2feb8fd89..82919b106010 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1118,7 +1118,7 @@
 		};
 
 		mailbox: mailbox@ff63c404 {
-			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
+			compatible = "amlogic,meson-gxbb-mhu";
 			reg = <0 0xff63c404 0 0x4c>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
-- 
2.22.0

