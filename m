Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75163C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F86A20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HJxTvXgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDLIuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:50:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44488 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfDLIuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:50:05 -0400
Received: from zn.tnic (p200300EC2F0884007C96562F0B339423.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:7c96:562f:b33:9423])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B30DD1EC0429;
        Fri, 12 Apr 2019 10:50:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555059003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=84+oxSxNMAadS6pIeooHpUoN4ue5mzY49h0DiXqMNjY=;
        b=HJxTvXgW9fUo77/6lRSVxZ/8ZFuPjGqjKfnXXuPPacdq5G2fzTQt3UeFkQ+Vh7XonaJaUZ
        32cptaiL308lV3r+58yeEpbMQpZgwJR+Emy7qh1HXMTXJJqAYmPM7uxYuMwzw4q/SzxEU3
        GlzcGQTyGsCEVP17EjiM3dzUTYV1qzU=
Date:   Fri, 12 Apr 2019 10:49:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190412084956.GC19808@zn.tnic>
References: <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:54:17AM +0000, Junichi Nomura wrote:
> Without #ifdef CONFIG_X86_64, I got compiler warnings on 32bit build
> about casting u64 to pointer.

Yah, stupid ifdeffery.

> We need #ifdef CONFIG_EFI to avoid build failure about undefined
> __efi_get_rsdp_addr().

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index c3020e2d8f67..4b1d4a0a4269 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -46,7 +46,6 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
-#ifdef CONFIG_EFI
 /*
  * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
  * ACPI_TABLE_GUID are found, take the former, which has more features.
@@ -56,6 +55,8 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
 		    bool efi_64)
 {
 	acpi_physical_address rsdp_addr = 0;
+
+#ifdef CONFIG_EFI
 	int i;
 
 	/* Get EFI tables from systab. */
@@ -85,10 +86,9 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
 		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
 			return table;
 	}
-
+#endif
 	return rsdp_addr;
 }
-#endif
 
 /* EFI/kexec support is 64-bit only. */
 #ifdef CONFIG_X86_64
---

> I think that should be the other way around:

No, it shouldn't.

kexec_get_rsdp_addr() must do:

	if (!kexec_kernel)
		return 0:

        esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
        if (!esd)
                return EFI_SETUP_DATA_INVALID;

	...

Now I need to go figure out whether there's a reliable way to know in
the kexec kernel that it *is* a kexec kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
