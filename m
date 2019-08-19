Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83978C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5603122CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V6Ye+hp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHSQZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:25:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40906 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfHSQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:25:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id h8so2225335edv.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTybdQSbJYXviMaMHMnMLGJOZBBRUnDKBVwSpon3+iQ=;
        b=V6Ye+hp2Gl1Ax/97+paIXXGQgJ1el9suKrpEMODehYp5ZX9LIhVfYpDR2ESokcsHRS
         Aaz3p/FE/TRUrMt+RPQ6/lJGgzcI3HJwwQGGz10VNFg3QS8za2uv5R7hlAm4sQDIzvbD
         sDwE1+rbxFUH1L0rGmmn2OAaKuqDIESg6uehSYO2UG5pe45fYOj2I23wddTYtUzVCZzy
         r01SGTGDPR8juGpx0lo2cvmPh8F97yyRqb4hvMacpxOunjoc/ryvfLHdcgVmsStgU9zY
         KKgdk1hu/HOVk0nBmNczKcAHngdnw8qioLsHdDXAqNLoCV5Xng/kc6cOfjjEkbXgerKM
         kEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTybdQSbJYXviMaMHMnMLGJOZBBRUnDKBVwSpon3+iQ=;
        b=jpdB7cuM44j6RA902CHKel6Y6wT4bUycOmaiW0rYvZXt42c2WL83tL5Pg51dGK2HfG
         bG3Mdi0tmhlgxEh5V6sd040wX+dkcblPMqvIlCxJgnJOUA3X8hl7hiqbTVjzW0MwxgBz
         mEjdi3B1fH/fvhKsNf34pJPX8n7TepWVznCgMy3FHSY426LidFFeFAPh+uWqSMV1LxQi
         Xk5OEfxB8knKn9fuAVr2TT7UKAy30axUM3w1EGfVF01FgSlz/JZ3UTn4D4q96tu36OsZ
         wY6G06Uj49qfhRHlPyOktF4TpdbxOyYwnRKEECoSZjBiH3ybuIwL2J3xk0HTyGVf+hPT
         1nMg==
X-Gm-Message-State: APjAAAW11ij0CHvJRssumWzrq7uWaJlqJG8vWWPu0vjRB/8CSHzVF4mi
        lbAekDMYgowHmbvyz/dAWqpCuWvkgSMooYY6c632Lg==
X-Google-Smtp-Source: APXvYqx6DaFjnU6QugCtFRq+z73auQsM7avscMrrbc99LuibAhGgZ9NPXOzVtge16aLCOwfiY8fafEF9yfKLFmVJPQk=
X-Received: by 2002:aa7:c552:: with SMTP id s18mr13639157edr.0.1566231918418;
 Mon, 19 Aug 2019 09:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-3-pasha.tatashin@soleen.com> <20190819155014.GD9927@lakrids.cambridge.arm.com>
In-Reply-To: <20190819155014.GD9927@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 19 Aug 2019 12:25:07 -0400
Message-ID: <CA+CK2bCnGVdNS=1wRBFhzKTkQJoi1=uD0Kof=pcePfG2eKHUYw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] arm64, hibernate: create_safe_exec_page cleanup
To:     Mark Rutland <mark.rutland@arm.com>
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for your review comments. My replies below:

On Mon, Aug 19, 2019 at 11:50 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Aug 16, 2019 at 10:46:17PM -0400, Pavel Tatashin wrote:
> > create_safe_exec_page() is going to be split into two parts in preparation
> > of moving page table handling code out of hibernate.c
> >
> > Remove allocator parameter, and rename dst to page. Also, remove the
> > goto's, as we can return directly without cleanups.
>
> It would be nice if you could do the goto/allocator/rename changes as
> separate patches, since it's vastly easier to verify each change in
> isolation that way.

Sure, I will split these changes into separate patches in the next
version of this patch series.

>
> What's the point of the rename? It's inconsistent with the phys_dst_addr
> that you leave as-is, so I'm not sure that's worthwhile.

dst_addr, phys_dst_addr VA/PA destination addresses. But, page is a
buffer in the current VA space (hence changed to void *), dst looked
confusing as it seemed as it was part of the
destination addresses.

>
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/kernel/hibernate.c | 60 +++++++++++++++--------------------
> >  1 file changed, 26 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 9341fcc6e809..96b6f8da7e49 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -196,57 +196,51 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
> >   */
> >  static int create_safe_exec_page(void *src_start, size_t length,
> >                                unsigned long dst_addr,
> > -                              phys_addr_t *phys_dst_addr,
> > -                              void *(*allocator)(gfp_t mask),
> > -                              gfp_t mask)
> > +                              phys_addr_t *phys_dst_addr)
> >  {
> > -     int rc = 0;
> > +     void *page = (void *)get_safe_page(GFP_ATOMIC);
> > +     pgd_t *trans_table;
>
> The addition of this trans_table variable wasn't mentioned in the commit
> message...
>
> > +     trans_table = (void *)get_safe_page(GFP_ATOMIC);
> > +     if (!trans_table)
> > +             return -ENOMEM;
> >
> > -     pgdp = pgd_offset_raw(allocator(mask), dst_addr);
> > +     pgdp = pgd_offset_raw(trans_table, dst_addr);
>
> > -     write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
> > +     write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);
>
>
> ... and I guess you're trying to ensure that we program the TTBR with
> the correct base address, without the offset of whatever pgd entry we
> happen to have plumbed in?
>
> I think that's a fix, and should come before any other cleanup or
> rework.

Yes.

>
> If you can respin that specific change with s/trans_table/pgdir/, that
> would make sense to me.

I will split this patch into several changes. I will describe
trans_table rational in different e-mail. There we will decide what
namespace to use.

Thank you,
Pasha
