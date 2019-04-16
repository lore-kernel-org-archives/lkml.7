Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EDBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B625220880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jkKfdnUX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ICzuq4B4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfDPRmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:42:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33884 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfDPRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:42:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3550E6156F; Tue, 16 Apr 2019 17:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555436558;
        bh=YK40KU7eOqh1XgsK+rZy8yyWRtnOszzW7YQnz/0N6MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkKfdnUXwa9KIHSem6J4rD4ah/KRr9+ulfnbP1OCja0CaFUmH9WkQyMGFn4mr+3Z1
         GO+nHIiPF8rHkXXqyF0xGsBfrzx8A7z0W24T0Gd1Uk7mH2h/+JIzfc3J0YXmTLrTk7
         uu2PDFp4ZyAXqW/oG3M4Vnzg87lvZwXvzFeee/oo=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C998E60E5F;
        Tue, 16 Apr 2019 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555436557;
        bh=YK40KU7eOqh1XgsK+rZy8yyWRtnOszzW7YQnz/0N6MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICzuq4B4Hv+bGDlcUq9muNYcCxr96jGFjo0yJlpuvFmkuWCCbacuG9wOoJtl1/uFV
         DpYBOwUuGTTx1D+CQNKHucSeeH9DKIqXsVWXF0gFEnOSqLWBQd/NjeF37fhG6lCz82
         n/ns6zgCR/DUNQ8wZNLuLU609/o0z4kJcCYQrpD0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C998E60E5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 16 Apr 2019 11:42:35 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 03/10] of/irq: document properties for wakeup
 interrupt parent
Message-ID: <20190416174235.GC16124@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-4-ilina@codeaurora.org>
 <20190318174236.072f0a95@why.wild-wind.fr.eu.org>
 <20190404155838.GD10883@codeaurora.org>
 <155543368899.15276.6065665159846837534@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155543368899.15276.6065665159846837534@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16 2019 at 10:54 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-04-04 08:58:38)
>> On Mon, Mar 18 2019 at 11:54 -0600, Marc Zyngier wrote:
>> >On Wed, 13 Mar 2019 15:18:37 -0600
>> >Lina Iyer <ilina@codeaurora.org> wrote:
>> >
>> >Please do Cc Rob when posting DT related patches.
>> >
>> >> Some interrupt controllers in a SoC, are always powered on and have a
>> >> select interrupts routed to them, so that they can wakeup the SoC from
>> >> suspend. Add wakeup-parent DT property to refer to these interrupt
>> >> controllers.
>> >>
>> >> If the interrupts routed to the wakeup parent are not sequential, than a
>> >> map needs to exist to associate the same interrupt line on multiple
>> >> interrupt controllers. Providing this map in every driver is cumbersome.
>> >> Let's add this in the device tree and document the properties to map the
>> >> interrupt specifiers
>> >>
>> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> >> ---
>> >> Changes in v4:
>> >>      - Added this documentation
>> >> ---
>> >>  .../interrupt-controller/interrupts.txt       | 39 +++++++++++++++++++
>> >>  1 file changed, 39 insertions(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> >> index 8a3c40829899..917b598317f5 100644
>> >> --- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> >> +++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> >> @@ -108,3 +108,42 @@ commonly used:
>> >>                      sensitivity = <7>;
>> >>              };
>> >>      };
>> >> +
>> >> +3) Interrupt wakeup parent
>> >> +--------------------------
>> >> +
>> >> +Some interrupt controllers in a SoC, are always powered on and have a select
>> >> +interrupts routed to them, so that they can wakeup the SoC from suspend. These
>> >> +interrupt controllers do not fall into the category of a parent interrupt
>> >> +controller and can be specified by the "wakeup-parent" property and contain a
>> >> +single phandle referring to the wakeup capable interrupt controller.
>> >> +
>> >> +   Example:
>> >> +    wakeup-parent = <&pdc_intc>;
>> >> +
>> >> +
>> >> +4) Interrupt mapping
>> >> +--------------------
>> >> +
>> >> +Sometimes interrupts may be detected by more than one interrupt controller
>> >> +(depending on which controller is active). The interrupt controllers may not
>> >> +be in hierarchy and therefore the interrupt controller driver is required to
>> >> +establish the relationship between the same interrupt at different interrupt
>> >> +controllers. If these interrupts are not sequential then a map needs to be
>> >> +specified to help identify these interrupts.
>> >> +
>> >> +Mapping the interrupt specifiers in the device tree can be done using the
>> >> +"irqdomain-map" property. The property contains interrupt specifier at the
>> >> +current interrupt controller followed by the interrupt specifier at the mapped
>> >> +interrupt controller.
>> >> +
>> >> +   irqdomain-map = <incoming-interrupt-specifier mapped-interrupt-specifier>
>> >> +
>> >> +The optional properties "irqdomain-map-mask" and "irqdomain-map-pass-thru" may
>> >> +be provided to help interpret the valid bits of the incoming and mapped
>> >> +interrupt specifiers respectively.
>> >> +
>> >> +   Example:
>> >> +    irqdomain-map = <22 0 &intc 36 0>, <24 0 &intc 37 0>;
>> >> +    irqdomain-map-mask = <0xff 0>;
>> >> +    irqdomain-map-pass-thru = <0 0xff>;
>> >
>> >
>> >This doesn't quite explain how the mask and pass-thru properties are
>> >used. I guess that the mask is used to define the 'useful bits' on the
>> >incoming side, but pass-thru puzzles me. In your example, does it mean
>> >that incoming lines map to outgoing interrupt <0 0>?
>> >
>> Sorry about the late reply.
>>
>> How about this to go with the rest of the documentation -
>>
>> In the above example, the input interrupt specifier map-mask <0xff 0> applied
>> on the incoming interrupt specifier of the map <22 0>, <24 0>, returns the
>> input interrupt 22, 24 etc. The second argument being irq type is immaterial
>> from the map and is used from the incoming request instead. The pass-thru
>> specifier parses the output interrupt specifier from the rest of the unparsed
>> argments from the map <&intc 36 0>, <&intc 37 0> etc to return the output
>> interrupt 36, 37 etc.
>>
>>
>
>I see two things going on here. Do both need to happen?
>
>	#1: Specifying wakeup parent phandle
>	#2: Mapping GPIO interrupts to a parent irqdomain
>
>Do we need the method of specifying the wakeup parent if with a dt
>property if we have a way to map irqdomains from one to another? I think
>I may have already said on the list that we must have #1 but now I'm not
>so sure. It looks like we could get away with just looking into the
>irqdomain-map and then pick out the wakeup parent that way.
>
I thought about it. But the wakeup-parent seems to be needed outside the
irqdomain-map to setup the gpiochip's hierarchy. This could be done by
reading the map, but I am not sure if that approach is clean enough.

>The way the bindings are written shows one way to map interrupts between
>domains but I don't know if it lets us differentiate which irqs go from
>which domain to what other domain. It seems that we assume we're looking
>at only the GPIO to wakeup parent irqdomain mapping from the
>irqdomain-map property in this series. If we had a way to do this with
>the irqdomain map then we could avoid needing a special 'wakeup-parent'
>property.
>
