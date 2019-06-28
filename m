Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B9B208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561753950;
	bh=nIIHPYVF/yLKT9Kd+T0+WBhtRttyLnFzsf/YfQlcS5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kdedyx+wCohUNoV1uWIela/6j3SH5JeptJIwRVP95amhkNULvKd4/bglji+sPKv/T
	 TTLv4EC3ESlwcVhu57oYcmlZ7YtZkN8Ddx4XLdBKsVuMI8TtLxp5bTJ2SmyXPNXnl9
	 q4noSrHE/JRD9jQ9APdRSps/2pbc8l8WOONSgQk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfF1Uc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfF1Uc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:32:28 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8960A214AF;
        Fri, 28 Jun 2019 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561753947;
        bh=nIIHPYVF/yLKT9Kd+T0+WBhtRttyLnFzsf/YfQlcS5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wLQq17BvzxyNlq1t5I4duxVE2UpZL+u6VkeTC6m/6zhcoUjximdIIWTF4XSFIsNgP
         HNNma++/g3HknbooVG2pSr44CHsAAY8l0ade8kfv4ZVfjHezfp2y67DawPOsI+3aI5
         CjRhl8Td1qVsKPxfmFlqf3mhFIKQmHAg3lUTOuJA=
Received: by mail-qk1-f171.google.com with SMTP id g18so6034573qkl.3;
        Fri, 28 Jun 2019 13:32:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXtR/7svaxX0XxQm7hTxQm+3w7TiSggZ1MOvtMTBqbKJjvvpKVA
        PPbVHyxdwDrbriAZF2mpO/DomTUBXLxbtFGUfw==
X-Google-Smtp-Source: APXvYqz2D0+DUUlKtR1qaP9vt2oqvuZ5e8zpaIXRl6gPIZnL9R+FlitcymlNefVcbVGbAxG1BBP1c4Nopp23cNH6MRE=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr10667886qke.223.1561753946755;
 Fri, 28 Jun 2019 13:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190627000044.12739-1-robh@kernel.org> <alpine.DEB.2.21.9999.1906261759390.29311@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906261759390.29311@viisi.sifive.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Jun 2019 14:32:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Ej15JfU_Mx0g+Hkpz6+1CnMem507RPgUgW7CB0U8hCA@mail.gmail.com>
Message-ID: <CAL_Jsq+Ej15JfU_Mx0g+Hkpz6+1CnMem507RPgUgW7CB0U8hCA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: Limit cpus schema to only check Arm
 'cpu' nodes
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 7:02 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Wed, 26 Jun 2019, Rob Herring wrote:
>
> > Matching on the 'cpus' node was a bad choice because the schema is
> > incorrectly applied to non-Arm cpus nodes. As we now have a common cpus
> > schema which checks the general structure, it is also redundant to do so
> > in the Arm CPU schema.
> >
> > The downside is one could conceivably mix different architecture's cpu
> > nodes or have typos in the compatible string. The latter problem pretty
> > much exists for every schema.
>
> The RISC-V patch applies cleanly, but this one doesn't apply here on
> either master or next-20190626.  Is there a different base commit?

Ugg, sorry. I had another commit colliding with this in my tree. I've
fixed it now and it's in my dt/next branch.

Rob
