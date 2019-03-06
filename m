Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FB3C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116320675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfCFKOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:14:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbfCFKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:14:52 -0500
Received: from p5492e5b8.dip0.t-ipconnect.de ([84.146.229.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1TZR-0000sJ-TL; Wed, 06 Mar 2019 11:14:42 +0100
Date:   Wed, 6 Mar 2019 11:14:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Borislav Petkov <bp@alien8.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
In-Reply-To: <e8d1128f-ff81-3dc9-90ae-86ce5d8f69b2@redhat.com>
Message-ID: <alpine.DEB.2.21.1903061112350.1646@nanos.tec.linutronix.de>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com> <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de> <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com> <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com> <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
 <57b32bc1-8ef2-1e1e-a70f-04444f5919a2@amd.com> <6fbcd261-f9e2-1685-1ef7-f148007aab9d@redhat.com> <51078b59-161a-0e13-6d8d-87d37c3375f2@redhat.com> <62f91d1a-4dc7-9628-5c87-5ffca0cd1a0f@amd.com> <92a886e1-1eca-7b94-2c62-9f42abc66bcf@redhat.com>
 <20190305195432.GI8256@zn.tnic> <e8d1128f-ff81-3dc9-90ae-86ce5d8f69b2@redhat.com>
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

Hans,

On Wed, 6 Mar 2019, Hans de Goede wrote:
> On 05-03-19 20:54, Borislav Petkov wrote:
> > On Tue, Mar 05, 2019 at 08:40:02PM +0100, Hans de Goede wrote:
> > > Finger pointing at the firmware if there are multiple vendors involved
> > > is really not going to help here. Esp. since most OEMs will just respond
> > > with "the machine works fine with Windows"
> > 
> > Yes, because windoze simply doesn't report that spurious IRQ, most
> > likely.
> 
> So maybe we need to lower the priority of the do_IRQ error from pr_emerg
> to pr_err then ?  That will stop throwing the errors in the users face each
> boot on distros which have chosen to set the quiet loglevel to such a level
> that pr_err messages are not shown on the console (*).

Well, we rather try to understand and fix the issue.

So if Tom's theory holds, then the patch below should cure it.

Thanks,

	tglx

8<---------------------

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1642,6 +1642,7 @@ static void end_local_APIC_setup(void)
  */
 void apic_ap_setup(void)
 {
+	clear_local_APIC();
 	setup_local_APIC();
 	end_local_APIC_setup();
 }
