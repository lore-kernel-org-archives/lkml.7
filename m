Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08EC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E103222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 07:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgADHRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 02:17:01 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47665
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbgADHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 02:17:01 -0500
X-IronPort-AV: E=Sophos;i="5.69,393,1571695200"; 
   d="scan'208";a="334728961"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2020 08:16:58 +0100
Date:   Sat, 4 Jan 2020 08:16:58 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Wen Yang <wenyang@linux.alibaba.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <20200104064448.24314-1-wenyang@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2001040815230.2636@hadrien>
References: <20200104064448.24314-1-wenyang@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



--- Please note the new email address ---


On Sat, 4 Jan 2020, Wen Yang wrote:

> do_div() does a 64-by-32 division.
> When the divisor is unsigned long, u64, or s64,
> do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.

Would it be worth having a specific warning message for the long/unsigned
long case?  If the target architecture has 32 bit longs then the warning
can be immediately ignored.

julia


> This semantic patch is inspired by Mateusz Guzik's patch:
> commit b0ab99e7736a ("sched: Fix possible divide by zero in avg_atom() calculation")
>
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Matthias Maennich <maennich@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: cocci@systeme.lip6.fr
> Cc: linux-kernel@vger.kernel.org
> ---
>  scripts/coccinelle/misc/do_div.cocci | 66 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/do_div.cocci
>
> diff --git a/scripts/coccinelle/misc/do_div.cocci b/scripts/coccinelle/misc/do_div.cocci
> new file mode 100644
> index 0000000..f1b72d1
> --- /dev/null
> +++ b/scripts/coccinelle/misc/do_div.cocci
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// do_div() does a 64-by-32 division.
> +/// When the divisor is unsigned long, u64, or s64,
> +/// do_div() truncates it to 32 bits, this means it
> +/// can test non-zero and be truncated to zero for division.
> +///
> +//# This makes an effort to find those inappropriate do_div () calls.
> +//
> +// Confidence: Moderate
> +// Copyright: (C) 2020 Wen Yang, Alibaba.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual context
> +virtual org
> +virtual report
> +
> +@depends on context@
> +expression f;
> +long l;
> +unsigned long ul;
> +u64 ul64;
> +s64 sl64;
> +
> +@@
> +(
> +* do_div(f, l);
> +|
> +* do_div(f, ul);
> +|
> +* do_div(f, ul64);
> +|
> +* do_div(f, sl64);
> +)
> +
> +@r depends on (org || report)@
> +expression f;
> +long l;
> +unsigned long ul;
> +position p;
> +u64 ul64;
> +s64 sl64;
> +@@
> +(
> +do_div@p(f, l);
> +|
> +do_div@p(f, ul);
> +|
> +do_div@p(f, ul64);
> +|
> +do_div@p(f, sl64);
> +)
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +msg="WARNING: WARNING: do_div() does a 64-by-32 division, which may truncation the divisor to 32-bit"
> +coccilib.org.print_todo(p[0], msg)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg="WARNING: WARNING: do_div() does a 64-by-32 division, which may truncation the divisor to 32-bit"
> +coccilib.report.print_report(p[0], msg)
> --
> 1.8.3.1
>
>
