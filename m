Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF7ACA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E172084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfJURKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:10:17 -0400
Received: from muru.com ([72.249.23.125]:38456 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfJURKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:10:17 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C5A3980CC;
        Mon, 21 Oct 2019 17:10:50 +0000 (UTC)
Date:   Mon, 21 Oct 2019 10:10:13 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Subject: Re: [PATCH 1/7] dt-bindings: gpu: pvrsgx: add initial bindings
Message-ID: <20191021171013.GX5610@atomide.com>
References: <cover.1571424390.git.hns@goldelico.com>
 <f0fb68dc7bc027e5e911721852f6bc6fa2d77a63.1571424390.git.hns@goldelico.com>
 <CAL_Jsq+obsTSU3iP1wm_3-FsAJ4Mxiz0NbMY1_h5NeFn67Sj+A@mail.gmail.com>
 <CEA29A3B-4116-4FE3-8E18-0C97353688DC@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CEA29A3B-4116-4FE3-8E18-0C97353688DC@goldelico.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [191021 15:46]:
> > Am 21.10.2019 um 17:07 schrieb Rob Herring <robh+dt@kernel.org>:
> > On Fri, Oct 18, 2019 at 1:46 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >> +- reg:         Physical base addresses and lengths of the register areas.
> > 
> > How many?
> 
> I assume there is only one. At least it suffices to make the existing
> driver work with it.
> 
> > 
> >> +- reg-names:   Names for the register areas.
> > 
> > If only 1 as the example suggests, then you don't need this.
> 
> ok.

My guess is that sgx is just a private interconnect instance
with few control modules like mmu and clocks, and the driver(s)
should consist of independent modules like iommu and clock
driver.

So yeah I agree, it's best to leave reg names out of the
dts at least for now.

> >> +                       compatible = "ti,sysc-omap4", "ti,sysc";
> >> +                       reg = <0x5600fe00 0x4>,
> >> +                             <0x5600fe10 0x4>;
> > 
> > How does it work that these registers overlap the GPU registers?
> 
> Both drivers have access to these registers. Likely, the gpu driver
> ignores them and does access other ranges.

Unfortunately TI is stuffing the interconnect target module
control registers at random places within the unused register
space of the child module(s). So the module control registers
are all over the map at various offsets.

Adding holes for each module control register to the child nodes
seems like an overkill to work around this IMO. Especially
considering many drivers only understand one IO range currently.

Regards,

Tony
