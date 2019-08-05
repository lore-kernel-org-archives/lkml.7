Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC11C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BF620B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uILuQErq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfHERpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:45:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35866 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfHERp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:45:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so36770328plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yaMCm60MQbAiEe109hZbk3mz1nB4Kn7VLm+HH7rwTRQ=;
        b=uILuQErqEj6dMFOf5SZh0i/b2tp5bwQfRZyTmmXbXwiJ905gJe7x+Y0F/LzIGf1GOM
         dbAhNp1MwxulQi3XQYrmPEEMHTBx2zFans4TpSdPfRssyPvaP8pThH1p2vRyI+qyq0er
         50z0RKVU3FWTZjDbrgC0275nB2kfXT95xJt6YA5QW/TQxFgtylRV5BLkD1bzZR9WxUjC
         jsXt6K+hAn+ZyM5pE2UZNTsjqbgDaX6+CXW3zdlkIdtZaoJXr2Tr8NzTJnoyvm1PTMG+
         cDsYIcu7PYHwyrBRenExj3UgjXocGhhCbvtc5z2de0yrPpz+BXVe4NgmA3lJMFHkwzCi
         pEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yaMCm60MQbAiEe109hZbk3mz1nB4Kn7VLm+HH7rwTRQ=;
        b=IMrAlAOu8a6Z5e/pfKeTotyLv9C90zZ+BIynfybuSUnaXzAVnOvLQKgLhDDx+S8I/4
         IrW4g/iopRHkmHduH878MH/afenqiKxev5g8WJ4jSpFZW9W0RV/YTSs3s6l+/Qj+wmgA
         ccMxPSqzXavLIYvSBqw/PqcIqj4cF0wo8pW+o+Zqfu005WV18e9BVHODDe5sS0x8r6Gz
         w6oV5+FCC0gM4oOEmNY/45l/1LDrYhQetV3El4WqCHfp5vjN0bPStwbyOD+/DqR6KZkx
         VQozfPIbOuxw7g9BUDbaDhBoT1mZstoZYwrXrPMbzF1wc11o/goRV5s1CDdukq5YYzRB
         uP8Q==
X-Gm-Message-State: APjAAAVYwBZQPPdFQJYkYZXAPgCA6x9djiLzI3WIhzEe//NE+NFLMx0Z
        ba5719HP7g2aP5Q8EU546Kbf8Q==
X-Google-Smtp-Source: APXvYqyXSBold9rTE84iJAtGLze32KZeXA3Zh9TxcfLV0XfYpUb8i/gYaAVGpQpEYjhS9ow7s7fROw==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr147750614plp.241.1565027127918;
        Mon, 05 Aug 2019 10:45:27 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s20sm96177226pfe.169.2019.08.05.10.45.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:45:27 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:46:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien DESSENNE <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
Message-ID: <20190805174659.GA23928@tuxbook-pro>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
 <20190801191403.GA7234@tuxbook-pro>
 <1a057176-81ab-e302-4375-2717ceef6924@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a057176-81ab-e302-4375-2717ceef6924@st.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Aug 01:48 PDT 2019, Fabien DESSENNE wrote:

> 
> On 01/08/2019 9:14 PM, Bjorn Andersson wrote:
> > On Wed 13 Mar 08:50 PDT 2019, Fabien Dessenne wrote:
> >
> >> The current implementation does not allow two different devices to use
> >> a common hwspinlock. This patch set proposes to have, as an option, some
> >> hwspinlocks shared between several users.
> >>
> >> Below is an example that explain the need for this:
> >> 	exti: interrupt-controller@5000d000 {
> >> 		compatible = "st,stm32mp1-exti", "syscon";
> >> 		interrupt-controller;
> >> 		#interrupt-cells = <2>;
> >> 		reg = <0x5000d000 0x400>;
> >> 		hwlocks = <&hsem 1>;
> >> 	};
> >> The two drivers (stm32mp1-exti and syscon) refer to the same hwlock.
> >> With the current hwspinlock implementation, only the first driver succeeds
> >> in requesting (hwspin_lock_request_specific) the hwlock. The second request
> >> fails.
> >>
> >>
> >> The proposed approach does not modify the API, but extends the DT 'hwlocks'
> >> property with a second optional parameter (the first one identifies an
> >> hwlock) that specifies whether an hwlock is requested for exclusive usage
> >> (current behavior) or can be shared between several users.
> >> Examples:
> >> 	hwlocks = <&hsem 8>;	Ref to hwlock #8 for exclusive usage
> >> 	hwlocks = <&hsem 8 0>;	Ref to hwlock #8 for exclusive (0) usage
> >> 	hwlocks = <&hsem 8 1>;	Ref to hwlock #8 for shared (1) usage
> >>
> >> As a constraint, the #hwlock-cells value must be 1 or 2.
> >> In the current implementation, this can have theorically any value but:
> >> - all of the exisiting drivers use the same value : 1.
> >> - the framework supports only one value : 1 (see implementation of
> >>    of_hwspin_lock_simple_xlate())
> >> Hence, it shall not be a problem to restrict this value to 1 or 2 since
> >> it won't break any driver.
> >>
> > Hi Fabien,
> >
> > Your series looks good, but it makes me wonder why the hardware locks
> > should be an exclusive resource.
> >
> > How about just making all (specific) locks shared?
> 
> Hi Bjorn,
> 
> Making all locks shared is a possible implementation (my first 
> implementation
> was going this way) but there are some drawbacks we must be aware of:
> 
> A/ This theoretically break the legacy behavior (the legacy works with
> exclusive (UNUSED radix tag) usage). As a consequence, an existing driver
> that is currently failing to request a lock (already claimed by another
> user) would now work fine. Not sure that there are such drivers, so this
> point is probably not a real issue.
> 

Right, it's possible that a previously misconfigured system now
successfully probes more than one device that uses a particular
spinlock. But such system would be suffering from issues related to e.g.
probe ordering.

So I think we should ignore this issue.

> B/ This would introduce some inconsistency between the two 'request' API
> which are hwspin_lock_request() and hwspin_lock_request_specific().
> hwspin_lock_request() looks for an unused lock, so requests for an exclusive
> usage. On the other side, request_specific() would request shared locks.
> Worst the following sequence can transform an exclusive usage into a shared
> 

There is already an inconsistency in between these; as with above any
system that uses both request() and request_specific() will be suffering
from intermittent failures due to probe ordering.

> one:
>    -hwspin_lock_request() -> returns Id#0 (exclusive)
>    -hwspin_lock_request() -> returns Id#1 (exclusive)
>    -hwspin_lock_request_specific(0) -> returns Id#0 and makes Id#0 shared
> Honestly I am not sure that this is a real issue, but it's better to have it
> in mind before we take ay decision

The case where I can see a
problem with this would be if the two clients somehow would nest their
locking regions.

But generally I think this could consider this an improvement, because
the request_specific() would now be able to acquire its hwlock, with
some additional contention due to the multiple use.

> I could not find any driver using the hwspin_lock_request() API, we
> may decide to remove (or to make deprecated) this API, having
> everything 'shared without any conditions'.
> 

It would be nice to have an upstream user of this API.

> 
> I can see three options:
> 1- Keep my initial proposition
> 2- Have hwspin_lock_request_specific() using shared locks and
>     hwspin_lock_request() using unused (so 'initially' exclusive) locks.
> 3- Have hwspin_lock_request_specific() using shared locks and
>     remove/make deprecated hwspin_lock_request().
> 
> Just let me know what is your preference.
> 

I think we should start with #2 and would like input from e.g. Suman
regarding #3.

Regards,
Bjorn

> BR
> 
> Fabien
> 
> >
> > Regards,
> > Bjorn
> >
> >> Fabien Dessenne (6):
> >>    dt-bindings: hwlock: add support of shared locks
> >>    hwspinlock: allow sharing of hwspinlocks
> >>    dt-bindings: hwlock: update STM32 #hwlock-cells value
> >>    ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
> >>    ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
> >>    ARM: dts: stm32: hwlocks for GPIO for stm32mp157
> >>
> >>   .../devicetree/bindings/hwlock/hwlock.txt          | 27 +++++--
> >>   .../bindings/hwlock/st,stm32-hwspinlock.txt        |  6 +-
> >>   Documentation/hwspinlock.txt                       | 10 ++-
> >>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  2 +
> >>   arch/arm/boot/dts/stm32mp157c.dtsi                 | 10 +++
> >>   drivers/hwspinlock/hwspinlock_core.c               | 82 +++++++++++++++++-----
> >>   drivers/hwspinlock/hwspinlock_internal.h           |  2 +
> >>   7 files changed, 108 insertions(+), 31 deletions(-)
> >>
> >> -- 
> >> 2.7.4
> >>
