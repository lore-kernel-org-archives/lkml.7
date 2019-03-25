Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F75C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47932085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bdsqhcpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfCYMcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:32:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbfCYMcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:32:24 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5ACA01EC0AE4;
        Mon, 25 Mar 2019 13:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553517142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JS+Ee3Bndpk+yP17/8CvyL26zTtYYsT8dWbdtkBI3cU=;
        b=bdsqhcpWXVHhCREk/CW43c6nG0DrN+iAvIEO+8Adpd1czVvYH3VzMZuIefQtn6pWWs29xO
        dlHlKmsQ01U8p6ojNPlXpYXNGIuDaAQiRPSBnXVh+kFqMOlunvzMofupFGWNi5dEOClrvl
        f+KVewpVXSiwXA0fx2K2DJspJOTDnyU=
Date:   Mon, 25 Mar 2019 13:32:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190325123229.GL12016@zn.tnic>
References: <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 08:23:02PM +0800, Dave Young wrote:
> efi_enter_virtual_mode() can only run once because of efi firmware/spec
> limitation,  and after entered virtual mode, efi firmware just updated

I should remember that - I did it at the time.

> Kexec saved the original physical addresses, and pass them to kexeced
> kernel via x86 setup_data, so  both the early parsing or efi init code
> need to get those physical values from setup_data.

So efi_get_rsdp_addr() needs to be refactored in such a way so that at
least the loop towards the end gets carved out into a separate function
- __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
size as arguments and finds the RSDP address in the kexec-ed kernel.

So we'd need something like that:

acpi_physical_address get_rsdp_addr(void)
{
        acpi_physical_address pa;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = boot_params->acpi_rsdp_addr;

        if (!pa)
                pa = efi_get_rsdp_addr();

	if (!pa)
		pa = kexec_get_rdsp_addr();		<--- new function

        if (!pa)
                pa = bios_get_rsdp_addr();

        return pa;
}

which would get config_tables from setup_data and call
__efi_get_rsdp_addr() to dig it out in the kexec'ed kernel.

Junichi, ask if it is still unclear what needs to be done.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
