Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D151EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DD320833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4cPP5Z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDIRew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:34:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40946 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDIRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:34:52 -0400
Received: by mail-io1-f67.google.com with SMTP id d201so15038617iof.7;
        Tue, 09 Apr 2019 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rz0aDV9OpL7jI4BvLfVtUPXYDaxQQtRxUY20Zf2oyXA=;
        b=V4cPP5Z1XaSRh22nIlFhsmpyRfDYa8UWb1HsXVs8OZuswciCnnEcVSISsEZJiHnk1V
         qYKFyr/Yll8t4jblcabWIHrJRF7tJuOAchbdMxdGNNFpRXYFG3pun03jrHdWHE8ifKBA
         PiXodOqEpex9gAeIFLU/9uMAw5faKABA8F+N/jEAPYv+grWroEp6urIwGjmJDIq8GUWx
         7uGVjIsF6EcG/0vLmSSZYfGA7VUY5PWshFOXmooyFgBHptE90fUsvN6bv5EG9YpA06+6
         gymIY0seAkNn/s9945zkzSt6le49neQV7Hjofp4Suc4RdU0trKDoxksvGZTFe7tBRZ9b
         K6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rz0aDV9OpL7jI4BvLfVtUPXYDaxQQtRxUY20Zf2oyXA=;
        b=BgC0Nxy9eVVRU9WEBGUN94EMNvbbicfNe7DVlMUVI7r14COn/nSMAzCqllqNQg977O
         GgNZxCJ6xNKMlsPNy/o4LQ8tq/P24gRbCGQwJWeLYlK0mlvpGjCkA2jr6gA/33zUY9Cl
         0oXAZCvoUWhfPAgYjEAlkp1Ys+h9dpx1PGysZ0TLYKVGZDrQoOpa2H4rNOA2d9F0mKd1
         pODOnJ+DaAX5kuH4lEgrkvete6JCT/CRSedgqIHhFqAKkqNN4JQBxxofBp3yKeyK6TXJ
         ryGzVgx703th93Lh7RE3LWJ76w2mCi+mqJmXgtyg4n6C3+/OskxEbBbXEpNcjMSdmRe9
         Wt7w==
X-Gm-Message-State: APjAAAXsGpKXldveoLvF4LqXfwy0jQYqN1tej7hhPfpcCULEW2ARrUl+
        Qhdr6JH41Yx3o3EWL1nIVB+H9DBQsUhWCmT1dY4=
X-Google-Smtp-Source: APXvYqyERUnrii6LK2LZodMbjTA8prA8ZWqOH31IgCG6z/FH1RCv3CMJEdtL6bkUMlz2iEjnfrwb3wt+5J4T+ezP888=
X-Received: by 2002:a6b:b797:: with SMTP id h145mr17061971iof.190.1554831290887;
 Tue, 09 Apr 2019 10:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190405102455.15311-1-tiny.windzz@gmail.com> <20190405102455.15311-3-tiny.windzz@gmail.com>
 <20190409100730.2rtxyy66knjning6@vireshk-i7>
In-Reply-To: <20190409100730.2rtxyy66knjning6@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 10 Apr 2019 01:34:39 +0800
Message-ID: <CAEExFWvQbXtyQjzr1RPQ9R6SxBushiNPN8UqH=MMHBLGsq+Omg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 6:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-04-19, 06:24, Yangtao Li wrote:
> > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > +     cpus {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             cpu0: cpu@0 {
> > +                     compatible = "arm,cortex-a53";
> > +                     device_type = "cpu";
> > +                     reg = <0>;
> > +                     enable-method = "psci";
> > +                     clocks = <&ccu CLK_CPUX>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu1: cpu@1 {
> > +                     compatible = "arm,cortex-a53";
> > +                     device_type = "cpu";
> > +                     reg = <1>;
> > +                     enable-method = "psci";
> > +                     clocks = <&ccu CLK_CPUX>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu2: cpu@2 {
> > +                     compatible = "arm,cortex-a53";
> > +                     device_type = "cpu";
> > +                     reg = <2>;
> > +                     enable-method = "psci";
> > +                     clocks = <&ccu CLK_CPUX>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu3: cpu@3 {
> > +                     compatible = "arm,cortex-a53";
> > +                     device_type = "cpu";
> > +                     reg = <3>;
> > +                     enable-method = "psci";
> > +                     clocks = <&ccu CLK_CPUX>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +                     operating-points-v2 = <&cpu_opp_table>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +        };
> > +
> > +     cpu_opp_table: opp_table {
> > +             compatible = "operating-points-v2-sunxi-cpu";
> > +             nvmem-cells = <&speedbin_efuse>;
> > +             opp-shared;
> > +
> > +             opp-480000000-0 {
> > +                     opp-hz = /bits/ 64 <480000000>;
> > +                     opp-microvolt = <880000>;
> > +                     opp-supported-hw = <0x1>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-720000000-0 {
> > +                     opp-hz = /bits/ 64 <720000000>;
> > +                     opp-microvolt = <880000>;
> > +                     opp-supported-hw = <0x1>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-816000000-0 {
> > +                     opp-hz = /bits/ 64 <816000000>;
> > +                     opp-microvolt = <880000>;
> > +                     opp-supported-hw = <0x1>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-888000000-0 {
> > +                     opp-hz = /bits/ 64 <888000000>;
> > +                     opp-microvolt = <940000>;
> > +                     opp-supported-hw = <0x1>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1080000000-0 {
> > +                     opp-hz = /bits/ 64 <1080000000>;
> > +                     opp-microvolt = <1060000>;
> > +                     opp-supported-hw = <0x1>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1320000000-0 {
> > +                     opp-hz = /bits/ 64 <1320000000>;
> > +                     opp-microvolt = <1160000>;
> > +                     opp-supported-hw = <0x1>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1488000000-0 {
> > +                     opp-hz = /bits/ 64 <1488000000>;
> > +                     opp-microvolt = <1160000>;
> > +                     opp-supported-hw = <0x1>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp-480000000-1 {
> > +                     opp-hz = /bits/ 64 <480000000>;
> > +                     opp-microvolt = <820000>;
> > +                     opp-supported-hw = <0x2>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-720000000-1 {
> > +                     opp-hz = /bits/ 64 <720000000>;
> > +                     opp-microvolt = <820000>;
> > +                     opp-supported-hw = <0x2>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-816000000-1 {
> > +                     opp-hz = /bits/ 64 <816000000>;
> > +                     opp-microvolt = <820000>;
> > +                     opp-supported-hw = <0x2>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-888000000-1 {
> > +                     opp-hz = /bits/ 64 <888000000>;
> > +                     opp-microvolt = <820000>;
> > +                     opp-supported-hw = <0x2>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1080000000-1 {
> > +                     opp-hz = /bits/ 64 <1080000000>;
> > +                     opp-microvolt = <880000>;
> > +                     opp-supported-hw = <0x2>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1320000000-1 {
> > +                     opp-hz = /bits/ 64 <1320000000>;
> > +                     opp-microvolt = <940000>;
> > +                     opp-supported-hw = <0x2>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1488000000-1 {
> > +                     opp-hz = /bits/ 64 <1488000000>;
> > +                     opp-microvolt = <1000000>;
> > +                     opp-supported-hw = <0x2>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +
> > +             opp-480000000-2 {
> > +                     opp-hz = /bits/ 64 <480000000>;
> > +                     opp-microvolt = <800000>;
> > +                     opp-supported-hw = <0x4>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-720000000-2 {
> > +                     opp-hz = /bits/ 64 <720000000>;
> > +                     opp-microvolt = <800000>;
> > +                     opp-supported-hw = <0x4>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-816000000-2 {
> > +                     opp-hz = /bits/ 64 <816000000>;
> > +                     opp-microvolt = <800000>;
> > +                     opp-supported-hw = <0x4>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-888000000-2 {
> > +                     opp-hz = /bits/ 64 <888000000>;
> > +                     opp-microvolt = <800000>;
> > +                     opp-supported-hw = <0x4>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1080000000-2 {
> > +                     opp-hz = /bits/ 64 <1080000000>;
> > +                     opp-microvolt = <840000>;
> > +                     opp-supported-hw = <0x4>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1320000000-2 {
> > +                     opp-hz = /bits/ 64 <1320000000>;
> > +                     opp-microvolt = <900000>;
> > +                     opp-supported-hw = <0x4>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +             opp-1488000000-2 {
> > +                     opp-hz = /bits/ 64 <1488000000>;
> > +                     opp-microvolt = <960000>;
> > +                     opp-supported-hw = <0x4>;
> > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > +             };
> > +     };
>
> Well, this is pure duplication of all the OPPs which isn't great. If I have
> understood things correctly from the above example, then all you want is a
> different microvolt value for each OPP, right ?

Not exactly like this. But this is working for the current situation.

>
> Then you are using the wrong feature of OPP core I am afraid. What you should
> rather look for is opp-microvolt-<name> property, look in opp.txt bindings.

Yeah. This is more appropriate.

>
> And these are the helper you need to use:
> dev_pm_opp_set_prop_name()/dev_pm_opp_put_prop_name().

Thanks,
Yangtao

>
> --
> viresh
