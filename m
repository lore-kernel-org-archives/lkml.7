Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE0DC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79123207FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578380409;
	bh=mqVAhJYsDI+d9WjdV8n8DMR9ou/rAJnSZlAgkuo6W9o=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=WlHa4jTy3s592wkeWcc+7VeNV4Dywov4tF0sy0QK0pgro+iJJScuyOvpaRfBeXxyC
	 hZ2V8a8gvz0lUNyqqVzwkXB0VN7hXmxGeSjGHXCsK7vXvfWh3qCBz4W5JzAAj1hfAT
	 65V+3NbixtPZ4d4Jwzk5eKYBsvQ/vnOoglXugOPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAGHAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGHAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:00:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D92F206DB;
        Tue,  7 Jan 2020 07:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380407;
        bh=mqVAhJYsDI+d9WjdV8n8DMR9ou/rAJnSZlAgkuo6W9o=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=aEqhSLP7UscDWt/g0rnZTzPSmOVPtuv25EZAc0MuCqYhpQrhc2QkDjuZ7QFZBnO5h
         jYSDwkDVEbXmD91SJs+L4JIN5aokcceddk+PL+7p+gYfCcACiWmwuPH/10/4HR4ddT
         jaN5gdi57+7Tb/DTQMbTociQ4MHJsQ+oq0Hn0+50=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4726f580-fe88-5b20-e869-4e31bd63c6e3@kernel.org>
References: <20190918013459.15966-1-dinguyen@kernel.org> <20190918013459.15966-2-dinguyen@kernel.org> <20190918050010.74B4021848@mail.kernel.org> <4726f580-fe88-5b20-e869-4e31bd63c6e3@kernel.org>
Cc:     devicetree@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: socfpga: agilex: add clock driver for the Agilex platform
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 23:00:06 -0800
Message-Id: <20200107070007.6D92F206DB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2019-12-03 07:15:21)
> Hi Stephen,
>=20
> On 9/18/19 12:00 AM, Stephen Boyd wrote:
> > Quoting Dinh Nguyen (2019-09-17 18:34:59)
> >> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> >> index 0cad76021297..ef2c96c0f1e0 100644
> >> --- a/drivers/clk/Makefile
> >> +++ b/drivers/clk/Makefile
> >> @@ -18,6 +18,7 @@ endif
> >> =20
>=20
> <snip>
>=20
> >> +struct clk *agilex_register_pll(const char *name,
> >> +                               const char * const *parent_names,
> >> +                               u8 num_parents, unsigned long flags,
> >> +                               void __iomem *reg, unsigned long offse=
t)
> >> +{
> >> +       struct clk *clk;
> >> +       struct socfpga_pll *pll_clk;
> >> +       struct clk_init_data init;
> >> +
> >> +       pll_clk =3D kzalloc(sizeof(*pll_clk), GFP_KERNEL);
> >> +       if (WARN_ON(!pll_clk))
> >> +               return NULL;
> >> +
> >> +       pll_clk->hw.reg =3D reg + offset;
> >> +
> >> +       if (streq(name, SOCFPGA_BOOT_CLK))
> >> +               init.ops =3D &clk_boot_ops;
> >> +       else
> >> +               init.ops =3D &agilex_clk_pll_ops;
> >> +
> >> +       init.name =3D name;
> >> +       init.flags =3D flags;
> >> +
> >> +       init.num_parents =3D num_parents;
> >> +       init.parent_names =3D parent_names;
> >=20
> > Is it possible to use the new way of specifying clk parents here so that
> > we don't have to keep using strings to describe the clk topology?
> >=20
>=20
> Can you point me to what you mean here? Perhaps a driver that is using
> this new way of specifying clk parents?
>=20

I'm supposed to write some documentation, but you can look for drivers
that have 'struct clk_parent_data' until I write the doc up.

 $ git grep 'struct clk_parent_data' -- drivers/clk/

