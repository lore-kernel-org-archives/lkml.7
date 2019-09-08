Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F86C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCEE206CD
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfIHIYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 04:24:01 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:30645 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbfIHIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 04:24:01 -0400
X-IronPort-AV: E=Sophos;i="5.64,481,1559512800"; 
   d="scan'208";a="400736864"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 10:23:58 +0200
Date:   Sun, 8 Sep 2019 10:23:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Petr Strnad <strnape1@fel.cvut.cz>,
        Wen Yang <wen.yang99@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: Coccinelle: pci_free_consistent: Checking when constraints
In-Reply-To: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
Message-ID: <alpine.DEB.2.21.1909081019020.3340@hadrien>
References: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-349894428-1567931038=:3340"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-349894428-1567931038=:3340
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 8 Sep 2019, Markus Elfring wrote:

> Hello,
>
> I have taken another look at a known script for the semantic patch language.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/free/pci_free_consistent.cocci?id=950b07c14e8c59444e2359f15fd70ed5112e11a0#n2
>
> The following SmPL code is used there so far.
>
> …
> ... when != pci_free_consistent(x,y,id,z)
>     when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
>     when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
> …
>
>
> It is specified that a specific function call should be excluded
> in a source code search.
> I do not see a need to repeat the specification twice that such a call
> could eventually happen also within a branch of another if statement.
> How do you think about to omit possibly redundant SmPL code at this place?

Have you actually run the rule and checked the impact of your proposed
change?

The when exists below these lines has an impact.  I believe that the rule
is ok as is.  A single path may have no call to pci_free_consistent, but
if it has that call under one of the mentioned ifs, then the path is still
ok, and not something that an error should be reported about.

julia
--8323329-349894428-1567931038=:3340--
