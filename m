Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D2C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFDB2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gztWv+bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfGVI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:27:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36289 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfGVI10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:27:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so25521835vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RJyhgfgruenwkBfxBo44jsW4pz2HfZkSJXTbiqBf3E=;
        b=gztWv+bmLCUDG6mNEYFFvY8tZqi5r3puq/pDBxPphVwweusuYVn6zN2Y8qdTZw2pYi
         4zFCzJ2ISOb18Z20Keksz0xaXGoT8aVi9NKNJeqnCzpwcOpEbYV6Saym/h48X5KIyTCJ
         fKvZiAB6CWpOL5FneJ4T/xEvritiiqNZHvJj9GHvkD+KXnKXuhY2O6wLzW3fR1i+43TJ
         r7eO6MickDKg1hTNpwLVzhRb0Ki37ouO2PMQd3Y2sfLKtO+2t5LHofzSll3wnadxDPR0
         BbqGFlaY3XTXtQG8Mo8sZwzewWTVDt6bRi8ZJ2N7tOFsTIzISJpShd6atLP7SEqwCxLr
         E+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RJyhgfgruenwkBfxBo44jsW4pz2HfZkSJXTbiqBf3E=;
        b=ZpsMsrSbjb+6PLgsDOvo1moV6Gn0P3nOa135Bq9OLZ73DGfjY76/oSve0s8XYncj0h
         eIrXpUicm76clwco7q8xgPj88ZUV5xeCIfdm4DxpBjXSMf7ATVbcWuAbwnZzK8RDLOLy
         85zMZ0+2BNzNwTtnlxPpDfk+p4QohLrRimbXAlaBs+DFDesspAr3WGON/hOkg0mldth4
         pJyfNdXaMQ9XB5hQiDGMv14PXeYVPsdP7JlCUOfcIdT6FSISqrGwETsMM2BNHMxCal+h
         O0BUqm6EVBb2Ahc1PnB7oxzSiTXtywpm3/3OxC1qJe4/4FqP6ZI2TVMFN2+1YTw74p9O
         KBFw==
X-Gm-Message-State: APjAAAUxTEAp42ZFzA+BpFfRWTnq5MttpgV5mwbne6TL3GylbjcdssvI
        1008sLguEkqJwi3Q7fGwS8Unybqm67M8qzr4/q1MfA==
X-Google-Smtp-Source: APXvYqyiO4svt03LtfyWGgVARgQQgWAX83euCH22ShiTYAP+9nnGonWbSkDuxevzOEUTnmTEFPm9l3Jw0Kwk9TtHijM=
X-Received: by 2002:a67:e8c3:: with SMTP id y3mr40205806vsn.94.1563784045548;
 Mon, 22 Jul 2019 01:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
 <1563534631-15897-3-git-send-email-yash.shah@sifive.com> <CAARK3H=D1N8gO0Z82_MCtgr5DtT1=E0wzYbn-y451ASgxV-qBg@mail.gmail.com>
 <20190719132657.GD24930@lunn.ch>
In-Reply-To: <20190719132657.GD24930@lunn.ch>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 22 Jul 2019 13:57:14 +0530
Message-ID: <CAARK3Hn7vocesjGm3mNGJ4GJXwRnqv-qtVGAgFKMghH033JH4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>, ynezz@true.cz,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.ferre@microchip.com,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Fri, Jul 19, 2019 at 6:57 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jul 19, 2019 at 05:23:45PM +0530, Sagar Kadam wrote:
> > > +&eth0 {
> > > +       status = "okay";
> > > +       phy-mode = "gmii";
> > > +       phy-handle = <&phy1>;
> > > +       phy1: ethernet-phy@0 {
> > > +               reg = <0>;
> > > +       };
>
> Hi Sagar
>
> Is there a good reason to call it phy1? Is there a phy0?
>

Sorry for the delayed response.
There is a single phy, so yes phy0 is a better name.
Thank you for pointing this out.

Thanks & Regards,
Sagar Kadam




> Thanks
>
>    Andrew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
