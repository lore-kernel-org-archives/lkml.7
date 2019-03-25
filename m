Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9646FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E88420830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfCYInL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:43:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45000 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfCYInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:43:11 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8LCA-0005Qk-PT; Mon, 25 Mar 2019 09:43:03 +0100
Date:   Mon, 25 Mar 2019 09:43:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
cc:     Borislav Petkov <bp@alien8.de>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
In-Reply-To: <20190325082124.GD3659@MiWiFi-R3L-srv>
Message-ID: <alpine.DEB.2.21.1903250941020.1798@nanos.tec.linutronix.de>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp> <20190322152328.GD12472@zn.tnic> <20190325072710.GA31828@MiWiFi-R3L-srv> <20190325075342.GE12016@zn.tnic> <20190325082124.GD3659@MiWiFi-R3L-srv>
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

On Mon, 25 Mar 2019, Baoquan He wrote:

> On 03/25/19 at 08:53am, Borislav Petkov wrote:
> > On Mon, Mar 25, 2019 at 03:27:10PM +0800, Baoquan He wrote:
> > > Kexec kernel also need to get rsdp to get SRAT tables so that KASLR can
> > > avoid those hotpluggable regions in boot compression stage.
> > > 
> > > The kexec_file_load has filled in acpi_rsdp_addr of kexec kernel in
> > > below code. It will return direclty in get_rsdp_addr() since
> > > acpi_rsdp_addr is got from boot_params->acpi_rsdp_addr.
> > > 
> > > arch/x86/kernel/kexec-bzimage64.c <<setup_boot_parameters>>
> > > 	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> > > 
> > > The other interface, kexec_load, its boot_params filling is done in user
> > > space kexec_tools. And we haven't made the acpi_rsdp_addr filling yet.
> > > And the old kexec_tools utility can also cause the new kexec kernel to
> > > search efi rspd pointer even thought it's fixed.
> > 
> > Yes, kexec is a pile of ugly and fragile hackery.
> 
> Well, yes, we have to admit that, since kexec is based on hacking.

Well, then the right thing to do is to think about it proper and replace
the hackery by something well thought out instead of adding duct tape to it
every other day.

Thanks,

	tglx
