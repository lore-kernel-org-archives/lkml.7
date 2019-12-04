Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E05C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E8920674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575462077;
	bh=SO4UPO0pN1BpTj2Vj+qz2h8O3I4ExQ0WHdRywPmMRHA=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=RZQDaV4u1tsnIH1esnEHZ+/Fd3AHvwjdq1wkAg7sVsjXvj045tYI/c2pxwqrjHqn/
	 FqlgbQAFb97Bk7Wka5Cm2RK8tEdSN809G9ADFF3dvWqrDRddMaX5HF6JraykaljqYN
	 kWK86Moa6PU+XikIOIW/UrdHxlV0+N1BtGbrm3hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfLDMVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:21:16 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:43763 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbfLDMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:21:16 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icTeU-0002F5-09; Wed, 04 Dec 2019 13:21:06 +0100
To:     <anarsoul@gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/2] arm64:  =?UTF-8?Q?arch=5Ftimer=3A=20Workaround=20for=20Allwinner=20A=36=34=20time?=  =?UTF-8?Q?r=20instability?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Dec 2019 12:21:05 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <marc.zyngier@arm.com>, Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
In-Reply-To: <CA+E=qVfaBcUN5iB3kaK5gHyURpWt7ET6_js=sLiDg4PCDXXTYA@mail.gmail.com>
References: <20190113021719.46457-1-samuel@sholland.org>
 <20190113021719.46457-2-samuel@sholland.org>
 <472c5450-1b60-6ac7-b242-805c2a2f3272@arm.com>
 <CA+E=qVfaBcUN5iB3kaK5gHyURpWt7ET6_js=sLiDg4PCDXXTYA@mail.gmail.com>
Message-ID: <4b922079aeed04f31ff67b3e7fb78022@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: anarsoul@gmail.com, marc.zyngier@arm.com, samuel@sholland.org, catalin.marinas@arm.com, will.deacon@arm.com, maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[please note that my email address has changed]

On 2019-12-04 04:18, Vasily Khoruzhick wrote:

[...]

> Unfortunately this patch doesn't completely eliminate the jumps. 
> There
> have been reports from users who still saw 95y jump even with the
> patch applied.
>
> Personally I've seen it once or twice on my Pine64-LTS.
>
> Looks like we need bigger hammer. Does anyone have any idea what it 
> could be?

Which kernel version did you see this happening on?

         M.
-- 
Jazz is not dead. It just smells funny...
