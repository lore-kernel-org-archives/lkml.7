Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF04C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CDB20673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mvMMAei/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFWRvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:51:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39857 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFWRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:51:35 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so322249iod.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Q2J+zKT6qsK6pe1jDDGYOH9t9wEmd7xRD0oxX/ZUOXQ=;
        b=mvMMAei/5azOZcypBaEq8btNPNLpZxE8KXSkooN06cOew1QavQgeymrVjqWBjat1GL
         uzBIDawPiu/bbiNJmLhZPmISgjP9aSiopTaL/7FR1APjAYczi+W0RvE9jR1WzBLBerqU
         7u5n19EJbrps00jQxZD4b5DiKjfAR2j6nJ3QDQUWgjjIP4uU7Rl5uAh4S4a2XlFtPU/d
         Q/Hnk1VimSW17bTId6rZHzDJiIQT2NBzvQefxhxRpAncjpMwQ7wUhc12FxoK2tKIdDcx
         XjQBxcDItwoOpcj78IDtHiU5jixCisA0Fsm4m9M9YUFLtXmouM0VW0sBz9+81nwGIiVL
         jisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Q2J+zKT6qsK6pe1jDDGYOH9t9wEmd7xRD0oxX/ZUOXQ=;
        b=T8UCAv2e421HouK3uaAUZDOQ4SxOG5FysYoRIkUSsOH22fTs3aNPZ9mEU8ft42KywX
         YlN9awOFcEcbnxt8QiIRgKvWo1JhSizV957LrR85hGtF8IrD4KWmo4GMjVfhwpOYpYC0
         Aqqt6MaP3Af2xX/3t4mmUN/MGuuxHbzSSojxAaFX0LZhtQUo64xpQ+EoKLlmRcAdpeBd
         vvFT7kOwzK42quK0v/2cl4X1Y3WUeBKFPSMMICEFckaIIoC2698L5FdufybtdXqZgOBV
         KWEvVD+Ns467E3oHkrtCuK66Sb7lnREywdMWB0AbxPvnvg3RUxzAKqr37SIcJ5nxDs1i
         9yvA==
X-Gm-Message-State: APjAAAXK+cc7N8hxyetjVpLMdXDnMXlYj4nMinJj8d1wJKc0KJRrTa7o
        7mfq+XW59fYNN16yYFuT1AJ4Qw==
X-Google-Smtp-Source: APXvYqzhFIic7VRKdOafvYSegTmj3HQpbIxq+GXv4K4JVmIbUVqc3WLm1Nzru7qiZWB7KESBlTOu5w==
X-Received: by 2002:a02:ce52:: with SMTP id y18mr19504458jar.78.1561312294952;
        Sun, 23 Jun 2019 10:51:34 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r5sm7607520iom.42.2019.06.23.10.51.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 10:51:34 -0700 (PDT)
Date:   Sun, 23 Jun 2019 10:51:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <Atish.Patra@wdc.com>, linux@armlinux.org.uk
cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ottosabart@seberm.com" <ottosabart@seberm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/7] cpu-topology: Move cpu topology code to common
 code.
In-Reply-To: <91559562f2958fa904b53e621e596d6216efa9fb.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906231045280.13854@viisi.sifive.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>  <20190617185920.29581-4-atish.patra@wdc.com>  <20190619173801.GB20916@kroah.com> <91559562f2958fa904b53e621e596d6216efa9fb.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish, Russell,

On Fri, 21 Jun 2019, Atish Patra wrote:

> On Wed, 2019-06-19 at 19:38 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 17, 2019 at 11:59:16AM -0700, Atish Patra wrote:
> > > Both RISC-V & ARM64 are using cpu-map device tree to describe
> > > their cpu topology. It's better to move the relevant code to
> > > a common place instead of duplicate code.

[ ... ]

> I guess Greg has acked the series assuming that it will go through some
> other tree. Can you take it through RISC-V tree ?
> 
> Sorry for the confusion.
> 
> Note: We are still waiting for RMK's ACK on arm patch before it can be
> sent as a PR.

I'm fine to take it through the RISC-V tree, once Russell acks the 
arch/arm patch.


- Paul
