Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C802BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970B82173E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LVruWYJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGZX3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:29:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36413 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGZX3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:29:41 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so4544340iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=f0NauJHVqo/HIKObdVkdw9yTl/4NywZItEu7j8mg3M0=;
        b=LVruWYJsd3bjeNXq3I2xolL9voc9Yk1+77O3/kR4rln3y9Svg6v4WdWHkyaFKL0T0f
         cFfOXSawqqUdLG7bNbuZIZ4hWhi/FEM5ZaCqLQ0Alt/LtYn8sgnlnHCSKSQjF8JaxwVL
         HPlBrIWyvIwW0JBa476SDk1xrjw/VXS01l/gIp1t/nCo6I10x8XsldgLfDqlbrx43DY4
         YA5h5hXLyD6tGPppVY74MabkYpC3wmz//jlD+RN9PyFexGFTkrawNpFHSR3A5p4HWVj3
         HGn6JfMJEMRwafxo6+6gs4TXmwAs/MnXNNR9bJeNJhq+6jE/btoTJJJYbhZwKT422qC3
         jVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=f0NauJHVqo/HIKObdVkdw9yTl/4NywZItEu7j8mg3M0=;
        b=PwFtQUEmWhwVHgO0PPEWzDA74RwkPmHAdYlgz1zqn65Qa2BytqHc78OaoTYjOxrtm0
         2ys+ONU6o8T2u8cc8ZvTIJFVh17D8eboQXxbMcAKtlYA+AJwJ5JQIW0VaiQITY3gvggA
         2CpNW3AKTq3eYixgXZonAfAhMKizki/IrYXHPTe+SAf4tD0Qr7QeAsOmJ3njof8KxOUY
         H6rygb485/iVdoRHpxHS/kbQjGBMrwocvKnFpqHrxfai0hbSWsOWJz/uiiOjx8eMRYL8
         H/3ECsxC7is9RSeT5r+ENOACECZ2SjfwKJcQyzo33XBuF7NrFpLPy4FACOsQpHSgRXB1
         rcdw==
X-Gm-Message-State: APjAAAV+FLFj1ngzszO9velfiiXdrC2e7RUO8Xd9KwwHrFGWp+2ni955
        XdhwpOGUYIVckalf73hVpera/w==
X-Google-Smtp-Source: APXvYqzrzFt15zIbn3sWYkAdzt0egDJg9bQUJpyBfwuwX6IMgrArgwXByra2h9LIHUx49dHbxOqrAA==
X-Received: by 2002:a5d:928a:: with SMTP id s10mr64008087iom.29.1564183780127;
        Fri, 26 Jul 2019 16:29:40 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id p25sm44650795iol.48.2019.07.26.16.29.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 16:29:39 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:29:38 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <Anup.Patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string
 parsing.
In-Reply-To: <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
References: <20190726194638.8068-1-atish.patra@wdc.com> <20190726194638.8068-3-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com> <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Atish Patra wrote:

> On 7/26/19 1:47 PM, Paul Walmsley wrote:
> > On Fri, 26 Jul 2019, Atish Patra wrote:
> > 
> > > As per riscv specification, ISA naming strings are
> > > case insensitive. However, currently only lower case
> > > strings are parsed during cpu procfs.
> > > 
> > > Support parsing of upper case letters as well.
> > > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > 
> > Is there a use case that's driving this, or 
> 
> Currently, we use all lower case isa string in kvmtool. But somebody can have
> uppercase letters in future as spec allows it.
>
> 
> can we just say, "use
> > lowercase letters" and leave it at that?
> > 
> 
> In that case, it will not comply with RISC-V spec. Is that okay ?

I think that section of the specification is mostly concerned with someone 
trying to define "f" as a different extension than "F", or something like 
that.  I'm not sure that it imposes any constraint that software must 
accept both upper and lower case ISA strings.  

What gives me pause here is that this winds up impacting DT schema 
validation:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/riscv/cpus.yaml#n41



- Paul
