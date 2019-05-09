Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB8C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB3020656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557422638;
	bh=SmDmkaW75MsL1jEDf7tS9WHYvMugppiXPKUjEfdfYgQ=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=2CrQOviB/UFQu0lr0jPJEQCpKRNO3atzoajbJ7QfGli18QWQiq+9iMmAcYN4FFuNH
	 16yGi/rDUsBsIuk011u7RuRkZ76uqzbHkHYMceUfAEO1ca93/gQzD72BzwLdCCBNQz
	 P9+nZw3Bu3gAqONit4yGFe/QG/+cBIDeAQrlt+ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEIRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEIRX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:23:57 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7204720656;
        Thu,  9 May 2019 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557422636;
        bh=SmDmkaW75MsL1jEDf7tS9WHYvMugppiXPKUjEfdfYgQ=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=fryQ9HWOM2wn3nJ37x5ERhLcU+2eAx82GgdJywncy/wlg3h6tznemY3L0slFeJ65A
         9j4ZOzx+19yYqGVB/2VFMTwMSgclzbMjdXpHyu02R0E580qshrZI04aEI8qlWzIe3J
         lVVEDaYzcCcZ/G/LxI4BZP3aPUfgSCkyYtN2dCJg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <857bce4e87bc473e533c53abc0b612ee918f2474.camel@analog.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com> <20190508112842.11654-4-alexandru.ardelean@analog.com> <155733480678.14659.15999974975874060801@swboyd.mtv.corp.google.com> <857bce4e87bc473e533c53abc0b612ee918f2474.camel@analog.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 02/16] treewide: rename match_string() -> __match_string()
Cc:     "heiko@sntech.de" <heiko@sntech.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <155742263550.14659.13420287678025539904@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 09 May 2019 10:23:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ardelean, Alexandru (2019-05-09 01:52:53)
> On Wed, 2019-05-08 at 10:00 -0700, Stephen Boyd wrote:
> > [External]
> >=20
> >=20
> > (Trimming the lists but keeping lkml)
> >=20
> > Quoting Alexandru Ardelean (2019-05-08 04:28:28)
> > > This change does a rename of match_string() -> __match_string().
> > >=20
> > > There are a few parts to the intention here (with this change):
> > > 1. Align with sysfs_match_string()/__sysfs_match_string()
> > > 2. This helps to group users of `match_string()` into simple users:
> > >    a. those that use ARRAY_SIZE(_a) to specify the number of elements
> > >    b. those that use -1 to pass a NULL terminated array of strings
> > >    c. special users, which (after eliminating 1 & 2) are not that many
> > > 3. The final intent is to fix match_string()/__match_string() which is
> > >    slightly broken, in the sense that passing -1 or a positive value
> > > does
> > >    not make any difference: the iteration will stop at the first NULL
> > >    element.
> > >=20
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> >=20
> > [...]
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 96053a96fe2f..0b6c3d300411 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -2305,8 +2305,8 @@ bool clk_has_parent(struct clk *clk, struct clk
> > > *parent)
> > >         if (core->parent =3D=3D parent_core)
> > >                 return true;
> > >=20
> > > -       return match_string(core->parent_names, core->num_parents,
> > > -                           parent_core->name) >=3D 0;
> > > +       return __match_string(core->parent_names, core->num_parents,
> > > +                             parent_core->name) >=3D 0;
> >=20
> > This is essentially ARRAY_SIZE(core->parent_names) so it should be fine
> > to put this back to match_string() later in the series.
>=20
> I don't think so.
> core->parents & core->parent_names seem to be dynamically allocated array.
> ARRAY_SIZE() is a macro that expands at pre-compile time and evaluates
> correctly at compile time only for static arrays.
>=20

Ah ok. The ARRAY_SIZE() is done inside the match_string() function? I
missed that.

