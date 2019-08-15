Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DDCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1CB2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfHOHhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:37:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfHOHhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:37:17 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyAJs-0006R3-3r; Thu, 15 Aug 2019 09:37:12 +0200
Date:   Thu, 15 Aug 2019 09:37:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Woody Suwalski <terraluna977@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit
 guests
In-Reply-To: <CAM6Zs0UoHZyBkY9-RLdO-W+u09RZPbzq-A-K01sHyRkfoEiYTA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908150924210.2241@nanos.tec.linutronix.de>
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com> <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com> <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com> <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com>
 <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com> <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com> <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de> <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com>
 <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com> <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de> <CAM6Zs0UoHZyBkY9-RLdO-W+u09RZPbzq-A-K01sHyRkfoEiYTA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woody,

On Tue, 13 Aug 2019, Woody Suwalski wrote:
> On Mon, Aug 12, 2019 at 1:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > The ACPI handler is not the culprit. This is either an emulation bug or
> > something really strange. Can you please use a WARN_ON() if the loop is
> > exited via the timeout so we can see in which context this happens?
> >
>
> B. On 5.3-rc4 problem is gone. I guess it is overall good sign.

Now the interesting question is what changed between 5.3-rc3 and
5.3-rc4. Could you please try to bisect that?

> C. To recreate problem I went back to 5.2.4. The WARN_ON trace shows
> (in reverse):

Next time you can spare yourself the work to reverse the stack trace. We
are all used to read it the other way round :)

> entry_SYSCALL_64_after_hwframe
> do_syscall_64
> ksys_write
> vfs_write
> kernfs_fop_write
> state_store
> pm_suspend.cold.3
> suspend_devices_and_enter
> dpm_suspend_noirq
> suspend_device_irqs
> ?ktime_get
> ?synchronize
> synchronize_irq
> __synchronize_hardirq.cold.9

dpm_suspend_noirq() is called with all CPUs online and interrupts
enabled. In that case an interrupt pending in IRR does not make any sense
at all. Confused.

Thanks,

	tglx
