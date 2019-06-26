Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA7BC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D4520659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561521169;
	bh=YtbDfJl0BWbBYAdPqlHUFfwmDl41K3e4m55oYYuQFmo=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=BBKI4MQ3tURiFQ4JUaLitmGJlVYu0qqDyX2buq6cnG3hzUwIvF4GllbUbu0jieACk
	 hOhZa/AV0CsAub8xFXv2vfvirL9+i+CqGxpJftdG05xH8vjz8K02c9dqrIhsosZK5G
	 NxAM5S2PQzczxN4PhV8UQ+SJuOcNfvxywXmf46hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfFZDws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfFZDwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:52:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4591A20659;
        Wed, 26 Jun 2019 03:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561521166;
        bh=YtbDfJl0BWbBYAdPqlHUFfwmDl41K3e4m55oYYuQFmo=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=bPsaerdHt5VMFIeTHZlGLf2VI08qXlLs9kDyiLi5peBR1pEi2qEpNBqFLRFqHt2tJ
         sJFDz0U1eeN6X9MULqO9W6PnSJib8wD826AlNWh7Kkis6a8vESxxO0+Po1znPJvX9G
         y06ljy6KIeOz0PidhfhJwl59jSvNEJSW2fiWZAC4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561511122.24282.10.camel@mtksdaap41>
References: <1560138293-4163-1-git-send-email-weiyi.lu@mediatek.com> <20190625221415.B0DC22086D@mail.kernel.org> <1561511122.24282.10.camel@mtksdaap41>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1] clk: core: support clocks that need to be enabled during re-parent
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Biao Huang <biao.huang@mediatek.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 20:52:45 -0700
Message-Id: <20190626035246.4591A20659@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-06-25 18:05:22)
> On Tue, 2019-06-25 at 15:14 -0700, Stephen Boyd wrote:
> > Quoting Weiyi Lu (2019-06-09 20:44:53)
> > > When using property assigned-clock-parents to assign parent clocks,
> > > core clocks might still be disabled during re-parent.
> > > Add flag 'CLK_OPS_CORE_ENABLE' for those clocks must be enabled
> > > during re-parent.
> > >=20
> > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> >=20
> > Can you further describe the scenario where this is a problem? Is it
> > some sort of clk that is enabled by default out of the bootloader and is
> > then configured to have an 'assigned-clock-parents' property to change
> > the parent, but that clk needs to be "enabled" so that the framework
> > turns on the parents for the parent switch?
>=20
> When driver is built as module(.ko) and install at runtime after the
> whole initialization stage. Clk might already be turned off before
> configuring by assigned-clock-parents. For such clock design that need
> to have clock enabled during re-parent, the configuration of
> assigned-clock-parents might be failed. That's the problem we have now.

Great. Please put this sort of information in the commit text.

> Do you have any suggestion for such usage of clocks? Many thanks.
>=20

Ok, and in this case somehow CLK_OPS_PARENT_ENABLE flag doesn't work? Is
that because the clk itself doesn't do anything unless it's enabled?  I
seem to recall that we usually work around this by caching the state of
the clk parents or frequencies and then when the clk prepare or enable
op is called we actually write the hardware to change the state. There
are some qcom clks like this and we basically just use the hardware
itself to cache the state of the clk while it hasn't actually changed to
be at that rate, because the clk is not enabled yet.

The main concern is that we're having to turn on clks to make things
work, when it would be best to not turn on clks just so that register
writes actually make a difference to what the hardware does.

