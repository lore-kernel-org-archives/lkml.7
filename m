Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8752BC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C66206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576882407;
	bh=JAZuLSPR3WOxwoL0cji9AhpNYjj80kA9U6ZIGNiKQ7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DDEysfB+YiPj37dHyQEOUT5EsWBrZBQqpEIf/s21jAQFueFVYzMlvFwPozp98zU7+
	 e6nBDpN2y7jEYLtHHVuUqc0XPOw36IfmpEGXN+wrpC/tzYrqnuHAuRJsDDf+0GQdXm
	 uBla/nggMLFQb8R/LepLDQoDHS6/v2L7xharyp5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLTWx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:53:26 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41396 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:53:26 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so9285944ils.8;
        Fri, 20 Dec 2019 14:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gfJyvbzdjRRE9mbB4EZAlkviKQGe4qIe+Xz7HY9aEuM=;
        b=aIBqxl23vZ8c0QArmatsB3uRdRwHb5m27TcqSF4BEkc0XqqjA0tjdhqlfgBYUgvK/R
         xi7hsrBO6wCP0sRoLMygtWZKYL8KPA6A8NIohYMOEP0VYi9EoT3bfFtrzK9Dg13cwuHZ
         OAhfOoQF3kqMlWL0TdBus7swliuj4DX/bkX65Us/LgeB8uQgy2UZSu2l8aaLOqv2Jir4
         uFJ/Q1USS6larwtkqa6iFGFLtECWZ5LrnSM24yuWftLXWluujYJpVBQ4XhEY2LLDhrmp
         Guyrr957aoVFNN6TWRXYxSL9AG9gbZS6yYmnN/G612sqBa6cYl0sFXTxYkR0ARdEf2Bn
         88lQ==
X-Gm-Message-State: APjAAAXDOWvMKTE75VENC0E6a+NgWoo+D+HQuCaRP8EDIIpsue8PapBW
        2g4fNQw/DELiXEtkPUaEBA==
X-Google-Smtp-Source: APXvYqw7OYFLkTge6J7y1//6QDQ+9JwMiyNGQaRAZBxuTLFcST/PLF3dXOQOVRZzDiAN2/x9nZfqbA==
X-Received: by 2002:a92:465c:: with SMTP id t89mr15163877ila.263.1576882405135;
        Fri, 20 Dec 2019 14:53:25 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l15sm3880575iom.81.2019.12.20.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 14:53:24 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:53:23 -0700
From:   Rob Herring <robh@kernel.org>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "amelie.delaunay@st.com" <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 0/2] Add yaml DWC2 bindings
Message-ID: <20191220225323.GA26563@bogus>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
 <c6101bcb-1491-b9ce-b0f8-e50826202ee3@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6101bcb-1491-b9ce-b0f8-e50826202ee3@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:54:27PM +0000, Minas Harutyunyan wrote:
> Hi Benjamin,
> 
> On 12/19/2019 2:35 PM, Benjamin Gaignard wrote:
> > Convert DWC2 bindings to json-schema and fix issue in dtsi file.
> > 
> > Benjamin Gaignard (2):
> >    dt-bindings: usb: Convert DWC2 bindings to json-schema
> >    ARM: dts: exynos: Remove unneeded "snps,dwc2" from hsotg node
> > 
> >   Documentation/devicetree/bindings/usb/dwc2.txt  |  64 ----------
> >   Documentation/devicetree/bindings/usb/dwc2.yaml | 152 ++++++++++++++++++++++++
> >   arch/arm/boot/dts/exynos3250.dtsi               |   2 +-
> >   3 files changed, 153 insertions(+), 65 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/usb/dwc2.txt
> >   create mode 100644 Documentation/devicetree/bindings/usb/dwc2.yaml
> > 
> 
> In Maintainers file mentioned that EHCI and OHCI drivers maintainer is 
> Alan Stern, but in 2 existing yaml files (generic-ehci.yaml and 
> generic-ohci.yaml) mentioned that maintainer is Greg Kroah-Hartman.
> So, I'm not sure that in dwc2.yaml file should be written me.
> Actually I'm not familiar with documentation/bindings.

Someone familar with DWC2 IP is ideal really.

Rob
