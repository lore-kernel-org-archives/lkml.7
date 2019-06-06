Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E235C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6E9207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfFFHt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:49:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:49036 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFFHt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:49:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x567nPUG022679;
        Thu, 6 Jun 2019 02:49:26 -0500
Message-ID: <c558ca3caac6f0c24a13cd5d7599bf4e861bca62.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna
 Labs Fabric Interrupt Controller Driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     "Shenhar, Talel" <talel@amazon.com>, nicolas.ferre@microchip.com,
        jason@lakedaemon.net, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, jonnyc@amazon.com,
        hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Date:   Thu, 06 Jun 2019 17:49:25 +1000
In-Reply-To: <86pnnrgpmm.wl-marc.zyngier@arm.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
         <1559731921-14023-3-git-send-email-talel@amazon.com>
         <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
         <553d06a4-a6b6-816f-b110-6ef7f300dde4@amazon.com>
         <0915892c-0e53-8f53-e858-b1c3298a4d35@arm.com>
         <54df139cc6cfef9202be6b945c968c3040591607.camel@kernel.crashing.org>
         <86pnnrgpmm.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 08:05 +0100, Marc Zyngier wrote:
> 
> > I disagree Marc. This is a rather bad error which indicates that the
> > device-tree is probably incorrect (or the HW was wired in a way that
> > cannot work).
> 
> But surely that's something you'll spot pretty quickly.

Not really. A level/edge mismatch isn't something you can spot that
quickly, but will cause lost interrupts on load. Since the kernel can
spot the error pretty much right away, I think that could even be a
pr_err :)

> Also, you get
> a splat from the irq subsystem already, telling you that things went
> wrong (see __irq_set_trigger). At that stage, you can enable debugging
> and figure it out.

Ah returning an error will cause such splat indeed.

> What I'm trying to avoid is the kernel becoming a (pretty bad)
> validation tool for DTS files.

Haha, yeah, I don't like it going out of its way to validate them but
that sort of very obvious sanity checking makes sense.

> > Basically a given FIC can either be entirely level sensitive or
> > entirely edge sensitive. This catches cases where the DT has routed
> > a mixed of both to the same FIC. Definitely worth barfing loudly
> > about rather than trying to understand subtle odd misbehaviours of
> > the device in the field.
> 
> Then, in the interest of not producing incorrect DTs, could the
> edge/level property be encoded in the FIC description itself, rather
> than in the interrupt specifiers of the individual devices? It would
> sidestep the problem altogether. You can still put the wrong one in
> the FIC node, but it then becomes even more obvious what is going
> on...

This was Talel original approach internally in fact. I told him to put
it in the specifier instead :-) The advantage in doing it that way is
that you get the right flags in the descriptor by default iirc, so the
right value in /proc/interrupts etc... And it will continue working if
a future FIC loses that limitation.

That said, if you feel strongly about it, we can revert to putting a
global property in the FIC node itself. Let us know what you want.

Cheers,
Ben.


