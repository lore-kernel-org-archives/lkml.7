Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190EAC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CE422BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbfGZSk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:40:58 -0400
Received: from mailoutvs25.siol.net ([185.57.226.216]:54746 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387434AbfGZSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:40:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3F180522DEC;
        Fri, 26 Jul 2019 20:40:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id haV3ghgp1HtG; Fri, 26 Jul 2019 20:40:54 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E644D523034;
        Fri, 26 Jul 2019 20:40:53 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 313BA522DEC;
        Fri, 26 Jul 2019 20:40:52 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/6] pwm: sun4i: Add support for Allwinner H6
Date:   Fri, 26 Jul 2019 20:40:39 +0200
Message-Id: <20190726184045.14669-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has PWM core which is basically the same as that found
in A20, it's just depends on additional bus clock and reset line.

This series adds support for it and extends PWM driver functionality in
a way that it's now possible to bypass whole core and output PWM source
clock directly as a PWM signal. This functionality is needed by AC200
chip, which is bundled in same physical package as H6 SoC, to serve as a
clock source of 24 MHz. AC200 clock input pin is bonded internally to
the second PWM channel.

I would be grateful if anyone can test this patch series for any kind of
regression on other SoCs.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (6):
  dt-bindings: pwm: allwinner: Add H6 PWM description
  pwm: sun4i: Add a quirk for reset line
  pwm: sun4i: Add a quirk for bus clock
  pwm: sun4i: Add support for H6 PWM
  pwm: sun4i: Add support to output source clock directly
  arm64: dts: allwinner: h6: Add PWM node

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 36 +++++++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 10 +++
 drivers/pwm/pwm-sun4i.c                       | 83 ++++++++++++++++++-
 3 files changed, 125 insertions(+), 4 deletions(-)

--=20
2.22.0

