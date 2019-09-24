Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1F3C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E64620673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569308485;
	bh=5h4RjjXT6Y1QOlkrf+E8Ulhz1Az+W+fntEF2LT7QCYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OHKF/QpajvyTVKsLplCp+nuokarAtrA0o033ixtL8aJyVoKXN3E02kRzu7f2gbPCA
	 P5/1TeLMrx2fghwaXHixHzIPNrKefCSouMDdAJHZC1r4IZTZr9eBZ9x3BGCroQQSkf
	 IN68RvYr1CX9AEnf10dtXizST/zjA+0MrFR53pgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407964AbfIXHBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388209AbfIXHBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:01:24 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89CA2214DA;
        Tue, 24 Sep 2019 07:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569308483;
        bh=5h4RjjXT6Y1QOlkrf+E8Ulhz1Az+W+fntEF2LT7QCYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1SI2QAIxn+9P+9+ZXLQOcENmeJvKQZ7IxWXebwQwwyiQPnp5bLMSct+YijIUXHdm1
         2RNZJoedR7RYaJB4W951JOl8Y+/QgL+3eRGwSxR51phVgUzwpHhiJEmMTxsVbaAZhz
         ev9EDY/7q7/k0R70PB000kUrGUGzHXQ95yYqAW4c=
Received: by mail-ot1-f45.google.com with SMTP id z6so561779otb.2;
        Tue, 24 Sep 2019 00:01:23 -0700 (PDT)
X-Gm-Message-State: APjAAAVcq/bpKt+cJkjp+eEABZNoIY2I3YrvVh/XHVfS+zZGNOYoUBYQ
        4dKsJ2LGPz7LdmCLDX9Sr8LJwBofk8fRLEZZZig=
X-Google-Smtp-Source: APXvYqxSVm+0t2DZ+pXLOjqfSf7/0N3VzaSsLciWrai0ViqCVP8GbXcUaRjcovauaSZEeA9dFQh1yAnhP42V2hGdtnI=
X-Received: by 2002:a9d:4597:: with SMTP id x23mr724863ote.185.1569308482898;
 Tue, 24 Sep 2019 00:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190923161411.9236-1-krzk@kernel.org> <CGME20190923161450epcas4p32dfa1273d244c1392c7bfb4c352f2d3e@epcas4p3.samsung.com>
 <20190923161411.9236-6-krzk@kernel.org> <7ad1898d-3aa7-db49-78c1-c42b34568c60@samsung.com>
In-Reply-To: <7ad1898d-3aa7-db49-78c1-c42b34568c60@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 24 Sep 2019 09:01:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPck6GhOk-ewByb=UtQsX7_NxVH=Aci77ODEAh3YfJKmiQ@mail.gmail.com>
Message-ID: <CAJKOXPck6GhOk-ewByb=UtQsX7_NxVH=Aci77ODEAh3YfJKmiQ@mail.gmail.com>
Subject: Re: [RFT v4 6/8] ARM: dts: exynos: Remove MCT subnode for interrupt
 map on Exynos5250
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 at 08:58, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
>
> On 23.09.2019 18:14, Krzysztof Kozlowski wrote:
> > Multi Core Timer node has interrupts routed to two different parents -
> > GIC and combiner.  This was modeled with a interrupt-map within a
> > subnode but can be expressed in an easier and more common way, directly
> > in the node itself.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Works fine on Arndale and Snow boards.

Thanks for testing!
