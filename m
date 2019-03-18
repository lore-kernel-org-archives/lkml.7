Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B48C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3E920685
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552938180;
	bh=jU0Hvq4xla+ij8ejd0tcj9NnaSuDFRrX9qP2lKseDPg=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=G/I/7khAeReusLFn58PbQXr8YDIFzUcs+HCExVPyu2THS+oZ3taGKxAsRI7GLLsLR
	 iFLOImnKwKDzQqmf5PJKx7+DHblijhbiSqS/rLbZYqIt+ajfnxxwx4xK1i3wietKtr
	 IvxuXtNSTfFvBnK4h4jXBdUClWhrh/IQX5HlPqzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCRTm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfCRTm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:42:58 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90AF20685;
        Mon, 18 Mar 2019 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552938177;
        bh=jU0Hvq4xla+ij8ejd0tcj9NnaSuDFRrX9qP2lKseDPg=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=qVQlr9BsdYS76JtNhqSj3QIOxFKXc2z2VQs4TpCU1moyxOUfWM5U4IRjctLCKZUDZ
         Vu1L9U9Ak+RPqaSFOoYctYHU9ideR7weDasoC6n6rMwTkPjfqjmgE/Ba4TI+5UArKj
         ybH9dl6JzPXd8Z+mN6oUnWO/2qlJrXZvedq3ddec=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <15f0f82f-0607-4cf5-f5a5-5edd7c5321bc@xilinx.com>
References: <1551742066-10825-1-git-send-email-jollys@xilinx.com> <15f0f82f-0607-4cf5-f5a5-5edd7c5321bc@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] drivers: clk: zynqmp: Allow zero divisor value
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, linux-clk@vger.kernel.org,
        michal.simek@xilinx.com, mturquette@baylibre.com,
        sboyd@codeaurora.org
Message-ID: <155293817691.20095.7275560826051843640@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 18 Mar 2019 12:42:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michal Simek (2019-03-18 05:48:52)
> On 05. 03. 19 0:27, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >=20
> > Zero divider is valid and default for some of ZynqMP
> > clocks. Allow zero divisor when CLK_DIVIDER_ALLOW_ZERO
> > for the clock is set.
> >=20
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  drivers/clk/zynqmp/divider.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> > index a371c66..e146b6f 100644
> > --- a/drivers/clk/zynqmp/divider.c
> > +++ b/drivers/clk/zynqmp/divider.c
> > @@ -76,6 +76,13 @@ static unsigned long zynqmp_clk_divider_recalc_rate(=
struct clk_hw *hw,
> >       else
> >               value =3D div >> 16;
> > =20
> > +     if (!value) {
> > +             WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
> > +                  "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set=
\n",
> > +                  clk_name);
> > +             return parent_rate;
> > +     }
> > +
> >       return DIV_ROUND_UP_ULL(parent_rate, value);
> >  }
> > =20
> >=20
>=20
> Stephen: Do you want to take it via your tree?
>=20

Sure.

