Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD229C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858E221726
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfEOGKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:10:30 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49658 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfEOGKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:10:30 -0400
X-IronPort-AV: E=Sophos;i="5.60,471,1549926000"; 
   d="scan'208";a="383210525"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 08:10:08 +0200
Date:   Wed, 15 May 2019 08:10:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     markus.elfring@web.de, Gilles Muller <Gilles.Muller@lip6.fr>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, ma.jiang@zte.com.cn
Subject: Re: [PATCH 3/3] Coccinelle: pci_free_consistent: Extend whenconstraints
 for two SmPL ellipses
In-Reply-To: <201905151043340243098@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1905150808180.2591@hadrien>
References: e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de,c4e9153c-234e-ab5a-0061-221374c2505b@web.de,alpine.DEB.2.21.1905142150360.2612@hadrien <201905151043340243098@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 May 2019, wen.yang99@zte.com.cn wrote:

> Hello,
> > >
> > > A SmPL ellipsis was specified for a search approach so that additional
> > > source code would be tolerated between an assignment to a local variable
> > > and the corresponding null pointer check.
> > >
> > > But such code should be restricted.
> > > * The local variable must not be reassigned there.
> > > * It must also not be forwarded to an other assignment target.
> > >
> > > Take additional casts for these code exclusion specifications into account
> > > together with optional parentheses.
> >
> > I leave this up to the ZTE people.
> > julia
> >
> Thanks.
>
> 1, "id = (T2)(e)" is rare.

Thanks for checking.  I don't really care if it is rare.  There should not
be much cost to this.  On the other hand, I do care about causing false
negatives.  I don't know any more what is the type of id.  Making it
identifier would lead to false negatives as noted below.  It would be
better as something like e2->fld.

julia

> It may be a minor detail that will have no impact in practice.
> We've tested it, and this SmPL may only need to fix the following two false positives:
> ./drivers/net/ethernet/cisco/enic/vnic_dev.c:861:1-7: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 855 and return without freeing on line 861
> ./drivers/message/fusion/mptctl.c:2643:2-8: ERROR: missing pci_free_consistent; pci_alloc_consistent on line 2511 and return without freeing on line 2643
>
> 2,  If you really plan to add the two restrictions above,
> you may need to consider this further than simply adding a "when != id = (T2)(e)" statement.
> I constructed the flollowing code snippet as a test case:
>
> int test()
> {
> 	unsigned char *new_page = NULL;
> 	int ret;
>
> 	new_page = pci_alloc_consistent(dev, 4096, &temp_pci);
> 	if (new_page == NULL)
>     return -1;
> X;
> 	Y;
> 	new_page = Z;
>
> 	return ret;
> }
>
> Using the original SmPL, we can find a bug.
> But with your modified SmPL, we can't find the bug.
>
> --
> Regards,
> Wen
>
> >
> >
> > >
> > > Fixes: f7b167113753e95ae61383e234f8d10142782ace ("scripts: Coccinelle script for pci_free_consistent()")
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >  scripts/coccinelle/free/pci_free_consistent.cocci | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/pci_free_consistent.cocci
> > > index 45bc14ece151..48a36adfa3ce 100644
> > > --- a/scripts/coccinelle/free/pci_free_consistent.cocci
> > > +++ b/scripts/coccinelle/free/pci_free_consistent.cocci
> > > @@ -13,13 +13,15 @@ virtual org
> > >  local idexpression id;
> > >  expression x,y,z,e;
> > >  position p1,p2;
> > > -type T;
> > > +type T,T2,T3,T4;
> > >  @@
> > >
> > >  id = pci_alloc_consistent@p1(x,y,&z)
> > > -... when != e = id
> > > + ... when != id = (T2)(e)
> > > +     when != e = (T3)(id)
> > >  if (id == NULL || ...) { ... return ...; }
> > >  ... when != pci_free_consistent(x,y,id,z)
> > > +    when != id = (T4)(e)
> > >      when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
> > >      when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
> > >      when != e = (T)id
> > > --
> > > 2.21.0
> > >
> > >
