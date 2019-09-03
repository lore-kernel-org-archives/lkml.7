Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA5C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A9022CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfkZw4ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfICCjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:39:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfICCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:39:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so7377575pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMDW/m3hv6pM+84dygmzOuAaegfuHoNMyS2NH8pm8Tg=;
        b=NfkZw4eyCld6HLQ14Z0yBRk9nQWDeOJzJn3bGZI69PVFoufD62dwEMB2i+VaoSFwST
         xxSVybA3SHPnkk8EGa8GpTs5c7d6IYiOeSnBofD39vIoUZirmiRTKoBhZkeEg30uORP5
         XhMCtZE2WHfl0k5/FsjZy+cw1ZCnKOb6IShidLwJrcKLV7A0WABr/WBwZy4oQsdmCnyM
         Ru0F8hmsIVkOFjKQl8GOBxIxiv/YSgV/3HHLQPqX55Q9x9R8nLHWy7B4YIKjfC05jQZk
         7HhFchFD0OaZjNwAMtpFY7ZWtRk0RQobeY2GvpY7520XLZQBQIRjPSOJzYDg7jceTgLG
         R5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMDW/m3hv6pM+84dygmzOuAaegfuHoNMyS2NH8pm8Tg=;
        b=LE1u4T1FkP63YucKtL1nL/8VrwwYOv7/WKcEOtlHgO1vXWZJOpuY+D5NiU9mBQtN66
         KW/XfJpfrRJtCpS7jCpYG8UyRtiK2fnT+WgPI/bjaJJpzNA58nSneCh0x7u7A+HtJeqz
         z0xaxGIORLsTCztTtKlmAC/MpNpfghk9uzkzROFfKBnvnpb29bRODho1nJpi/aWeI+XX
         KshKTbmDJOXn0wM3+tupkzkUXdBA8yqOYJhSrOznDhlqa6RqhxfRKAh9el3BP3kYQG7w
         r/KtRBf2+EapCL9L7anSRoXDVtmcX+4BUgNqdPGV1zoZneIVhqnNrhEGY1B6/QbKbIaF
         52dg==
X-Gm-Message-State: APjAAAW7MQisyDENFTW0F6DTAzsD3xO67F1SDEp8RImIwPUSAEDUNape
        pKm4ZRbXXXGUoOnL9nd3g8MyfA==
X-Google-Smtp-Source: APXvYqyEZC6bVMU9/I4/7wZb0vVsPM80Gk3t1roo/YA9fCGd/tMfPnLz7IzwHQ2W3GuO5dvE77vpdA==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr16008922pje.96.1567478384117;
        Mon, 02 Sep 2019 19:39:44 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id c127sm1785472pfb.5.2019.09.02.19.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 19:39:43 -0700 (PDT)
Date:   Tue, 3 Sep 2019 08:09:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC 2/5] ARM: dts: add support for opp-v2 for omap34xx and
 omap36xx
Message-ID: <20190903023941.pgh24mz4jh325xrc@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com>
 <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-19, 08:08, Viresh Kumar wrote:
> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> > +		opp1-125000000 {
> > +			opp-hz = /bits/ 64 <125000000>;
> > +			// we currently only select the max voltage from table Table 3-3 of the omap3530 Data sheet (SPRS507F)
> > +			// <target min max> could also be single <target>
> > +			opp-microvolt = <975000 975000 975000>;
> > +			// first value is silicon revision, second one 720MHz Device Identification
> 
> > +			opp-supported-hw = <0xffffffff 3>;
> 
> I don't see the driver changes using this field, am I missing
> something ?

The driver already had them it seems. Hmm..

-- 
viresh
