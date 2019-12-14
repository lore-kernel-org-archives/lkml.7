Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D65C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791212465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="L+cDiK2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfLNHNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:13:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfLNHNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:13:36 -0500
Received: from zn.tnic (p200300EC2F0A5A00D0F33451B6E85A6B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:d0f3:3451:b6e8:5a6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A16B91EC02D2;
        Sat, 14 Dec 2019 08:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576307615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O4cUJfhfIm6Vq0fIrXBbCsIIq316DP/Jj9B41AfGuo8=;
        b=L+cDiK2oScjfSpQqVBm7TSXSRiVQmfnXUMJzzzMBG3TS3Mb3KixJ9ZM/kDef2xhZ+6AYdV
        +LDVkhuqLWOyu+1EMwAKW3a0gOYvkDexSe5jVVl2anLz5RPQZ2eBUwN3Br0UCz+Jw0ROmx
        7B7hXTNhhOffV4CXl/nleqo7Pnt1yeU=
Date:   Sat, 14 Dec 2019 08:13:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct mapping.
Message-ID: <20191214071329.GA28635@zn.tnic>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
 <20191212201916.GL4991@zn.tnic>
 <20191213132850.GG28917@MiWiFi-R3L-srv>
 <20191213141543.GA25899@zn.tnic>
 <20191213145448.GH28917@MiWiFi-R3L-srv>
 <20191213163818.GB25899@zn.tnic>
 <20191213232928.GI28917@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213232928.GI28917@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 07:29:28AM +0800, Baoquan He wrote:
> OK, you mean parsing SRAT again before kernel_randomize_memory(). I
> think this is what Masa made this patchset to avoid. Then we will have
> three times SRAT parsing.

Can the SRAT parsing be *moved* up so that it is done before
kernel_randomize_memory() ?

So that it doesn't happen 3 times and acpi_numa_init() can simply use
the already parsed results.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
