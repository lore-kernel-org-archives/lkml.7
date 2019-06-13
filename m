Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D570E2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFMPby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:31:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:47095 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfFMK46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:56:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5DAuVOr010532;
        Thu, 13 Jun 2019 05:56:32 -0500
Message-ID: <5e3e3f21b53f45cb115b4c04e04dc7557c63982d.camel@kernel.crashing.org>
Subject: Re: [PATCH+DISCUSSION] irqchip: armada-370-xp: Remove redundant ops
 assignment
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 13 Jun 2019 20:56:31 +1000
In-Reply-To: <86muilc012.wl-marc.zyngier@arm.com>
References: <e4c7b434452775d00b6621012ad5e263076b3fcf.camel@kernel.crashing.org>
         <86muilc012.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-13 at 10:22 +0100, Marc Zyngier wrote:
> 
> It looks to me that masking at the PCI level is rather superfluous as
> long as the MSI controller HW has the capability to mask the interrupt
> on a per MSI basis. After all, most non MSI-X endpoint lack support
> for masking of individual vectors, so I think that we should just mask
> things at the irqchip level. This is also consistent with what you'd
> have to do for non-PCI MSI, where nothing standardises the MSI
> masking.
> 
> I think this is in effect a split in responsibilities:
> 
> - the end-point driver should (directly or indirectly) control the
>   interrupt generation at the end-point level,
> 
> - the MSI controller driver should control the signalling of the MSI
>   to the CPU.
> 
> The only case where we should rely on masking interrupts at the
> end-point level is when the MSI controller doesn't provide a method to
> do so (hopefully a rare exception).

While I would tend to agree, I'm also wary of standardizing on
something which isn't what x86 does today :-)

You know what happens when we break them... interestingly enough they
(like quite a few other drivers) don't even bother trying to mask at
the APIC level unless I misread the code. That means that for endpoints
that don't support masking, they just get those MSIs and
"ignore" them...

But I'll look into it, see what the patch looks like.

I've also looked at trying to make the "inner domain" more generic but
that's looking a tad trickier... not giving up yet though :-)

Cheers,
Ben.


