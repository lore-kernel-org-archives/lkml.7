Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD4C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2232053B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfGAMrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:47:35 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:17047
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727479AbfGAMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:47:34 -0400
X-IronPort-AV: E=Sophos;i="5.63,439,1557180000"; 
   d="scan'208";a="312023377"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 14:47:31 +0200
Date:   Mon, 1 Jul 2019 14:47:25 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: Re: [PATCH v2] Coccinelle: Add a SmPL script for the reconsideration
 of redundant dev_err() calls
In-Reply-To: <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
Message-ID: <alpine.DEB.2.20.1907011442390.4005@hadrien>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de> <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de> <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jul 2019, Enrico Weigelt, metux IT consult wrote:

> On 01.07.19 10:10, Markus Elfring wrote:
>
> Hi folks,
>
> > +@script:python to_do depends on org@
> > +p << or.p;
> > +@@
> > +coccilib.org.print_todo(p[0],
> > +                        "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> > +
> > +@script:python reporting depends on report@
> > +p << or.p;
> > +@@
> > +coccilib.report.print_report(p[0],
> > +                             "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> > --
>
> By the way: do we have any mechanism for explicitly suppressing
> individual warnings (some kind of annotation), when the maintainer is
> sure that some particular case is a false-positive ?
> (I'm thinking of something similar to certain #praga directives for
> explicitly ignoring invididual warnings in specific lines of code)
>
> I believe such a feature, so we don't get spammed with the same false
> positives again and again.

0-day takes care of it on its own.  Probably other such bots do the same.
I'm not sure that it is a good idea to clutter the kernel code with such
annotations, especially since the whole point of Ccocinelle is that the
rules are easy to change.  We also made a tool named Herodotos for
collecting identical reports over time, but it seems to be not so easy to
use.

julia
