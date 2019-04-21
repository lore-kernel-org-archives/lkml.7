Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A132C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D5820870
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnDUIPFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfDURuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:50:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32927 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfDURtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:49:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so4817414pgh.0;
        Sun, 21 Apr 2019 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgD/uImHb6NwkHJPZVMHXtBTkKsMvl+ZXd/c4dnETFU=;
        b=hnDUIPFfrNnd7PDqA4WrOToorlxV1XtIn/CAGaFxIWIdfaMB3Sa5BfTwtUocC59z6N
         Hz7e0XCLgZCiYurAu10kQCNfL2cvQ3VWvVZxS3wYIKSfzRxdzsghr9XxaAG0OEATD6kP
         44Bv8voEdSd97vWrAHEhtIewr1KsFiRcvph261w5E/SiYZlhDWq3Vi4TQTNJLHoM/9td
         VXPxO04peYP5ZnLkfsp9U/y5lf4sM2vqtlmEqVWfB2YZbOLoek2G3P0h83kDC7HnvAop
         zTja9XwxQoF2XDb/38lmm2VWshmPzebuP28xODxCIk0rcht1dn46FmoGDjEQuDmMu8UZ
         57kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgD/uImHb6NwkHJPZVMHXtBTkKsMvl+ZXd/c4dnETFU=;
        b=n3wrQS99OaScoQYR2srwKKdI5PKP9N4Zcx6J6E7xZW6V5aV/W4taIoNDFOhgUsSVdI
         l77zpDh16ZD8VH17pbjX4+xFcO4PdNWgbTMAO7UWgpK7yksVJMdM0zYu7vHDWmXA8ZwY
         BsqLiIv7jHphgN0pFbybT4Y2Xz+Uv07HDIuDfmr6Hn8mRQJGoY9t6W88rDtJHRyWUdQh
         +FOJps9uWu4TnDutK8LT/0AYauM2ru87XJzxmK0cIKNyKlUQICt+HKV5qGMBwVAVg6kn
         /P9YA41iXOBM4SjPT/Dx5ccvCrQZFPwYOxPAOl79/0pmt5ftXm+rBTOkqrcDS3nO/Awm
         nKeg==
X-Gm-Message-State: APjAAAUKcgyFHH3TUbYK9KQmUvgah9vjoxjvM4vvaIoZby+UFTxAQ2Xx
        EhEJBcQHRMH01XZ5YhSsLEhh3aHI
X-Google-Smtp-Source: APXvYqwTteDTKGFFxT0wiWNmiwFALQu6twk7vWPTSkvyLwN8AJ8saaEJlo5LUOm93eYF462iPydyFA==
X-Received: by 2002:a65:5189:: with SMTP id h9mr14701933pgq.304.1555868991565;
        Sun, 21 Apr 2019 10:49:51 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g63sm16279233pfc.127.2019.04.21.10.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 10:49:51 -0700 (PDT)
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
Subject: [PATCH v1 4/5] dt-bindings: mfd: max77620: Add compatible for Maxim 77663
Date:   Sun, 21 Apr 2019 20:48:33 +0300
Message-Id: <20190421174834.9366-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421174834.9366-1-digetx@gmail.com>
References: <20190421174834.9366-1-digetx@gmail.com>
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

