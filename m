Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4710E20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554151848;
	bh=gaf4kSQQmOvBbLcHu3tooVRnG7LJbRtKf7fQ2aaa+EY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ghmne7hiGl7Mo2AM1K2K6iLuuZylACDrkJN6G+fskcNRqaKdIyh9Pv0m48cdlDZqX
	 jFXG5cw2NjiZKHZvDTRgFcOYSvoiEQH/vPSGPsMYX0Ly1A9syeQCWraV1VDsEZiIK9
	 qGO1Jyiy1bkPIadx363gPwW13TPO2/GHQAeB3qS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDAUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfDAUur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:50:47 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A192133D;
        Mon,  1 Apr 2019 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554151846;
        bh=gaf4kSQQmOvBbLcHu3tooVRnG7LJbRtKf7fQ2aaa+EY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QQeiziMwwOk8ytBVeY0Aaj37hoWKK7AfRCyjudTXdUKB23Pszb8weKamr2fXB5Ko0
         lN+Q0tT8j+2vlJj7sb1PFHCmd3LIYX+GESDHeeB3dYOZFAhSxBezC5xw2Sj151U30s
         QQiSmH03knVR71TMlNxnGZca7xjyL4iyS7umJGB4=
Received: by mail-ed1-f52.google.com with SMTP id h22so9624248edw.7;
        Mon, 01 Apr 2019 13:50:45 -0700 (PDT)
X-Gm-Message-State: APjAAAW283kHUNeGx4B1/xjnTqHXpKw8o2GwyrQOZkyjYNEYN7fWVLjk
        CZAQrMGPwUe1rQ/MjD/NLG0Bwo5uQBXdpJN+QrQ=
X-Google-Smtp-Source: APXvYqyCTSsoyB1JMN0DctNb3opTPKWx+15gjPwmL87Y/mY0rIr1s/TUiLWHTbrueLEeoNVYNEE+FSiQDMnOfk2AYlU=
X-Received: by 2002:a17:906:1906:: with SMTP id a6mr21552610eje.236.1554151844382;
 Mon, 01 Apr 2019 13:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190326143129.2608-1-nava.manne@xilinx.com> <20190326143129.2608-7-nava.manne@xilinx.com>
 <20190328170028.GA10815@bogus>
In-Reply-To: <20190328170028.GA10815@bogus>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 1 Apr 2019 15:50:08 -0500
X-Gmail-Original-Message-ID: <CANk1AXTcwb1oJL5Uq-H-Q41-n8SXtamObSedMHSa_smZ8Xr1fw@mail.gmail.com>
Message-ID: <CANk1AXTcwb1oJL5Uq-H-Q41-n8SXtamObSedMHSa_smZ8Xr1fw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
To:     Rob Herring <robh@kernel.org>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:00 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 26 Mar 2019 20:01:29 +0530, Nava kishore Manne wrote:
> > Add documentation to describe Xilinx ZynqMP fpga driver
> > bindings.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v5:
> >               -Moved pcap node as a child to firwmare
> >                node as suggested by Rob.
> > Changes for v4:
> >               -Modified binding description as suggested by Moritz Fischer.
> > Changes for v3:
> >               -Removed PCAP as a child node to the FW and Created
> >                an independent node since PCAP driver is a consumer
> >                not a provider.
> >
> >  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>
