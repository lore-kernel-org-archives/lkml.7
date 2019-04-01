Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C7320700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554156358;
	bh=+7DV69eLQbx34EJ28+qJJiKaFJDS3Fwk5lheQAqMoi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hLZUNw3COs7EgynKYwLH0Yg4kh1gUqIaeegSsVPQ8GhbYaHmMhTi+4j38zGVL1ONL
	 t8wjc2OSqlmS825wIAYvmsKe+roir5zbh8wcDnifgL9lOX0hEI5tU+pXP+D1t2ubbO
	 IteV2v4ltrNYUUsPjtgFFQp+2A0aV07vN52Lhzws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDAWF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:05:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41842 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDAWF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:05:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id v7so8709143oie.8;
        Mon, 01 Apr 2019 15:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eak4+wigjL6ESqg4AsCrjF7ZtYM/iQ/LkcDMGnO7Ark=;
        b=MWqcqBSZdS8E7LdOF7pP/edDtcMTKeLBv1Q037g1ygDGujtXSXWYrJWJqUgjeGhNee
         /3YSS5aOu7YMzqkG4/xQdhz2Et8cdOGWXxc4V/aZloFt3qG1Qc8SdGck9Ul/c1Azo3vW
         2IatVurrXIAmTRqfy6fJelUoo5DsaY0erpu/GblAXScA9Gguzwd9rrm7TvVtnzh6oD8o
         6aXzWVRfyXXf5xJI8Mc1Emg6y7L8IBC3t+/cD6z1qRPc905NRSmt092SFVlf3EmBqFoq
         D6229bm2EtUqViyF1WkwRo9y+gY3cQrRccLfnaQUd0hRNE2AqAi72/spMlHkAFBt4d4E
         g2aw==
X-Gm-Message-State: APjAAAUOvVh4UMUhYMS9lR0XpX89e+19/rAAS5EwKWEM/lQqa6M89Rli
        6Agw+9ZsSBHz8rmT+0Ns14s=
X-Google-Smtp-Source: APXvYqwDuG8rqjTkAZUSFA+LBSzj23PfxAGQWZbQ3lNRH0RU8yUmIsMRPCsniQK/Q7ZZA6M2kBjxug==
X-Received: by 2002:aca:aa91:: with SMTP id t139mr14850350oie.174.1554156356187;
        Mon, 01 Apr 2019 15:05:56 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id c145sm4774314oig.0.2019.04.01.15.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 15:05:55 -0700 (PDT)
Date:   Mon, 1 Apr 2019 15:05:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Subject: Re: [PATCH v5 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190401220555.GA2716@archbook>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
 <20190326143129.2608-7-nava.manne@xilinx.com>
 <20190328170028.GA10815@bogus>
 <CANk1AXTcwb1oJL5Uq-H-Q41-n8SXtamObSedMHSa_smZ8Xr1fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTcwb1oJL5Uq-H-Q41-n8SXtamObSedMHSa_smZ8Xr1fw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 03:50:08PM -0500, Alan Tull wrote:
> On Thu, Mar 28, 2019 at 12:00 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, 26 Mar 2019 20:01:29 +0530, Nava kishore Manne wrote:
> > > Add documentation to describe Xilinx ZynqMP fpga driver
> > > bindings.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > > Changes for v5:
> > >               -Moved pcap node as a child to firwmare
> > >                node as suggested by Rob.
> > > Changes for v4:
> > >               -Modified binding description as suggested by Moritz Fischer.
> > > Changes for v3:
> > >               -Removed PCAP as a child node to the FW and Created
> > >                an independent node since PCAP driver is a consumer
> > >                not a provider.
> > >
> > >  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
