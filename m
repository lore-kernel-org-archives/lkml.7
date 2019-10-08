Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA826C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3CC206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfJHP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:56:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41115 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:56:17 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iHrqK-0001K2-Nn; Tue, 08 Oct 2019 17:56:08 +0200
Message-ID: <1570550166.18914.12.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Date:   Tue, 08 Oct 2019 17:56:06 +0200
In-Reply-To: <CAFBinCAEzBk7tT5M-F3H4kLnKURRkK2oSSAmKkrjAn7_wdAROA@mail.gmail.com>
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
         <20191003141955.zi5wqjqf4wa7lhv7@pengutronix.de>
         <CAFBinCAEzBk7tT5M-F3H4kLnKURRkK2oSSAmKkrjAn7_wdAROA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, 2019-10-07 at 21:53 +0200, Martin Blumenstingl wrote:
> Hi Philipp,
> 
> On Thu, Oct 3, 2019 at 4:19 PM Philipp Zabel <pza@pengutronix.de> wrote:
> [...]
> > > because the register layout was greatly simplified for the newer SoCs
> > > (for which there is reset-intel) compared to the older ones
> > > (reset-lantiq).
> > > Dilip's suggestion (in my own words) is that you take his new
> > > reset-intel driver, then we will work on porting reset-lantiq over to
> > > that so in the end we can drop the reset-lantiq driver.
> > 
> > Just to be sure, you are suggesting to add support for the current
> > lantiq,reset binding to the reset-intel driver at a later point? I
> > see no reason not to do that, but I'm also not quite sure what the
> > benefit will be over just keeping reset-lantiq as is?
> 
> according to Chuan and Dilip the current reset-lantiq implementation
> is wrong [0].

The only issue seems to be the .reset callback, which doesn't have any
users anway.

> my understanding is that the Lantiq and Intel LGM reset controllers
> are identical except:
> - the Lantiq variant uses a weird register layout (reset and status
> registers not at consecutive offsets)
> - the bits of the reset and status registers sometimes don't match on
> the Lantiq variant

Thank you, so these are a good explanation for why the DT bindings
should be different.

> - the Intel variant has a dedicated registers area for the reset
> controller registers, while the Lantiq variant mixes them with various
> other functionality (for example: USB2 PHYs)

I'm not quite sure I understand why the intel driver is using syscon,
then. Either way, it shouldn't make a big difference if regmap is used
anyway. 

> > > This approach means more work for me (as I am probably the one who
> > > then has to do the work to port reset-lantiq over to reset-intel).
> > 
> > More work than what alternative?
> 
> compared to "fixing" the existing reset-lantiq driver (reset callback)

That is still something you could do, or just drop the .reset callback
because there are no reset consumers using it anyway.

One correct thing to do would be to identify those self-clearing reset
bits and to disallow calling assert/deassert on them.

> and then (instead of adding a new driver) integrating Intel LGM
> support into reset-lantiq

Since at this point I'm not even sure whether merging the two at all is
better than keeping them separate, I have no opinion on whether merging
intel support into the lantiq driver or the other way around is
preferable.

> > > I'm happy to do that work if you think that it's worth following this
> > > approach.  So I want your opinion on this before I spend any effort on
> > > porting reset-lantiq over to reset-intel.
> > 
> > Reset drivers are typically so simple, I'm not quite sure whether it is
> > worth to integrate multiple drivers if it complicates matters too much.
> > In this case though I expect it would just be adding support for a
> > custom .of_xlate and lantiq specific register property parsing?
> 
> yes, that's how I understand the Lantiq and Intel reset controllers:
> - reset/status/assert/deassert callbacks would be shared across all variants
> - register parsing and of_xlate are SoC specific

Ok. If that turns out to be less rather than more boilerplate than two
separate drivers, that should be fine.

regards
Philipp
