Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D1FC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48EC21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfGEF3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:29:53 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39947
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbfGEF3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:29:53 -0400
X-IronPort-AV: E=Sophos;i="5.63,453,1557180000"; 
   d="scan'208";a="312496483"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 07:29:49 +0200
Date:   Fri, 5 Jul 2019 07:29:49 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, Gilles Muller <Gilles.Muller@lip6.fr>,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        yamada.masahiro@socionext.com, cocci@systeme.lip6.fr
Subject: Re: [PATCH v2] coccinelle: semantic code search for
 missingof_node_put
In-Reply-To: <201907041103003504524@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1907050727550.18245@hadrien>
References: 1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn,904b9362-cd01-ffc9-600b-0c48848617a0@web.de,alpine.DEB.2.21.1906281304470.2538@hadrien <201907041103003504524@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1407068154-1562304590=:18245"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1407068154-1562304590=:18245
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 4 Jul 2019, wen.yang99@zte.com.cn wrote:

> > > > +x = @p1\(of_find_all_nodes\|
> > >
> > > I would find this SmPL disjunction easier to read without the usage
> > > of extra backslashes.
> > >
> > > +x =
> > > +(of_…
> > > +|of_…
> > > +)@p1(...);
> >
> > Did you actually test this?  I doubt that a position metavariable can be
> > put on a ) of a disjunction.
> >
> > > > +|
> > > > +return x;
> > > > +|
> > > > +return of_fwnode_handle(x);
> > >
> > > Can a nested SmPL disjunction be helpful at such places?
> > >
> > > +|return
> > > +(x
> > > +|of_fwnode_handle(x)
> > > +);
> >
> > The original code is much more readable.  The internal representation will
> > be the same.
> >
> > > > +    when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
> > >
> > > Would the specification variant “<+... x ...+>” be relevant
> > > for the parameter selection?
> >
> > I'm indeed quite surprised that <...x...> would be accepted by the parser..
>
> Hi julia,
>
> Thank you for your comments.
> We tested and found that both <...x...> and <+... x ...+> variants work fine.
> We use <... x ...> instead of <+... x ...+> here to eliminate the following false positives:
>
> ./drivers/media/platform/qcom/camss/camss.c:504:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 479, but without a corresponding object release within this function.
>
> 465 static int camss_of_parse_ports(struct camss *camss)
> 466 {
> ...
> 479 remote = of_graph_get_remote_port_parent(node);
> ...
> 486 asd = v4l2_async_notifier_add_fwnode_subdev(
> 487 &camss->notifier, of_fwnode_handle(remote), ---> v4l2_async_notifier_add_fwnode_subdev will pass remote to camss->notifier.
> 488 sizeof(*csd));
> ...
> 504 return num_subdevs;

I suspect that what is happening is that there is a runtime error, but
that error is caught somewhere and you don't see it.  Could you send me
again the entire semantic patch so I can check on this?

I think that what you want is:

when != v4l2_async_notifier_add_fwnode_subdev(...,<+...x...+>,...)

ie x occurring somewhere within some argument.

julia
--8323329-1407068154-1562304590=:18245--
