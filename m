Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15779C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE902084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLKI1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:08:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37800 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfDLKI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:08:26 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEt6c-0004fB-8v; Fri, 12 Apr 2019 12:08:22 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ARM: dts: rockchip: Add dynamic-power-coefficient for rk3288
Date:   Fri, 12 Apr 2019 12:08:21 +0200
Message-ID: <9063550.zi1cCdPW0A@diego>
In-Reply-To: <20190412000158.248080-1-mka@chromium.org>
References: <20190412000158.248080-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. April 2019, 02:01:58 CEST schrieb Matthias Kaehlcke:
> The value was determined with the following method:
> 
> - take CPUs 1-3 offline
> - for each OPP
>   - set cpufreq min and max freq to OPP freq
>   - start dhrystone benchmark
>   - measure CPU power consumption during 10s
>   - calculate Cx for OPPx
>     - Cx = (Px - P1) / (Vx²fx - V1²f1)          [1]
>       using the following units: mW / Ghz / V   [2]
> - C = avg(C2, ..., Cn)
> 
> [1] see commit 4daa001a1773 ("arm64: dts: juno: Add cpu
>      dynamic-power-coefficient information")
> [2] https://patchwork.kernel.org/patch/10493615/#22158551
> 
> FTR, these are the values for the different OPPs:
> 
> freq (kHz)   	mV		Px (mW)		Cx
> 
> 126000		900		39
> 216000		900		66		370
> 312000		900		95		372
> 408000		900		122		363
> 600000		900		177		359
> 696000		950		230		363
> 816000		1000		297		361
> 1008000		1050		404		362
> 1200000		1100		528		362
> 1416000		1200		770		377
> 1512000		1300		984		385
> 1608000		1350		1156		394
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I've applied this for 5.2 but moved the new entries
below the clock properties for some more alphabetic ordering.


Heiko


