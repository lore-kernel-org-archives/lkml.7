Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A721900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BnZRpwmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCVXuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:50:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34399 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfCVXuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:50:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so2552555pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=IEOHDcRDNKEttMJKwIZbSUvgHF+/177DDBtgxfrk4Ug=;
        b=BnZRpwmIGiuonDcgGQtpDZ/91xXwGJAyZOgKcsoMNsgR5LgPheQV42BKLmdqJFmIac
         UlDEdS01yDRnpNb34opCbw/QpN8KQzluDcUBuQMO7EG2JuTsQcGNFsn4Sq3POGeMyFOu
         3+rmBWhyOUCGXdG9a5ufkVgBXcXbF/+xfqEdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=IEOHDcRDNKEttMJKwIZbSUvgHF+/177DDBtgxfrk4Ug=;
        b=Cc6uHlySNNZOOjAG2X40ELZwq/+3g8X7/mUsqFoEn2y1j8sAoB+anAoR424MAZoamB
         ASqxUkSduuLQUgGVfWEjkqVKbcERQS9Ind/HjNI2sgGL1fpDYh4qqs8EWslPSG4NAGhB
         9HGPklHXgzCBcu4umd6yZknQtq2y33AJJSJkWM7pUAhEZ/5YUSr6ZaAMgJwbNIzoXjiI
         3PSTu+y32cI0eoFFwHzPlOqD/th34OZEMe+/MKGrxTwtgW5K3EDZcIbp1bI/luDSJ/x9
         JamabuD+fS3PsRUTO9YecOrnfonu5d00cg1+gtz8nFTcMOJiD/i3/y79TaiaP+prnKbG
         329g==
X-Gm-Message-State: APjAAAWB88Q8Rn4TtDUnn9144aGh171bYAvPIaRXS9Cm9elmT/4bx13d
        SZopAmjBhbYMXNTVm5QszIojzY40rDQ9LA==
X-Google-Smtp-Source: APXvYqzj+MCmadL4UBD9qDdLShFi9sFsNb7PDKT/0ft/KQPoz4/3C2ANwd5YRBMEo8v5s98KdBFtCg==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr3380288pgp.197.1553298621841;
        Fri, 22 Mar 2019 16:50:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b8sm9905445pgq.33.2019.03.22.16.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 16:50:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alpine.DEB.2.21.1903211007310.1777@nanos.tec.linutronix.de>
References: <20190315200759.139479-1-swboyd@chromium.org> <alpine.DEB.2.21.1903211007310.1777@nanos.tec.linutronix.de>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Message-ID: <155329862018.20095.14024385652448015564@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 22 Mar 2019 16:50:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2019-03-21 02:26:26)
> On Fri, 15 Mar 2019, Stephen Boyd wrote:
>=20
> > This function returns an error if a child interrupt controller calls
> > irq_chip_set_wake_parent() but that parent interrupt controller has the
> > IRQCHIP_SKIP_SET_WAKE flag. Let's return 0 for success instead because
> > there isn't anything to do.
> >=20
> > There's also the possibility that a parent indicates that we should skip
> > it, but the grandparent has an .irq_set_wake callback. Let's iterate
> > through the parent chain as long as the IRQCHIP_SKIP_SET_WAKE flag isn't
> > set so we can find the first parent that needs to handle the wake
> > configuration. This fixes a problem on my Qualcomm sdm845 device where
> > I'm trying to enable wake on an irq from the gpio controller that's a
> > child of the qcom pdc interrupt controller. The qcom pdc interrupt
> > controller has the IRQCHIP_SKIP_SET_WAKE flag set, and so does the
> > grandparent (ARM GIC), causing this function to return a failure because
> > the parent controller doesn't have the .irq_set_wake callback set.
>=20
> It took me some time to distangle that changelog.... and I don't think th=
at
> this is the right thing to do.

Yes, your diagram would be a useful addition to the commit text.

>=20
> set_irq_wake_real() returns 0 when the topmost chip has SKIP_SET_WAKE set.

Just to confirm, the topmost chip would be chip B or chip C below?

>=20
> So let's assume we have the following chains:
>=20
>   chip A -> chip B=20
>=20
>   chip A -> chip B -> chip C
>=20
> chip A has SKIP_SET_WAKE not set
> chip B has SKIP_SET_WAKE set
> chip C has SKIP_SET_WAKE not set and invokes irq_chip_set_wake_parent()
>=20
> Now assume we have interrupt X connected to chip B and interrupt Y
> connected to chip C.
>=20
> If irq_set_wake() is called for interrupt X, then the function returns
> without trying to invoke the set_wake() callback of chip A.

It's not clear to me that having SKIP_SET_WAKE set means "completely
ignore set wake for irqs from this domain" vs. "skip setting wake here
because the .irq_set_wake() is intentionally omitted for this chip".
Reading Santosh's reasoning in commit 60f96b41f71d ("genirq: Add
IRQCHIP_SKIP_SET_WAKE flag") just further confuses me because it sounds
like the latter.

>=20
> If irq_set_wake() is called for interrupt Y, irq_chip_set_wake_parent() is
> invoked from chip C which then skips chip B, but tries to invoke the
> callback on chip A.
>=20
> That's inconsistent and changes the existing behaviour. So IMO, the right
> thing to do is to return 0 from irq_chip_set_wake_parent() when the parent
> has SKIP_SET_WAKE set and not to try to follow the whole chain. That shou=
ld
> fix your problem nicely w/o changing behaviour.

Ok. I understand that with hierarchical chips you want it to be explicit
in the code that a parent chip needs to be called or not. This works for
me, and it's actually how I had originally solved this problem. Will you
merge your patch or do you want me to resend it with some updated commit
text?

