Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A0C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F1E218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394859AbfIGQFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:05:32 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38239 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392003AbfIGQFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:05:32 -0400
X-IronPort-AV: E=Sophos;i="5.64,477,1559512800"; 
   d="scan'208";a="400701616"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 18:05:29 +0200
Date:   Sat, 7 Sep 2019 18:05:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: =?UTF-8?Q?Re=3A_Adjusting_SmPL_script_=E2=80=9Cptr=5Fret=2Ecocci?=
 =?UTF-8?Q?=E2=80=9D=3F?=
In-Reply-To: <c8e0db8a-1f96-dac0-791c-43e2d1e1cf05@web.de>
Message-ID: <alpine.DEB.2.21.1909071804090.2562@hadrien>
References: <c8e0db8a-1f96-dac0-791c-43e2d1e1cf05@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-185961993-1567872329=:2562"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-185961993-1567872329=:2562
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 7 Sep 2019, Markus Elfring wrote:

> Hello,
>
> I have taken another look at a known script for the semantic patch language.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/ptr_ret.cocci?id=1e3778cb223e861808ae0daccf353536e7573eed#n3
>
> I got the impression that duplicate SmPL code can be reduced here.
> So I tried the following approach out.
>
> …
> @depends on patch@
> expression ptr;
> @@
> (
> (
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> |
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> )
> + return PTR_ERR_OR_ZERO(ptr);
> |
> - (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
> + PTR_ERR_OR_ZERO(ptr)
> )
> …
>
>
> Unfortunately, I got the following information then for a test transformation.
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch -D patch scripts/coccinelle/api/ptr_ret.cocci drivers/spi/spi-gpio.c
> …
> 29: no available token to attach to
>
>
> It seems that the Coccinelle software “1.0.7-00218-gf284bf36” does not like
> the addition of the shown return statement after a nested SmPL disjunction.
> But the following SmPL code variant seems to work as expected.
>
>
> …
> @depends on patch@
> expression ptr;
> @@
> (
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> + return PTR_ERR_OR_ZERO(ptr);
> |
> - if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> + return PTR_ERR_OR_ZERO(ptr);
> |
> - (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
> + PTR_ERR_OR_ZERO(ptr)
> )
> …
>
>
> How do you think about to reduce subsequent SmPL rules also according to
> a possible recombination of affected implementation details?

There is not going to be any change with respect to this issue.  It's fine
when replacing one statement by another, but introduces complexity when
removing something more complex.  And there's not point to have something
that works in only one special case.

julia
--8323329-185961993-1567872329=:2562--
