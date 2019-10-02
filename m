Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA783C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B28217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="RsaX3chV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJBWFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:05:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40069 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBWFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:05:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so311127qkb.7;
        Wed, 02 Oct 2019 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1s738KR7peDPdk0egrEOotdFH/XvdoPuk8qM2dZV4+M=;
        b=RsaX3chVgIapb461BDRuC0sDD0I5xgnK4SHyqIX74Teg/PoXx45jz4Bn1w1j0x915o
         0cld1gKH27FzDLsKxsCxX2fDACDVYXV2Kl7DbbVqnNr2YV5auxIbgJ3ZClu9UATlO1cd
         phlso1RkSrEk+wzqJ5HPqDerQZGThL/aqS8nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s738KR7peDPdk0egrEOotdFH/XvdoPuk8qM2dZV4+M=;
        b=RM3NJmq2LlolUkyM8BdpHSCnag9YwrGFabtlnSWO0u1/FDJPKJ3FIIjum2e/zip0+u
         ITqptIYPMFW5+vIVmTVDHLNzqYUTJsjb0ndYOckuw1qFJ/eAeK8MV2Xn/ZwOGkH3bmBz
         ZNEUHehuzSxwV7IYEjFp7mBTGrWejZinRz377X63ZiSKcnFE41D/gRtzD8M9eY85ocO+
         xsgZ5fUyGqcppZR6FNWBST3sBodyB6dwp+6X5+uOhY7A5cONNarMFOjfBWxeYrrKZHBm
         GadBIh3fB+NaFJE3lW7fH54x0/zKb7k5ShLaMeUq5AZcn76htoMEfnw8UsD0jJAAT15V
         6j7A==
X-Gm-Message-State: APjAAAUCCNxyWb26SVkR7vwBvw2Ip7QB8vDN7rOOgB9xOsoFxB6HiBVY
        fzgGzktX7hMJ+iurIzygQj7uL8Htw9UYkOWW7eA=
X-Google-Smtp-Source: APXvYqzCQ+ctGU7OQGZqx/nxtHTMHw9WlHbGNxcjNnj4Cgg7Cq7pSYMp4k90/LRI+zGC5+lRhoD79BWDyiWYxBW8A0g=
X-Received: by 2002:a37:4f4c:: with SMTP id d73mr1165671qkb.171.1570053944314;
 Wed, 02 Oct 2019 15:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com> <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
In-Reply-To: <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Oct 2019 22:05:32 +0000
Message-ID: <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019 at 18:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> Hi Chia-Wei,
>
> On 10/1/2019 11:11 PM, Chia-Wei, Wang wrote:
> > Update the Aspeed PECI driver with the AST2600 compatible string.
> > A new comptabile string is needed for the extended HW feature of
> > AST2600.
> >
> > Chia-Wei, Wang (2):
> >    peci: aspeed: Add AST2600 compatible string
> >    dt-bindings: peci: aspeed: Add AST2600 compatible
> >
> >   Documentation/devicetree/bindings/peci/peci-aspeed.txt | 1 +
> >   drivers/peci/peci-aspeed.c                             | 1 +
> >   2 files changed, 2 insertions(+)
> >
>
> PECI subsystem isn't in linux upstream yet so you should submit it into
> OpenBMC dev-5.3 tree only.

OpenBMC has been carrying the out of tree patches for some time now. I
haven't seen a new version posted for a while. Do you have a timeline
for when you plan to submit it upstream?
