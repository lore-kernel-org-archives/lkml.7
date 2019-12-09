Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118FC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6122071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="c3kwm7J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLIXoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:44:15 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:52365 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:44:09 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B74DB2304C;
        Tue, 10 Dec 2019 00:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575935046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9SMg2Cu1zKUbHhX0qMmHr+reE8G5Mnme8ftIO8ll3Tc=;
        b=c3kwm7J3TcRR4lGnhx6RbZC8PGIWULFe1MzSkuTgZuYJjskdkJXNfVRxFkjZuDwt9advkR
        iUdRVYCJoE9zVYzZw3tRuFXLMrvgoAR2MsRohzbTmCH5dR3zW3w3ng7baP9zian0gEztox
        d2wtzqceGFA+GyCD6YLXvLjZttYuk44=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/5] ls1028a: dts fixes and new board support
Date:   Tue, 10 Dec 2019 00:43:45 +0100
Message-Id: <20191209234350.18994-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: B74DB2304C
X-Spamd-Result: default: False [6.40 / 15.00];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.735];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for the Kontron SMARC-sAL28 board. It also
adds missing nodes to the ls1028a base device tree which are used by the
board.

changes since v1:
 - dropped "arm64: dts: ls1028a: add FlexSPI node" in favor of:
   https://lore.kernel.org/lkml/1575457098-18368-2-git-send-email-Ashish.Kumar@nxp.com/
   Thus, this series now depends on that patch
 - better commit message for the TMU patch
 - added fixes tag to the TMU patch
 - document the LS1028A evaluation boards compatible strings
 - document the Kontron sl28 boards compatible strings
 - fix node names of the sl28 device tree(s)
 - removed device specific compatible string of the spi flash
 - rebased the patch series
 - integrate the RGMII configuration of the AR8031 PHY since the binding is
   now already upstream

This patchseries depends on:
 - [Patch v2 1/5] arm64: dts: ls1028a: Add FlexSPI support
   https://lore.kernel.org/lkml/1575457098-18368-2-git-send-email-Ashish.Kumar@nxp.com/
 - [PATCH v2 1/2] dt-bindings: clock: document the fsl-sai driver
   https://lore.kernel.org/lkml/20191209233305.18619-1-michael@walle.cc/

This patchseries superseeds:
 - [PATCH 0/4] ls1028a: dts fixes and new board support
   https://lore.kernel.org/lkml/20191123201317.25861-1-michael@walle.cc/
 - [PATCH] arm64: dts: sl28: configure the RGMII PHY
   https://lore.kernel.org/lkml/20191123202624.28093-1-michael@walle.cc/

Michael Walle (5):
  arm64: dts: ls1028a: fix typo in TMU calibration data
  arm64: dts: ls1028a: add missing sai nodes
  dt-bindings: arm: fsl: add LS1028A based boards
  dt-bindings: arm: fsl: add Kontron sl28 boards
  arm64: dts: freescale: add Kontron sl28 support

 .../devicetree/bindings/arm/fsl.yaml          |  45 +++++
 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     |  27 +++
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    | 106 +++++++++++
 .../fsl-ls1028a-kontron-sl28-var4.dts         |  50 +++++
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 174 ++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  44 ++++-
 7 files changed, 449 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts

-- 
2.20.1

