Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06352C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C835220842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="V9ebDC2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfCEUTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:19:41 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55861 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfCEUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:19:35 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A9B7A886B5;
        Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551817172;
        bh=QPhOGYHWxwP2qJ67Ti8eiHu3rNsWIWCJOgj1xDg1Gyo=;
        h=From:To:Cc:Subject:Date;
        b=V9ebDC2Qww/4gxrERCrI4n+SW/fXgshrNFGS8kSnLcPyLadj9HMiylDkWN8qL1ePE
         BdtQrlSXGXsDiFcbpOJeaeF8vXqTWo9Otdb+r2XJ+McTvvsZACgL9DL484+238UR9U
         lxCv4d8qfLQKaAONuCnV7z239uEOlSjbtqs45cJQKKfmdW+LxC/sv/g0UGpBtAoaHW
         nEo2uVIJ64zUDusGtFwwu2/ShCPR7I3C+Sm9B8bKUADsq8Jg4qCATGULnxZJTp1rRt
         LtWFg2u6SmBauyrDfJbKS9iYNNxNgfBfHNSICUExS+GY6CVDhVq4V9uizlya52lo1R
         Aeki69c+EMdvA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c7ed9d40000>; Wed, 06 Mar 2019 09:19:32 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id A05AC13EF3B;
        Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 66DF01E1D96; Wed,  6 Mar 2019 09:19:32 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/3] watchdog: orion_wdt: add pretimeout support
Date:   Wed,  6 Mar 2019 09:19:21 +1300
Message-Id: <20190305201924.14853-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that the kernel has only ever used timer0 on the armada platfo=
rms so
timer1 appears to be spare on these. Timers 2 and 3 are also free which c=
ould
be used if it is deemed that timer1 should be kept for some other purpose=
.

Chris Packham (3):
  ARM: dts: armada-38x: add interrupts for watchdog
  watchdog: orion: remove orion_wdt_set_timeout
  watchdog: orion_wdt: use timer1 as a pretimeout

Changes in v2:

I've reduced this to just touching the Armada-38x. It would probably
also work on Armada-XP just by adding the appropriate interrupt nodes
to the dts. I don't have access to the Armada-370 datasheet but it'd
likely work there as well..

 arch/arm/boot/dts/armada-38x.dtsi |  2 +
 drivers/watchdog/orion_wdt.c      | 67 +++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 17 deletions(-)

--=20
2.21.0

