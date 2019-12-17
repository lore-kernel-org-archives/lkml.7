Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10FF2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576611994;
	bh=CF9QKJaQ9DJ6x/TTz4g2ABsgpHdQolqZOBba2q9djQM=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=vMP+i+QaPEDlLvja+ni8meRamtdNaLHu3vKbgk0kyxUq/tPUY2eRMe9POSqS1SHup
	 se1Var1ah3XjhoctTPi4bfvnLo6ZVkFgdZVXqLH+6pi6S+hTlsU8QYQz8BjYJ00LBc
	 KpFAAHiyyxJT0jvz1G3hL03Zr3jGb/M0naCjdzLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLQTqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfLQTqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:46:33 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6FC2146E;
        Tue, 17 Dec 2019 19:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576611993;
        bh=CF9QKJaQ9DJ6x/TTz4g2ABsgpHdQolqZOBba2q9djQM=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=PyxzARwQMbWFON1uohCy1VDYTURiHALizTOeni4E3S0Ax5Kr5M/hLIZQF/qCNnC9e
         ZvTWCFdGip1KE1vkzwJXmtpGN12QTsVuNP5Dxwdxibv/4va6wFEJ5Z8EorkmaNksUJ
         UBEsYTRHCewiLOwg5329QG35PfWneQgTOOB5keVw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOesGMj2qRM3YhTWQubRqmjP2TgMgXVyLxHs5D=bWfd4sKnNrw@mail.gmail.com>
References: <20191217044146.127200-1-olof@lixom.net> <20191217044635.127912-1-olof@lixom.net> <20191217082501.424892072D@mail.kernel.org> <CAOesGMj2qRM3YhTWQubRqmjP2TgMgXVyLxHs5D=bWfd4sKnNrw@mail.gmail.com>
To:     Olof Johansson <olof@lixom.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: declare clk_core_reparent_orphans() inline
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 17 Dec 2019 11:46:32 -0800
Message-Id: <20191217194632.DE6FC2146E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Olof Johansson (2019-12-17 10:01:15)
> On Tue, Dec 17, 2019 at 12:25 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Olof Johansson (2019-12-16 20:46:35)
> > > A recent addition exposed a helper that is only used for
> > > CONFIG_OF. Instead of figuring out best place to have it in the order
> > > of various functions, just declare it as explicitly inline, and the
> > > compiler will happily handle it without warning.
> > >
> > > (Also fixup of a single stray empty line while I was looking at the c=
ode)
> > >
> > > Fixes: 66d9506440bb ("clk: walk orphan list on clock provider registr=
ation")
> > > Signed-off-by: Olof Johansson <olof@lixom.net>
> > > ---
> > >
> > > v3: ACTUALLY amend this time. Sigh. Time to go home.
> > >
> >
> > Isn't it simple enough to just move the function down to CONFIG_OF in
> > drivers/clk/clk.c?
>=20
> "Simple" in a 5000 line file is maybe not the right word to use, but
> yeah, sure, do with it what you want.
>=20
> Seems like clk.c could do with some refactoring? :)
>=20

Ok.

