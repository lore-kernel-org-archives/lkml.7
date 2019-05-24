Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBC1C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23288217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KUQBIAgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfEXEwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:52:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45972 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731773AbfEXEwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:52:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so1988376lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V20z0KsB9cueisqTKMsu9xWIxFvhrK8pRRyFM+6kcXg=;
        b=KUQBIAgjJy54O12HR/RuHSSIcavrDhN4oFMJxSyw1H5om5949xmqcpUMUM0aXJU4EK
         xXbGmF35qNp/8LxI91Qi6twy/cbPli9PqZPhLNpqh6as/vgnhChBwNHqEGDRYpOcbYoK
         FvlTy715Wme6Rct1Jg947fwAsiaxvQ48DjpEmvR3hwtc5YFIjXe5ZdUv5E9VTq8RljSQ
         vWydQb9aZ3ZnUrGShFzntaJBuebxU1w37/f/1Zxz66M4E6Oo03cx7S+4naQAsfS+IXi0
         fRydRh3q7XKlnkp3bbjOUT9qC5pftTrdTVDlNPOiLcoVw1KV8MVk1PRDyp8eskBxRdB/
         0+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V20z0KsB9cueisqTKMsu9xWIxFvhrK8pRRyFM+6kcXg=;
        b=aHpbiEmdZi+ikJXTpp18IfnYkT6bPwDz+Z+tLrPjixcbVEmA6Ci66A6kct5pCw+pfe
         IpF4EojG6UM/rCZZXBH0yBWF0e0Bzp7Sb6xHeQyCjuH5YDdyx4NwURLZIhToe6fquUZ7
         qRrR5qgZbV9i1D7/oaXNeUCHEkloFu5OQEde5BUPDmKba4mzT2fCZQlED+Pg+LUDoPLh
         ZtaMTwUXVxRwX0nv8s/bSXS5p0n9Z/xDgyvaFmbjP9WkKDdKmaN1jA6lENx1bXeyJreV
         xxjpWnQQRpFoNbJHgs65yJygQaL2MutppjPc8U3eNgWcik2iyLdhK4Vbe4LWb+Kg/0tq
         mhGA==
X-Gm-Message-State: APjAAAVoCpi25v3PVRsRdSfkECQ79A5yQT7uj3xDSwluWlDolzUqvfuN
        p8OcgUApQmIbiGhDsLVe4hO4H7I7UlYsHnLupb4rrg==
X-Google-Smtp-Source: APXvYqxz0wNQDMda+GtVe5gubvtJUXWkBLq/qX5juG1Eg/5ylGDqqmuLdtNb6543eugrO6i1QFuePfWPqT9od0rGXI4=
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr16405025ljj.147.1558673563302;
 Thu, 23 May 2019 21:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <1558611952-13295-1-git-send-email-yash.shah@sifive.com>
 <1558611952-13295-3-git-send-email-yash.shah@sifive.com> <20190523145417.GD19369@lunn.ch>
In-Reply-To: <20190523145417.GD19369@lunn.ch>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 24 May 2019 10:22:06 +0530
Message-ID: <CAJ2_jOE0-zK1csRNeiAmag9kEbvOGhbvRa-5ESYif7e15gpRcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: macb: Add support for SiFive FU540-C000
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, netdev@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        Sachin Ghadi <sachin.ghadi@sifive.com>, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, ynezz@true.cz,
        linux-riscv@lists.infradead.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 8:24 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int fu540_macb_tx_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                               unsigned long parent_rate)
> > +{
> > +     rate = fu540_macb_tx_round_rate(hw, rate, &parent_rate);
> > +     iowrite32(rate != 125000000, mgmt->reg);
>
> That looks odd. Writing the result of a comparison to a register?

The idea was to write "1" to the register if the value of rate is
anything else than 125000000.
To make it easier to read, I will change this to below:
    - iowrite32(rate != 125000000, mgmt->reg);
    + if (rate != 125000000)
    +     iowrite32(1, mgmt->reg);
    + else
    +     iowrite32(0, mgmt->reg);

Hope that's fine. Thanks for your comment
- Yash

>
>      Andrew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
