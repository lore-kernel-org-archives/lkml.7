Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50572C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63F2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLZU2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:28:04 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43686 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfLZU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 15:28:03 -0500
Received: from [193.173.216.178] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ikZjg-0007qI-RB; Thu, 26 Dec 2019 21:27:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Kever Yang <kever.yang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] Revert "rockchip: make sure timer7 is enabled on rk3288 platforms"
Date:   Thu, 26 Dec 2019 21:27:45 +0100
Message-ID: <1865524.AMUeMo0HA2@phil>
In-Reply-To: <CAGb2v675A0fG9wHiJj_pkVQBmBFDf_u1L_dxiD9pT_8VBjujzw@mail.gmail.com>
References: <20191225025908.25305-1-kever.yang@rock-chips.com> <CAGb2v675A0fG9wHiJj_pkVQBmBFDf_u1L_dxiD9pT_8VBjujzw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 25. Dezember 2019, 04:02:29 CET schrieb Chen-Yu Tsai:
> On Wed, Dec 25, 2019 at 10:59 AM Kever Yang <kever.yang@rock-chips.com> wrote:
> >
> > This reverts commit 2a9fe3ca84afff6259820c4f62e579f41476becc.
> > All the U-Boot version for rk3288 including mainline, rockchip
> > legacy/next-dev, have init the timer7, so no need to init it in kernel
> > again.
> 
> What about the ChromeOS bootloader?

Coreboot does seem to start timer7 correctly:
https://github.com/coreboot/coreboot/blob/master/src/soc/rockchip/rk3288/timer.c

But old rk3288 Android TV-boxes do contain bootloaders not doing that and
as the owners of such boxes will most often not have too great development
tools available, that would break newer kernels for them, which is really bad
as we value backwards compatibility very much.

Instead (just checked theoretically) could we just check for psci existence?
I.e. the calling order seems to be:

start_kernel() (in init/main.c)
	-> setup_arch()
		-> psci_dt_init()
			-> populates struct psci_ops
	-> time_init()
		-> machine_desc->init_time()

so in rockchip_timer_init() you should "just" be able to check like

	if (of_machine_is_compatible("rockchip,rk3288") && !psci_ops.cpu_on) {
		/* timer init */
	}


Heiko

> > One more reason is that if  we enable the trust for rk3288, then timer7 is
> > not able to be accessed in kernel.
> >
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> 




