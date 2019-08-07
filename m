Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB704C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EED221E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfHGNUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:20:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbfHGNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:20:10 -0400
Received: from p200300ddd742df588d2c07822b9f4274.dip0.t-ipconnect.de ([2003:dd:d742:df58:8d2c:782:2b9f:4274])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvLrE-0001XK-Eh; Wed, 07 Aug 2019 15:20:00 +0200
Date:   Wed, 7 Aug 2019 15:19:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <maz@kernel.org>
cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] irqdomain/debugfs: Fix uses of
 irq_domain_alloc_fwnode
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
Message-ID: <alpine.DEB.2.21.1908071519410.24014@nanos.tec.linutronix.de>
References: <20190806145716.125421-1-maz@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019, Marc Zyngier wrote:

> I recently noticed that all irq_domain_alloc_fwnode were passing a VA
> to it, which is unfortunate as this is designed to appear in debugfs
> (and we don't like to leak VAs). Disaster was avoided thanks to our
> ____ptrval____ friend, but it remains that the whole thing is pretty
> useless if you have more than a single domain (they all have the same
> name and creation fails).
> 
> In order to sort it out, change all users of irq_domain_alloc_fwnode
> to pass the PA of the irqchip the domain will be associated with. One
> notable exception is the HyperV PCI controller driver which has no PA
> to associate with. This is solved by using a named fwnode instead,
> using the device GUID.
> 
> Finally, irq_domain_alloc_fwnode() is changed to pa a pionter to a PA,
> which can be safely advertised in debugfs.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
