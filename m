Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399BBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BD1206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Z5OxgccH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfIJJNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:13:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42558 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:13:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so16329835ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbBZuUfX3eYzsTIc3XZwtrg9Htc+jzFYCQ9N85/KvC8=;
        b=Z5OxgccHbfn9g3PIB8bPABfGmcCaxxb1J7F7+yr0+pGuVMBBQo8ANum7+26tfvS4RC
         G9MhvM4u2bE+JEv+ewuotVeHnoUnEMymJcCm6fbOq3w5MhGsy0hCiKquBnVNH+5tUTJe
         KVSszKycXH/ARdNzK93YM+Nr1islpESB3U2PpA44vFenbEcXrBvdSr1Jl8cKPONV0f7t
         lMNh/HHY7OgbawBfOYH5CmxcbwMInVqOQydF3uyjVPuhXfy8POmejGJXwNpdOnq1ZnwW
         ChZVNZGSzPgQe1quf1GT8CWiuf1xFhGrKS5XKkCrtKg005TW0Ma1UYXs8TgHunhNocL4
         4rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbBZuUfX3eYzsTIc3XZwtrg9Htc+jzFYCQ9N85/KvC8=;
        b=L2XvwJ33g4Gpz3DS8zLFIx5E/3WBoYyd6jWfIt9vGqBQEqhtqdUGtQim+hmwaOUK+Z
         ZNStWiTcpDWR1dnhuRyathkEaV7AGDnG3bcEiaV2E33PLyyreE02L5Ej4HfVQfKIyKsA
         QGTcMkX9KsFWA3OuIMrPIx/71oDLWYHKSRIiH7F6++PJPgfMq/9kmdJXUXKlyh2faivC
         zSikEabiN3HrCvE8idTTf4xLykBP8r0qJTKmWewjzFLeceQjf4cqXPzssQtrEdTFmgpW
         NW6R7qzkW/aRIzwmM//jjAcPm1pXgNINEPPDch1rC9saiAriqqvA6pAWl0NfJw/NZ/si
         d6jA==
X-Gm-Message-State: APjAAAWMmyTCRvPQox8dsQinC3/MiPnJvLN19MDenDz4qgeOh+be7Gj9
        0QsRAZasFg0m6IEIETFzl4YgP6U7gigCfXtLzffcLg==
X-Google-Smtp-Source: APXvYqwiy51QDBEUeHPFO4jWirM5BDZX1zPUw+Hne5qlRbnCZgObrJm78xql+txsNxH8uVTBgiORMGERQfs9UNrBN84=
X-Received: by 2002:a17:906:414:: with SMTP id d20mr23875393eja.165.1568106785200;
 Tue, 10 Sep 2019 02:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-6-pasha.tatashin@soleen.com> <9135be3e-cf7e-821d-928d-db98aa3ec9c8@suse.com>
In-Reply-To: <9135be3e-cf7e-821d-928d-db98aa3ec9c8@suse.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 10 Sep 2019 10:12:54 +0100
Message-ID: <CA+CK2bCGgAXDdjDVS1KYj8uYWmeBM6cTJ3Y-DXZ_8+93uCiV7w@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] arm64: hibernate: remove gotos in create_safe_exec_page
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 09/09/2019 20:12, Pavel Tatashin wrote:
> > Usually, gotos are used to handle cleanup after exception, but
> > in case of create_safe_exec_page there are no clean-ups. So,
> > simply return the errors directly.
> >
>
> While at it, how about also cleaning up swsusp_arch_resume() which has the same
> issue.

Thank you for suggestion. I will do cleanups in swsusp_arch_resume() as well.

Pasha

>
> Regards,
> Matthias
>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/arm64/kernel/hibernate.c | 34 +++++++++++-----------------------
> >  1 file changed, 11 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 47a861e0cb0c..7bbeb33c700d 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -198,7 +198,6 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >                                unsigned long dst_addr,
> >                                phys_addr_t *phys_dst_addr)
> >  {
> > -     int rc = 0;
> >       pgd_t *trans_pgd;
> >       pgd_t *pgdp;
> >       pud_t *pudp;
> > @@ -206,47 +205,37 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >       pte_t *ptep;
> >       unsigned long dst = get_safe_page(GFP_ATOMIC);
> >
> > -     if (!dst) {
> > -             rc = -ENOMEM;
> > -             goto out;
> > -     }
> > +     if (!dst)
> > +             return -ENOMEM;
> >
> >       memcpy((void *)dst, src_start, length);
> >       __flush_icache_range(dst, dst + length);
> >
> >       trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
> > -     if (!trans_pgd) {
> > -             rc = -ENOMEM;
> > -             goto out;
> > -     }
> > +     if (!trans_pgd)
> > +             return -ENOMEM;
> >
> >       pgdp = pgd_offset_raw(trans_pgd, dst_addr);
> >       if (pgd_none(READ_ONCE(*pgdp))) {
> >               pudp = (void *)get_safe_page(GFP_ATOMIC);
> > -             if (!pudp) {
> > -                     rc = -ENOMEM;
> > -                     goto out;
> > -             }
> > +             if (!pudp)
> > +                     return -ENOMEM;
> >               pgd_populate(&init_mm, pgdp, pudp);
> >       }
> >
> >       pudp = pud_offset(pgdp, dst_addr);
> >       if (pud_none(READ_ONCE(*pudp))) {
> >               pmdp = (void *)get_safe_page(GFP_ATOMIC);
> > -             if (!pmdp) {
> > -                     rc = -ENOMEM;
> > -                     goto out;
> > -             }
> > +             if (!pmdp)
> > +                     return -ENOMEM;
> >               pud_populate(&init_mm, pudp, pmdp);
> >       }
> >
> >       pmdp = pmd_offset(pudp, dst_addr);
> >       if (pmd_none(READ_ONCE(*pmdp))) {
> >               ptep = (void *)get_safe_page(GFP_ATOMIC);
> > -             if (!ptep) {
> > -                     rc = -ENOMEM;
> > -                     goto out;
> > -             }
> > +             if (!ptep)
> > +                     return -ENOMEM;
> >               pmd_populate_kernel(&init_mm, pmdp, ptep);
> >       }
> >
> > @@ -272,8 +261,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >
> >       *phys_dst_addr = virt_to_phys((void *)dst);
> >
> > -out:
> > -     return rc;
> > +     return 0;
> >  }
> >
> >  #define dcache_clean_range(start, end)       __flush_dcache_area(start, (end - start))
> >
