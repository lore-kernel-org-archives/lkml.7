Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C81C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3B2206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559852211;
	bh=dtO+5DakYD+OBjmih0j/tzf4TsEgQw8kAWSobV34pos=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=wTd9kcfdY2ZcxLPVps96S7lxiUn6yywrGnd/8grLk/TR3vPJaG51al358XBEo+dgC
	 s/ySyN4HFVLuWqHot/AFGeTaEvMiNMq34rqGl5/2sm3Gee9XB7i1UlR5/70BEOTPpL
	 pG6PhpgynBR0TeS5yE0N9+Y3JeSTj3Ud5r4nzJ60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfFFUQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbfFFUQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:16:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CC4206BB;
        Thu,  6 Jun 2019 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852206;
        bh=dtO+5DakYD+OBjmih0j/tzf4TsEgQw8kAWSobV34pos=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=auni+q2MkEs6XpdIx4TVt3rGKVBpTISGYV2lWzplv/HgVbnBkbp+TWJaf1JO/ZbFh
         sLQaF2cKycyi5+/vb5dOZUwEoYfrbPEXQ7I7HcjVaoqTg/hgvjcaoZi0B7cYf2mxbY
         vAGlb05B3a4l5vjuwDPvHqrHs18xVWrZOxVNatf4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190605160043.GA4351@zhanggen-UX430UQ>
References: <20190531011424.GA4374@zhanggen-UX430UQ> <eb8e2d33-e8f7-93a5-c8bc-98731c0d63b6@suse.cz> <20190605160043.GA4351@zhanggen-UX430UQ>
To:     Gen Zhang <blackgod016574@gmail.com>, Jiri Slaby <jslaby@suse.cz>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: fix a missing-free bug in clk_cpy_name()
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 13:16:45 -0700
Message-Id: <20190606201646.B4CC4206BB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gen Zhang (2019-06-05 09:00:43)
> On Wed, Jun 05, 2019 at 08:38:00AM +0200, Jiri Slaby wrote:
> > On 31. 05. 19, 3:14, Gen Zhang wrote:
> > > In clk_cpy_name(), '*dst_p'('parent->name'and 'parent->fw_name') and =

> > > 'dst' are allcoted by kstrdup_const(). According to doc: "Strings=20
> > > allocated by kstrdup_const should be freed by kfree_const". So=20
> > > 'parent->name', 'parent->fw_name' and 'dst' should be freed.
> > >=20
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > ---
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index aa51756..85c4d3f 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -3435,6 +3435,7 @@ static int clk_cpy_name(const char **dst_p, con=
st char *src, bool must_exist)
> > >     if (!dst)
> > >             return -ENOMEM;
> > > =20
> > > +   kfree_const(dst);
> >=20
> > So you are now returning a freed pointer in dst_p?
> Thanks for your reply. I re-examined the code, and this kfree is=20
> incorrect and it should be deleted.
> >=20
> > >     return 0;
> > >  }
> > > =20
> > > @@ -3491,6 +3492,8 @@ static int clk_core_populate_parent_map(struct =
clk_core *core)
> > >                             kfree_const(parents[i].name);
> > >                             kfree_const(parents[i].fw_name);
> > >                     } while (--i >=3D 0);
> > > +                   kfree_const(parent->name);
> > > +                   kfree_const(parent->fw_name);
> >=20
> > Both of them were just freed in the loop above, no?
> for (i =3D 0, parent =3D parents; i < num_parents; i++, parent++)
> Is 'parent' the same as the one from the loop above?

Yes. Did it change somehow?

>=20
> Moreover, should 'parents[i].name' and 'parents[i].fw_name' be freed by
> kfree_const()?
>=20

Yes? They're allocated with kstrdup_const() in clk_cpy_name(), or
they're NULL by virtue of the kcalloc and then kfree_const() does
nothing.

I'm having a hard time following what this patch is trying to fix. It
looks unnecessary though so I'm going to drop it from the clk review
queue.

