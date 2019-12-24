Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5641CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B68820709
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577156674;
	bh=owfHBdwaORIK4L5asGXD/WbRybZzQGR4SY7hj7jRnks=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=BszG+ExgCM2YVP3Xt9m4zfiY62N1ppmKUbe5AlAIhTg0Q6KImhnSoPXjNUXV0ZO9O
	 xS2ydaQa1HYS+bl9CwiI7M87tqP36DkC+kBZN9q5o4mPm95IsxOfVscjE7aASrpY6t
	 473LdiM44m+SfJvgZ7pkAksOl4ZHdLjPYH7eb8E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfLXDEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 22:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfLXDEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 22:04:32 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E93206B7;
        Tue, 24 Dec 2019 03:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577156672;
        bh=owfHBdwaORIK4L5asGXD/WbRybZzQGR4SY7hj7jRnks=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=xgXHAq+ptsMMelxcsMUUqPbuXn1zmTj7/iNcPMvpG6Hy1tkCMrc+WHIgeR0319hKS
         zJXQaEMezrBou8JR5ROMPXd3Cxsi1kvEWPcKHp87dYXb1SZgPqk6haPleYvzhqRu7/
         K8SkF6tUK2OnlnEyNo9j8etnGpkBqvlz+svNBGNo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75VdtsXjW5kaWVspi-5u6ya5512Yk7VN4HJ4Tn34PWci5Og@mail.gmail.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com> <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com> <20190828150951.GS2680@smile.fi.intel.com> <e4a1fd0a-b179-92dd-fb81-22d9d7465a33@linux.intel.com> <20190902122030.GE2680@smile.fi.intel.com> <20190902122454.GF2680@smile.fi.intel.com> <db9b8978-b9ae-d1bf-2477-78a99b82367a@linux.intel.com> <CAHp75VdtsXjW5kaWVspi-5u6ya5512Yk7VN4HJ4Tn34PWci5Og@mail.gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        robhkernel.org@smile.fi.intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
From:   Stephen Boyd <sboyd@kernel.org>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 19:04:31 -0800
Message-Id: <20191224030431.E0E93206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2019-12-07 06:57:43)
> On Fri, Dec 6, 2019 at 7:06 AM Tanwar, Rahul
> <rahul.tanwar@linux.intel.com> wrote:
> > On 2/9/2019 8:24 PM, Andy Shevchenko wrote:
> > >>
> > >>      div =3D val < 3 ? (val + 1) : (1 << ((val - 3) / 3));
> > > It's not complete, but I think you got the idea.
> > >
> > >> So, can we eliminate table?
> >
> > In the desperation to eliminate table, below is what i can come up with:
> >
> >         struct clk_div_table div_table[16];
>=20
> But this is not an elimination, it's just a replacement from static to
> dynamically calculated one.
>=20
> >         int i, j;
> >
> >         for (i =3D 0; i < 16; i++)
> >                 div_table[i].val =3D i;
> >
> >         for (i =3D 0, j=3D0; i < 16; i+=3D3, j++) {
> >                 div_table[i].div =3D (i =3D=3D 0) ? (1 << j) : (1 << (j=
 + 1));
> >                 if (i =3D=3D 15)
> >                         break;
> >
> >                 div_table[i + 1].div =3D (i =3D=3D 0) ? ((1 << j) + 1) :
> >                                         (1 << (j + 1)) + (1 << (j - 1));
> >                 div_table[i + 2].div =3D (3 << j);
> >         }
> >
> > To me, table still looks a better approach. Also, table is more extenda=
ble &
> > consistent w.r.t. clk framework & other referenced clk drivers.
> >
> > Whats your opinion ?
>=20
> Whatever CCF maintainers is fine with.
>=20

Table is fine. Or something that calculates is also fine. Is it going to
be extended in the future? If we're talking about a driver for hardware
I wonder if this is really going to change in the future.

Please resend so your binding can be reviewed.

