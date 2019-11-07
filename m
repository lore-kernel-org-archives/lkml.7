Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E9FC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F0D21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573167631;
	bh=iatOuGVaEBWa1WK3FQpf+kZSEyjOgjCvm+7pE6XkBpk=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=hqNqkClLGe9D4m75cYJvJZSapIfj6H2ar1NiZdwN8Sq4h9wHNCHXIlxAnEihvfk40
	 nSm1BlMv7AknZJCwcjxIZyjM0RVwogSeXl0VZpQ2zZM66L7ClpKTOf5TPogkUqbybj
	 WKdgLGh+pbwE54p81fg+DU5pqHBHl6SdkuQWvtYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfKGXAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:00:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfKGXAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:00:30 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ED72178F;
        Thu,  7 Nov 2019 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573167629;
        bh=iatOuGVaEBWa1WK3FQpf+kZSEyjOgjCvm+7pE6XkBpk=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=1hXIx7ueKCiIl4/GZvb4LCtwk8iz7ngEhRfQVBOl9SE0cO9c9DTTq0EFqJtapuQOy
         x8mRVVS2KkW6Q4mKiNNJLW6CwNyJdykzvXflx8hrVjKLNJ1ifhEpuRn+1YKSYmpRi+
         ZUWc0UrSbrFnHVDbdSxmUXmiwfLu/K4shvzyLyaM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com>
References: <20191010020725.3990-1-andrew@aj.id.au> <20191010020725.3990-2-andrew@aj.id.au> <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 15:00:28 -0800
Message-Id: <20191107230029.75ED72178F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-10-31 21:50:42)
> Hi clock maintainers,
>=20
> On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The AST2600 has an explicit gate for the RMII RCLK for each of the four
> > MACs.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>=20
> I needed this patch and the aspeed-clock.h one for the aspeed dts
> tree, so I've put them in a branch called "aspeed-clk-for-v5.5" and
> merged that into the aspeed tree. Could you merge that into the clock
> tree when you get to merging these ones?
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?h=3D=
aspeed-clk-for-v5.5
>=20

Can you send a pull request please?

