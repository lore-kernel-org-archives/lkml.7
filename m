Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB2DC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7369207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Onq1sluN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfIZX2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:28:31 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46910 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfIZX23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:28:29 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9FD898365B;
        Fri, 27 Sep 2019 11:28:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1569540506;
        bh=l6bAe+xtedR+bltocjAHq5456NfUIQhNENNdw3LBmWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Onq1sluNBuPq6cASMObOcHpSgaHREZ06kCSE+4G6DHCUBwZE8JWDj/kL7dsgr2Jzd
         Z+CLfKZ1Kc2J+ZwrK1vrQl9T47Uh9nrjVWaEtPcJI/ZvFmgzY454BqtqDMhEOBv0wt
         v3nKtEfHX4Ze78Tl05NTkPDO4MeGSxfrjoC2AVIgJb1DppCRlCGngqc3UmDqAZAPIb
         51LruL8F4o/D8IMeTMDLRZ1Cy+Q7DYdgWy+TMqn0VroEp0QdIrKwnl6D1mGtiEY2Xn
         zi4dwzBCtNYqQ9z0tn/vAJh1hH5vN+I65utbpFTonKq95vzwq9FgekqHDSJk7mguk+
         WVPvn8Hn8jo8w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d8d49980001>; Fri, 27 Sep 2019 11:28:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 3006713EEFB;
        Fri, 27 Sep 2019 11:28:28 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7638B28003E; Fri, 27 Sep 2019 11:28:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/3] ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
Date:   Fri, 27 Sep 2019 11:28:18 +1200
Message-Id: <20190926232820.27676-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
References: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable L2 cache parity and ECC on the db-xc3-24g4xg board so that cache
operations are protected and errors can be flagged to the EDAC
subsystem.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boo=
t/dts/armada-xp-db-xc3-24g4xg.dts
index df048050615f..4ec0ae01b61d 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -33,6 +33,11 @@
 	};
 };
=20
+&L2 {
+	arm,parity-enable;
+	marvell,ecc-enable;
+};
+
 &devbus_bootcs {
 	status =3D "okay";
=20
--=20
2.23.0

