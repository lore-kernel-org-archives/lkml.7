Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC8C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562CC218B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPkyr+PH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbfGWMLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:11:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40327 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfGWMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:11:07 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so81221720iom.7;
        Tue, 23 Jul 2019 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RfcQDeXv3vi4x+f0TWtpD+QCoOrOE8bGEkTmKPL9PsM=;
        b=qPkyr+PHSqzeDPM0m6/PNEJJas7OaoN0n2nFK8voa4Ev+5xSfB+4F6dk2pLlcf+9SD
         47YTXzrFDZYE9z5UPwms31LN578noNIRHJ1j656eV2gUYqu171V2SAoP3p4RDjVv8yOC
         hX+pyDhufX8wiqNxJolSSKvmmwtTbS5dgM9r7ls1tGgbrX5+gFtm/fhMm5x28eB4KOMD
         PtxA/fx5V+AcPfIQhqJJmhDXUsMPZ7QBPnPPEESul+cH0psWJ9igkeNKRLPjmOScrP6B
         9BL5So9kdxdQ3hGt7IA+D+NvSlo/cb8PGK7Rdr7GrfgYh5cr+ylx4jeJNOM2GwDAs7RM
         r5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RfcQDeXv3vi4x+f0TWtpD+QCoOrOE8bGEkTmKPL9PsM=;
        b=bzg2bUclDCMZBWhlFCRzU8+f/XkEeGpSYJBI+PlcUnFxXITGKyXRXeAWJYfQO8GDer
         nLhmCvZ/9vOis4QFBqNUVHz0KlGslvsVPGNPp9fJPB3QqdQDDTHDSksLSU6Xxex9nyOP
         CWm/xSXtetv3xPzHfofMVHb0QjfFC/2HxVsaml0KmUvYBHNkKT8XLrWe3HYaL6KXmGux
         MiZkA+ud6aTc5wUF6p66bvX0WH3TSsNkXfT0nNTw6pmZC1SJybtfT7sTNJ9hwFmrt5Kt
         yOvCYTol57nAR84CZ3yzfaiRgUdvjJfBG3krGbvKpYcvWMXEel72asaCZ6xB08noiPbS
         enVQ==
X-Gm-Message-State: APjAAAW6OhXbxK/A0a0CV7s6qnROtI1G8eNWafMSQDDen6S4fdqPp8lu
        SNd1qWHMuUK6iJ3SGl1z44E=
X-Google-Smtp-Source: APXvYqxkztg/xfJufiOkhmGbLxOjIO5U47Sjx6Mzk5DuGLVff8s8gwJqzW8JPIUDEY8r9zVDS18ZsA==
X-Received: by 2002:a5e:9404:: with SMTP id q4mr8566734ioj.46.1563883866034;
        Tue, 23 Jul 2019 05:11:06 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id k2sm36656076iom.50.2019.07.23.05.11.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:11:05 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: da850-evm: Use generic jedec, spi-nor for flash
Date:   Tue, 23 Jul 2019 07:10:42 -0500
Message-Id: <20190723121042.28634-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logic PD re-spun the L138 and AM1808 SOM's with larger flash.
The m25p80 driver has a generic 'jedec,spi-nor' compatible option
which is requests to use whenever possible since it will read the
JEDEC READ ID opcode.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 5b2b1ed04d51..f2e7609e5346 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -281,7 +281,7 @@
 	flash: m25p80@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "m25p64";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <30000000>;
 		m25p,fast-read;
 		reg = <0>;
-- 
2.17.1

