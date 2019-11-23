Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78490C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0D520679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="i3o40RAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKWUNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:13:37 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39047 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:13:36 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 03D49230E1;
        Sat, 23 Nov 2019 21:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1574540012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZFklsfAEUdCApZC1vMSb5aopAltK94RX5w3mlDHQqe0=;
        b=i3o40RAQ5v+LQ7qsAO0d94nAao0u7X5OOdv7kz+mz/kg6i+M4XMOeU9e3BOZqQ+vRVkrCF
        yhnc1ZurCzr5Z+JW7qHJJiSUiUuFK8UexV+1CmDfGgckttdzjP2TugNXLCtrnq7QVTOkTb
        FBhiBjYosznKtszTI0Xc+AYddSNKsc0=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/4] ls1028a: dts fixes and new board support
Date:   Sat, 23 Nov 2019 21:13:13 +0100
Message-Id: <20191123201317.25861-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 03D49230E1
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.179];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for the Kontron SMARC-sAL28 board. It also
adds missing nodes to the ls1028a base device tree which are used by the
board.

Michael Walle (4):
  arm64: dts: ls1028a: fix typo in TMU calibration data
  arm64: dts: ls1028a: add missing sai nodes
  arm64: dts: ls1028a: add FlexSPI node
  arm64: dts: freescale: add Kontron sl28 support

 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     |  27 +++
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    |  73 ++++++++
 .../fsl-ls1028a-kontron-sl28-var4.dts         |  34 ++++
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 158 ++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  57 ++++++-
 6 files changed, 352 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts

-- 
2.20.1

