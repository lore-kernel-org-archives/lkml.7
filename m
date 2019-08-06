Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0168C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BF2216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565128135;
	bh=jJlefsLNTHcXdSrlXz0gbSzDo7ArhuKPE0ip2ySlfZk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=OF+Amb4S5P3/1qpx5i2Nq6lyLFB8ZLECKGtCECkGZBBTETQbI5jcLY02JkQJ2APe9
	 UUjfoy1K27a7R+2hXCtBeRShoZHlHROp9mlezyRc284H/ZpXTavP2aJLCcZp4Bj2ss
	 iSMz1f9q0v2vwScox/X1QX7cKnuqjxPtsN/T7vR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfHFVsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfHFVsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:48:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE14F216F4;
        Tue,  6 Aug 2019 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565128133;
        bh=jJlefsLNTHcXdSrlXz0gbSzDo7ArhuKPE0ip2ySlfZk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=srrBWXOtzoGkFmJiNuxDu9wKwsGsgB54/PMoj8eFAizxqjUv7e/4YESmAbmU0UCb7
         6eFHX/29bco/LMbM9R6FWuOM7n3if+oYydQTNXduSKP+pzpmuOepRqPinxvB0QkiRy
         l5vdBoo7EmQgQdI5zNRXLC1jOEhdso1XVGq8SEZQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jwofqvftg.fsf@starbuckisacylon.baylibre.com>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-4-sboyd@kernel.org> <1jwofqvftg.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH 3/9] clk: meson: axg-audio: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
User-Agent: alot/0.8.1
Date:   Tue, 06 Aug 2019 14:48:52 -0700
Message-Id: <20190806214852.DE14F216F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-08-06 01:49:47)
> On Wed 31 Jul 2019 at 12:35, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > A future patch is going to change semantics of clk_register() so that
> > clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> > referencing this member here so that we don't run into NULL pointer
> > exceptions.
>=20
> Hi Stephen,
>=20
> What to do you indend to do with this one ? Will you apply directly or
> should we take it ?

I said below:

 Please ack so I can take this through clk tree

>=20
> We have several changes for the controller which may conflict with this
> one. It is nothing major but the sooner I know how this changes goes in,
> the sooner I can rebase the rest.

Will it conflict? I can deal with conflicts.

>=20
> Also, We were (re)using the init_data only on register failures.
> I understand that you want to guarantee .init is NULL when the clock is
> registered, but it this particular case, the registeration failed so the
> clock is not registered.
>=20
> IMO, it would be better if devm_clk_hw_register() left the init_data
> untouched if the registration fails.

Do you have other usage of the init_data besides printing out the name?
I think we could have devm_clk_hw_register() print out the name of the
clk that failed to register instead, and get rid of more code in drivers
that way. Unless of course there are other uses of the init struct?

>=20
> >
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >
> > Please ack so I can take this through clk tree
> >
> >  drivers/clk/meson/axg-audio.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
