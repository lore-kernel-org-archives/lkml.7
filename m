Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9EC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72120678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgAGRZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:25:10 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:48215
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbgAGRZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:25:09 -0500
X-IronPort-AV: E=Sophos;i="5.69,406,1571695200"; 
   d="scan'208";a="335054412"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 18:25:07 +0100
Date:   Tue, 7 Jan 2020 18:25:07 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Wen Yang <wenyang@linux.alibaba.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <20200107170240.47207-1-wenyang@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2001071823060.3004@hadrien>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This part is not really ideal.  For the reports, you filter for the
constants, but here you don't do anything.  You can put some python code
in the matching of the metavariables:

unsigned long ul : script:python() { whatever you want to check on ul };

Then it will only match if the condition is satisfied.

julia
