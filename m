Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FAEC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047D120828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfF0Oik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:38:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56202 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0Oik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:38:40 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgVXj-0006CB-G4; Thu, 27 Jun 2019 16:38:31 +0200
Date:   Thu, 27 Jun 2019 16:38:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Octavio Alvarez <octallk1@alvarezp.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
In-Reply-To: <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org>
Message-ID: <alpine.DEB.2.21.1906271632300.32342@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org> <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org> <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de> <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
 <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de> <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org>
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

Octavio,

On Mon, 24 Jun 2019, Octavio Alvarez wrote:
> On 6/23/19 7:54 AM, Thomas Gleixner wrote:
> >   Load the driver on Linus master with the following module parameter:
> > 
> >     disable_msi=1
> > 
> > That switches to INTx usage. Does the machine resume proper with that?
> 
> I did two tests:
> 
> If I boot with sky2.disable_msi=1 on the kernel cmdline then the problem goes
> away (when back from hibernation, the NIC works OK).
> 
> If I boot regularly (disable_msi not set) and then do modprobe -r sky2;
> modprobe sky2 disable_msi=1, the problem stays (when back from hibernation,
> the NIC does not work).

Interesting. Did you verify that the driver still uses INTx after
hibernation in /proc/interrupts?

 cat /proc/interrupts | grep eth0

The 6st column should show IO-APIC for INTx. If it shows PCI-MSI then
something went wrong.

Also please check Linus suspicion about the module being reloaded after
hibernation through some distro magic.

Thanks,

	tglx



