Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F837C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBB621907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfIRRGm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:06:42 -0400
Received: from foss.arm.com ([217.140.110.172]:45332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfIRRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:06:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E800337;
        Wed, 18 Sep 2019 10:06:41 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC10B3F59C;
        Wed, 18 Sep 2019 10:06:39 -0700 (PDT)
Date:   Wed, 18 Sep 2019 18:06:37 +0100
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
Message-ID: <20190918180637.1ac3ae08@donnerap.cambridge.arm.com>
In-Reply-To: <CABb+yY3gJpK5ghS1u-e=f-msO+=oVvX=zDNj3Jg2i0-uJHrLiA@mail.gmail.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
        <1568626884-5189-2-git-send-email-peng.fan@nxp.com>
        <20190917183115.3e40180f@donnerap.cambridge.arm.com>
        <CABb+yY2CP1i9fZMoPua=-mLCUpYrcO28xF5UXDeRD2XTYe7mEg@mail.gmail.com>
        <20190918104347.285bd7ad@donnerap.cambridge.arm.com>
        <CABb+yY3drgYHk2_SZMgGhgSisB7wMVKFSx8VVabCcXkGByvgwg@mail.gmail.com>
        <20190918154654.6fb7e7f5@donnerap.cambridge.arm.com>
        <CABb+yY3gJpK5ghS1u-e=f-msO+=oVvX=zDNj3Jg2i0-uJHrLiA@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 10:31:57 -0500
Jassi Brar <jassisinghbrar@gmail.com> wrote:

Hi,

> On Wed, Sep 18, 2019 at 9:46 AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Wed, 18 Sep 2019 09:19:46 -0500
> > Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >
> > Hi,
> >  
> > > On Wed, Sep 18, 2019 at 4:44 AM Andre Przywara <andre.przywara@arm.com> wrote:
> > >  
> > > >  
> > > > > which needs 9 arguments to work. The fact that the fist argument is
> > > > > always going to be same on a platform is just the way we use this
> > > > > instruction.
> > > > >  
> > > > > > We should be as strict as possible to avoid any security issues.
> > > > > >  
> > > > > Any example of such a security issue?  
> > > >
> > > > Someone finds a way to trick some mailbox client to send a crafted message to the mailbox.
> > > >  
> > > What if someone finds a way to trick the block layer to erase 'sda' ?  
> >
> > Yes, the Linux block driver control the whole block device, it can do whatever it wants.
> >  
> Sorry, it doesn't make any sense.

What I meant is that in contrast to a block driver the SMC interface is a shared resource. The mailbox controller is just using a tiny part of that. We must make sure to not interfere with the other services offered by firmware.
 
> > >  That is called "bug in the code".
> > > It does happen in every subsystem but we don't stop implementing new
> > > features .... we write flexible code and then fix any bug.
> > >
> > >  
> > > > Do you have any example of a use case where the mailbox client needs to provide the function ID?
> > > >  
> > > FSL_SIP_SCMI_1/2 ?  
> >
> > Huh? Where does the SCPI or SCMI driver provide this? Those clients don't even provide any arguments. Adding some would defeat the whole point of having this mailbox in the first place, which was to provide a drop-in replacement for a hardware mailbox device used on other platforms.
> >  
> SCPI/SCMI implementation is broken. I did NAK it.
> With the 'smc' mailbox you may get away without have to program the
> channel before transmit, but not every controller is natively so.
> 
> > > But that is not the main point, which is to be consistent (not
> > > ignoring first argument because someone may find a bug to exploit) and
> > > flexible.  
> >
> > Please read the SMCCC[1]: The first argument is in r1/w1/x1. r0/w0 is the function ID, and this is a specific value (fixed by the firmware implementation, see Peng's ATF patch) and not up to be guessed by a client.
> >  
> The first argument of smc call is the function-id
>   arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, arg5, 0, &res);

As I wrote we can't safely use a bare smc call. We must comply with the SMCCC, because there are a possible multitude of services the firmware offers. PSCI is a one obvious example.
And SMCCC says:
When an SMC32/HVC32 call is made from AArch32:
   • A Function Identifier is passed in register R0.
   • Arguments are passed in registers R1-R6.
   • Results are returned in R0-R3.
...
(similar for SMC64)

So arguments start from r1/x1.

> >
> > That's why I think the function ID (which is part of the SMCCC protocol, not of the mailbox service!) should just be set in the controller DT node and nowhere else.
> >  
> Actually that is the very reason func-id should be a client thing and
> passed via client's DT node :)
> It is general understanding that protocol specific bits should not be
> a part of controller driver, but the client(protocol) driver.

There are *two* protocols to consider here:
One is the outer SMCCC protocol, which establishes communication between the mailbox controller driver and the firmware. SMCCC defines very precisely the meaning of r0/w0 for that, but leaves the rest (x1-x6) to the user. Think of the function ID being the equivalent of an MMIO base address. You can use it to select several instances of one type of mailbox. It's the task of the controller driver to abstract from that. Surely you wouldn't provide the MMIO base address of the particular mailbox in the client's DT node.

The *client* protocol is then wrapped inside this, using the six argument registers that SMCCC gives us. This is indeed up to the client to use and it dictates its meaning.

Maybe there is some misunderstanding that this mailbox is really a SMCCC mailbox rather than a pure SMC mailbox? Should we use a different naming like smccc_mailbox or firmware_mbox instead?

> Page-7 Function-ID specifies :-
> 1) The service to be invoked.
> 2) The function to be invoked.

"Service" is the term used for a "group of functions". PSCI is one service, for instance. It's typically determined by some upper bits. Inside this service there are several functions, like CPU_ON or SYSTEM_RESET, typically using low order bits.
In our case the service is the mailbox, and there is just one function, the actual doorbell. We could have introduced more functions (like disocvery, information or statistics), but there is no real need for that.

Cheers,
Andre.

> 3) The calling convention (32-bit or 64-bit) that is in use.
> 4) The call type (fast or yielding) that is in use.
> 
> Even if we turn blind to 2,3 & 4, but (1) shouts like a runtime property.

> 
> Thanks.

