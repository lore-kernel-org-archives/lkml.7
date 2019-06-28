Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB98C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97560205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF1LHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:07:54 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39257
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfF1LHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:07:53 -0400
X-IronPort-AV: E=Sophos;i="5.63,427,1557180000"; 
   d="scan'208";a="311767956"
Received: from wifi-eduroam-85-160.paris.inria.fr ([128.93.85.160])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 13:07:51 +0200
Date:   Fri, 28 Jun 2019 13:07:51 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        Yi Wang <wang.yi59@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH v2] coccinelle: semantic code search for missing
 of_node_put
In-Reply-To: <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
Message-ID: <alpine.DEB.2.21.1906281304470.2538@hadrien>
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn> <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-202224278-1561720071=:2538"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-202224278-1561720071=:2538
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> > +x = @p1\(of_find_all_nodes\|
>
> I would find this SmPL disjunction easier to read without the usage
> of extra backslashes.
>
> +x =
> +(of_…
> +|of_…
> +)@p1(...);

Did you actually test this?  I doubt that a position metavariable can be
put on a ) of a disjunction.

> > +|
> > +return x;
> > +|
> > +return of_fwnode_handle(x);
>
> Can a nested SmPL disjunction be helpful at such places?
>
> +|return
> +(x
> +|of_fwnode_handle(x)
> +);

The original code is much more readable.  The internal representation will
be the same.

> > +    when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
>
> Would the specification variant “<+... x ...+>” be relevant
> for the parameter selection?

I'm indeed quite surprised that <...x...> would be accepted by the parser.

julia
--8323329-202224278-1561720071=:2538--
