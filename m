Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E38C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4079C20748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574699724;
	bh=djhyZJDtxB70JBGj3o4DS80jcr7ceSVnPnc8G1l/Mrk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0gY6Kx8SolFkensQYu0FE/aEu4jq/cItRZ1HsbkdUMECYccDmKtI3AA0KYyqEgP/1
	 YcB3mVOXckJCUnfsIVO28PNT3EEEu4juN+6eQgfJOGUwPoeIKqW9coa+X2y0m8F5OQ
	 rAC5d2mtFhlYi7hzsuQHDuU/7neJ5eWZhF7BMayM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfKYQfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfKYQfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:35:22 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F1920740;
        Mon, 25 Nov 2019 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574699722;
        bh=djhyZJDtxB70JBGj3o4DS80jcr7ceSVnPnc8G1l/Mrk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ApvQiZNesjcWJJDV0zN9Wjny9kGpbkQVYxD5zT+gHd8VYKOON1UigLALXqh7WEqUi
         ZR55Mj03230H0OrhDIQu5Nl7JVn2aJABxrVv10sBQGLwqGbUGz9ZFaM+sFXpw/VLDX
         QZCBTuUlAwqTSmn0zzaNOIaPfM6eeULQuWqPO/qY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAfSe-uwOvQSWUkOEw1m0C5wnKH1z0gSdjzAMTayKS3cphXMtA@mail.gmail.com>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com> <20191025111338.27324-6-chunyan.zhang@unisoc.com> <20191113221952.AD925206E3@mail.kernel.org> <CAAfSe-twxx4PyERHXuYcoehPoNYiVaOS4hZEK0KndoM2sL_5gQ@mail.gmail.com> <20191125013312.ACC2E2071A@mail.kernel.org> <CAAfSe-uwOvQSWUkOEw1m0C5wnKH1z0gSdjzAMTayKS3cphXMtA@mail.gmail.com>
Subject: Re: [PATCH 5/5] clk: sprd: add clocks support for SC9863A
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
User-Agent: alot/0.8.1
Date:   Mon, 25 Nov 2019 08:35:21 -0800
Message-Id: <20191125163521.D9F1920740@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-11-24 18:10:58)
> On Mon, 25 Nov 2019 at 09:33, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Chunyan Zhang (2019-11-17 03:27:15)
> > >
> > > Not sure if I understand correctly - do you mean that switch to use a
> > > reference to clk_parent_data.hw in the driver instead?
> > > like:
> > > https://elixir.bootlin.com/linux/v5.4-rc7/source/drivers/clk/qcom/gcc=
-sm8150.c#L136
> > >
> >
> > Yes something like that.
> >
> > > Since if I have to define many clk_parent_data.fw_name strings
> > > instead, it seems not able to reduce the code size, right?
> >
> > Ideally there are some internal only clks that can be linked to their
>=20
> If the *internal* clks should be in the same base address, then we
> have many external clks as parents, since most of our clks are not
> located according to modules which clks serve, but according to clk
> type.
>=20
> > parent with a single clk_hw pointer. That will hopefully keep the size
>=20
> Since all clks used for a chip are defined in the same driver file, I
> actually can use clk_hw pointer directly, that will cut down the size
> of this driver code, and also easier for users to look for parents for
> one clk (only need to look at driver file).
>=20
> But not sure if you aggree this way?

If all clks are in the same file then it sounds fine to just use clk_hw
pointers everywhere.

>=20
> > down somewhat. And if there are any external clks, they can be described
> > in DT and then only the .fw_name field can be used and the fallback
> > field .name can be left assigned to NULL.
>=20
> Yes, I noticed that. But I still need to add many .fw_name, that will
> not be a small count.
>=20

Sure. The plan is to get rid of the array of string names to specify
parents. We can debate the size and cost associated with moving away
from that, but it won't change the overall message here that I'd like to
see new drivers use the new way of specifying parents instead of using
strings for topology description.

