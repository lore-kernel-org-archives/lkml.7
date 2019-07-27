Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062C1C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 07:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DE920840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 07:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hWpTrlNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfG0HxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 03:53:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43042 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG0HxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 03:53:02 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so109514763ios.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xLd5dKN/1Vn4JBfs1gVZiFPuMvq838eaVl4bcxKPEMM=;
        b=hWpTrlNe88UUNfwg3GUnDUeJrzMoOUSuY+SoquSWaF4JqjQXBAmy/X7Re4tWTWf1Y4
         283W/2UUYE/DYYbtfvDgEgEsGSuBBHLLFy9NWCmlThgb82sUCajc4XA+gyry0jBR/c1q
         wsYlP2Az33kWJoZH0snuazvGY8eNKZYCpkKJUl31kLUDWc9mj8MK+nBq2jUNV/9ApL1u
         J4Yugd3PZ1vzPaOoKAXrGfis7dEoDq/j/fLi5aS/+OO8RTvhEJ01Vi4Ur0GulZiBV7Wq
         XPr9SfoDTvGbyB4S+yxTUVvGFwJRSH4UekhuvFTRnzC0wApKD7DvMWFyKcdfDxqIIQjB
         gH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xLd5dKN/1Vn4JBfs1gVZiFPuMvq838eaVl4bcxKPEMM=;
        b=ilouqkEuKHMqR2yDfhwkyZeJJyLp5kCa34qZvDJjDL5nU2QFxQO5mreh2fwkNPXezu
         KwqkPUoZYH9D/4ucc6xOsi+fL01ny1IlC5UtV3w00i3jzVhOkKMGoYOqnjXEbVOJW06N
         3KMW8PsvK2g8xQxNaRwVvCCyIUw6AvMECjs4TofEaC31OlZIf6l0lcouzZnp0tqLcjjt
         Lu0LScSUlEpyYydeaYPy05UNVHx2snIcvRv2CDWsWA/49Ezxt27L76faG22tGKnIFxQb
         6Dad2rVtAUI3l+i0ErYs5vqF4BFF3zGII+YdbkNQ0jfdxAd798//0g8TpQqki4lpf/lg
         yI+A==
X-Gm-Message-State: APjAAAWp9nFC89O5Lu4FB7/1DrdHXx63onvX2+KZbk4gvo1J21rKFxkg
        NiUAwhc/3NEiJQOaQ5XEf0x2gw==
X-Google-Smtp-Source: APXvYqzEOwrzMD2xH/L1gj0DzO0QBuJ/XdHgi7C1YpXKU+KcRjY8a3+ZkDPTZ+RvOv6tc2fEwOLYSQ==
X-Received: by 2002:a02:a595:: with SMTP id b21mr7904643jam.28.1564213981562;
        Sat, 27 Jul 2019 00:53:01 -0700 (PDT)
Received: from localhost ([65.152.59.42])
        by smtp.gmail.com with ESMTPSA id z26sm54391272ioi.85.2019.07.27.00.53.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 00:53:00 -0700 (PDT)
Date:   Sat, 27 Jul 2019 00:52:59 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 3/4] RISC-V: Support case insensitive ISA string
 parsing.
In-Reply-To: <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com>
References: <20190726194638.8068-1-atish.patra@wdc.com> <20190726194638.8068-3-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com> <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com> <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
 <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019, Anup Patel wrote:

> > -----Original Message-----
> > From: Paul Walmsley <paul.walmsley@sifive.com>
> > Sent: Saturday, July 27, 2019 5:00 AM
> > 
> > On Fri, 26 Jul 2019, Atish Patra wrote:
> > 
> > > On 7/26/19 1:47 PM, Paul Walmsley wrote:
> > > > On Fri, 26 Jul 2019, Atish Patra wrote:
> > > >
> > > > > As per riscv specification, ISA naming strings are case
> > > > > insensitive. However, currently only lower case strings are parsed
> > > > > during cpu procfs.
> > > > >
> > > > > Support parsing of upper case letters as well.
> > > > >
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > >
> > > > Is there a use case that's driving this, or
> > >
> > > Currently, we use all lower case isa string in kvmtool. But somebody
> > > can have uppercase letters in future as spec allows it.
> > >
> > >
> > > can we just say, "use
> > > > lowercase letters" and leave it at that?
> > > >
> > >
> > > In that case, it will not comply with RISC-V spec. Is that okay ?
> > 
> > I think that section of the specification is mostly concerned with someone
> > trying to define "f" as a different extension than "F", or something like that.
> > I'm not sure that it imposes any constraint that software must accept both
> > upper and lower case ISA strings.
> > 
> > What gives me pause here is that this winds up impacting DT schema
> > validation:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docu
> > mentation/devicetree/bindings/riscv/cpus.yaml#n41
> 
> If 'f' and 'F' mean same extension as-per RISC-V spec then software should also
> interpret it that way hence this patch.

The list of valid RISC-V ISA strings is already constrained by the DT 
schema to be all lowercase.  Anything else would violate the schema.

I'd take a patch that would pr_warn() or a BUG() if any uppercase letters 
were found in the riscv,isa DT property, though, in case the developer 
skipped the DT schema validator.


- Paul
