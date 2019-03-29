Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12EE2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KtaQW9Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfC2IjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:39:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbfC2IjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:39:19 -0400
Received: from zn.tnic (p200300EC2F148A00F5B59F909E867DAC.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:f5b5:9f90:9e86:7dac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F11051EC082D;
        Fri, 29 Mar 2019 09:39:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553848758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qnx2mgxzq1f+cPwCSevadqywNys3rOqIKYk6h98ma24=;
        b=KtaQW9Ne2GTK8AgrSsPBwlcz+9ja+rENDnDNXskiZ65HP659aC+KgjGRuH/Mt5jV5YbDnj
        Yg3ikXr4HuO1GC5H3a0J/FdBHOZCv8lXmx1BPo4mipUgmtRqOBtKVgHC86G/xFZhFWSRLe
        /DGOi+mpf+UBVSxNuwUFo/JS8kON2EM=
Date:   Fri, 29 Mar 2019 09:39:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190329083920.GA21152@zn.tnic>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:05:52AM +0000, Junichi Nomura wrote:
> > You don't need that variable and can return "table" or 0 after the endif
> > below.
> 
> I could do that but it will slightly change the current logic.
> 
> Existing code does this:
> 
>                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>                         rsdp_addr = table;
>                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>                         return table;
> 
> I thought it was to return the table for ACPI_20_TABLE_GUID
> if both tables exist.  If we remove rsdp_addr, the code will be:
> 
>                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>                         return table;
>                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>                         return table;
> 
> So if there are 2 tables, we return the one that comes first.
> Is it ok?

That's a good question.

Chao, what was the intention there, ACPI_20_TABLE_GUID is the preferred
table to return? If so, why?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
