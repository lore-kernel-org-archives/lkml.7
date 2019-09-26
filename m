Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2339CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED173207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="AOasu4YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfIZX2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:28:30 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46912 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfIZX23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:28:29 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A07FB886BF;
        Fri, 27 Sep 2019 11:28:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1569540506;
        bh=6RbE8qI20kMEdMD7hJsrS7/ArZwF7p3FRXfaz2j2zVo=;
        h=From:To:Cc:Subject:Date;
        b=AOasu4YE/rNgmlEt3wbns6XCP6oVTh0K6isgfuhvYjMlI+JPZzJPV0IrCnkbSQL6/
         YmO4JqAy9/taOwnxf1lBz1p8OSiMIPw2L8dlmbm9sHA6Xs1mqBBHDZTsOXU/PJHZHc
         Y/qRJ4aehuhymI5FtPp+LsRmVjygQS1hOu7piaVucp99TDvH28u2maRlzH/sDzTlND
         GW5njq0M2kljLxlfGyVjFryKJ53NrVQrx7fevF1+cooONCK/PGu3snPG+vbKh+UEst
         +0JqDG7Fbo3WKXWWN4chJ9rXxviLH+F4H3Dkg+V6kxop0GqD0zjARCvu7V1qplJM/3
         JZZ+fYXkSK8qw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d8d49980000>; Fri, 27 Sep 2019 11:28:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 13C2C13EED0;
        Fri, 27 Sep 2019 11:28:28 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 592FD28003E; Fri, 27 Sep 2019 11:28:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/3] ARM: dts: SDRAM and L2 cache EDAC for Armada SoCs
Date:   Fri, 27 Sep 2019 11:28:17 +1200
Message-Id: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was waiting for the armada_xp edac driver to be accepted.
Now that it has the relevant nodes can be added to the Armada SoCs. So
that boards can use the EDAC driver if they have the hardware support.

The db-xc3-24g4xg.dts board doesn't have an ECC chip for it's DDR but it
can use the L2 cache parity and ecc support.

Chris Packham (3):
  ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
  ARM: dts: mvebu: add sdram controller node to Armada-38x
  ARM: dts: armada-xp: add label to sdram-controller node

 arch/arm/boot/dts/armada-38x.dtsi             | 5 +++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi     | 2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi              | 2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

--=20
2.23.0

