Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4058C43141
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D16820835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574791280;
	bh=omsnWS1CdzFSYWPwB5Bc/IkaXklFcCy9SMZZUTRYQzs=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=FxbezKH2RNzeN/lNNMgpZ+vIFsogYy3Fww/w8GmZoK6ujaE3UfkGvFWnG2roH4Ztz
	 8DaSaHI6Yr2SiUCmZm2JB+CuhfIEIv0QwKOkCM7S5kU7HcKrZHAX+280dSQuLBF2YI
	 XiKTBRWh7Gsl/kdToI08qGWV+4zJDjT6wb4pagmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfKZSBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKZSBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:01:19 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76792071A;
        Tue, 26 Nov 2019 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574791278;
        bh=omsnWS1CdzFSYWPwB5Bc/IkaXklFcCy9SMZZUTRYQzs=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=HaNfuNJCXCkhjrwWON6HDO91gUx5c4vNMR1sAm696rb63zkQZGtqM9XDdnHUzfvDM
         poIJW3DSg7GABxuFVkdWdUSOzGHr2qgxLOpo+OnNLsFXYxwWIe5EEvWGuqaIUhfbJu
         9owrAiqtUMfRkBfEhno9SjyQg7ED2+XEezweAKJk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACPK8XchwGdgE95jkdhwWbp0r+NHge7W3q6yQp-wzfxV3Kpajg@mail.gmail.com>
References: <20191010020655.3776-1-andrew@aj.id.au> <20191010020655.3776-3-andrew@aj.id.au> <CACPK8Xcrc_2itUcGw6caa8Fp3sJE8oHBO5LJgBtqScwmVAuHJw@mail.gmail.com> <CACPK8XchwGdgE95jkdhwWbp0r+NHge7W3q6yQp-wzfxV3Kpajg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500 MACs
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
User-Agent: alot/0.8.1
Date:   Tue, 26 Nov 2019 10:01:17 -0800
Message-Id: <20191126180118.C76792071A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-11-25 16:59:19)
> Hi Stephen,
>=20
> On Thu, 10 Oct 2019 at 23:41, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> > > single gate for each MAC.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
>=20
> I noticed this one hasn't been applied to clk-next.
>=20

It's marked awaiting upstream in my UI. I think it was some patch that
might have come through your PR?

