Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8128CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DAA21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403947AbfIYLB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:01:56 -0400
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:46121
        "EHLO know-smtprelay-omc-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403867AbfIYLB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:01:56 -0400
Received: from mail0.xen.dingwall.me.uk ([82.47.84.47])
        by cmsmtp with ESMTPA
        id D53Qi4CI0wGUPD53Ri497I; Wed, 25 Sep 2019 12:01:53 +0100
X-Originating-IP: [82.47.84.47]
X-Authenticated-User: james.dingwall@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=0bfgdX8EJi0Cr9X0x0jFDA==:117
 a=0bfgdX8EJi0Cr9X0x0jFDA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=J70Eh1EUuV4A:10
 a=R3OVokhvzph9xWr5bnAA:9 a=wPNLvfGTeEIA:10
Received: from localhost (localhost [IPv6:::1])
        by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id A659E10D2A7;
        Wed, 25 Sep 2019 11:01:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
        by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id USOBNqyBtDPy; Wed, 25 Sep 2019 11:01:52 +0000 (UTC)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2001:470:695c:302::c0a8:105])
        by dingwall.me.uk (Postfix) with ESMTP id 6F60310D2A4;
        Wed, 25 Sep 2019 11:01:52 +0000 (UTC)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
        id 58172FB608; Wed, 25 Sep 2019 11:01:52 +0000 (UTC)
Date:   Wed, 25 Sep 2019 11:01:52 +0000
From:   James Dingwall <james@dingwall.me.uk>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Juergen Gross <jgross@suse.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: pstore does not work under xen
Message-ID: <20190925110152.GA31550@dingwall.me.uk>
References: <20190919102643.GA9400@dingwall.me.uk>
 <3908561D78D1C84285E8C5FCA982C28F7F472015@ORSMSX115.amr.corp.intel.com>
 <20190919161430.GA28042@dingwall.me.uk>
 <ae56e2c0-b2d3-835d-04cb-e4404d979859@oracle.com>
 <20190923154227.GA11201@dingwall.me.uk>
 <201909231556.7FF7A11@keescook>
 <be41da82-3adc-4ab1-e4f9-5fdf11ac4b08@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be41da82-3adc-4ab1-e4f9-5fdf11ac4b08@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfEO2FbJeaZSLiyToWx2IURbsIZpX9oT4HCG7RhrySskcO2p7R96PcRT6u+eIV3FMxxEWqqPtNx6CwZ7hQbtSrL9cBDZo6mLOVXzNxATMvnfG8od5gNaY
 mnz48ivj1uwlgcAhOuwm5haHBBAjrT/Xcc3dW/2MOduYovyouZ4IFdhDvE5J/ksxDGaVSy291fCH2JJrC5qlNz3dz9NEcnmWorPMbYBLhV5nvGqg6V4fTG5+
 iBa7rHNwFg42r3tZPs+tJxanGh9HiwKZUQSbcCqye7hHpscQ0cnFWZeSQ4FSZoIE8o4dNY+QA7B02ZZ8AHY/IzkSiUhlRQXNvGSfd6ww8mjCAFbawwM8nikf
 WgkeeNNECKL/hJcj84ldH3TnCh0QQM1Yrj7xgjpd2B9tZWYn9CpRDDAZuZxSElETBghaiQoOLF8VDvl0gffcNEAPOYMO6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:41:05PM -0400, Boris Ostrovsky wrote:
> On 9/23/19 6:59 PM, Kees Cook wrote:
> > On Mon, Sep 23, 2019 at 03:42:27PM +0000, James Dingwall wrote:
> >> On Thu, Sep 19, 2019 at 12:37:40PM -0400, Boris Ostrovsky wrote:
> >>> On 9/19/19 12:14 PM, James Dingwall wrote:
> >>>> On Thu, Sep 19, 2019 at 03:51:33PM +0000, Luck, Tony wrote:
> >>>>>> I have been investigating a regression in our environment where pstore 
> >>>>>> (efi-pstore specifically but I suspect this would affect all 
> >>>>>> implementations) no longer works after upgrading from a 4.4 to 5.0 
> >>>>>> kernel when running under xen.  (This is an Ubuntu kernel but I don't 
> >>>>>> think there are patches which affect this area.)
> >>>>> I don't have any answer for this ... but want to throw out the idea that
> >>>>> VMM systems could provide some hypercalls to guests to save/return
> >>>>> some blob of memory (perhaps the "save" triggers automagically if the
> >>>>> guest crashes?).
> >>>>>
> >>>>> That would provide a much better pstore back end than relying on emulation
> >>>>> of EFI persistent variables (which have severe contraints on size, and don't
> >>>>> support some pstore modes because you can't dynamically update EFI variables
> >>>>> hundreds of times per second).
> >>>>>
> >>>> For clarification this is a dom0 crash rather than an HVM guest with EFI.  I
> >>>> should probably have also mentioned the xen verion has changed from 4.8.4 to
> >>>> 4.11.2 in case its behaviour on detection of crashed domain has changed.
> >>>>
> >>>> (For capturing guest crashes we have enabled xenconsole logging so the
> >>>> hvc0 log is available in dom0.)
> >>>
> >>> Do you only see this difference between 4.4 and 5.0 when you crash via
> >>> sysrq?
> >>>
> >>> Because that's where things changed. On 4.4 we seem to be forcing an
> >>> oops, which eventually calls kmsg_dump() and then panic. On 5.0 we call
> >>> panic() directly from sysrq handler. And because Xen's panic notifier
> >>> doesn't return we never get a chance to call kmsg_dump().
> >>>
> >> Ok, I see that change in 8341f2f222d729688014ce8306727fdb9798d37e.  I 
> >> hadn't tested it any other way before.  Using the null pointer 
> >> de-reference module code at [1] a pstore record is generated as expected 
> >> when the module is loaded (panic_on_oops=1).
> > This change looks correct -- it just gets us directly to the panic()
> > state instead of exercising the various exception handlers.
> >
> >> I have also tested swapping the kmsg_dump() / 
> >> atomic_notifier_call_chain() around in panic.c and this also results in 
> >> a pstore record being created with sysrq-c.  I don't know if that would 
> >> be an acceptable solution though since it may break behaviour that other 
> >> things depend on.
> > I don't think reordering these is a good idea: as the comments say,
> > there might be work done in the notifier chain that kmsg_dump() will
> > want to capture (e.g. the KASLR base offset).
> >
> > The situation seems to be that notifier callbacks must return -- I think
> > Xen needs fixing here.
> >
> 
> I only had one quick sanity test with a PV guest so this needs more
> testing. James, can you give it a try?

I have tested the patch in a pv domU and in dom0.  The kernel was built 
with a default Ubuntu .config which sets CONFIG_PANIC_TIMEOUT=0. uname 
-r = 5.0.0-27-generic.

In the domU (no custom kernel parameters):

- sysrq-c: I saw my debug printk messages about kmsg_dump() being 
invoked after the traceback and the domain became listed as crashed in 
the xl status output.

- halt -p: clean shutdown

- shutdown -r now: clean reboot


In the domU with panic=15 in kernel parameters:

- sysrq-c: as without panic=15 then final message "Rebooting in 15 
seconds.." printed but domain never rebooted.  Without this patch the 
domain doesn't reboot or print the Rebooting message presumably because 
of the non-returning panic handler.  If that message is reached then I 
think I would expect a reboot.  (In our Linux 4.4 / Xen 4.8.4 
environment no value of panic resulted in reboot.)

- halt -p: clean shutdown

- shutdown -r now: clean reboot


In dom0 with oops=panic panic=15 in the kernel parameters:

- sysrq-c: kmsg_dump() debug messages printed, last linux message 
"Rebooting in 15 seconds..", after 15s "(XEN) Hardware Dom0 crashed: 
rebooting machine in 5 seconds.", after 5s system rebooted.  On the 
next start a pstore record is present as expected.

- halt -p: clean shutdown, no pstore record present on next start.

- shutdown -r now: clean reboot, no pstore record present on next 
start.


In dom0 with panic=0:

- sysrq-c: dom0 crashes, no reboot messages printed from Xen or kernel 
and system hangs.  A pstore record is present on next start.

- halt -p: clean shutdown, no pstore record present on next start.

- shutdown -r now: clean reboot, no pstore record present on next 
start.


In my opinion this patch:
 - fixes the original issue of no pstore record being generated for a 
dom0 panic.
 - respects the dom0 panic=... value.  This is a change in behaviour in 
how xen handles the crashed dom0 from always rebooting to only rebooting 
if panic > 0.
 - causes a Rebooting message to be printed in a crashed pv domU when 
panic > 0 but the domain does not reboot when it should.

James

> 
> 
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 750f46ad018a..d88f118028b4 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -269,16 +269,17 @@ void xen_reboot(int reason)
>                 BUG();
>  }
>  
> +static int reboot_reason = SHUTDOWN_reboot;
>  void xen_emergency_restart(void)
>  {
> -       xen_reboot(SHUTDOWN_reboot);
> +       xen_reboot(reboot_reason);
>  }
>  
>  static int
>  xen_panic_event(struct notifier_block *this, unsigned long event, void
> *ptr)
>  {
>         if (!kexec_crash_loaded())
> -               xen_reboot(SHUTDOWN_crash);
> +               reboot_reason = SHUTDOWN_crash;
>         return NOTIFY_DONE;
>  }
>  
> @@ -290,6 +291,8 @@ static struct notifier_block xen_panic_block = {
>  int xen_panic_handler_init(void)
>  {
>         atomic_notifier_chain_register(&panic_notifier_list,
> &xen_panic_block);
> +       if (panic_timeout == 0)
> +               set_arch_panic_timeout(-1, CONFIG_PANIC_TIMEOUT);
>         return 0;
>  }
> 
> 
