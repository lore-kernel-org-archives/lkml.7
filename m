Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66925C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E942086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfENGw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:52:58 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43586
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfENGw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:52:58 -0400
X-IronPort-AV: E=Sophos;i="5.60,467,1549926000"; 
   d="scan'208";a="305905534"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 08:52:54 +0200
Date:   Tue, 14 May 2019 08:52:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [4/5] Coccinelle: put_device: Extend when constraints for two
 SmPL ellipses
In-Reply-To: <4116e083-9e21-62d7-10b7-5cb26594144c@web.de>
Message-ID: <alpine.DEB.2.21.1905140849570.2567@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn> <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de> <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de> <alpine.DEB.2.20.1905131130530.3616@hadrien> <4116e083-9e21-62d7-10b7-5cb26594144c@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 May 2019, Markus Elfring wrote:

> >> A SmPL ellipsis was specified for a search approach so that additional
> >> source code would be tolerated between an assignment to a local variable
> >> and the corresponding null pointer check.
> >>
> >> But such code should be restricted.
> >> * The local variable must not be reassigned there.
> >> * It must also not be forwarded to an other assignment target.
> >>
> >> Take additional casts for these code exclusion specifications into account
> >> together with optional parentheses.
> >
> > NACK.
>
> Can you agree to any information which I presented in the commit message?
>
>
> > You don't need so many type metavariables.
>
> It seems that the Coccinelle software can cope also with my SmPL code addition.
> You might feel uncomfortable with the suggested changes for a while.

It's ugly.  Much more ugly than msg =

>
>
> > Type metavariables in the same ... can be the same.
>
> Such information is good to know for the proper usage of specifications
> after a SmPL ellipsis.
>
> * Can it become required to identify involved source code placeholders
>   by extra metavariables?

I don't understand the question.

> * Would you like to clarify the probability any more how often the shown
>   type casts will be identical?

No idea about this one either.

Basically, if you have T && T, the two T's have to be the same, and T is
not pure.  If you have T || T, then only one will be matched and T remains
pure.  If you have T on two separate ...s then you are in the && case.  If
you have T in two branches of a disjunction or in two whens on the same
... you are in the || case.  Just as you can use the variable e1 over and
over on the same when, you can use the same T.

julia
