Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95217CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0C20862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge/UTzPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfKARk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:40:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36901 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKARk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:40:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24so1026234pfn.4;
        Fri, 01 Nov 2019 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nFNT0LPVheWA4KBpnwRedDxe323lH3c78BcmwLbJ700=;
        b=ge/UTzPgmx562dBN7M+gJnaLpgdt7tTLMJj965/UtlsjHMookPjfZEeSyuW6yaBJ/t
         aziJDTH8+9YwXmzr0Xx5hpG5e9caR15dZKiaMPAf4PyasAzBv0vx87Vf02OLwoM8qUbQ
         6lPYg2bQvvDGYW2hQQo3KXH6Ha7iuEaqv3kZymF1Pya4y1sjKq/0iDVomDCBsrW3lD8g
         ojwug482SwJTWzYJ62hWzrQPU1DwHsebPq4qsbWjVIH8HEXoJSGpXC7EiUAYFoakcosh
         BvXhyG9EnJgXnPi+dYOf2m1VxgGQ8+bZg54SqXSHvHom7gowiYfuCyJdZaeqoOS04AsO
         TbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nFNT0LPVheWA4KBpnwRedDxe323lH3c78BcmwLbJ700=;
        b=Eca0500v2VUmd2jufYMCQSkCXOVUhqL2OtODLk38ixNRi3qNxrTYaqR2NSDPXoACve
         v5NHYu5zWmck5UYD9PamEZ5oXw59aSDx9GdGSfZMF1nVm+qKPON5GyO+V4h7QMWG5nYV
         bUJtSKfb+zntUUCULXv4CispBDiQNM9/3FL9RZ1yBy3vSepb7maZy7KgCwZMtUjzeo4v
         N6NBRTHp5FymniNE7UG+drMuYj9ORNyA0EBkOzPi89LzoYA9rhxssIUjCgNoSac4eHIX
         rjDUpIt5JmOIe6qR3B+7Sh4vX/SE7+jmj1tPaEf6jzWaHRhwQ2wb+pqc4/Q8XnMKo/h/
         EOVA==
X-Gm-Message-State: APjAAAWNdT1dGdHhDhqW4rbEgo6OKYqgxFpdP0kcMrtDA5Ld1VnQtyGV
        mbAxLT2so9yW94eBvNZ5gkwut/p8o+g=
X-Google-Smtp-Source: APXvYqxEMn19nRiQYdcMHXDUyl1sN5kC5K5u0Di4ZM95TyefIw5grebLlrUdxgtbp3mv1L0GC8D08g==
X-Received: by 2002:a65:5388:: with SMTP id x8mr8040065pgq.398.1572630055931;
        Fri, 01 Nov 2019 10:40:55 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:200::3:155b])
        by smtp.gmail.com with ESMTPSA id b18sm7009793pfi.157.2019.11.01.10.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 10:40:55 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:40:45 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Tao Ren <taoren@fb.com>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: add dtsi for Facebook AST2500
 Network BMCs
Message-ID: <20191101174044.GA13557@taoren-ubuntu-R90MNF91>
References: <20191021194820.293556-1-taoren@fb.com>
 <CACPK8XcNxs5T=ZC_mRnvkOF_kqS1AvP=9PvMB6w9Fgn_XbtZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcNxs5T=ZC_mRnvkOF_kqS1AvP=9PvMB6w9Fgn_XbtZQw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:08:35AM +0000, Joel Stanley wrote:
> Hi Tao,
> 
> On Mon, 21 Oct 2019 at 19:49, Tao Ren <taoren@fb.com> wrote:
> >
> > The patch series adds "facebook-netbmc-ast2500-common.dtsi" which defines
> > devices that are common cross all Facebook AST2500 Network BMC platforms.
> > The major purpose is to minimize duplicated device entries among Facebook
> > Network BMC dts files.
> >
> > Patch #1 (of 4) adds "facebook-netbmc-ast2500-common.dtsi" file, and the
> > remaining 3 patches update CMM, Minipack and Yamp device tree to consume
> > the new dtsi file.
> 
> The patches look okay to me. I modified the file name to match the
> convention used by other device trees in the arm directory, where it
> includes the SOC name first.
> 
> I also reworded the commit messages a little.
> 
> They have been merged into the aspeed tree for submission to 5.5.
> 
> Thanks!
> 
> Joel

Got it. Thanks a lot for doing this, Joel.

Cheers,

Tao

> >
> > Tao Ren (4):
> >   ARM: dts: aspeed: add dtsi for Facebook AST2500 Network BMCs
> >   ARM: dts: aspeed: cmm: include dtsi for common network BMC devices
> >   ARM: dts: aspeed: minipack: include dtsi for common network BMC
> >     devices
> >   ARM: dts: aspeed: yamp: include dtsi for common network BMC devices
> >
> >  arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 66 ++++---------
> >  .../boot/dts/aspeed-bmc-facebook-minipack.dts | 59 ++++--------
> >  .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 62 +-----------
> >  .../dts/facebook-netbmc-ast2500-common.dtsi   | 96 +++++++++++++++++++
> >  4 files changed, 136 insertions(+), 147 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi
> >
> > --
> > 2.17.1
> >
