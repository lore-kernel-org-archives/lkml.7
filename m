Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13587218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfJCOUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:20:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58345 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfJCOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:20:04 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1iG1xW-0003Vd-IS; Thu, 03 Oct 2019 16:19:58 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <pza@pengutronix.de>)
        id 1iG1xT-0006E6-Kf; Thu, 03 Oct 2019 16:19:55 +0200
Date:   Thu, 3 Oct 2019 16:19:55 +0200
From:   Philipp Zabel <pza@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
Message-ID: <20191003141955.zi5wqjqf4wa7lhv7@pengutronix.de>
References: <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com>
 <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
 <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com>
 <CAFBinCA5sRp1-siqZqJzFL2nuD3BtjrbD65QtpWbnTgtPNXY1A@mail.gmail.com>
 <cebd8f1d-90ab-87e7-9a34-f5c760688ce5@linux.intel.com>
 <CAFBinCCXo50OX6=8Fz-=nRKuELU_fMOCX=z6iwAcw0_Tfgn1ug@mail.gmail.com>
 <da347f1c-864c-7d68-33c8-045e46651f45@linux.intel.com>
 <CAFBinCDhLYmiORvHdZJAN5cuUjc6eWJK5n9Qg26B0dEhhqUqVQ@mail.gmail.com>
 <389f360a-a993-b9a8-4b50-ad87bcfec767@linux.intel.com>
 <CAFBinCBwrTajCrSf-UqZY5gHqUSn0UTmbc_TLPNVZrPyY5jpOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBwrTajCrSf-UqZY5gHqUSn0UTmbc_TLPNVZrPyY5jpOA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:21:55 up 87 days, 19:32, 47 users,  load average: 0.17, 0.20,
 0.22
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Dilip,

On Thu, Sep 19, 2019 at 09:51:48PM +0200, Martin Blumenstingl wrote:
> Hi Dilip,
> 
> (sorry for the late reply)

Same, sorry for the delay.

> On Thu, Sep 12, 2019 at 8:38 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> [...]
> > The major difference between the vrx200 and lgm is:
> > 1.) RCU in vrx200 is having multiple register regions wheres RCU in lgm
> > has one single register region.
> > 2.) Register offsets and bit offsets are different.
> >
> > So enhancing the intel-reset-syscon.c to provide compatibility/support
> > for vrx200.
> > Please check the below dtsi binding proposal and let me know your view.
> >
> > rcu0:reset-controller@00000000 {
> >      compatible= "intel,rcu-lgm";
> >      reg = <0x0000000 0x80000>, <reg_set2 size>, <reg_set3 size>,
> > <reg_set4 size>;
> I'm not sure that I understand what are reg_set2/3/4 for
> the first resource (0x80000 at 0x0) already covers the whole LGM RCU,
> so what is the purpose of the other register resources
> 
> >     intel,global-reset = <0x10 30>;
> >     #reset-cells = <3>;
> > };
> >
> > "#reset-cells":
> >    const:3
> >    description: |
> >      The 1st cell is the reset register offset.
> >      The 2nd cell is the reset set bit offset.
> >      The 3rd cell is the reset status bit offset.
> I think this will work fine for VRX200 (and even older SoCs)
> as you have described in your previous emails we can determine the
> status offset from the reset offset using a simple if/else
> 
> for LGM I like your initial suggestion with #reset-cells = <2> because
> it's easier to read and write.
>
> > Reset driver takes care of parsing the register address "reg" as per the
> > ".data" structure in struct of_device_id.
> > Reset driver takes care of traversing the status register offset.
> the differentiation between two and three #reset-cells can also happen
> based on the struct of_device_id:
> - the LGM implementation would simply also use the reset bit as status
> bit (only two cells are needed)
> - the implementation for earlier SoCs would parse the third cell and
> use that as status bit
> 
> Philipp, can you please share your opinion on how to move forward with
> the reset-intel driver from this series?

That all sounds reasonable for VRX200/LGM to me.

> because the register layout was greatly simplified for the newer SoCs
> (for which there is reset-intel) compared to the older ones
> (reset-lantiq).
> Dilip's suggestion (in my own words) is that you take his new
> reset-intel driver, then we will work on porting reset-lantiq over to
> that so in the end we can drop the reset-lantiq driver.

Just to be sure, you are suggesting to add support for the current
lantiq,reset binding to the reset-intel driver at a later point? I
see no reason not to do that, but I'm also not quite sure what the
benefit will be over just keeping reset-lantiq as is?

> This approach means more work for me (as I am probably the one who
> then has to do the work to port reset-lantiq over to reset-intel).

More work than what alternative?

> I'm happy to do that work if you think that it's worth following this
> approach.  So I want your opinion on this before I spend any effort on
> porting reset-lantiq over to reset-intel.

Reset drivers are typically so simple, I'm not quite sure whether it is
worth to integrate multiple drivers if it complicates matters too much.
In this case though I expect it would just be adding support for a
custom .of_xlate and lantiq specific register property parsing?

regards
Philipp
