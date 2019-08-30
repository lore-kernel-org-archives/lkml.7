Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8937C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985252070B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrowYFp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfH3HVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:21:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32814 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3HVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:21:44 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so12194310iog.0;
        Fri, 30 Aug 2019 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlhFgQeL/mYiQX6p6gp6sv+Yu6hpMLWLNkdRBnpDQiA=;
        b=QrowYFp5jRyggiMNrPIzMypbBgTVm25Yb91NkmJgbZPFHT3+eqflmDIpgaXs9Ja+Sb
         0SaId/XviBrbPr9ra3Q1ryqGt923GWhcBPA2YkrkoACGObI7CLSF7nwtayBSVvyivIGi
         Ij+pCG1oX+tSO4KL2tbwP1WxwVaDsGcf0qzgP7R8e/B4KHVlIPD4AN8aXaON1ppV47HD
         cxDxkQbMKFsYy4aqhwvzL33/Mb3wgkj/Tl4tZ7lAZXVxq5d58qUyEQZlamIfnAG/JlhK
         3Y7noHEHERn2uzFp8REzI8xn9s0oPLeM0+gRB/PtFppOdAeb4rsjxbLP3Tlvel4v+VaS
         HYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlhFgQeL/mYiQX6p6gp6sv+Yu6hpMLWLNkdRBnpDQiA=;
        b=gvgUu4TLlE7L6gPRuf66n81zLxJF1d3ZwraBswf4rdjzp0dgq8jyeRM6B3mdxKB8uh
         RdqBz2zj5vw0UdJK38fH2bcycl5pQ1j/uRgywnIPf/mqzJX0sVhuqrfCDZNdmq+5Vxnl
         Y9PO0CpWFclMaRB00bvVBmBg5rkLgbSWPlwWIcoVILSp0lB7s3Z01nLaBq0ZGLy/Ruhl
         g+5mObVxM1e/fKnmvubBjEkT657DNXuxFvK4/ede9ns/ZyHzvDYJv5+3S7xXZQy/Pt/a
         5yk9oheWct+KPqWxh9Zes4bB2trEKvcomaMC1wI9aejICHFURLKgk2u/OAfGGKkvACi3
         vn/w==
X-Gm-Message-State: APjAAAWPjCJq9lbCa5iROmqFR5ia/xGQL0dmqSSjZc7QM0+hZFSRU6lO
        Mfz/xDkK0fX6Ady1FkLIfrds/XmvsQaWmiSWLfQ=
X-Google-Smtp-Source: APXvYqxdEUCSeILyh2pFmXq4fHzi6CcocAFis6vG7eX8iNXSYZsq2LtQPx3otlCh1YNNK3ymTfJiHprCHskaedRe/kE=
X-Received: by 2002:a5d:9aca:: with SMTP id x10mr15481830ion.11.1567149702961;
 Fri, 30 Aug 2019 00:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 30 Aug 2019 02:21:32 -0500
Message-ID: <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 1:28 AM Peng Fan <peng.fan@nxp.com> wrote:

> > > +examples:
> > > +  - |
> > > +    sram@910000 {
> > > +      compatible = "mmio-sram";
> > > +      reg = <0x0 0x93f000 0x0 0x1000>;
> > > +      #address-cells = <1>;
> > > +      #size-cells = <1>;
> > > +      ranges = <0 0x0 0x93f000 0x1000>;
> > > +
> > > +      cpu_scp_lpri: scp-shmem@0 {
> > > +        compatible = "arm,scmi-shmem";
> > > +        reg = <0x0 0x200>;
> > > +      };
> > > +
> > > +      cpu_scp_hpri: scp-shmem@200 {
> > > +        compatible = "arm,scmi-shmem";
> > > +        reg = <0x200 0x200>;
> > > +      };
> > > +    };
> > > +
> > > +    firmware {
> > > +      smc_mbox: mailbox {
> > > +        #mbox-cells = <1>;
> > > +        compatible = "arm,smc-mbox";
> > > +        method = "smc";
> > > +        arm,num-chans = <0x2>;
> > > +        transports = "mem";
> > > +        /* Optional */
> > > +        arm,func-ids = <0xc20000fe>, <0xc20000ff>;
> > >
> > SMC/HVC is synchronously(block) running in "secure mode", i.e, there can
> > only be one instance running platform wide. Right?
>
> I think there could be channel for TEE, and channel for Linux.
> For virtualization case, there could be dedicated channel for each VM.
>
I am talking from Linux pov. Functions 0xfe and 0xff above, can't both
be active at the same time, right?
