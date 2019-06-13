Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7FAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC2F20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbfFMQzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:55:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:32774 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbfFMCDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:03:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5D234NX020590;
        Wed, 12 Jun 2019 21:03:05 -0500
Message-ID: <3093d174ddd183fe5b6e949a62a15e72aa373e26.camel@kernel.crashing.org>
Subject: Re: [PATCH+DISCUSSION] irqchip: armada-370-xp: Remove redundant ops
 assignment
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Jun 2019 12:03:04 +1000
In-Reply-To: <e4c7b434452775d00b6621012ad5e263076b3fcf.camel@kernel.crashing.org>
References: <e4c7b434452775d00b6621012ad5e263076b3fcf.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 15:16 +1000, Benjamin Herrenschmidt wrote:
> pci_msi_create_irq_domain -> pci_msi_domain_update_chip_ops will
> set those two already since the driver sets MSI_FLAG_USE_DEF_CHIP_OPS
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> [UNTESTED]
> 
> Just something I noticed while browsing through those drivers in
> search of ways to factor some of the code.
> 
> That leads to a question here:
> 
> Some MSI drivers such as this one (or any using the defaults
> mask/unmask
> provided by drivers/pci/msi.c) only call the PCI MSI mask/unmask
> functions.
> 
> Some other drivers call those PCI function but *also* call the parent
> mask/unmask (giv-v2m for example) which generally is the inner domain
> which just itself forwards to its own parent.

  .../...

So I looked at x86 and it also only uses pci_msi_unmask_irq, it doesn't
mask at the parent level. And it also specifies those explicitly which
isn't necessary so the same trivial cleanup patch could be done (happy
to do it unless I missed something here).

Question: If that's indeed the rule we want to establish, should we
consider making all MSI controllers just use the PCI masking and remove
the forwarding to the parent ?

The ones that do the parent, at least in drivers/irqchip/* and
drivers/pci/controller/* (ther are more in arch code) are all the GIC
ones (v2m, v3-its, v3-mbi), alpine which was copied on GIC I think,
tango and dwc.

The other approach would be to make the generic ops setup by
pci_msi_domain_update_chip_ops call the parent as well .. if there is
one and it has corresponding mask/unmask callbacks. That means things
like armada_370 would be unaffected since their "middle" irqdomain chip
doesn't have them, at least until somebody decides that masking at the
parent level as well is a good thing. I *think* it would also work for
x86 since the parent in that case is x86_vector_domain which also
doesn't have mask and unmask callbacks, so it would be a nop change.

Let me know what you think.

Cheers,
Ben.



