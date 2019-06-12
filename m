Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E423C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631542063F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445394;
	bh=l4zTQw5iuVI5u2179hf0ZvOJfs8bcO/Q5NNJY+li7E4=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=aDpkqqgL9EKkhXVWpWZoyGLBV7cXw6yWoG5a1kC3ijs0iq0cjQ2kpaZQ6FPNh+Cmi
	 xbHNapKCSy6BXHeRAvgbPpfVIXcRlTxmkVkzAZV7D6jP9zKa2p2NivvhOJ/CMfKPX1
	 shz1PrPqsgxsBJ5wF8VLfIoW8sKfAGQt8QNvcyaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfFMRDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfFLXAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:00:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B5B20896;
        Wed, 12 Jun 2019 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560380437;
        bh=l4zTQw5iuVI5u2179hf0ZvOJfs8bcO/Q5NNJY+li7E4=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=rBSHgyy3EKq17XCPFCa5swhMphCseFqHCsP3YRVDFmBJv1AAjNo9DoD14m/roAUJ+
         q0HpVndeHitDymOYBwyYoCam4uCtVGeAaH+lC84VcF/eTv2T6uG9leco/1PbwFJcwI
         wNB0Y8KN3LP0z2CEuZsHnGiCK4/AxgoXKhHrTA2Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGb2v661GYVmq9Xvw9j3RN1jV5Xe2c-naHkvEcVFSbHkeW3HBQ@mail.gmail.com>
References: <20190524072745.27398-1-amergnat@baylibre.com> <CAGb2v661GYVmq9Xvw9j3RN1jV5Xe2c-naHkvEcVFSbHkeW3HBQ@mail.gmail.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        wens Tsai <wens213@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        baylibre-upstreaming@groups.io,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: fix clock global name usage.
User-Agent: alot/0.8.1
Date:   Wed, 12 Jun 2019 16:00:36 -0700
Message-Id: <20190612230037.52B5B20896@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting wens Tsai (2019-06-10 23:46:17)
> On Fri, May 24, 2019 at 3:29 PM Alexandre Mergnat <amergnat@baylibre.com>=
 wrote:
> >
> > A recent patch allows the clock framework to specify the parent
> > relationship with either the clk_hw pointer, the global name or through
> > Device Tree name.
> >
> > But the global name isn't handled by the clk framework because the DT n=
ame
> > is considered valid even if it's NULL, so of_clk_get_hw() returns an
> > unexpected clock (the first clock specified in DT).
> >
> > This can be fixed by calling of_clk_get_hw() only when DT name is not N=
ULL.
> >
> > Fixes: fc0c209c147f ("clk: Allow parents to be specified without string=
 names")
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> >  drivers/clk/clk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index bdb077ba59b9..9624a75e5a8d 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -368,7 +368,7 @@ static struct clk_core *clk_core_get(struct clk_cor=
e *core, u8 p_index)
> >         const char *dev_id =3D dev ? dev_name(dev) : NULL;
> >         struct device_node *np =3D core->of_node;
> >
> > -       if (np && index >=3D 0)
> > +       if (name && np && index >=3D 0)
>=20
> I think the opposite should be the case. If either the name or index is v=
alid,
> and there's a device node backing it, the code path should be entered.
>=20
> This is implied by the description of struct clk_parent_data:
>=20
>     @index: parent index local to provider registering clk (if @fw_name a=
bsent)
>=20
> So the code path should be valid regardless of the value of .index.
>=20
> That would make it
>=20
>         if (np && (name || index >=3D 0)) ...
>=20

Sure. I'll post my fix and pick the patch into clk-fixes so that this
works.

