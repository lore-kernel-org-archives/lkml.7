Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A441206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KMf83iY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfCYVSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:18:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43517 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:18:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so7018266pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0twdiqilZrb/3YXdP2/n6MpVRrwGHy/8HD+Fjzt4tjs=;
        b=KMf83iY2GNJjRGjeIl+JaioegThTB5LGRytbCa+qgImYnOLAW/9rkuJeLUGwbvCqik
         s9o0oW/WiF+XQ/SdW6E0gIRdnjNTRdNMVQ+YFkov7/lQH0rILJzLbpwWywQJiBxiLQgJ
         e25VrYieR4QDn9f3XymipC3wcFuVGAbeVvZK3MRnRs91covJPsSGg21W2jnyXAqL2ct8
         rC++/MCkOvrT1J+XsOQVtBqCwFVJ1I5dHUjHff4TKABtuPqwt7+yy6XByaR5kf9hWj/C
         A4QXM1dmEIj6oFeT/9z4JHBgDWXwqlhLFDhEuq8GUHj4bDdH+RfMPSoDuIR8ryYbujia
         V83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0twdiqilZrb/3YXdP2/n6MpVRrwGHy/8HD+Fjzt4tjs=;
        b=ZPiWG17ON84XPi4kjfW5M1afnqiRw0+9M369dW8O/C8eGvaOIYc/NmPSXG2r5D0hbC
         r0+J5UPAwVZP5AEzvZPipn3l1SXjMLTMToyUtoK8nDfPBfoAUfHUGscsyC/SvCSlVHQK
         V4ctCpUPK1gJ3SbCxtD+WVewnOeQNJbVquYZBJIMf5EmUioTlLRX1jacYmysvoS7PAgr
         5ug3oe8NsD6Kt25HafO+ZXp3V64zD1UXpcNg+6D1N6pxVGuK05MsxWbDIHVLaCW6+kGM
         hopeH+ZhRHRzvDnUjmEuABS5s/oWI4U1sh6bhWp2qMrGdFdmDNr8cLsKrfBgD+cIUqxO
         n1Ug==
X-Gm-Message-State: APjAAAW9nHjHaSUKzL79Mo3BPf5Cfk/KtUwZNuLyvMo5x2XGB6XlICKh
        v/A2Jyq/SWce0J01AXbvBuGR2Q==
X-Google-Smtp-Source: APXvYqw+Wa59SxvPDZzW8FOWCPBj8SavQ2czzpPK1Rskg9xetFcyw4YzZW4/bsY809kQuKFTuYWgQw==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr23885407pgt.391.1553548721345;
        Mon, 25 Mar 2019 14:18:41 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z189sm24207535pfb.146.2019.03.25.14.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:18:40 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:18:39 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Borislav Petkov <bp@alien8.de>
cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] sifive: edac: Add EDAC driver for Sifive l2 Cache
 Controller
In-Reply-To: <20190325065453.GC12016@zn.tnic>
Message-ID: <alpine.DEB.2.21.9999.1903251211190.8028@viisi.sifive.com>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com> <1552382461-13051-3-git-send-email-yash.shah@sifive.com> <20190312092842.GC28589@zn.tnic> <alpine.DEB.2.21.9999.1903241705460.8028@viisi.sifive.com> <20190325065453.GC12016@zn.tnic>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Borislav Petkov wrote:

> On Sun, Mar 24, 2019 at 05:16:17PM -0700, Paul Walmsley wrote:
> > Looking at the Synopsys,
> 
> Look again at synopsys_edac.
>
> >  Highbank,
> 
> Yes, that one and octeon.
> 
> > PowerPC 4xx, and
> 
> also a single ppc4xx_edac driver.
>
> > TI EDAC drivers,
> 
> There's TI drivers, plural? 
>
> I see only ti_edac.c. Also, per-vendor.

All of these drivers are for single IP blocks.  Mostly DRAM controllers.  
There's no "platform EDAC manager" IP block in these cases.

> > all of those are clearly for IP block error management, rather than
> > platform error management. Has the upstream guidance changed since
> > those drivers were merged?
> 
> There are others which are per-platform and work just fine this way:
> xgene_edac, altera_edac, layerscape_edac, qcom_edac, synopsys_edac...

Of your list, only xgene_edac, altera_edac, and qcom_edac have something 
that resembles a platform error manager.  The others are just for 
individual IP blocks.

> > The core issue for us is that we don't have a generalized "ECC management" 
> > IP block.  And I would just as soon not fake one in the DT data, since the 
> > general DT guidance is that the data in DT is meant to describe the actual 
> > hardware.
> 
> Look at how the others I mentioned above do it.

The Synopsys case is illustrative.  Synopsys doesn't have a unified EDAC 
platform; they don't sell chips.  SoC vendors (like Xilinx) take some 
Synopsys IP blocks (like the memory controller), perhaps others from a 
different IP vendor like ARM or Cadence, and integrate them into their 
SoCs to create their own platforms.  They often combine a Synopsys memory 
controller with an ARM L2 cache controller.  But both of those IP blocks 
might be able to detect and report ECC errors.

So as a result of these EDAC limitations, Xilinx hacked their platform 
code into the synopsys_edac driver:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/edac/synopsys_edac.c#n901

The problem with this is that it is backwards.  The Zynq platform has 
other sources of ECC notifications and errors, beyond the Synopsys 
DDR controller:

https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf

So the EDAC "platform," if there is one, would be Xilinx Zynq, not 
Synopsys.  Probably this hasn't been a problem so far because:

1. Xilinx hasn't upstreamed any support for the other EDAC sources on the 
chip; and

2. no other SoC vendors using the Synopsys memory controller have bothered 
to upstream EDAC support for their platform

> The problem with per IP block is that if those compilation units would
> need to share info or communicate, then that is impossible nowadays and
> you'd need to build something on your own.
> 
> Also, the EDAC core supports only one driver.

OK.  Would you have a preference between these two options:

1.  We could modify the EDAC subsystem to support different EDAC data 
sources from different vendors.  This would avoid duplicating code for 
different platforms that combine EDAC data sources from different IP 
blocks.  (This seems to me like the better long-term approach.)

2.  We could create a platform driver for the "SiFive FU540-C000 EDAC" 
reporting platform that wouldn't map to any hardware block, but would call 
functions exported by other sources of EDAC data - most likely drivers 
living in separate directories.  If, for example, we wind up using a 
Synopsys memory controller in a future product, we move the Synopsys code 
into a separate library, and move the Xilinx Zynq-specific code into a 
zynq_edac driver, etc. 

Or perhaps you have another idea?


- Paul
