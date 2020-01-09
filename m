Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A59C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831AA20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578593952;
	bh=N5ayqb9hJI/an6dqyr0YYn3Ng/ODIBWl27ADDvsd2M8=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=dI4Kkpy9nPeFMjJnrBZq/4Fpg4dua0W3YGZOGizTlQoWLP4/XSmqzNXY4qgBdgjxR
	 LvN7gKCV4GbA5oc6FiCGsKXLD5maR0uDCEx9+qtacZJDvQNvUu/b8RWdHWoIpeUZur
	 4Ryj+3nCYCw9uVx9ktJwTP1+9oeYcPJZAgdJu4hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbgAISTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgAISTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:19:11 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B2B206ED;
        Thu,  9 Jan 2020 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578593950;
        bh=N5ayqb9hJI/an6dqyr0YYn3Ng/ODIBWl27ADDvsd2M8=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=LBHmaoC2zH/CzzWb9JWpt3BWiP9bRmNAqVVCrvo5nPvRajrPLr/UA9JorxddhYYG4
         V3SmrfP/HCTrfV9X2nvi3H35hMQnwpKU5K/M4/ZZURtquBsM+ItMYrXnxRIXasQx6d
         7qLATly7XljbfSva+mo51us2JMAhJdo8d5gYnbz4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200108110218.GT3040@piout.net>
References: <20191229202907.335931-1-alexandre.belloni@bootlin.com> <20200106030905.8643221582@mail.kernel.org> <20200108110218.GT3040@piout.net>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: add sama5d3 pmc driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 09 Jan 2020 10:19:09 -0800
Message-Id: <20200109181910.59B2B206ED@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2020-01-08 03:02:18)
> On 05/01/2020 19:09:04-0800, Stephen Boyd wrote:
> > > +       return;
> > > +
> > > +err_free:
> > > +       pmc_data_free(sama5d3_pmc);
> > > +}
> > > +CLK_OF_DECLARE_DRIVER(sama5d3_pmc, "atmel,sama5d3-pmc", sama5d3_pmc_=
setup);
> >=20
> > Any reason this can't be a platform driver?
> >=20
>=20
> As for the other PMC driver, we need a few of the peripheral clocks very
> early which means that we would have to register most of the clock tree
> registered early leaving only a few clocks to be registered by a
> platform driver.
>=20

What peripheral clks? Can you add a comment to the code?

