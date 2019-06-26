Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D41C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E1921726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561575242;
	bh=f5WpHBtEtFahIw3vdUhL2oQjYqmF7FGf/RrCjS8X2io=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=o4txt7equ/pj2TL8erYLJm6NZxoUKxVQaMvH3F7pftWJK0tBnHHjhVfqvr/folEOZ
	 rz80SpAXQ1oYJ4YDq2yn0Nqz8Df2NmCXSRd058BMdHbzSay8Dg7Hzgn89t+eKBAs8Z
	 5sYMAM1X2PKC2TmzTDCgV/LxzCWOZhCee44Sr+s4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFZSyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZSyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:54:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90C120B1F;
        Wed, 26 Jun 2019 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561575240;
        bh=f5WpHBtEtFahIw3vdUhL2oQjYqmF7FGf/RrCjS8X2io=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=2DgVwPGP72rgzQZSWHXMghXrWIppNM0nQ8i48SfoOD1tLrP9zDD7brzNtRI0QJOXc
         Qe+aMbqYbnlToGBRDg97O+pH0iaHjjItDJlEQ5QnLdAvFL8zCBC8FrUnBJnw34Zq/W
         juX/mJDB/4OZrSjpNW/8We1tG3C7qk6zjbQyeYFo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190621093302.GJ23549@piout.net>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com> <20190618095521.GE23549@piout.net> <929ac20b-db1d-3f7a-b37c-0dfb253156d5@microchip.com> <20190621093302.GJ23549@piout.net>
Subject: Re: [PATCH 0/7] clk: at91: sckc: improve error path
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, Nicolas.Ferre@microchip.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, claudiu.beznea@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:53:59 -0700
Message-Id: <20190626185359.D90C120B1F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-06-21 02:33:02)
> On 20/06/2019 10:30:42+0000, Claudiu.Beznea@microchip.com wrote:
> > Hi,
> >=20
> > On 18.06.2019 12:55, Alexandre Belloni wrote:
> > > On 13/06/2019 15:37:06+0000, Claudiu.Beznea@microchip.com wrote:
> > >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> > >>
> > >> Hi,
> > >>
> > >> This series tries to improve error path for slow clock registrations
> > >> by adding functions to free resources and using them on failures.
> > >>
> > >=20
> > > Does the platform even boot when the slow clock is not available?=20
> > >=20
> > > The TCB clocksource would fail at:
> > >=20
> > >         tc.slow_clk =3D of_clk_get_by_name(node->parent, "slow_clk");
> > >         if (IS_ERR(tc.slow_clk))
> > >                 return PTR_ERR(tc.slow_clk);
> > >=20
> >=20
> > In case of using TC as clocksource, yes, the platform wouldn't boot if =
slow
> > clock is not available, because, anyway the TC needs it. PIT may work
> > without it (if slow clock is not used to drive the PIT).
> >=20
> > For sure there are other IPs (which may be or are driven by slow clock)
> > which may not work if slow clock is driven them.
> >=20
> > Anyway, please let me know if you feel this series has no meaning.
> >=20
>=20
> Well, I'm not sure it is worth it but at the same time, it is not adding
> many lines and you already developed it...
>=20

Is that a Reviewed-by or a Rejected-by tag?

