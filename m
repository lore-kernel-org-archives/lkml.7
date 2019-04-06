Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BCAC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3766120B1F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDFMzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 08:55:54 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41747 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDFMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 08:55:53 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 63466240003;
        Sat,  6 Apr 2019 12:55:50 +0000 (UTC)
Date:   Sat, 6 Apr 2019 14:55:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Message-ID: <20190406125550.GA7480@piout.net>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <5ca84214.1c69fb81.e3ace.21e5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca84214.1c69fb81.e3ace.21e5@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2019 01:07:13-0500, Rob Herring wrote:
> On Wed, Apr 03, 2019 at 04:52:44PM +0200, Flavio Suligoi wrote:
> > Some RTC devices have a battery-low automatic detection circuit.
> > The battery-low event is usually reported with:
> > 
> > - a bit change in a RTC status register
> > - a hw signaling (generally using an interrupt generation), changing
> >   the hw level of a specific pin;
> > 
> > The new property "battery-low-hw-alarm" enable the RTC to generate the
> > hw signaling in case of battery-low event.
> > 
> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > ---
> >  Documentation/devicetree/bindings/rtc/rtc.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
> > index a97fc6a..f93a44d 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> > @@ -31,6 +31,9 @@ below.
> >                              expressed in femto Farad (fF).
> >                              The default value shall be listed (if optional),
> >                              and likewise all valid values.
> > +- battery-low-hw-alarm :    Enable the "battery-low" output pin. This function
> > +                            is available on the following devices:
> > +                            - pcf2127 - pin used for alarm: INTn
> 
> Boolean? If there's cases where which pin is selectable, then we'd need 
> this to take a value. Not sure how likely that is?
> 

Indeed, there is at least the pcf85363 that has two possible pins for
that interrupt. How would you select the pin then? a zero based index? a
string?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
