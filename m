Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2734EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 05:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B5421D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 05:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSiBR/IZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfJDFlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 01:41:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37532 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbfJDFle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 01:41:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so2608906plq.4;
        Thu, 03 Oct 2019 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKVLI9LUqHPEjp3RS7mC+DCEnq9WI1TJleS4Dvszv8U=;
        b=iSiBR/IZvtIKmtKsBEg1fXjUd7BM/mtimLVfxJcmzcJZHuweE259D07Hmy+3/MWnQY
         Z8RAYJDJepnKC13JaqVKO6RfkeuFBbR28+lOoc7cnadTlpS1XI2DTtgZTEVPPd3bhcD4
         C9ud0mFDJHUXpXGFYStQm8qqh5djbXa/nrYYRMTUmB/+ZNGJTw2zwYaPkQcdDDhgRx7C
         9c2AZCjEaD8lI9wXWwqDF2jVYflssod3yWyFW9OpmFD+fEED/wZfNbjrALLGNxw09Uxg
         9g5RD7Jmz54At0evGtvhSxKGa8G8Bl2y1ALwgOOQthJOEA4PsTFVi0FH3CqURhb9Znlb
         VPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKVLI9LUqHPEjp3RS7mC+DCEnq9WI1TJleS4Dvszv8U=;
        b=HyA+rZHCDcJkycZB0i8VIFCVO+dCRKHS1S9JTVi/jWkr+W9im3AnPPi0K5E+yDzP9g
         Il4tNUQtniU9XKd0muyrSOWoIgMApiz19AEGu3iKuVE0DJba8HTLttaeiX4E/lojhFkS
         B5Ws9V/DBEE9nGIpqjE+9Kd8IwJcEEIDIsAPlffyz86ogqKW/x26bbPGXKZtYyQjFdAJ
         U5OMdcSwg3Im/y/opQxg/DhjSlHZsEf97eNCGAMhViqZ3RLRx8FDVptL6kjnNX5tGnjn
         5Mdn7hKnLRE+dJITDJ1CroqiicJoWhIxTwvzMCWrYXCxTcEagShr83HUYkGE/RLnfoBR
         OuRw==
X-Gm-Message-State: APjAAAX/SG4F8uQ6H0L5mLGSTUS8w8S/QctS8ipusRA/Xa1ipErikhxL
        aW2xL245qr+qB7eq/Z8Uq4U=
X-Google-Smtp-Source: APXvYqxq2ZMNDYaJCoOc9QDAeCL1dkqqeXLO4Zk30uye0zXZCYarwbW9lkud/Ozlu47vWdC7smk5jQ==
X-Received: by 2002:a17:902:a418:: with SMTP id p24mr13411978plq.312.1570167692424;
        Thu, 03 Oct 2019 22:41:32 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id o67sm5651892pje.17.2019.10.03.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 22:41:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Jeff White <jeff.white@zii.aero>,
        Rick Ramstetter <rick@anteaterllc.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-scu4-aib: Specify 'i2c-mux-idle-disconnect'
Date:   Thu,  3 Oct 2019 22:41:15 -0700
Message-Id: <20191004054115.26082-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify 'i2c-mux-idle-disconnect' for both I2C switches present on the
board, since both are connected to the same parent bus and all of
their children have the same I2C address.

Fixes: ca4b4d373fcc ("ARM: dts: vf610: Add ZII SCU4 AIB board")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Jeff White <jeff.white@zii.aero>
Cc: Rick Ramstetter <rick@anteaterllc.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Shawn:

If this is possible, I'd like this one to go into 5.4.

Thanks,
Andrey Smirnov

 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index dc8a5f37a1ef..c8ebb23c4e02 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -602,6 +602,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 
 		sff0_i2c: i2c@1 {
 			#address-cells = <1>;
@@ -640,6 +641,7 @@
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		sff5_i2c: i2c@1 {
 			#address-cells = <1>;
-- 
2.21.0

