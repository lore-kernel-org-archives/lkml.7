Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991CDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E72339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfICNkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:40:05 -0400
Received: from muru.com ([72.249.23.125]:59570 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfICNkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:40:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B540380CF;
        Tue,  3 Sep 2019 13:40:33 +0000 (UTC)
Date:   Tue, 3 Sep 2019 06:40:00 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC 5/5] ARM: dts: omap3-beagle: make explicitly compatible to
 ti,omap34xx
Message-ID: <20190903134000.GM52127@atomide.com>
References: <cover.1567421750.git.hns@goldelico.com>
 <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190902 10:56]:
> Matching the ti-cpufreq driver needs to specify explicitly if
> a board uses an omap34xx or omap36xx chip.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-beagle.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index e3df3c166902..d47213c7a4d0 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "TI OMAP3 BeagleBoard";
> -	compatible = "ti,omap3-beagle", "ti,omap3";
> +	compatible = "ti,omap3-beagle", "ti,omap34xx", "ti,omap3";
>  
>  	cpus {
>  		cpu@0 {

For a clean-up patch, we should just use the following compatibles
in general for omap3:

ti,omap3	omap3
ti,omap34	omap34xx and omap35xx
ti,omap36	omap36xx and dm37xx
ti,am35		am35xx

So we should just leave out the "xx" part. But we still need parse
also the legacy binding with "xx" in drivers.

Regards,

Tony
