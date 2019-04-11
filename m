Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C21C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B702084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTCKbcwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDKX1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:27:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45040 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfDKX1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:27:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so9466200wrn.11;
        Thu, 11 Apr 2019 16:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ze0w0xHnD895HKr27kyNg2YZ6tBzCpkGTUAT3n7kLKk=;
        b=DTCKbcwvPOeLpSLsKauvHp3p8mtYDDh0N23gAJW9vLaEO/i5y6dTyQfjDTXX03CvXO
         P8f6zuxNbMi2OW52RPyLaOkk17JqYDIMs8ngfTAh+sWawCdPyi4EnPsLDw3kFpYStOwN
         U+UH3hEWt7ZbrQ2Oi9nsPGF2RfwBPDfVUXJVgrUmQbd0rZ4HRGAZ+tnP2DuPgP/ZR0UN
         Eseq0D7UaYhtMiEK+/wC6m7xuIaGAGuTMoFA7Po0tLfgs93duKXUA30/r25wmjCKf7+s
         x8i2LgeN1YRFVCs8tMzgceVVbCyOByDceaGMfBMphbGQnua6mTElinkDkGfDk4cT0Xvd
         sP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ze0w0xHnD895HKr27kyNg2YZ6tBzCpkGTUAT3n7kLKk=;
        b=hQteAQkIZNHv1PI07/qaS+khtoYJzCJYkiZt34FWT/z2lj/+XkWYheUp1QdbBaznib
         QivUfiA77StBUaNgyjQxmDzbHAFP+lE+tgdOqrJgvuNw27N2RKBEFWEQp+jZ0rmdhUxf
         QCOikDwgDvm4PDotNJoUZOsDoy287ZhllgIkSBxO62DaCP8X4m6Q4Z3u+b+taae8EV0B
         /y3P1LWsoGhqbhjnlNj6D+bhAqLqcdhO2ePH4ITVxo/mz39am47ySwXGQZJsFgotL2JK
         fww2zpCWkq6O0b6oSpitlnGNcdJfH7aJCkpgbmgSFL6Zf+qMMHwIsbTUI2OLsFYycr3l
         tQyw==
X-Gm-Message-State: APjAAAXOo0PWNPqopzv656ycRV1CUREO8eb3L8PyzkYSlt9Neo7RaNEz
        XEvsxNAdVeXGePJiJkFWT6c=
X-Google-Smtp-Source: APXvYqxQTNUI4Xwqy//eYgW6cSNRX9kQA3NpnPGJEMfvb8/SZApTbUzAFY98T1H5yrjMP1uiQW6bXA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr34306936wrn.108.1555025237611;
        Thu, 11 Apr 2019 16:27:17 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id g132sm6355642wme.3.2019.04.11.16.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:27:16 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, claudiu.manoil@nxp.com
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: ls1021: Use different compatible for MDIO bus node
Date:   Fri, 12 Apr 2019 02:23:14 +0300
Message-Id: <20190411232315.19588-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it less ambiguous since the bindings for the Ethernet
controller and for the MDIO bus were using the same compatible string.

Changing it, since the LS1021 has the only DTS that uses this compatible
string for the MDIO bus node.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Leo Li <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index b4f2723ecd86..1a2a9509d9c2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -701,7 +701,7 @@
 		};
 
 		mdio0: mdio@2d24000 {
-			compatible = "gianfar";
+			compatible = "fsl,etsec2-mdio";
 			device_type = "mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.17.1

