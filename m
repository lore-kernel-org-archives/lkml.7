Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1EAFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AD7206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573231377;
	bh=g4CoKvF3KBeAiTVPLjlckAUsjTuuIjtO+HohvgouYnY=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=GaU1RDcnrZtp3sa6OhS0sCjUTbpI0dRFtWWgJM5h5UnslUPK82NTf9erbCXHiNSey
	 +Q0ba9mwVhjsn/SNJzNY2sQzBzyG5ek9NKc7CI2mM2/DtJwNOgU6XutsAcRmdlxdtj
	 RzGXeJYyef5KZ4wzYE09SIaLIR+zF9W399MqWpQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfKHQm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfKHQm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:42:56 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B1F206A3;
        Fri,  8 Nov 2019 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573231375;
        bh=g4CoKvF3KBeAiTVPLjlckAUsjTuuIjtO+HohvgouYnY=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=0ZpsztU1FYRY6L52Ezgj7+jOOs1x/hVT/ozS92H5H+GQTKKKDb+rMwk7lVULhGsF/
         dGkdS59Ii91Y5vgj+xTa/pyKyS5XkSwV6lSpK4251lQ1R6b0j49oYgNTuw3uUfeI3I
         WaQv+j6fKwqgsZhzEUdOkSDt+Np7ZYDzDQDg98no=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACPK8Xe7dmeVjQYObzOw9LdwxH3+1XTcU+RJOZo5C69j8d-yOg@mail.gmail.com>
References: <20191010020725.3990-1-andrew@aj.id.au> <20191010020725.3990-2-andrew@aj.id.au> <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com> <20191107230029.75ED72178F@mail.kernel.org> <CACPK8Xe7dmeVjQYObzOw9LdwxH3+1XTcU+RJOZo5C69j8d-yOg@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 08:42:54 -0800
Message-Id: <20191108164255.44B1F206A3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-11-08 03:29:41)
> On Thu, 7 Nov 2019 at 23:00, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Joel Stanley (2019-10-31 21:50:42)
> > > Hi clock maintainers,
> > >
> > > On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > The AST2600 has an explicit gate for the RMII RCLK for each of the =
four
> > > > MACs.
> > > >
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > >
> > > I needed this patch and the aspeed-clock.h one for the aspeed dts
> > > tree, so I've put them in a branch called "aspeed-clk-for-v5.5" and
> > > merged that into the aspeed tree. Could you merge that into the clock
> > > tree when you get to merging these ones?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?=
h=3Daspeed-clk-for-v5.5
> > >
> >
> > Can you send a pull request please?
>=20
> Sure. Here you go. Let me know if you need it in a separate email.
>=20
> The following changes since commit d8d9ad83a497f78edd4016df0919a49628dcaf=
bc:
>=20
>   dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
> (2019-11-01 15:01:18 +1030)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> tags/aspeed-5.5-clk
>=20
> for you to fetch changes up to d8d9ad83a497f78edd4016df0919a49628dcafbc:
>=20
>   dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
> (2019-11-01 15:01:18 +1030)
>=20
> ----------------------------------------------------------------
> ASPEED clock device tree bindings for 5.5
>=20
> ----------------------------------------------------------------

The diffstat got lost? Anyway, thanks! I pulled it into clk-next.

