Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9471C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AC62067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfHLRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:24:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:24:44 -0400
Received: from p200300ddd71876867e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7686:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hxE3j-0002Jy-TR; Mon, 12 Aug 2019 19:24:39 +0200
Date:   Mon, 12 Aug 2019 19:24:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Woody Suwalski <terraluna977@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit
 guests
In-Reply-To: <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de>
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com> <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com> <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com> <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com>
 <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com> <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com> <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de> <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com>
 <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com>
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

 A: Because it messes up the order in which people normally read text.
 Q: Why is top-posting such a bad thing?
 A: Top-posting.
 Q: What is the most annoying thing in e-mail?

 A: No.
 Q: Should I include quotations after my reply?

 http://daringfireball.net/2007/07/on_top

Woody,

On Mon, 12 Aug 2019, Woody Suwalski wrote:

> I have added a timeout counter in __synchronize_hardirq().
> At the bottom I have converted while(inprogress); to while(inprogress
> && timeout++ < 100);
> 
> That is bypassing the suspend lockup problem. On both 32-bit and
> 64-bit VMs the countdown is triggered by sync of irq9.

So ACPI triggered an interrupt, which got already forwarded to a CPU, but
it is not handled. That's more than strange. 

> Which probably means that there is some issue in ACPI handler and
> synchronize_hardirq() is stuck on it?

The ACPI handler is not the culprit. This is either an emulation bug or
something really strange. Can you please use a WARN_ON() if the loop is
exited via the timeout so we can see in which context this happens?

Thanks,

	tglx
