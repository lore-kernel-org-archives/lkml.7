Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8796C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9E2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391224AbfIGXr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 19:47:57 -0400
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:35019 "EHLO
        15.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfIGXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 19:47:57 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Sep 2019 19:47:56 EDT
Received: from player728.ha.ovh.net (unknown [10.108.54.72])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 68A63130586
        for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2019 01:39:05 +0200 (CEST)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 4B47C979D591;
        Sat,  7 Sep 2019 23:38:10 +0000 (UTC)
Date:   Sun, 8 Sep 2019 02:38:10 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, wahrenst@gmx.net, shc_work@mail.ru,
        agross@kernel.org, khilman@baylibre.com, matthias.bgg@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, kgene@kernel.org,
        Andi Shyti <andi@etezian.org>, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20190907233810.GA15768@jack.zhora.eu>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
 <3595bac1-e426-b4f9-4e24-01e104fdfe5d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3595bac1-e426-b4f9-4e24-01e104fdfe5d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 4582412622624637493
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudekvddgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuehaibing,

> >> Use devm_platform_ioremap_resource() to simplify the code a bit.
> >> This is detected by coccinelle.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> > 
> > This tag does not look real... First of all where is the report?
> 
> It is our internal CI robot, which is unavailable to external temporarily.

Hulk Robot is not a person and not accountable for his report.
If it is your internal CI, please write a sentence stating that
the fix has been made using Huawei internal tools.

Credit must be given to tools as well, but not accounts that will
never answer an e-mail.

Otherwise, the patch would look fine.

Andi
