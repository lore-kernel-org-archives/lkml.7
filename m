Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDC920879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfCYJDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfCYJDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DBC699C4B;
        Mon, 25 Mar 2019 09:03:53 +0000 (UTC)
Received: from localhost (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB3E8611B7;
        Mon, 25 Mar 2019 09:03:52 +0000 (UTC)
Date:   Mon, 25 Mar 2019 17:03:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
Message-ID: <20190325090349.GE3659@MiWiFi-R3L-srv>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325072710.GA31828@MiWiFi-R3L-srv>
 <20190325075342.GE12016@zn.tnic>
 <20190325082124.GD3659@MiWiFi-R3L-srv>
 <alpine.DEB.2.21.1903250941020.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903250941020.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 25 Mar 2019 09:03:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/19 at 09:43am, Thomas Gleixner wrote:
> On Mon, 25 Mar 2019, Baoquan He wrote:
> 
> > On 03/25/19 at 08:53am, Borislav Petkov wrote:
> > > On Mon, Mar 25, 2019 at 03:27:10PM +0800, Baoquan He wrote:
> > > > Kexec kernel also need to get rsdp to get SRAT tables so that KASLR can
> > > > avoid those hotpluggable regions in boot compression stage.
> > > > 
> > > > The kexec_file_load has filled in acpi_rsdp_addr of kexec kernel in
> > > > below code. It will return direclty in get_rsdp_addr() since
> > > > acpi_rsdp_addr is got from boot_params->acpi_rsdp_addr.
> > > > 
> > > > arch/x86/kernel/kexec-bzimage64.c <<setup_boot_parameters>>
> > > > 	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> > > > 
> > > > The other interface, kexec_load, its boot_params filling is done in user
> > > > space kexec_tools. And we haven't made the acpi_rsdp_addr filling yet.
> > > > And the old kexec_tools utility can also cause the new kexec kernel to
> > > > search efi rspd pointer even thought it's fixed.
> > > 
> > > Yes, kexec is a pile of ugly and fragile hackery.
> > 
> > Well, yes, we have to admit that, since kexec is based on hacking.
> 
> Well, then the right thing to do is to think about it proper and replace
> the hackery by something well thought out instead of adding duct tape to it
> every other day.

I could make mistakes on expressing. I meant the mechanism of kexec is
based on hacking into kernel booting stuff. So sometime we call kexec a
bootloader, at least a bootloader variant. That means we may need to adapt
code when any change is made in kernel boot side.

E.g for this acpi_rsdp_addr adding, it happened in boot compressing
stage, to get rsdp to fix the conflict between KASLR and HOTPLUG.
Accordingly, kexec code need be adpated too.

So, when maintain kexec/kdump, we have to track and test any change
which could happen in kernel boot.

Thanks
Baoquan
