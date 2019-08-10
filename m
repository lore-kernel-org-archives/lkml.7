Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F84C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2167217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnd6S+DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfHJFaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:30:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34775 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfHJFaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:30:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so47118037pfo.1;
        Fri, 09 Aug 2019 22:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UosgfXx4rXCpr6ibQdnwjU3IwPluehmRT7Dfu14EBL8=;
        b=cnd6S+DBub3Od7fbxAslNjlYDsv5ue3V/132Q7Xf5VEoqcGO/DFlOhgzdxc1VaXJ96
         2PgeD2F10SWJaBt6QchPdzKipe28KCDHn7XEueb2a1Qmmn7b0rYA3pxnvd+MlRxLpK9S
         TyT1uhKHI7DwDTPH+EK09luy6RrTrsPoswDsPfOnoHH9BTFOG/zAp+kePk2ZFZB4nQJ6
         UlCaKIpk2um+gw3jipGxtsaJTly/AxqEDb+hPv+V9GMV56EzLzQBZTyBMP3aS0lgNXhr
         UAhG0lm88oyH85kLR0QmMPKTpdo+cW9JxDcL2fSw30jI1n6BRmnPx+f1Ur3DZz74F04U
         UX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UosgfXx4rXCpr6ibQdnwjU3IwPluehmRT7Dfu14EBL8=;
        b=WtNQiVxmToNkJJ39dzo/85Xj7wjhiG2dxo7Xu7nlWRJNWRCz9iDlYCwn0BIm9NyBtL
         ASuX2uad0KHdvQWqV31ak2fcGTzy2QlVgdlNOsQ/WlsQQdRvZaeQZXxfNHJNYnRGzdZk
         75Ay+jPChHqMQgOhB66X4JtBHA55C9auOe76c2vWIqE2PJ+WI2m7ZpefIczuG1t4QCoD
         xG5RHIlgjk+TcitFH8axGki8qL7wzLuOmjtArsTzhwmzW+DpPsTgQF6YcGVMP8rPcTLQ
         pD0x9/uQdVf2H7YksMa19vk0qOPrM1p9PIlv7oQ0ZVYyGCXCadfUraEkxx2nphrmj76u
         7Rww==
X-Gm-Message-State: APjAAAWN+7LQ9XjAyqT/83IF1hBJuqMwoZSYPAWnDapQJEib10UdsLj7
        B6mqwQhnFBmkBooDroldAQw=
X-Google-Smtp-Source: APXvYqzNvo1OGTUF4/A2gNYiIgcr+dkAqN2eFc1rbhbt9UgJhZ10auqHQ+8MqNVMZkpLbNDrfDMG1A==
X-Received: by 2002:a63:d84e:: with SMTP id k14mr20737624pgj.234.1565415012208;
        Fri, 09 Aug 2019 22:30:12 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id f7sm96704339pfd.43.2019.08.09.22.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:30:11 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 14/18] dt-bindings: thermal: add binding document for h5 thermal controller
Date:   Sat, 10 Aug 2019 05:28:25 +0000
Message-Id: <20190810052829.6032-15-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding document for allwinner h5 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
index f935b4fab8ec..2e28f5b33d33 100644
--- a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - allwinner,sun8i-h3-ths
       - allwinner,sun50i-a64-ths
+      - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
 
   reg:
-- 
2.17.1

