Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679A22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbfC0Bs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:48:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbfC0Bs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 433B959445;
        Wed, 27 Mar 2019 01:48:56 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B3DF6085B;
        Wed, 27 Mar 2019 01:48:55 +0000 (UTC)
Date:   Wed, 27 Mar 2019 09:48:52 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190327014852.GA3659@MiWiFi-R3L-srv>
References: <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326135714.GG1867@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 27 Mar 2019 01:48:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junichi,

On 03/26/19 at 02:57pm, Borislav Petkov wrote:
> On Mon, Mar 25, 2019 at 11:10:01PM +0000, Junichi Nomura wrote:
> > efi_get_rsdp_addr() and kexec_get_rsdp_addr() could be implemented
> > like this (sorry about the pseudo code):
> 
> This doesn't look like what I suggested:
> 
> > So efi_get_rsdp_addr() needs to be refactored in such a way so that at
> > least the loop towards the end gets carved out into a separate function
> > - __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
> > size as arguments and finds the RSDP address in the kexec-ed kernel.
> 
> You need to carve out the loop at the end and make it into a separate
> __efi_get_rsdp_addr() function which gets the physical or the virtual
> address.

I guess Boris is suggesting code like below. Please correct me if I am
wrong.

static acpi_physical_address _efi_get_rsdp_addr(efi_config_table tbl, ...)
{
	/* Get EFI tables from systab. */
	for (i = 0; i < nr_tables; i++) {
		...
	}
	return rsdp_addr;
}

static acpi_physical_address efi_get_rsdp_addr(void)
{
	...
	/* Get systab from boot params. */		
	...
	/* Handle EFI bitness properly */
	...
	return _efi_get_rsdp_addr();
}


static acpi_physical_address kexec_get_rsdp_addr(void)
{
	if (!is_kexec_booted)
		return 0;

	efi_get_setup_data_addr();
	...
	/* Handle EFI bitness properly */
	...
	return _efi_get_rsdp_addr();
}

acpi_physical_address get_rsdp_addr(void)
{
        acpi_physical_address pa;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = boot_params->acpi_rsdp_addr;


	/**
	/*I think here we should check if it's kexec booted firstly.
	 * Skip it if not kexec. this can avoid the wrong kexec virt
	 * addr parsing./
        if (!pa)
                pa = kexec_get_rdsp_addr();             <--- new function

        if (!pa)
                pa = efi_get_rsdp_addr();

        if (!pa)
                pa = bios_get_rsdp_addr();

        return pa;
}
