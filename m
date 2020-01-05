Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F47C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6744920715
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAEKlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:41:03 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19651 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgAEKlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:41:02 -0500
X-IronPort-AV: E=Sophos;i="5.69,398,1571695200"; 
   d="scan'208";a="429930408"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 11:41:00 +0100
Date:   Sun, 5 Jan 2020 11:41:00 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <21e9861a-5afc-fd66-cfd1-a9b5b92b230b@web.de>
Message-ID: <alpine.DEB.2.21.2001051139010.2579@hadrien>
References: <20200104064448.24314-1-wenyang@linux.alibaba.com> <21e9861a-5afc-fd66-cfd1-a9b5b92b230b@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2099431970-1578220860=:2579"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2099431970-1578220860=:2579
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 5 Jan 2020, Markus Elfring wrote:

> > +virtual context
> > +virtual org
> > +virtual report
>
> The operation mode “patch” is not supported here.
> Should the term “semantic code search” be used instead in the subject again?

Doesn't matter,

>
>
> > +@@
> > +(
> > +* do_div(f, l);
> > +|
> > +* do_div(f, ul);
> > +|
> > +* do_div(f, ul64);
> > +|
> > +* do_div(f, sl64);
> > +)
>
> I suggest to avoid the specification of duplicate SmPL code.
>
> +@@
> +*do_div(f, \( l \| ul \| ul64 \| sl64 \) );

I don't se any point to this.  The code matched will be the same in both
cases.  The original code is quite readable, without the ugly \( etc.

>
> Will any more case distinctions become helpful?
>
>
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +
> > +msg="WARNING: WARNING: do_div() does a 64-by-32 division, which may truncation the divisor to 32-bit"
> > +coccilib.report.print_report(p[0], msg)
>
> Please improve the message construction.

Please make more precise comments (I already made some suggestions, so it
doesn't matter much here, but "please improve" does not provide any
concrete guidance).

julia
--8323329-2099431970-1578220860=:2579--
