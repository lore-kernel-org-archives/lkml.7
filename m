Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BE9C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE84206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGBDRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:17:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfGBDRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:17:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C305308FBB4;
        Tue,  2 Jul 2019 03:17:24 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB41B18F0A;
        Tue,  2 Jul 2019 03:17:19 +0000 (UTC)
Date:   Tue, 2 Jul 2019 11:17:15 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Airlie <airlied@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>
Subject: Re: mgag200 fails kdump kernel booting
Message-ID: <20190702031715.GB3327@dhcp-128-65.nay.redhat.com>
References: <20190626081522.GX24419@MiWiFi-R3L-srv>
 <20190626082907.GY24419@MiWiFi-R3L-srv>
 <CAMwc25oeskFG4bbrb3rwotqi1a5z4wYsGW=Qs_XJmhX_vAdNfQ@mail.gmail.com>
 <20190702014158.GC3178@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702014158.GC3178@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 02 Jul 2019 03:17:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/19 at 09:41am, Baoquan He wrote:
> On 07/02/19 at 06:51am, David Airlie wrote:
> > On Wed, Jun 26, 2019 at 6:29 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 06/26/19 at 04:15pm, Baoquan He wrote:
> > > > Hi Dave,
> > > >
> > > > We met an kdump kernel boot failure on a lenovo system. Kdump kernel
> > > > failed to boot, but just reset to firmware to reboot system. And nothing
> > > > is printed out.
> > > >
> > > > The machine is a big server, with 6T memory and many cpu, its graphic
> > > > driver module is mgag200.
> > > >
> > > > When added 'earlyprintk=ttyS0' into kernel command line, it printed
> > > > out only one line to console during kdump kernel booting:
> > > >      KASLR disabled: 'nokaslr' on cmdline.
> > > >
> > > > Then reset to firmware to reboot system.
> > > >
> > > > By further code debugging, the failure happened in
> > > > arch/x86/boot/compressed/misc.c, during kernel decompressing stage. It's
> > > > triggered by the vga printing. As you can see, in __putstr() of
> > > > arch/x86/boot/compressed/misc.c, the code checks if earlyprintk= is
> > > > specified, and print out to the target. And no matter if earlyprintk= is
> > > > added or not, it will print to VGA. And printing to VGA caused it to
> > > > reset to firmware. That's why we see nothing when didn't specify
> > > > earlyprintk=, but see only one line of printing about the 'KASLR
> > > > disabled'.
> > >
> > > Here I mean:
> > > That's why we see nothing when didn't specify earlyprintk=, but see only
> > > one line of printing about the 'KASLR disabled' message when
> > > earlyprintk=ttyS0 added.
> > 
> > Just to clarify, the original kernel is booted with mgag200 turned
> > off, then kexec works, but if the original kernel loads mgag200, the
> > kexec kernels resets hard when the VGA is used to write stuff out.
> 
> Thanks for looking into this, Dave.
> 
> Yeah, in fact the issue was found in kdump kernel. I haven't checked the
> kexec jumping. Kexec jumping will call device_shutdown() to attempt to
> shutdown all devices before jumping to the 2nd kernel. But kdump jumping
> won't.
> 
> > 
> > This *might* be fixable in the controlled kexec case, but having an
> > mgag200 shutdown path that tries to put the gpu back into a state
> > where VGA doesn't die, but for the uncontrolled kexec it'll still be a
> > problem, since once the gpu is up and running and VGA is disabled, it
> > doesn't expect to see anymore VGA transactions.
> 
> Yes, I see. It should have been shutdown by device_shutdown() in kexec
> case. The uncontrolled case, I guess you mean the kdump case. In
> kdump case, we don't call device_shutdown() before jumping because the
> 1st kernel has been in crashed state, we just want to switch to kdump
> kernel asap. So wondering how other GPU/VGA device/driver bebahve,
> currently haven't got report about them. Probably mgag200 is very new,
> or we may not meet them. This issue was met on a new bought server.

I assumed the vga writing only take effect when earlyprintk is provided.
eg. earlyprintk=ttyS0, then x86 early decompress code will write to both
vga and ttyS0.  So if one does not use earlyprintk, he/she still get
nothing.  But if one provides earlyprintk, then he/she should provide a
correct param he want, instead of blindly assume kernel will write to
vga even if he use ttyS0.

Thanks
Dave
