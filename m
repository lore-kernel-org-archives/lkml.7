Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429EDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED3E214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaIfYoJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDXWuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:50:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35848 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfDXWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:49:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id l6so3600078ljb.3;
        Wed, 24 Apr 2019 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgD/uImHb6NwkHJPZVMHXtBTkKsMvl+ZXd/c4dnETFU=;
        b=UaIfYoJlqGJ/4aAiJufB+f4/7t4ZXvLF/MHVxtD+XNDaobucMnu6yk6+PylyyAhoiN
         A87lHLJu7n4FfWmhTHFar/YKL4+vaYDpwBTw820Mp1BDbKaGFOi5ula3jP9xzD5ioxe8
         nIEkKou80MH//Owr5iGZeAh/IIlJpamyLbIpIaiU5u7zjlc0Hl5dUCiFzj1di/hMIDl1
         L6LVIoEZTcfnoaUUZC5Z5akt2pH/pwcakbVRwo7LMc+JBwE19DjdC15zZD/QE7ZuJKUV
         JzI9xcf4hEPS/qLbfJMWeNHM2a4IA/0RJbJit8ev3QFjZUYkCGh41v3aIWU4oLPWAHGa
         MWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgD/uImHb6NwkHJPZVMHXtBTkKsMvl+ZXd/c4dnETFU=;
        b=BmFjXiJcQB47AFAx/oXhx3d3EPyfawg3z3RktkfWQC2Okv96zBeNwVx8TDa4qQ2xnh
         SThJh+EpypSO9Yw0eSMr+i80FtOs3l61iSP/Jc3NxPYgARShZM/5TK81MLTwUT+II+nN
         MabvKDStENRJaYqM44bbHIAdzhzBE5KrxYIRB7zwFF1EkBcFFTfOnnoZQkHZTe7kktC0
         /3gGFqW6hNEMMpUnlvG4konyzllrpiPZdNIiEMbdaMkJIYUJYmDyyMpr2BX96oGC/Ty1
         21NeH2XZSlcBw3GIyTk/ZtJeulRrv53QyOBcpf82M5yY/6Sv7PSteBWTUTyhSaz/wnPU
         Z2DQ==
X-Gm-Message-State: APjAAAX1E+q+7ZJgj38kj6BE8xkhNqP6CmROc3Ce8Z/umb73LSxcXYz+
        RYHNJwqcCOXOcmG7ZVl6Nho=
X-Google-Smtp-Source: APXvYqxkL8zBZiOA3g2PS2K2J9lIYhxF5pMlA225Je1b0n2Y+u9DrwLeVWoaI2WnYaiwArQBYeA14g==
X-Received: by 2002:a2e:4a09:: with SMTP id x9mr16437699lja.19.1556146184710;
        Wed, 24 Apr 2019 15:49:44 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s24sm4219879ljs.30.2019.04.24.15.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:49:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] dt-bindings: mfd: max77620: Add compatible for Maxim 77663
Date:   Thu, 25 Apr 2019 01:48:58 +0300
Message-Id: <20190424224900.8018-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424224900.8018-1-digetx@gmail.com>
References: <20190424224900.8018-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim 77663 has a few minor differences in regards to hardware interface
and available capabilities by comparing it with 77620 and 20024 models,
hence re-use 77620 device-tree binding for the 77663.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/mfd/max77620.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
index 9c16d51cc15b..9058499051e0 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -4,7 +4,8 @@ Required properties:
 -------------------
 - compatible: Must be one of
 		"maxim,max77620"
-		"maxim,max20024".
+		"maxim,max20024"
+		"maxim,max77663".
 - reg: I2C device address.
 
 Optional properties:
@@ -105,6 +106,7 @@ Optional properties:
 Here supported time periods by device in microseconds are as follows:
 MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microseconds.
 MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
+MAX77663 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
 
 -maxim,power-ok-control: configure map power ok bit
 			1: Enables POK(Power OK) to control nRST_IO and GPIO1
-- 
2.21.0

