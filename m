Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F506C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B4E218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfDWW1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:27:38 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:57931 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:27:38 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 2FB073C00C1;
        Wed, 24 Apr 2019 00:27:35 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qs-FQSUThAAS; Wed, 24 Apr 2019 00:27:27 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 0FD2F3C0034;
        Wed, 24 Apr 2019 00:27:27 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 00:27:26 +0200
Date:   Wed, 24 Apr 2019 00:27:22 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jiada Wang <jiada_wang@mentor.com>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms+renesas@verge.net.au>,
        <niklas.soderlund+renesas@ragnatech.se>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>, <george_davis@mentor.com>,
        <joshua_frkuska@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: Re: [PATCH v3 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Message-ID: <20190423222622.GA30401@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190423141414.24264-1-jiada_wang@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

On Tue, Apr 23, 2019 at 11:14:12PM +0900, Jiada Wang wrote:
> There are issues with interrupt handling in rcar_gen3_thermal driver.
> 
> Currently IRQ is remain enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> triggered but not able to clear IRQ status, thus cause system to hang.
> 
> Since the irq line isn't shared between different devices,
> so the proper interrupt type flag should be IRQF_ONESHOT.
> 
> This patch-set fix these interrupt handling retated issues.
> 
> ---
> v3: fix to use correct code base
>     remove unused "flag" variable in rcar_gen3_thermal_irq
[..]

Based on below:
 - basic functional testing [1]
 - 40 min of loading and unloading the driver in a loop doesn't
   trigger the original problem (soft lockup)

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

[1] Basic functional testing on H3-ES2.0-ULCB-KF-M06:
rcar-gen3:~# T0=/sys/devices/virtual/thermal/thermal_zone0/temp
rcar-gen3:~# T1=/sys/devices/virtual/thermal/thermal_zone1/temp
rcar-gen3:~# T2=/sys/devices/virtual/thermal/thermal_zone2/temp
rcar-gen3:~# stress-ng --cpu 16 --timeout 60s &
[1] 2300
rcar-gen3:~# stress-ng: info: [2300] dispatching hogs: 16 cpu
rcar-gen3:~# for i in $(seq 1 24); do \
                 cat $T0 $T1 $T2 | tr '\n' ' '; echo; sleep 5; \
             done
31500 37500 34500 
32000 37500 34500 
32500 38000 35000 
33500 39500 36500 
34000 39500 36500 
35000 40500 37500 
35500 41000 38000 
36000 42000 38500 
36500 42000 39000 
37500 43000 40000 
stress-ng: info: [2300] successful run completed in 60.55s
[1]+  Done                    stress-ng --cpu 16 --timeout 60s
37500 42500 39000 
37500 41500 39000 
37000 41000 38000 
36500 40500 38000 
36000 40000 37000 
35500 39500 36500 
35500 40000 36000 
35000 39500 35500 
35000 39500 36000 
34500 38000 35500 
34500 39000 35500 
34000 38500 35000 
34000 37500 35500 
33500 38000 35500 

-- 
Best regards,
Eugeniu.
