Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DF9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C9720830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554914713;
	bh=UNbQ8KAilo6jAPYgs/PtUDri4Ui/TV6dz5DwlBUrtP8=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=zjiDzAFdZumfQbWEKx7E12kuzuxaljrdL9C0AzDHdmZg173Ewh++gZAxqltBIYc0z
	 l8oZfsiqM7EYedyy6I84sijmO9FziCqHSCbToseRUU9TWmN2Bl+QDxjixDRQRvq0M6
	 d7i77clGoTXOOrc/Fzhk9XNj3MO+Zcw++8FVsPbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfDJQpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfDJQpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:45:12 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14008206B6;
        Wed, 10 Apr 2019 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554914711;
        bh=UNbQ8KAilo6jAPYgs/PtUDri4Ui/TV6dz5DwlBUrtP8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=Ox42K1kd5MNawbGFUkre3dwpIUIQFYYt2C7sSHyc2BuF2JOeqv7gVMdiTTxIuAXG+
         9TF7IIh8qAchN9m1q54hgd3UcGDZyacGe9+HKFQnT90zsVCPFXw4n+ybmyg9cjVLqm
         OLGWHkKb0FIlPZ+5bF0JFgZ6SzZnOwhj8MHa27XE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190409085717.d24c636fuzpoxume@shell.armlinux.org.uk>
References: <20190404215344.6330-1-sboyd@kernel.org> <20190404215344.6330-2-sboyd@kernel.org> <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com> <155449664462.20095.10904772826291270300@swboyd.mtv.corp.google.com> <20190408104941.GB17594@localhost.localdomain> <155474280295.20095.182612336816713159@swboyd.mtv.corp.google.com> <20190408222106.ect7nwjsklzhmdwj@shell.armlinux.org.uk> <4e63d42b27bc5bdf7d991c00f9105ba96a34dc8a.camel@fi.rohmeurope.com> <20190409085717.d24c636fuzpoxume@shell.armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks list
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Message-ID: <155491471024.20095.7879335266054730921@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 10 Apr 2019 09:45:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King - ARM Linux admin (2019-04-09 01:57:17)
> On Tue, Apr 09, 2019 at 05:31:48AM +0000, Vaittinen, Matti wrote:
> > On Mon, 2019-04-08 at 23:21 +0100, Russell King - ARM Linux admin
> > wrote:
> > > On Mon, Apr 08, 2019 at 10:00:02AM -0700, Stephen Boyd wrote:
> > > > >=20
> > > >=20
> > > > Sure. I was thinking along the same lines after you asked.
> > >=20
> > > This is rubbish.  The reason clk_find() doesn't take the lock is that
> > > you _need_ to hold the lock while you dereference the clk_lookup
> > > data.
> >=20
> > I think we all agreed on this already. Stephen pointed out that the
> > current user(s) of clk_find() do _not_ dereference the pointer.
>=20
> Which is actually another incorrect statement - clk_get_sys()
> dereferences it, but Stephen's patch does rearrange the code there.
>=20

I've split this patch into two. One to fix the locking of the new
clk_find() user and the other to introduce a clk_find_hw() API that lets
me use it later on in this series. I'll resend the series with this
update.

