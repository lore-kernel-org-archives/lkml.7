Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB1ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8F6206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x34chc1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbfJIXZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:25:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35284 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbfJIXZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:25:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so2419630pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nlXGRir7qxNg9h2YHpsllSmIDcGkVZs+qNLw+3OKCsk=;
        b=x34chc1l4jhUZ+ieWqc/QAPmxIUsAJEfqo1ezDT7BobFrWN6CVavsRTggcyCxErecR
         YdtdK52rVs80vijSYalZdizlf+im10l6PzquuIoOJ9IkiTVY8jhcKzAgTu260eGu7qez
         YW7b0/lEKyjdcZNVRisYcSrcC52nmpqRX0WPUIHFx1t5WNPZKBpUKz+/ZLEnCLDzo1JB
         aAOYMm7hFT2kLclTZohWvBVopRkNgw0dicBjSBI3qFxrarqGlHr5IpUpqCMyvaSvqNUQ
         XdOnLzIdHBWBlxFUNjytOETYTlxng1UlLjirJN+q4vflwCkudObWX26WWbTisccwAz2r
         DCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nlXGRir7qxNg9h2YHpsllSmIDcGkVZs+qNLw+3OKCsk=;
        b=RNEawtpgSBGkxEElygZf/EOFwyhMAPnxCIi5l/BP5apK24ODEX8NRVLz80Kl8wyoPJ
         onuVB5BGgvIivKCnzWkz2WquYRUgDeuXjAwTG2yO9bilHa+kFIb4dyR9+Vw2jar0RmNl
         GUsG+gtmEQi/eJs0Aq0t084n18ip1xYzovMjk5FwLcc461IyPLsU5ONlD1i17C11qhsE
         tAd6j4LOZMi7c/Uyj9ZvMQDx2n63JDDUb8DSZ7si9bO4Bm3J5sGVLKkrKusltRdBNe44
         EUd5YAabmxYq6OxV8A8cWaw39ickwa5xUg0rwpDUwZsTKUCQDg4g0oL+mFD/Hpp4LS4x
         O67A==
X-Gm-Message-State: APjAAAVamdXrY0vd7uhpWUe84qFy6RtDpAyLa83OgzH7hKR7Wybong+I
        xkNNcg+sjwYPNiXBkoD3cnE3eg==
X-Google-Smtp-Source: APXvYqyvw9caDYL9lBwWJwX4I76qO/hB3yMcB4SRwuLzUvSYJfjlZDjoGXvFM1dH/PDxroFRg9jFLw==
X-Received: by 2002:a17:90a:3623:: with SMTP id s32mr7334902pjb.42.1570663542101;
        Wed, 09 Oct 2019 16:25:42 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j25sm3132946pfi.113.2019.10.09.16.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:25:41 -0700 (PDT)
Date:   Wed, 9 Oct 2019 16:25:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 04/16] leds: multicolor: Introduce a multicolor class
 definition
Message-ID: <20191009232539.GB571@minitux>
References: <20191008204800.19870-1-dmurphy@ti.com>
 <20191008204800.19870-5-dmurphy@ti.com>
 <CAOCOHw5uQL56T_DcZA47721yS1tLsp9cyUEdmiWr+Ccfh7YpRQ@mail.gmail.com>
 <d6b68a79-235a-0a9b-bbf3-519571646eff@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6b68a79-235a-0a9b-bbf3-519571646eff@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Oct 13:44 PDT 2019, Dan Murphy wrote:

> Bjorn
> 
> On 10/9/19 3:11 PM, Bjorn Andersson wrote:
> > On Tue, Oct 8, 2019 at 1:49 PM Dan Murphy <dmurphy@ti.com> wrote:
> > > Introduce a multicolor class that groups colored LEDs
> > > within a LED node.
> > > 
> > > The multi color class groups monochrome LEDs and allows controlling two
> > > aspects of the final combined color: hue and lightness. The former is
> > > controlled via <color>_intensity files and the latter is controlled
> > > via brightness file.
> > > 
> > Thanks for making progress on this, it's been the one outstanding
> > question mark for the long overdue respin of the Qualcomm LPG driver.
> 
> > But while it works for the LPG, in that it has outputs named "RGB" I
> > have boards with "generic" LED drivers that are connected to RGB LEDs.
> > So per your proposed solution we would need to add the additional
> 
> You don't have to add the MC class to those drivers.  This is an optional
> framework but if you wanted to use the framework for specific devices then
> yes you would need to add that support. This is why I did the LP55xx patches
> to demonstrate the feasibility since the LP50xx has the MC class
> intelligence already.
> 

Correct me if I've misunderstood something, but if I have a product
using e.g. lm3533 connected to an RGB LED then the correct way to
represent this towards userspace is to introduce the MC class in the
lm3533 LED driver, no?

> The LP55xx driver can register to the LED class and/or the MC LED class
> pending on the DT organization.
> 

Understood.

> I don't plan on going through all of TI's RGB drivers and retrofitting them
> to the MC class.  I do have to update the GPIO LED driver to use the class
> but that work is still pending.
> 
> I may also update the Motorola PCAP driver as well since I have a Droid4 to
> test.
> 

My concern with this is that being connected to a RGB LED is not a
property of the controller, but the system design and the proposed
implementation makes it a property of each controller.

I'm not saying that the proposed path is wrong, I'm saying that we have
83 files named leds-*.c in drivers/leds and this adaption needs to
happen on each one.


And I'm not saying I expect you to do this.

> > mc_class handling to every single LED driver that might be used to
> > sink current into an RGB LED.
> > 
> > I also don't see anything preventing hardware designers from feeding
> > single RGB LEDs from multiple different LED controllers, something the
> > current proposal would prohibit.
> 
> What do you mean by a single RGB LED? Are you referring to a RGB module?
> 
> http://wiki.sunfounder.cc/index.php?title=RGB_LED_Module
> 

Yes

> There is no prevention for HW designers to put a driver on each LED output
> but I am not sure why they would incur
> 
> the additional BOM cost seems quite silly unless you have an unlimited
> budget ;)
> 

So if you have a system with e.g. 8 PWM channels on one PMIC and a
single PWM available on a different PMIC then you're saying that the
hardware guys would be silly to believe that they can drive 3 RGB LEDS
off this?

> If they did design the system that way then the SW would need to revert back
> to the standard LED class as it is done today.
> 

If that is the agreed upon design then I'll continue to adapt my LED
drivers to the MC class.

Regards,
Bjorn
