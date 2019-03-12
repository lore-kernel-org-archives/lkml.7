Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB1A214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfCLImj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:42:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57566 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfCLImj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:42:39 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3cza-0000YP-1a; Tue, 12 Mar 2019 09:42:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: rockchip: rk3288: fix missing grf reference in tsadc node
Date:   Tue, 12 Mar 2019 09:42:33 +0100
Message-ID: <1950463.k8Yvi4fDWQ@phil>
In-Reply-To: <AM3PR03MB0966E8AA93CC1B7CA355CECEAC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <AM3PR03MB0966E8AA93CC1B7CA355CECEAC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 24. Februar 2019, 22:52:00 CET schrieb Jonas Karlman:
> The following message can be seen during boot:
> 
>   rockchip-thermal ff280000.tsadc: Missing rockchip,grf property
> 
> Fix this by adding rockchip,grf property to tsadc node.
> 
> Fixes: b67d6bc38823 ("ARM: dts: rockchip: add main thermal info to rk3288")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

applied for 5.2

The warning doesn't affect rk3288 (v2 tsadc) and the grf requirement
only got introduced later on after the rk3288 tsadc node, so I've dropped
the Fixes tag, also reducing the workload of the stable poeple

In general it looks like driver quality of the tsadc deteriorated over time,
as it shouldn't warn about missing GRF references on platforms not
needing it in the first place. And GRF locations should of course also
live in the per-soc data structures as GRF register never are stable
like the constants currently suggest.


