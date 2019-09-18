Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E882C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C621928
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfIROq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:46:59 -0400
Received: from foss.arm.com ([217.140.110.172]:43338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfIROq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546751000;
        Wed, 18 Sep 2019 07:46:58 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E98923F67D;
        Wed, 18 Sep 2019 07:46:56 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:46:54 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Message-ID: <20190918154654.6fb7e7f5@donnerap.cambridge.arm.com>
In-Reply-To: <CABb+yY3drgYHk2_SZMgGhgSisB7wMVKFSx8VVabCcXkGByvgwg@mail.gmail.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
        <1568626884-5189-2-git-send-email-peng.fan@nxp.com>
        <20190917183115.3e40180f@donnerap.cambridge.arm.com>
        <CABb+yY2CP1i9fZMoPua=-mLCUpYrcO28xF5UXDeRD2XTYe7mEg@mail.gmail.com>
        <20190918104347.285bd7ad@donnerap.cambridge.arm.com>
        <CABb+yY3drgYHk2_SZMgGhgSisB7wMVKFSx8VVabCcXkGByvgwg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 09:19:46 -0500
Jassi Brar <jassisinghbrar@gmail.com> wrote:

Hi,

> On Wed, Sep 18, 2019 at 4:44 AM Andre Przywara <andre.przywara@arm.com> wrote:
> 
> >  
> > > which needs 9 arguments to work. The fact that the fist argument is
> > > always going to be same on a platform is just the way we use this
> > > instruction.
> > >  
> > > > We should be as strict as possible to avoid any security issues.
> > > >  
> > > Any example of such a security issue?  
> >
> > Someone finds a way to trick some mailbox client to send a crafted message to the mailbox.
> >  
> What if someone finds a way to trick the block layer to erase 'sda' ?

Yes, the Linux block driver control the whole block device, it can do whatever it wants.
The firmware provides an interface for multiple users, and the mailbox controller just uses *one part* of it. So we should make sure that it's the right part.

>  That is called "bug in the code".
> It does happen in every subsystem but we don't stop implementing new
> features .... we write flexible code and then fix any bug.
> 
> 
> > Do you have any example of a use case where the mailbox client needs to provide the function ID?
> >  
> FSL_SIP_SCMI_1/2 ?

Huh? Where does the SCPI or SCMI driver provide this? Those clients don't even provide any arguments. Adding some would defeat the whole point of having this mailbox in the first place, which was to provide a drop-in replacement for a hardware mailbox device used on other platforms.

> But that is not the main point, which is to be consistent (not
> ignoring first argument because someone may find a bug to exploit) and
> flexible.

Please read the SMCCC[1]: The first argument is in r1/w1/x1. r0/w0 is the function ID, and this is a specific value (fixed by the firmware implementation, see Peng's ATF patch) and not up to be guessed by a client.

Please keep in mind that we should *NOT* do smc calls without following the SMCCC spec.

> > > > The firmware certainly knows the function ID it implements. The firmware controls the DT. So it is straight-forward to put the ID into the DT. The firmware could even do this at boot time, dynamically, before passing on the DT to the non-secure world (bootloader or kernel).
> > > >
> > > > What would be the use case of this functionality?
> > > >  
> > > At least for flexibility and consistency.  
> >
> > I appreciate the flexibility idea, but when creating an interface, especially a generic one to any kind of firmware, you should be as strict as possible, to avoid clashes in the future.
> >  
> I really don't see how there can be clashes with more complete and
> flexible implementation.

Platform A uses PSCI, but no other SMCCC services, so in your scenario you assign a valid function ID say from the SIP range and tell the mailbox *client* to use it. Now you want to run this client on platform B, which happens to have chosen this very function ID for the "set fire on the device" SMCCC service.
So now you would need to assign different IDs to the *client*, depending on the platform? That doesn't make sense. The solution is that you just assign the function ID to the controller, in the (platform specific) DT, so it naturally matches the platform requirements. You can even change it over time, as long as you change both the DT and firmware at the same time.
The client (SCPI, for instance) is totally ignorant about this communication detail, it just needs some mailbox to request services.

That's why I think the function ID (which is part of the SMCCC protocol, not of the mailbox service!) should just be set in the controller DT node and nowhere else.

Cheers,
Andre.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0028b/ARM_DEN0028B_SMC_Calling_Convention.pdf
