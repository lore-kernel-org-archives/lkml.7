Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A15C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570673388;
	bh=fvzBJD1dgq1Y0BNh7wTv4WB04bHYPpFgO446N/44mdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sP8XWU5CxUtYk6+nEnnNkKC7PQ7gL8rgtA8e5dxxNoebAYRWuSl35sGFnCBOfQ/Zi
	 U6Ru+JrsIWwHHlr4b4ci2wYlsqcjF84CvgKi/Bo2GHOWwxUoxm7aC9myv+Re0lMTv0
	 4jlC1sf/xFl4rTgc4zZUmtC6EPOOgVoXtSj43CBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbfJJCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:09:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39583 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfJJCHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:07:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so4477467ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 19:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LVTlFWjjXqkfqHeR1S0u6EjRM0YYyhBOrAMAs/nOEWk=;
        b=BeieFAWyjI1F3VJRLfbX4p2jjIhtEOLplHRHxqZshN8p2DRirvoI5LMUtdoTMVa0jF
         hNeeEl7AXyvjUh3O8eAOPH51FAs5ujKoALbPurD6W8Utd4Owa6wJx/+3HVjzZH2kn5KZ
         mdnrWEWC7X8bEP6QvZMTajKS25sCA3oFM31pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LVTlFWjjXqkfqHeR1S0u6EjRM0YYyhBOrAMAs/nOEWk=;
        b=G4XUkYULLM4rk9FCWnxgchy4i2oE9Va84yfsSZuE46aOvRl+rIknyOYHmLIv7iJ+P7
         U4DjQAgxjdPOFxm68g9zS33He+DHjgtoC8Z8GiuE7YdYq3lxzM2jufh4TP6UO5epz86t
         r/FCkAjVNpECMhm61KfuQx5HBkJcx3K2epe7vcm7Q3/YpkR0GJ86Wh2ikPvPvcKhRYvP
         v3I0bFVENeIGRAjZcsskb+KLrW9csxUdRULEH/SOxQeuDhurov93z+aA06CTxRg/DBiE
         /qXgTy1/5YM90p8mDM8eDVKQ7zS53SasdoPFyCYTpA29/N36r/4h63OET+7JAJKN6ehk
         qfJw==
X-Gm-Message-State: APjAAAXCk8Ox3t0PCr9SI/tjwLpbWTJzVOnYUzhAyvRi6XYU2cpn7U45
        XfcpFOQz8tF7/KeT/GE9K5KZtI3DtIo=
X-Google-Smtp-Source: APXvYqyxsMaolCfjbvpazrqRZy5MlKOG4EKv35fFDqLQWKV3sQU8xuHn/sbKczSg6/2JqKU3Ys+eHw==
X-Received: by 2002:a2e:7312:: with SMTP id o18mr4230249ljc.32.1570673263515;
        Wed, 09 Oct 2019 19:07:43 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b19sm829129lji.41.2019.10.09.19.07.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 19:07:42 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v24so4503688ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 19:07:41 -0700 (PDT)
X-Received: by 2002:a2e:29dd:: with SMTP id p90mr4334806ljp.26.1570673261288;
 Wed, 09 Oct 2019 19:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box> <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org> <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
 <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com>
 <c054849e-1e24-6b27-6a54-740ea9d17054@shipmail.org> <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
 <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org> <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
 <6d3ef513-ca9d-9778-10da-86f368a57cd0@shipmail.org>
In-Reply-To: <6d3ef513-ca9d-9778-10da-86f368a57cd0@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 19:07:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimOMuhBVrxYneQ5bawFNeGW1h_D3cxN80pitDKgfBx0A@mail.gmail.com>
Message-ID: <CAHk-=wimOMuhBVrxYneQ5bawFNeGW1h_D3cxN80pitDKgfBx0A@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 6:10 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> Your original patch does exactly the same!

Oh, no. You misread my original patch.

Look again.

The logic in my original patch was very different. It said that

 - *if* we have a pmd_entry function, then we obviously call that one.

    And if - after calling the pmd_entry function - we are still a
hugepage, then we skip the pte_entry case entirely.

   And part of skipping is obviously "don't split" - but it never had
that "don't split and then call the pte walker" case.

 - and if we *don't* have a pmd_entry function, but we do have a
pte_entry function, then we always split before calling it.

Notice the difference?

So instead of looking at the return value of the pmd_entry() function,
the approach of that suggested patch was to basically say that if the
pmd_entry function wants us to go another level deeper and it was a
hugepmd, it needed to split the pmd to make that happen.

That's actually very different from what your patch did. My original
patch never tried to walk the pte level without having one - either it
*checked* that it had one, or it split.

But I see where you might have misread the patch, particularly if you
only looked at it as a patch, not as the end result of the patch.

The end result of that patch was this:

                if (ops->pmd_entry) {
                        err =3D ops->pmd_entry(pmd, addr, next, walk);
                        if (err)
                                break;
                        /* No pte level walking? */
                        if (!ops->pte_entry)
                                continue;
                        /* No pte level at all? */
                        if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)
|| pmd_devmap(*pmd))
                                continue;
                } else {
                        if (!ops->pte_entry)
                                continue;

                        split_huge_pmd(walk->vma, pmd, addr);
                        if (pmd_trans_unstable(pmd))
                                goto again;
                }
                err =3D walk_pte_range(pmd, addr, next, walk);

and look at thew two different sides of the if-statement: if they get
to "walk_pte_range()", both cases wil have verified that there
actually _is_ a pte level. They will just have done it differently. -
the "we didn't have a pmd function" will have split the pmd if it was
a hugepmd, while the "we do have a pmd_entry" case will just check
whether it's still a huge-pmd, and done a "continue" if it was and
never even tried to walk the ptes.

But I think the "change pmd_entry to have a sane return code" is a
simpler and more flexible model, and then the pmd_entry code can just
let the pte walker split the pmd if needed.

So I liked that part of your patch.

           Linus
