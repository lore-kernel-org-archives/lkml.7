Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B29C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF29C20879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="elbZGVcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfCRKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52728 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfCRKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id f65so12315090wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GObn4uv/LM1BtjvUD8arU4OqaFNJ41INPjbZaoMAVI=;
        b=elbZGVcJhcGwRNgZIxl4MFrmm3gWFgEidwms3mu//qxVnxyLWaUvK8x0JTCCas+bV9
         uygsXyy4NhpyBEOAzlepzLa+3gZ3TE1IuZLdj3LkBWD+T2fNnjfe4aU6FpKBGH4ungEG
         BcN6EHyeLdElSOle77dCXFo0AAeNi3WfpN1yGSHnpmKuMZPqW2wOr8WN8OGweVQDm22Y
         hMfsQe/S3aKFPDBm/2apq/S/XXNXNPY0nTQH6hhC6+zH2wc0gD5PL/z3wo0q7Lf4gl9H
         Azdro+i70MZG76WXwNZ08A9bE4EnfglqlXWKYWCLFpvHl9d2T9riS05slJyOjUsvLAdY
         t7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GObn4uv/LM1BtjvUD8arU4OqaFNJ41INPjbZaoMAVI=;
        b=mMkrNQ0KTv25mfPRLUPVfMz40Q33+mRF+0pmWXI/xmg58gIckjYU6MOUc953aX6xy4
         rQ9aU4gR6fjYSNUY9IL/O3SB2GzVMdh1i0JqMzf4yIAK1/8bh3OCp89pMFOOt736kha4
         NvLsiJFInY87Sd5uYHnLJQ1TNF7ITaS+c+CN0x+Ii0Dh76/ZHqpuyeRV5kNApbIwpX7y
         /yAHOzadL3PVdZBf+HUKSfgM6jFAHeK8UE7FmQYeIP2/79enG1xYwtTluwJTOBeWgNcx
         RzhHwxa2mF/nu7PhIZnuwYPu5Z4qU8yZaYsgz8nyBH+6uV0rY1iYauKrD96roJJUxTAZ
         77nQ==
X-Gm-Message-State: APjAAAXK3zN/UBVJu+eLimQXT37qi33b9bD2JsYAkGp+wKzmAuucTkYl
        tVYM3iH9JOmoAjgWLy4Ob5EMV9INrQ8ZRg==
X-Google-Smtp-Source: APXvYqzNvpG1L663xGIz3PBfy4ggoyJ0FBb/h7m17k1nF9dI6Gn3KC7L/AwlWHX5NQwvxVmTkVbjzA==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr3826565wmk.133.1552903511125;
        Mon, 18 Mar 2019 03:05:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] arm64: dts: meson-g12a-x96-max: Enable USB
Date:   Mon, 18 Mar 2019 11:04:58 +0100
Message-Id: <20190318100458.5619-12-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 and USB3 Host ports on the X96 Max Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index bc152b1863c3..b9721bba9255 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -107,3 +107,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.20.1

