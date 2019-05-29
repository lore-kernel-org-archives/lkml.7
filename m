Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2EBC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA142075C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdY+eLvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfE2HTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:19:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40268 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfE2HSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:18:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so1021786pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P57cGd5au/pxCm3dCI4WNXQPVL3URAglM9O9Pw3PXWM=;
        b=hdY+eLvGd0/CiM306UIlYlfWMtUD0oWi2NeJfCEW3M1nQmrICpgsesO3HyKaK0tbMj
         y7O8PIRyWd21oU5g3cMRc6Gxyx92OfRUBsn71b9hnJu6eT07pqeokrxViFiwgDeWo4L1
         X/moRRWJHWBUiWe4vLXQdDybRCaFLogvlPCkpZ+ZvIUI2nzXy1/sSUYbz4rfPBjKWc9v
         jWg6cDG40Ivb3snKohS5Ql9LxbXYFmfycPxxU0G7m0lXW4VTpxwqn135c6cJ//RXUZRo
         AzYd9iebs3tdOMni2xVMMRAoe1UdID6Isza4RXCzaR1GPNhEcaBfFh+uqFXU7mM5SdCu
         HDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P57cGd5au/pxCm3dCI4WNXQPVL3URAglM9O9Pw3PXWM=;
        b=uWUYd5vg4Og3qNoAHvM4Yi8DivCh/rN2LV9Z+lZbkHz8QpzTg02siluIpNUJYmzY4t
         qreIBknrGvH//mavloSIF0GlKDWJGgu9S6/0cLfDAAY18sYUpJ8FFkdbMnKNAxMN3h4m
         l+je2wioYZ/0afK9MffA14MkgKqhTn7GmC2lxu1TJ4FUYo5nTdd2LLNSdjt/h51Ay6uX
         nLRxAdrdZxstPARkIDRrIawXlPOyoRXkmsLarKlm9scvKBE9mSMd8vtAtfrZPDy0tAb2
         RYQWYnSb2anOG8QFX44x7eBWtyHNe0YKYNv/cveV1DAd5PLgWn0RPDLoTQhP0PHfjS9o
         lIYg==
X-Gm-Message-State: APjAAAV+IwsML0i2T0TVSR1THVrSIaZP+MkNZJgO7qDvgaOHwJK+7mHb
        UmT2cmYvrRkAsTZM6PYUrI8=
X-Google-Smtp-Source: APXvYqzU/O0hkTUNdjazxjZSJmGmSvPWTsv6ggb+I3Z3g8OtTH+Y8bRN3EaXebun8KSunjKFkkaCpw==
X-Received: by 2002:a63:2315:: with SMTP id j21mr42017705pgj.414.1559114335066;
        Wed, 29 May 2019 00:18:55 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id y16sm32038938pfo.133.2019.05.29.00.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:18:54 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
Date:   Wed, 29 May 2019 00:18:43 -0700
Message-Id: <20190529071843.24767-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529071843.24767-1-andrew.smirnov@gmail.com>
References: <20190529071843.24767-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cabling used to connect devices to USBH1 on RDU2 does not meet USB
spec cable quality and cable length requirements to operate at High
Speed, so limit the port to Full Speed only.

Reported-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 04d4d4d7e43c..e1d8478884f9 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -805,6 +805,7 @@
 &usbh1 {
 	vbus-supply = <&reg_5p0v_main>;
 	disable-over-current;
+	maximum-speed = "full-speed";
 	status = "okay";
 };
 
-- 
2.21.0

