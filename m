Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B01C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9022070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kj77aelH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfCZQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:58:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43659 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfCZQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:58:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so2245154pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=/qyfPsW7gKCbvRlxk8/hqHHM+WTgixIZCzfz1ObNHKw=;
        b=Kj77aelHKEp5JKhJMzxvuv+6XzDAuJmYWOsBSd+cR6RJ4b3x5UctW5f4l45xdMwwTC
         xFGuueoyCPWEHkBYZZQ3HQFY0MKfmHq282iTio95b/pkj3e38CAxC/h1Gg/4HskOc4IZ
         nKuB8eTwNIrm8YWXHZxugiCPsZGhyGnWOBK+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=/qyfPsW7gKCbvRlxk8/hqHHM+WTgixIZCzfz1ObNHKw=;
        b=Gww4UWebYAqpKAibxSA4U7vZtecsMfLvIAY7y1VcMNcKOlgU+YBs5PCp0/M73T3Lxw
         F5knvja1tI4bUx+7ryWyoMgaHjktNschksGvogcMgiwEu1gzPL9BORyD57+TReayOyGZ
         /kQH6lFDt/94r9u4QVOOP6jFC0A7h3vRWzRnDYKGV6JDE4ISmGrbPWNQ1Cl3ljIWAClj
         UAK88pwBc4AqWOlsPj94TamZ6Yw4M+/Z1ouOdvqsF41TxB+70CwesK8b+nc8gdOt2SEZ
         4sXjhGesfmNhVHSM75XhpIrrRegmKpvhHrZVhXs4or17Fuou8BtkZiUTt/7tpPWe6wLf
         LbvA==
X-Gm-Message-State: APjAAAXK0W0H6Lb6K/kWm2A1hTTY4IRHGgss1/HqElcWk3e1kxYInhBu
        Woap6c3lZDbzrAgJtd5cqS36uMwFG2nsqQ==
X-Google-Smtp-Source: APXvYqyNNyhFt4zjP6GLdbdf15qMmwfOqyE6MMz3K18W8HQWGc0J5jZzSQIUjW7lRm+X93PMlQ+gow==
X-Received: by 2002:a65:4547:: with SMTP id x7mr28976718pgr.350.1553619535776;
        Tue, 26 Mar 2019 09:58:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c130sm30405631pfb.145.2019.03.26.09.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 09:58:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f53f4556-72f1-051b-0dbe-f1789521233e@arm.com>
References: <20190325181026.247796-1-swboyd@chromium.org> <f53f4556-72f1-051b-0dbe-f1789521233e@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2] genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <155361953432.20095.14563397546308928190@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 26 Mar 2019 09:58:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2019-03-26 04:11:56)
> Hi Stephen,
>=20
> On 25/03/2019 18:10, Stephen Boyd wrote:
> > This function returns an error if a child irqchip calls
> > irq_chip_set_wake_parent() but its parent irqchip has the
> > IRQCHIP_SKIP_SET_WAKE flag set. Let's return 0 for success here instead
> > because there isn't anything to do.
> >=20
> > This keeps the behavior consistent with how set_irq_wake_real() is
> > implemented. That function returns 0 when the irqchip has the
> > IRQCHIP_SKIP_SET_WAKE flag set. It doesn't attempt to walk the chain of
> > parents and set irq wake on any chips that don't have the flag set
> > either. If the intent is to call the .irq_set_wake() callback of the
> > parent irqchip, then we expect irqchip implementations to omit the
> > IRQCHIP_SKIP_SET_WAKE flag and implement an .irq_set_wake() function
> > that calls irq_chip_set_wake_parent().
> >=20
> > This fixes a problem on my Qualcomm sdm845 device where I can't set wake
> > on any GPIO interrupts after I apply work in progress wakeup irq patches
> > to the GPIO driver. The chain of chips looks like this:
> >=20
> >  ARM GIC (skip) -> QCOM PDC (skip) -> QCOM GPIO
>=20
> nit: the parenting chain is actually built the other way around (we
> don't express the 'child' relationship). This doesn't change anything to
> the patch, but would make the reasoning a but easier to understand.

I take it you want the sentence below to say 'parent' instead of 'child'
then?

>=20
> >=20
> > The GPIO controller is a child of the QCOM PDC irqchip which is a child
> > of the ARM GIC irqchip. The QCOM PDC irqchip has the
> > IRQCHIP_SKIP_SET_WAKE flag set, and so does the grandparent ARM GIC.
> >=20
> > The GPIO driver doesn't know if the parent needs to set wake or not, so
> > it unconditionally calls irq_chip_set_wake_parent() causing this
> > function to return a failure because the parent irqchip (PDC) doesn't
> > have the .irq_set_wake() callback set. Returning 0 instead makes
> > everything work and irqs from the GPIO controller can be configured for
> > wakeup.
> >=20
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> Fixes: 08b55e2a9208e ("genirq: Add irqchip_set_wake_parent")
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>=20

I'm happy to resend with the commit text clarified more and the above
tags added.

