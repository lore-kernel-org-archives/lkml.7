Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BDEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841DE20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="gvYeeqJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfC0Cdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:33:51 -0400
Received: from vps.xff.cz ([195.181.215.36]:55078 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732470AbfC0Cdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553654027; bh=mcXDctExLUC9k+kDWH1pLaGbCHshnclxdA/sUDMkajY=;
        h=From:To:Cc:Subject:Date:From;
        b=gvYeeqJge1xXE/aK1yWtYwYCYZhnGsYkweVrVQbKHUux288rwCynUhRu47AbPWg7K
         v3OIKqPogIwdQex/e7PLG2mihx+g2JBmYpbW1kpPBd9Clw2ygIgsOgkyzaIKfhCU+t
         ubVCQHoLNVjD5qeCEOuYHYxTHbmBNnpcw1SI+e8U=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Ziping Chen <techping.chan@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-input@vger.kernel.org, hdegoede@redhat.com
Subject: [PATCH RESEND v4 0/4] Add support for lradc on A83T
Date:   Wed, 27 Mar 2019 03:33:35 +0100
Message-Id: <20190327023339.25975-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

(This is a re-send, with input subsystem maintainer added. Sorry,
for the extra noise, I did only send the v4 to the previous recipients
of v3, and didn't notice input subsystem was missing back then too.
Thank you wens for pointing it out.)

This series implements r_lradc (low res ADC) support for A83T.

This is a continuation of v3 patch series from 2017 by Ziping Chen. I've
rebased it on top of linux-next and changed the compatibe string as
requested back then.[1]

There was some talk of iio based lradc driver back then[2], but noone
stepped forward to make it. Let's finish this series, so that it's
at least possible to add support for tablet keys on various A83T tablets
as that's the main use of lradc module.

[1] https://lkml.org/lkml/2017/6/26/558

[2] https://lkml.org/lkml/2017/6/27/877

Please take a look, and apply the patches if you have no objections.

regards,
  Ondrej Jirman


Changes for v4:
- changed comaptible string to allwinner,sun8i-a83t-r-lradc
  (drop -keys suffix)
- dropped 0 prefix in the r_lradc DT node
- added sample A83T lradc user (TBS A711 tablet)

Changes for v3:
- Fix some issuses raised by Maxime.
- Added Rob's ACK.

Changes for v2:
- Add an A83T specific compatible.

Ondrej Jirman (1):
  ARM: dts: sun8i: tbs-a711: Add support for volume keys input

Ziping Chen (3):
  input: sun4i-a10-lradc-keys: Add support for A83T
  dt-bindings: input: Add R_LRADC support for A83T
  ARM: dts: sunxi: Add R_LRADC support for A83T

 .../bindings/input/sun4i-lradc-keys.txt       |  6 ++-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts     | 20 ++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  7 ++++
 drivers/input/keyboard/sun4i-lradc-keys.c     | 38 +++++++++++++++++--
 4 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.21.0

