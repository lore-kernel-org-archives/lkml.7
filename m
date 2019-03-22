Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0682190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OdFbo4mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCVPX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:23:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45674 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfCVPX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:23:26 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80B1E1EC00FF;
        Fri, 22 Mar 2019 16:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553268205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qRw4iZkAziOv6VmeiqfOrJRVJ3BZJo1nZAdArkjjySI=;
        b=OdFbo4mXX6DMTdzVtnksS1CkWWDghcnU5dBr12PYq3Mcf4rm/KX09ahhFJaimYEzHituT/
        JlT6onfY0xZ5GKCyC0xsqCr3vg+eLa9PVQFoWV3CSPIhjWwCULLl/7O/iZF1P7nhpToDBJ
        m/cSvrxMItdCLcuBD8gT24yJL3RagbE=
Date:   Fri, 22 Mar 2019 16:23:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
Message-ID: <20190322152328.GD12472@zn.tnic>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:03:43AM +0000, Junichi Nomura wrote:
> Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> in the early parsing code tries to search RSDP from EFI table but
> whose address is virtual.
> 
> Since kexec(1) provides physical address of config_table via boot_params,
> efi_get_rsdp_addr() should look for setup_data in the same way as
> efi_systab_init() in arch/x86/platform/efi/efi.c does.

If the kexec kernel should continue to use efi_systab_init() then you
should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
