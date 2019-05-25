Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A15C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520A5216E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krobs59/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfEYQip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:38:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52591 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfEYQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:38:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so12234473wmm.2;
        Sat, 25 May 2019 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kX1q8iX0X4303ErWm6lM+rRst5YhXcgIu4cEhOJHl1c=;
        b=krobs59/49UbKhHuTP/YivClJTfexdgqOLwxGxG7GrdN9zj5Hh1sdevqbbAozFjouY
         O4tDua3cJoczqnfx+35v9XOguSH+4JB3LU21g3tBp+yKNIYc5N8I16BaEhhCF7+UOYEH
         s5HYSKrpiLu1F4z/iG6smjT4555gc0q/CjaFgZTUNtpscNq9F5ukZVO/ItzEegqm32IB
         LnacyjXEnqjnfhSnTHfUUQAJ03tzRslVmMSjIP39LIu3H6An/RqerVO1P2PzqmMqrsc6
         x7SRuIDscb7NVByOKxyYEUtHae6KNIe3w4KAbnRkHHE6A1sOsG6ARUnntOOGqAb6uq17
         zuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kX1q8iX0X4303ErWm6lM+rRst5YhXcgIu4cEhOJHl1c=;
        b=QzhfDvC3xEvW5RaUP/qn/SBGj3KSScgjvlI7igjq3STuqQxKdo8G3rHjwDa+H92ZAt
         5TVRt+m4AD1gp9LTZn/N6Wi4v8TVC0iT3u3XXvHp1/W7NWf7e4sVIm+ym0P0NYMtlYzu
         IUcX/hysuDtCkUfnpjtFZnaJ1U8wZU22ROVUKOoKRH04Bgv6QEb3LtOiArkmzBeb26mR
         F5qbuZbgnVEyxCE8hM3Ij3EM3PHdeZveSx+GgK4WEf5AicZ+ZBmxM0yf+LCcSyGyAzvZ
         15j/Ng5VzY1MQIv3xDjfzYLUsOGqvCv/N6D6YjAnqRZv1iHXEcvKmcAByI0SGl5O5sBu
         MozA==
X-Gm-Message-State: APjAAAXqLSwrSqIQCWvavi9gwHevYPV84m1eH6TsLRnlXopaq5F8QpOo
        tSPyi9euZTfOGaZAPolwvkg=
X-Google-Smtp-Source: APXvYqwH0lslbsXMD9wwixNplf75D7OjGQDY/HX6QdZZ6L6hQd2DzjzpVOz6N15Sq3zf0VrRJfVI9g==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr20897671wmj.108.1558802313160;
        Sat, 25 May 2019 09:38:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id f65sm9306498wmg.45.2019.05.25.09.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:38:32 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 7/7] arm64: defconfig: enable Allwinner DMA drivers
Date:   Sat, 25 May 2019 18:38:19 +0200
Message-Id: <20190525163819.21055-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525163819.21055-1-peron.clem@gmail.com>
References: <20190525163819.21055-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner sun6i DMA drivers is used on A64 and H6 boards.

Enable it as a module.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..b535f0f412cc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -614,6 +614,7 @@ CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=m
+CONFIG_DMA_SUN6I=m
 CONFIG_K3_DMA=y
 CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
-- 
2.20.1

