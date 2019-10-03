Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA941C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9564F2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570126337;
	bh=819/wUZTlZOA89Rc6IuzC1Fd1lR2f6e7+dvyj4ZkwRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BY+x+v5ZWzLKD92KkVzHR3Xp6tca1cxSXKiQEOFBkmanf6sxMw7ZhjdMEmJzLGrkW
	 LsrLUjeIXO0RlUw0qLCBhbqvMAnlbsBmCNQUIe6j/TATiwWC+xlF3HKIhqfiU+q5me
	 t7ZvDRXCAcOn538u4eDVIZuTM/C0bLAldaEuctU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfJCSMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:12:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37339 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbfJCSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:12:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so3825753lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9CLff0xdjhwTwseNBTStiFNCovDaCPWc7aVjBBxw1vY=;
        b=dMFb3uM/UyVtVEpIyGLjZQ5D18cmbwEsrABzaJQGR8dc/u0V7qHCKXlrcEidk/cRrn
         wYj/a7r+sxttXokd27j5hVkylFooq/4ywDgSdJj8Ry/bZU6+gYBaMVdp6VvVAc+mHPVP
         Xx6A534Uq6kdvFHYq1JLHYRTJlsG39xebJzh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9CLff0xdjhwTwseNBTStiFNCovDaCPWc7aVjBBxw1vY=;
        b=Frb2UentRCWiWzQjpsHIYjcVr7Oxm9QG1ayg2B/zI4Qq2FIuvBoReewrfMwcbhLFWr
         xwVLX6X1snyXbF7OzyllX77DBlyuPFpAg8ngAMyCy03ahxTtM/QolxjxVq2ZCmEJ2ARs
         8as4yR9EnsAiY6rlSbw/LTLfkZ8tCVjHgbsx0z5viBlYQw3f3g6j+vNvlgF2XOLbygh6
         K0yoCbiZTtsPsUQ3KDELPUYzELeLN1b+PeswBwtWYwRGPlMMNgCQoC3A6LsQ005VlZod
         p6Bk0patgzWRPkgr9ISt+aINyw0POA84MbBUdcXbvQcelMG3qZxxB4JN/MwWTYNNzNpm
         WOFA==
X-Gm-Message-State: APjAAAVr7qvw/MNhTarNkeJJD18but+Rwcvd5fYe+4tRnDNuPW19qjaS
        a8Nu6v8JygWHTfAOPU9QpZrYVvK7op8=
X-Google-Smtp-Source: APXvYqyJod6qf7Idkars4G/Cy1As2PJ00DjKwG/t5yV7WEbMU/n5quhrSPoAVQhDO8ap8WJsR5XJ+w==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr6752550ljb.47.1570126332872;
        Thu, 03 Oct 2019 11:12:12 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id o13sm672112ljh.35.2019.10.03.11.12.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 11:12:10 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m13so3772745ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:12:09 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr7032210ljg.148.1570126329445;
 Thu, 03 Oct 2019 11:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-4-thomas_os@shipmail.org> <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
 <516814a5-a616-b15e-ac87-26ede681da85@shipmail.org> <CAHk-=wgH=T5mcDxTaC6QbBN=iJD3d_amzcb2+GxbcV7XuEYL2A@mail.gmail.com>
 <MN2PR05MB61412DB4F703A5EE4F961593A19F0@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wj5NiFPouYd6zUgY4K7VovOAxQT-xhDRjD6j5hifBWi_g@mail.gmail.com> <a3aebf74-be74-bf15-f016-da9734ba435a@shipmail.org>
In-Reply-To: <a3aebf74-be74-bf15-f016-da9734ba435a@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 11:11:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK1Tj6qhtohzfwJV-T9qZYG6ULs=NyFfbWPH90U_j4+A@mail.gmail.com>
Message-ID: <CAHk-=wiK1Tj6qhtohzfwJV-T9qZYG6ULs=NyFfbWPH90U_j4+A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 11:03 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> >
> > So I think this is the right direction to move into, but I do want
> > people to think about this, and think about that next phase of doing
> > the pmd_trans_huge_lock too.
>
> I think if we take the ptl lock outside the callback, we'd need to allow
> the callback to unlock to do non-atomic things or to avoid recursive
> locking if it decides to split in the callback.

Note that I think that the particular pmd locking case we should leave
for later, simply because it's a separate issue, and it comes with
more worries.

So I just wanted to mention it to see what people thought and keep it
in mind for later, but I don't think it should be part of this series.
Your use case doesn't need it (at least yet), and existing users
already do their own locking.

The "change pte_entry" to do the proper locking I think is safe.
Probably exactly *because* pte_entry is so broken, we literally have
only five users of it in the whole kernel, and they are fairly simple
and certainly don't block.

(Ok, the s390 has some funky hw locking, so maybe "simple" is the
wrong word to use, but it doesn't seem to have any interaction with
the locking).

End result: I absolutely agree that changing the pmd locking to be
done by the walker would be a much bigger change. I don't think we
need to do that part yet. It's not the current pain-point.

             Linus
