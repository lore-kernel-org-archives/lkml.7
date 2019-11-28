Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D52CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474162176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfK1VxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:53:12 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38962 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfK1VxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:53:12 -0500
Received: from p5b127cfe.dip0.t-ipconnect.de ([91.18.124.254] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iaRii-0005Hu-IH; Thu, 28 Nov 2019 22:53:04 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Soeren Moch <smoch@web.de>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-rockchip@lists.infradead.org,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: split rk3399-rockpro64, for v2 and v2.1 boards
Date:   Thu, 28 Nov 2019 22:53:03 +0100
Message-ID: <9133677.cKcSbgiQdr@phil>
In-Reply-To: <3fa2e3df-221b-99a8-796a-2e21f75cf706@web.de>
References: <3fa2e3df-221b-99a8-796a-2e21f75cf706@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 28. November 2019, 20:55:54 CET schrieb Soeren Moch:
> > On Thu, Nov 28, 2019 at 6:02 AM Katsuhiro Suzuki
> > <katsuhiro@katsuster.net> wrote:
> >> This patch splits rk3399-rockpro64 dts file to 2 files for v2 and
> >> v2.1 boards.
> >>
> >> Both v2 and v2.1 boards can use almost same settings but we find a
> >> difference in I2C address of audio CODEC ES8136.
> >>
> >> Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> >>
> >> ---

[...]

> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> >> new file mode 100644
> >> index 000000000000..183eda4ffb9c
> >> --- /dev/null
> If we add this as new file, should we sort handles and properties
> alphabetically, where it is not done yet?

I'm torn here ... on one side, doing missing sorting might be nice
on the other hand, there is the moving without functional changes
paradigm, which is generally nice to adhere to.

But I guess sorting would generally be ok.

> I'm not sure about all the exceptions that usually apply for rockchip
> devicetrees, status property at the end, also the pinctrl node?

In general I don't "enforce" the sorting, so don't reject patches but instead
just do sorting myself if necessary ;-).

The general rule-of-thumb for nodes we came up with during the rk3288-veyron
era is something like:

compatible
reg
interrupts
[alphabetical properties]
status

as this makes it somewhat easier to parse the core properties (compatible,
reg, ints, status] when scrolling through a devicetree :-) .

Pinctrl position is at the discretion of the dt author :-D .
Position at the end has just the advantage that a long pin-group list does
not get in the way so much.

> What about unused references, e.g. "fan"?

Don't change too much when moving stuff around :-)


Heiko


