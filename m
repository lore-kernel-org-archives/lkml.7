Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540DA2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iplkALAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLIQus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:50:48 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46469 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLIQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:50:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so6123010pjq.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7j8A/bmJ0tivsU1R0/vbl49gfES1PujVpawMqj4L0dI=;
        b=iplkALAZMx+B4uudUY+CyOprIn5iQJqyJfp73EPWgJt3f5iTj/qSpIwRdArrIDAQ/q
         yCnhdG4xKbW/AUUVaYED3jlGQoTcWI9xdpyV9jN5begCp1ibEK0NSH2y5JtNaeSDSch3
         PxWcatN0Sq9JLZh+9qpJ2fMGREq6DL7ZFPxhZ95hyfckkDafiIy4FRtrXKEQ0oC5lUgh
         Y6NZPMKmmr3xRQtnY6FXmDmd6p/kLSCKwK7fqH+KMg+klPCRMwc2AFOANV8Dz13UIWav
         Gg0xJUb10//xoqyfU3OYaHP2YXwDGenQxGDGMHAEHdLUcj9KITsT/bsKMjfNA0zoDNyT
         r+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7j8A/bmJ0tivsU1R0/vbl49gfES1PujVpawMqj4L0dI=;
        b=svvBqtzmp11NbKdbOFx/VKW0uFhPbFERuqwFXie9RcMwgsIKClkEx3PW4MlsV5EqBY
         Cf0Wiu4F7x1oc91CXNSCoLibpNk49nM4+7bj7A/uI+k5bNsgmK37Yi5ELaqCttES+q6q
         MorNuuwf98VgjpuBG99da24BRtxWDtxwFx+uaG2oAIMe/9Q6w7qwVkwGEUJfyt7TI5JR
         5Yxy3ibEu1nbDpGdv62bOhsrR2yuMF4VHaiXVwwz4Lo7vYhdSX1xKSyfUu0iUFEBF9lk
         2MRIv1NcSOcZDLxG1Jwf/RFXtYX6u/TYp8X3yBu/RTWQSPoF7kLD8AxtEwU8UfmYF9EC
         4dPQ==
X-Gm-Message-State: APjAAAWMwQVkoaW8yP8kOGbdgujdhUeg4GOhWF3DrLeX3i2qDyg50tXq
        5sCFO9D4Ly+8M9rEZz80Dww=
X-Google-Smtp-Source: APXvYqzQjCtuiV7fSG1wIeHmk2lOV/ALk5dveVljihJCp6vzBXm2UhInYMiasdvg3HGwQmtmb10w1w==
X-Received: by 2002:a17:902:7d98:: with SMTP id a24mr30813869plm.321.1575910245353;
        Mon, 09 Dec 2019 08:50:45 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id c19sm18299294pfc.144.2019.12.09.08.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:50:44 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
Date:   Mon,  9 Dec 2019 08:50:18 -0800
Message-Id: <20191209165018.21794-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191209165018.21794-1-andrew.smirnov@gmail.com>
References: <20191209165018.21794-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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
index d062c86e0762..ca0b81c41998 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -890,6 +890,7 @@
 &usbh1 {
 	vbus-supply = <&reg_5p0v_main>;
 	disable-over-current;
+	maximum-speed = "full-speed";
 	status = "okay";
 };
 
-- 
2.21.0

