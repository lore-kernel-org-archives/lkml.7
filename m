Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D582720854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfCYH1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbfCYH1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B18463082E90;
        Mon, 25 Mar 2019 07:27:13 +0000 (UTC)
Received: from localhost (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18E321001E70;
        Mon, 25 Mar 2019 07:27:12 +0000 (UTC)
Date:   Mon, 25 Mar 2019 15:27:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
Message-ID: <20190325072710.GA31828@MiWiFi-R3L-srv>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322152328.GD12472@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 25 Mar 2019 07:27:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/19 at 04:23pm, Borislav Petkov wrote:
> On Fri, Mar 22, 2019 at 11:03:43AM +0000, Junichi Nomura wrote:
> > Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > in the early parsing code tries to search RSDP from EFI table but
> > whose address is virtual.
> > 
> > Since kexec(1) provides physical address of config_table via boot_params,
> > efi_get_rsdp_addr() should look for setup_data in the same way as
> > efi_systab_init() in arch/x86/platform/efi/efi.c does.
> 
> If the kexec kernel should continue to use efi_systab_init() then you
> should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.

Kexec kernel also need to get rsdp to get SRAT tables so that KASLR can
avoid those hotpluggable regions in boot compression stage.

The kexec_file_load has filled in acpi_rsdp_addr of kexec kernel in
below code. It will return direclty in get_rsdp_addr() since
acpi_rsdp_addr is got from boot_params->acpi_rsdp_addr.

arch/x86/kernel/kexec-bzimage64.c <<setup_boot_parameters>>
	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;

The other interface, kexec_load, its boot_params filling is done in user
space kexec_tools. And we haven't made the acpi_rsdp_addr filling yet.
And the old kexec_tools utility can also cause the new kexec kernel to
search efi rspd pointer even thought it's fixed.

Thanks
Baoquan

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
