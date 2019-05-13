Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E2420879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfEMLvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:51:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52931
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727690AbfEMLvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:51:47 -0400
X-IronPort-AV: E=Sophos;i="5.60,465,1549926000"; 
   d="scan'208";a="305811236"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 13:51:44 +0200
Date:   Mon, 13 May 2019 13:51:39 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [3/5] Coccinelle: put_device: Merge four SmPL when constraints
 into one
In-Reply-To: <1c36d747-ac2d-0187-ddb7-d1a2bb18ddaf@web.de>
Message-ID: <alpine.DEB.2.20.1905131350330.1009@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn> <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de> <6b62ecb5-ab88-22d9-eee2-db4f58b6d2ae@web.de> <alpine.DEB.2.20.1905131132250.3616@hadrien> <1c36d747-ac2d-0187-ddb7-d1a2bb18ddaf@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 May 2019, Markus Elfring wrote:

> >> An assignment target was repeated in four SmPL when constraints.
> >> Combine the exclusion specifications into disjunctions for the semantic
> >> patch language so that this target is referenced only once there.
> >
> > NACK.
>
> I find this rejection questionable.
>
>
> > This exceeds 80 characters
>
> The line became 105 characters long.
> 14 space characters can eventually be omitted.
>
>
> > and provides no readability benefit.
>
> I try to stress SmPL functionality in this use case.

That's not the goal of the semantic patches in the kernel.

The rule is fine as it is.

> >> +++ b/scripts/coccinelle/free/put_device.cocci
> >> @@ -23,10 +23,7 @@ if (id == NULL || ...) { ... return ...; }
> >>      when != platform_device_put(id)
> >>      when != of_dev_put(id)
> >>      when != if (id) { ... put_device(&id->dev) ... }
> >> -    when != e1 = (T)id
> >> -    when != e1 = (T)(&id->dev)
> >> -    when != e1 = get_device(&id->dev)
> >> -    when != e1 = (T1)platform_get_drvdata(id)
> >> +    when != e1 = \( (T) \( id \| (&id->dev) \) \| get_device(&id->dev) \| (T1)platform_get_drvdata(id) \)
>
> How do you think about to extend the Coccinelle software in the way
> that such a detailed constraint can be specified on separate lines
> (without duplicated SmPL code)?

This causes some ambiguities in the parser.  No change is likely to occur
here.

julia

>
> How long will it take to reconsider corresponding software limitations?
>
> Regards,
> Markus
>
