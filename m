Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D85C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DAA216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556227244;
	bh=FwWW5aF+KPCN6r6b5P/fYFL30f8b/Q9I5eF3YH9cCvI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=aSnvd3BCWe/KKzBn8paSutbxanGEA1PUQVgLcmGEx3o19orC/UaWx3FeFJ1D8xV8U
	 RLPOS/BEEmH0SUHFSo90UKaRVbEjJ1M4B2vkTDHwuDXEgjm4BqaGUgg6rxQ+tO3QfJ
	 mdXPPt9+gqK57arTGuVLkfp9R+hZbQ3m/C1wl6oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfDYVUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfDYVUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:20:42 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F3E216C4;
        Thu, 25 Apr 2019 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556227242;
        bh=FwWW5aF+KPCN6r6b5P/fYFL30f8b/Q9I5eF3YH9cCvI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=D/lR2eFzA3tSlYpcSUcrFt6eyzW/S/73YG696QgswmT6LTDaVUoDo5jvGJSCyLz5s
         aWPFvMk0DqVf61/g8G+rlTwPs9YnV4HVHi+J0RuqYg0+D8P5rK6owkc2gqFrZI0mVa
         F45LfU2isehEQ0IaQRmQ6LA8TpSICnrD8vQvkyKs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190425211009.GP14604@piout.net>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-8-alexandre.belloni@bootlin.com> <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com> <20190425203139.GO14604@piout.net> <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com> <20190425211009.GP14604@piout.net>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622724107.15276.12946928869888731656@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:20:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-25 14:10:09)
> On 25/04/2019 13:58:10-0700, Stephen Boyd wrote:
> > > IIRC two clocks are used by the clocksource and having it as a platfo=
rm
> > > device make the clocksource driver fail with -EPROBE_DEFER.
> > >=20
> >=20
> > Ok. I'll add a comment in the driver. It needs to be
> > CLK_OF_DECLARE_DRIVER() because it's used somewhere else too? Or it can
> > be CLK_OF_DECLARE() instead?
>=20
> It is coming from that comment:
> https://lore.kernel.org/lkml/153573753043.93865.2420370848457480370@swboy=
d.mtv.corp.google.com/
>=20
> Maybe I misinterpreted it.
>=20

Hmm I was just confused it seems. If you don't have two devices probing
the same DT node with this compatible string then I think it can just be
CLK_OF_DECLARE(). I was thinking that you were running into some sort of
issue where the other driver using this same compatible couldn't probe.

