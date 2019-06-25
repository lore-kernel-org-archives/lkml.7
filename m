Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A1EC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D581120657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561505303;
	bh=6+te7mpJt5x4SRywvdcyKAoVs6nKqWEZS+6deQkXGH8=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=1kMnW1Vi3mNnmI5EtlNDA6KV3d+DnMlFLythIOJ203iq/X30CqJDLcTTEGnG7Br5p
	 G1HPcfsdU3w+cFmGuoonQ10OH1X+perXJUHuhPi+zHNuq8ha1GqvWsXA0V3n7GiNA+
	 LBtIxFKgzziym0hXIJLu775o9exp2NNdwIDUI8oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFYX2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYX2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:28:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D4A20645;
        Tue, 25 Jun 2019 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561505300;
        bh=6+te7mpJt5x4SRywvdcyKAoVs6nKqWEZS+6deQkXGH8=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=mNi8EavtpgSP7114DE4Fp5biFG5wHsOt3mCwaHqAvPfToIR33ip/aGcRxUCsKxc0s
         EXhLCkwtAoStCqe+GzLtuLgPgtQZ1pupbmDvgjVncKJH5h41SuyDXxIch7EZ52g+6a
         B0t6ZoE7uS0Gi+Lpb5A0gDs/i/stm1Y4Kn4Lr/kU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561502227.10069.1@crapouillou.net>
References: <20190624225759.18299-1-paul@crapouillou.net> <20190624225759.18299-6-paul@crapouillou.net> <20190625220931.2F69B2086D@mail.kernel.org> <1561502227.10069.1@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v13 05/13] clk: ingenic: Add driver for the TCU clocks
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        James Hogan <jhogan@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:28:20 -0700
Message-Id: <20190625232820.D1D4A20645@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-06-25 15:37:07)
> >=20
> > Do you need to get the clk by name? Or can that clk be "known" to the
> > TCU somehow so we can already have a direct clk pointer?
>=20
> This clock is provided by a separate driver, so I have to obtain the
> clock pointer from devicetree.

Ok.

> >>  +}
> >>  +
> >>  +static int __maybe_unused tcu_pm_suspend(void)
> >>  +{
> >>  +       struct ingenic_tcu *tcu =3D ingenic_tcu;
> >>  +
> >>  +       if (tcu->clk)
> >>  +               clk_disable(tcu->clk);
> >=20
> > Do you need to unprepare? Or it just isn't possible because this is
> > called from syscore and thus we can't sleep?
>=20
> I thought that clk_disable() was enough. We don't actually need to
> unprepare, do we? And yes, as you pointed out, this call cannot sleep.

Yeah unprepare isn't necessary, but it will be different on different
platforms. This is a highly platform specific driver though so I suspect
this is all fine.

