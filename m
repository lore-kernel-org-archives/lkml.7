Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4750CC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E08C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BAjhFYlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfLLO7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:59:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34736 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfLLO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:59:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id f4so3807493wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38rJqXHZjcXBB4mvoplhT0cjvb8m/n1ml03uGyFv6p8=;
        b=BAjhFYlBWOTrrPM/C9ckV2izA+EnfWmSdK6mkCEW2UgO0HYqc9UsNUNvlR9dMjSz3d
         JN/hsxtteUqQnVmCQTq47mq1PGsivh5lrl/L9IxXalWCBN+PXyN1IRn2UAAiLCZy38Ib
         QM7JI6e1KmIZiTlPr1iQ9AwNLxdAhXvlMLoh0s918vX8BQa4T0PQZ5BvkTtSn9nkH7KZ
         Gb1uPRkKtyaYYHcrghm7sgUeBUkwrVRz4szHrNowHW4erZxBSSKN3cj3CG2BHxAXBYBG
         FDEIJd0nCGmfF1olDD6WX+uLg16Yr9YeUh7CT1T7ghUV/2KZC9h1gZ+lgpux9niZU7zw
         /+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38rJqXHZjcXBB4mvoplhT0cjvb8m/n1ml03uGyFv6p8=;
        b=cOGy1b6rw4L9FND5Jkm2zOVihzurJQn9kOTcCLHcVj0IFgXkq8sySC16ExAxytHmWp
         qdaX299dsOiz5EnUqMsmo4LUvQJNAiFJBJPv3lesS1TTAZtdzfsRhstfHirxCD1kU5YP
         /im2hKKtVMdo57dsTiEIfTFUKfzxr2+dTw+Okn8FtfFh+Ir3H+aoriXu9mdeTVsYDAwe
         XiQzW69AAQm+qd/FEmPgwgku37YVkTS+3pelh2dNXaLRRh/0olXTDPXKRIjWfzAHsMCC
         5o7FeGO1e90FkA7YW/NagbYdmCmt1qL7/nuc4ae+s8rrhsXqkeXm0hsgVK0UoAl4di7C
         vK5g==
X-Gm-Message-State: APjAAAX89yFPzHWKl6j2+qWnwq9RJInkvZ4qj2BsA1d6nQtRLIsxrwkd
        6VAaqpTjR51/wT4rJn+tp1cHDA==
X-Google-Smtp-Source: APXvYqwKa3+rSD2mxWWJuNz1Hup01RbVsGslqsIbH/oJIm8YXhIy9SEHl7lcDD/GNrjJTphnr+Qgdw==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr6750643wmi.10.1576162769121;
        Thu, 12 Dec 2019 06:59:29 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h8sm6670292wrx.63.2019.12.12.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:59:28 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, khilman@baylibre.com,
        devicetree@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson-g12g12: add syscon phandle in cec node
Date:   Thu, 12 Dec 2019 15:59:24 +0100
Message-Id: <20191212145925.32123-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212145925.32123-1-glaroque@baylibre.com>
References: <20191212145925.32123-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add syscon phandle in cec node to activate wakeup support

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 7fabc8d9654a..98c6a1d1d035 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1899,6 +1899,7 @@
 				interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&clkc_AO CLKID_AO_CTS_OSCIN>;
 				clock-names = "oscin";
+				amlogic,ao-sysctrl = <&rti>;
 				status = "disabled";
 			};
 
-- 
2.17.1

