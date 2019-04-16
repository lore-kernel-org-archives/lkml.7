Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5283D2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aA6EkZLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfDPQyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:54:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44808 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfDPQyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:54:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so10600831pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:cc
         :from:subject:to:message-id:user-agent:date;
        bh=CrBcSrCNlpe0AffWCVBAeUmUuQIkMGW6G+qpbcbeEas=;
        b=aA6EkZLZI/+bJs4umWCbMabjVmqsS0VY+luaUfVxCPRVPznuZ4PN/nlYcyyR4cyRoL
         BR46ZZrPQC78F+IRtv0mr5CEN2wStJzdWVMByJg+eYzey0VK/tzJxPkARbwwiy0gMw10
         zQGmhT7/F+mYFkb3lqrTJ4zD68DE1O+tIItzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:cc:from:subject:to:message-id:user-agent
         :date;
        bh=CrBcSrCNlpe0AffWCVBAeUmUuQIkMGW6G+qpbcbeEas=;
        b=lOXrDeY4qOAONT4KJ4ykuWu6siRdZcyYvHwLHMrX/RAvrMkyzxGFi8g1XMfBHqi3HG
         CzOEWdzG5ZevM17rHcvk0VzoCS0pnXb9yLMUHAgGX+JWk4puOMI6U4FfvbToByKTFnAE
         CPPcfV6N7c4NxtSkTEi0QWLCsEKYOft0hqIOD+7wLvR+AH1eFuVN/k/Rqxc+7Xvclem2
         6q4aH+N/RFvEia8u7eRkvAzuZOVkfSLHfpg7JrD5OsNYp7iOxGvNv17dxQHP8XvSMJ7e
         H2kmp+IsWAinX6edft4kcAJXL9aQz0HMD/K5Fv6Foq0k05XxaesBVYeBCNdfwY5mtYCL
         zkOw==
X-Gm-Message-State: APjAAAXGFpT6HjPtPYZ1yv4+48rGGS1ANhj0rlNhtT2HJuH0qovXmeAf
        VD+WHkCh2Ds20rAytObc8QLRYA==
X-Google-Smtp-Source: APXvYqz/DEX/58MZ4SZ6b3KXkK+z1Adv1m9cQg5qNd4viMoZ4E0Jxx9NEyXRKHl4D8R8vZDjINAZzw==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr84181666pld.172.1555433690799;
        Tue, 16 Apr 2019 09:54:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p9sm21941368pfi.186.2019.04.16.09.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 09:54:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190404155838.GD10883@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org> <20190313211844.29416-4-ilina@codeaurora.org> <20190318174236.072f0a95@why.wild-wind.fr.eu.org> <20190404155838.GD10883@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        thierry.reding@gmail.com, bjorn.andersson@linaro.org,
        dianders@chromium.org, linus.walleij@linaro.org,
        Rob Herring <robh@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 03/10] of/irq: document properties for wakeup interrupt parent
To:     Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <155543368899.15276.6065665159846837534@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 16 Apr 2019 09:54:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-04-04 08:58:38)
> On Mon, Mar 18 2019 at 11:54 -0600, Marc Zyngier wrote:
> >On Wed, 13 Mar 2019 15:18:37 -0600
> >Lina Iyer <ilina@codeaurora.org> wrote:
> >
> >Please do Cc Rob when posting DT related patches.
> >
> >> Some interrupt controllers in a SoC, are always powered on and have a
> >> select interrupts routed to them, so that they can wakeup the SoC from
> >> suspend. Add wakeup-parent DT property to refer to these interrupt
> >> controllers.
> >>
> >> If the interrupts routed to the wakeup parent are not sequential, than=
 a
> >> map needs to exist to associate the same interrupt line on multiple
> >> interrupt controllers. Providing this map in every driver is cumbersom=
e.
> >> Let's add this in the device tree and document the properties to map t=
he
> >> interrupt specifiers
> >>
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> ---
> >> Changes in v4:
> >>      - Added this documentation
> >> ---
> >>  .../interrupt-controller/interrupts.txt       | 39 +++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/interrupt-controller/in=
terrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/inter=
rupts.txt
> >> index 8a3c40829899..917b598317f5 100644
> >> --- a/Documentation/devicetree/bindings/interrupt-controller/interrupt=
s.txt
> >> +++ b/Documentation/devicetree/bindings/interrupt-controller/interrupt=
s.txt
> >> @@ -108,3 +108,42 @@ commonly used:
> >>                      sensitivity =3D <7>;
> >>              };
> >>      };
> >> +
> >> +3) Interrupt wakeup parent
> >> +--------------------------
> >> +
> >> +Some interrupt controllers in a SoC, are always powered on and have a=
 select
> >> +interrupts routed to them, so that they can wakeup the SoC from suspe=
nd. These
> >> +interrupt controllers do not fall into the category of a parent inter=
rupt
> >> +controller and can be specified by the "wakeup-parent" property and c=
ontain a
> >> +single phandle referring to the wakeup capable interrupt controller.
> >> +
> >> +   Example:
> >> +    wakeup-parent =3D <&pdc_intc>;
> >> +
> >> +
> >> +4) Interrupt mapping
> >> +--------------------
> >> +
> >> +Sometimes interrupts may be detected by more than one interrupt contr=
oller
> >> +(depending on which controller is active). The interrupt controllers =
may not
> >> +be in hierarchy and therefore the interrupt controller driver is requ=
ired to
> >> +establish the relationship between the same interrupt at different in=
terrupt
> >> +controllers. If these interrupts are not sequential then a map needs =
to be
> >> +specified to help identify these interrupts.
> >> +
> >> +Mapping the interrupt specifiers in the device tree can be done using=
 the
> >> +"irqdomain-map" property. The property contains interrupt specifier a=
t the
> >> +current interrupt controller followed by the interrupt specifier at t=
he mapped
> >> +interrupt controller.
> >> +
> >> +   irqdomain-map =3D <incoming-interrupt-specifier mapped-interrupt-s=
pecifier>
> >> +
> >> +The optional properties "irqdomain-map-mask" and "irqdomain-map-pass-=
thru" may
> >> +be provided to help interpret the valid bits of the incoming and mapp=
ed
> >> +interrupt specifiers respectively.
> >> +
> >> +   Example:
> >> +    irqdomain-map =3D <22 0 &intc 36 0>, <24 0 &intc 37 0>;
> >> +    irqdomain-map-mask =3D <0xff 0>;
> >> +    irqdomain-map-pass-thru =3D <0 0xff>;
> >
> >
> >This doesn't quite explain how the mask and pass-thru properties are
> >used. I guess that the mask is used to define the 'useful bits' on the
> >incoming side, but pass-thru puzzles me. In your example, does it mean
> >that incoming lines map to outgoing interrupt <0 0>?
> >
> Sorry about the late reply.
>=20
> How about this to go with the rest of the documentation -
>=20
> In the above example, the input interrupt specifier map-mask <0xff 0> app=
lied
> on the incoming interrupt specifier of the map <22 0>, <24 0>, returns the
> input interrupt 22, 24 etc. The second argument being irq type is immater=
ial
> from the map and is used from the incoming request instead. The pass-thru
> specifier parses the output interrupt specifier from the rest of the unpa=
rsed
> argments from the map <&intc 36 0>, <&intc 37 0> etc to return the output
> interrupt 36, 37 etc.
>=20
>=20

I see two things going on here. Do both need to happen?

	#1: Specifying wakeup parent phandle
	#2: Mapping GPIO interrupts to a parent irqdomain

Do we need the method of specifying the wakeup parent if with a dt
property if we have a way to map irqdomains from one to another? I think
I may have already said on the list that we must have #1 but now I'm not
so sure. It looks like we could get away with just looking into the
irqdomain-map and then pick out the wakeup parent that way.

The way the bindings are written shows one way to map interrupts between
domains but I don't know if it lets us differentiate which irqs go from
which domain to what other domain. It seems that we assume we're looking
at only the GPIO to wakeup parent irqdomain mapping from the
irqdomain-map property in this series. If we had a way to do this with
the irqdomain map then we could avoid needing a special 'wakeup-parent'
property.

