Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F55C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE267214E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KWbZvsNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436478AbfIFRla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:41:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42191 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfIFRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:41:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so6991301ede.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBkiR/7BisGtZVmNVXhHtJrfmofi1qU8Pxcjpjv/ZgU=;
        b=KWbZvsNIkISQq4DJ0Jn0+DC13xFv36DJ+INz1iCwsDURlinnxi/FqltluIcUdyKEH+
         rohLlAAcGa9S/ZYLvc1vTaR6e7aQaHawkNyzLp29w4f6Au1gxqx6ccQi15xWrUysZLko
         l0O4EcJcNb3Zxrza5Xu2Cdd0Q8c1MNJiep4Y23PuKjCm1JHlOUjUXO3rjxiUgpMuxdBZ
         195WYeYAEX+sfEiPtjph8YRPHJ5jQAWbkYH6/UE6sgH5I3Tkdk2sSbsvvqd+Xnpv0uvu
         1ilSBFkcIXgD0EgHuYTfM1YDM5ly+poGMtxFMSDOaOGhgSkdDDpWTmBO4MBPmbtsnmHo
         MKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBkiR/7BisGtZVmNVXhHtJrfmofi1qU8Pxcjpjv/ZgU=;
        b=P4qo3vHSZVBq3qubgdjuCpktqvUFJf8Uwn0CADDLA9yqFtVa+roA64gkF7/tWbthhH
         Al9vBhEkCEPECxjiR7xYQOwIIVwHi6ZUlFtCMsasu2TL8MSpxUrJvbFTEQPNmaO2aFRC
         qaFqZO0qRQ+2/p9+Dd3koJ8cYodLb/FgVguhzuOCXhc8nTVAPg97kXr1qGv6IKBi3tba
         6WzUJiRNKWmlChmjQxqKL579Vh2W7yErGSJWZha3lmVrcP8FwKAXOhmogneg/VbkAbtG
         3i+mgHnsoYxwJ2pxDDjINyxWWXcETbnl4GTGlN2ziHuZfsa1XSRSc88JaLITDGkXCMoB
         +UuQ==
X-Gm-Message-State: APjAAAXSj94TLjv2t10bfMblXmU8G9R9ZWRO/+EBmHriYcUsCBjy2VyK
        ynMLM3UNcNZWlfW2Ztc3IhcYob68K51pOoRGwB1wGg==
X-Google-Smtp-Source: APXvYqzdydAQq2XsQ/paSb9m4rgwscf0/CCdiPGGGSWL+1ARUwePukKygj3cKHXfmSeUdjAS/Egx8Zb0S9m9dpj+AVQ=
X-Received: by 2002:aa7:c40c:: with SMTP id j12mr11037477edq.80.1567791688713;
 Fri, 06 Sep 2019 10:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-8-pasha.tatashin@soleen.com> <f1db863a-de57-2d1a-6bec-6020b2130964@arm.com>
In-Reply-To: <f1db863a-de57-2d1a-6bec-6020b2130964@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 13:41:17 -0400
Message-ID: <CA+CK2bDTVGm6pNRGQx7eAyEP6m0xr9X1No_=qgUOTDAoL9uigw@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] arm64, hibernate: move page handling function to
 new trans_pgd.c
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:18 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Now, that we abstracted the required functions move them to a new home.
> > Later, we will generalize these function in order to be useful outside
> > of hibernation.
>
> > diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> > new file mode 100644
> > index 000000000000..00b62d8640c2
> > --- /dev/null
> > +++ b/arch/arm64/mm/trans_pgd.c
> > @@ -0,0 +1,211 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (c) 2019, Microsoft Corporation.
> > + * Pavel Tatashin <patatash@linux.microsoft.com>
>
> Hmmm, while line-count isn't a useful metric: this file contains 41% of the code that was
> in hibernate.c, but has stripped the substantial copyright-pedigree that the hibernate
> code had built up over the years.
> (counting lines identified by 'cloc' as code, not comments or blank)
>
> If you are copying or moving a non trivial quantity of code, you need to preserve the
> copyright. Something like 'Derived from the arm64 hibernate support which has:'....

I will do that.  The copyright thing was meant to appear in
"generalization" patch that comes later, where I unified most of the
code to be symmetric.
So, I will add it there, and also do the derived message that you suggested.

>
>
> > + */
> > +
> > +/*
> > + * Transitional tables are used during system transferring from one world to
> > + * another: such as during hibernate restore, and kexec reboots. During these
> > + * phases one cannot rely on page table not being overwritten.
>
> I think you need to mention that hibernate and kexec are rewriting memory, and may
> overwrite the live page tables, therefore ...

Will add, thank you.

Pasha
