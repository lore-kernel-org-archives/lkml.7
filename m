Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEAAC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80C521882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+Z/emuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCRYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:24:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41567 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:24:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so3172111qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWLpZXNsM3p1lTZJX7ibWXQLVjnLmHCj16wtFukaXUE=;
        b=K+Z/emuyyEu2GtrW6DwpMUytgxyzefDmap3xK+ih+5k6Yz7qGbT2WMhfe5xiksDjr2
         nq97Vzlb15tYoo6y/uCV+CZ6cpxvdy8VudBrG0l3x0MbQP5y7ql8BK5BXXk3GnlVbW7I
         ZjVnV6pBuABhtaAksWCOFGGiMV3oN2JBn4NtMAjdE5rA3EQdLuHx8I0D0Fv5uRd0D8zL
         VGjDOQ+g2tVgYGb/jebFO8OR0CM109mmu2hfJgLPlPoHRaeeHiFQfme10QHCfyF4gfgm
         SIkAn7hMXPgV7MKcSFoGIRdT1DyVwpIv7Rs4ckHb3sZNgoP5LksLeVYuaiS8HIAvvw4p
         8QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWLpZXNsM3p1lTZJX7ibWXQLVjnLmHCj16wtFukaXUE=;
        b=WMFP7O1KMUOadn+B0YbpLV6/2beY/AObjU5uo6QJ5Xs/gE0K/y9iZrC0VpkLstkUbu
         /TP7FKodBfmuCd/82l6+fKakhnWxQ606+YRHXlZP3j6iMzWeVAdG3YRql3ECEWbnq6xC
         WRjsyxoKOVDsXomUFFfgaFjoZkPOvckg/yYiUR7p+D+4ZHSofvL+ZtcaBI1M7W0ne2xH
         Qvemb91tlscjXcXXPP48GDzyAXtoMgG5sYfku/Fywe2iZ4wEUev+kfjiZaqwHSxK6mkd
         uSRqknzJmru6tTluizj+yjcqKpWxk19QPuOuQ/baoA8EIg2ASmKRk9At7ob6768Fk795
         hAjQ==
X-Gm-Message-State: APjAAAV7evPMMY0KFG4OFdBYsQuiN7ujty1tNK0FNIixex8z7/xAOkml
        hHsn6rHr0E701FI6gb4Gjvg8JYosgLkD+6DRvE86OQ==
X-Google-Smtp-Source: APXvYqzfCXHR7AdEFmhAVziQehhOQUss9jDtQBcLd32WC6403cGso4D3MyynOBLu1Lg4Gj24PStyaR78IU3QTlpr2aw=
X-Received: by 2002:ac8:6c9:: with SMTP id j9mr854936qth.76.1562174678092;
 Wed, 03 Jul 2019 10:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJkfWY4yvVVmJoQ0WwyoFBkWYsUJnnQPNU+-g23-m-L3ETe_hQ@mail.gmail.com>
 <20190702234135.78780-1-nhuck@google.com> <20190703112139.GA29570@lakrids.cambridge.arm.com>
In-Reply-To: <20190703112139.GA29570@lakrids.cambridge.arm.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 3 Jul 2019 10:24:26 -0700
Message-ID: <CAJkfWY6kZnd3TSTvZ3CqhPOT7Lu+koCsfwS6ACEg04xXX6szgw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: mm: Fix dead assignment of old_pte
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning is not triggered in next. Looks like this patch is unnecessary.

Thanks,
Nathan Huckleberry

On Wed, Jul 3, 2019 at 4:23 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Jul 02, 2019 at 04:41:35PM -0700, Nathan Huckleberry wrote:
> > When analyzed with the clang static analyzer the
> > following warning occurs
> >
> > line 251, column 2
> > Value stored to 'old_pte' is never read
> >
> > This warning is repeated every time pgtable.h is
> > included by another file and produces ~3500
> > extra warnings.
> >
> > Moving old_pte into preprocessor guard.
> >
> > Cc: clang-built-linux@googlegroups.com
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> > Changes from v1 -> v2
> > * Added scope to avoid [-Wdeclaration-after-statement]
> >  arch/arm64/include/asm/pgtable.h | 27 ++++++++++++++++-----------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
>
> As Will asked, does this also trigger in linux-next?
>
> I rewrote this code to avoid to only perform the READ_ONCE() when we'd
> use the value, and IIUC that may be sufficient to avoid the warning:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=9b604722059039a1a3ff69fb8dfd024264046024
>
> Thanks,
> Mark.
>
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index fca26759081a..12b7f08db40d 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -238,8 +238,6 @@ extern void __sync_icache_dcache(pte_t pteval);
> >  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >                             pte_t *ptep, pte_t pte)
> >  {
> > -     pte_t old_pte;
> > -
> >       if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
> >               __sync_icache_dcache(pte);
> >
> > @@ -248,16 +246,23 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >        * hardware updates of the pte (ptep_set_access_flags safely changes
> >        * valid ptes without going through an invalid entry).
> >        */
> > -     old_pte = READ_ONCE(*ptep);
> > -     if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(old_pte) && pte_valid(pte) &&
> > -        (mm == current->active_mm || atomic_read(&mm->mm_users) > 1)) {
> > -             VM_WARN_ONCE(!pte_young(pte),
> > -                          "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
> > -                          __func__, pte_val(old_pte), pte_val(pte));
> > -             VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
> > -                          "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
> > -                          __func__, pte_val(old_pte), pte_val(pte));
> > +     #if IS_ENABLED(CONFIG_DEBUG_VM)
> > +     {
> > +             pte_t old_pte;
> > +
> > +             old_pte = READ_ONCE(*ptep);
> > +             if (pte_valid(old_pte) && pte_valid(pte) &&
> > +               (mm == current->active_mm ||
> > +                atomic_read(&mm->mm_users) > 1)) {
> > +                     VM_WARN_ONCE(!pte_young(pte),
> > +                                  "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
> > +                                  __func__, pte_val(old_pte), pte_val(pte));
> > +                     VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
> > +                                  "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
> > +                                  __func__, pte_val(old_pte), pte_val(pte));
> > +             }
> >       }
> > +     #endif
> >
> >       set_pte(ptep, pte);
> >  }
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
