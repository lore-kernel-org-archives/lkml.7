Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC647C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8256B208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565882178;
	bh=YIfI/ppz1LWSDkP2R1sEFsQgzfbXfwcerSHGBbeZVcQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Kqdgf5bvst1WrFeBRXEOP7gYXLH8keepgpO4O6bxQxOXw69I6Zjg2HK215Ts0nNi9
	 ++KTZLBxjvYqcRctA5+8epT4ZzD9Zu03cqOBHE2w8THzlhJLPKxxYfF2rf+lblH0L3
	 YWG+3PTpULwF9yBjKVv9kbGCeCOILRZY3G+tSkmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfHOPQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbfHOPQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:16:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A298206C1;
        Thu, 15 Aug 2019 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565882176;
        bh=YIfI/ppz1LWSDkP2R1sEFsQgzfbXfwcerSHGBbeZVcQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=f7BBgtpIhpR9pWeAYZpkjQLqjogcL13PZg3qdB77K49aXzmH7+UAGHJYl2BzFqmTg
         ftpiCR+aKQnJcT6J8GzHhy0l2POdjDxE8ea++K/LX4Nk8Cp1lx9+09y0tlRtg3ZBPe
         2ETdoIwk46b6D8EWrqHmNqHzJebqw8y5JXYS84Ng=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815112614.GA4841@sirena.co.uk>
References: <5d54d2fd.1c69fb81.e13e5.7422@mx.google.com> <20190815040221.DE28F2067D@mail.kernel.org> <20190815112614.GA4841@sirena.co.uk>
Subject: Re: clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-libretech-all-h3-cc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        enric.balletbo@collabora.com, guillaume.tucker@collabora.com,
        khilman@baylibre.com, matthew.hart@linaro.org,
        mgalka@collabora.com, tomeu.vizoso@collabora.com,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Mark Brown <broonie@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 15 Aug 2019 08:16:15 -0700
Message-Id: <20190815151616.2A298206C1@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2019-08-15 04:26:14)
> On Wed, Aug 14, 2019 at 09:02:20PM -0700, Stephen Boyd wrote:
> > Quoting kernelci.org bot (2019-08-14 20:35:25)
>=20
> > > clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-li=
bretech-all-h3-cc
>=20
> > If this is the only board that failed, great! Must be something in a
> > sun8i driver that uses the init structure after registration.
>=20
> The infrastructure suppresses duplicate-seeming bisections so I'd not
> count on it, check the reports on the web site.

Hmm ok. I can remove the change from -next, but I'd still like to figure
out what is using the init pointer after registration. Is there a way to
get earlycon logs?
