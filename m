Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65443ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BA1218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641433;
	bh=azVcBauMb2GNwRnAVAwRm4vtVfwBRKCa0m5Pzh8jMZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TxQZT2pUg0OosCdzk8R1AfdRVOy4/iMD38lcj9XCChadSe6y04aI5R7hZeKvbR5+e
	 EaiVgRIupPkk9Cyo95XqNdUTi8bZYGwVIGlbGc5BfT+T2+o6IjMnmggn7sv8FrTeVA
	 K3OX3U5HWarJeYtfvXJBwR5x2eZpiVv4LvoAINv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfJIRRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:17:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42398 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:17:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so3267691lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WYDrRYPHs0j7kH6nvfHacya6cMEOhB6fPC+Nemlqhfc=;
        b=AOAkA+oySTesOPMVYaXrzFKziTaxffb4NvaLlldPxDNma8iMLawniVil20T4VPFBT/
         lJMODrpuJPMyGcX5A2MSdkt5UwkF3L8ZbQNgFABx5dhefmgUO+tHZ4ey9D0lN9erNqVg
         hnHobkTbmoNLfTwLN96hilGvYMpN12W8DR9gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WYDrRYPHs0j7kH6nvfHacya6cMEOhB6fPC+Nemlqhfc=;
        b=j0yxFzv+Eo9AEphcPo3gKeqRr4geT2mY7bPAJioq91ceDtYRpc5wjiq/YbLwa6xiu1
         0zOO3SMaB53yRGElqEFn27QguAkAkFiN5tPBH7cpKymjqI6WXLo7HNK+4tlzSUUOBUYf
         MnAFhDwsIcOU5QanqX3wymJHiW1MdZaVyGc8LL25VwPf3wHoY1Sg3Q0tG6CGnSWANQtU
         nmSPve7aROK/rbobAwVBf/iQ5ZGg29eHoYW0KrNz4yekKvwUuGfmcCf7uMnuHZt/t+uW
         nn1EbdwjTkQFtYkXhWdJIuB+R2wim8evF87V2hT65eajs/qf6s4UrO24VL4e0mHJDc26
         JEEQ==
X-Gm-Message-State: APjAAAXnbE9JHURTYDlXxqmWYCgi2uBHWYYJ5RC0pFUITw4WGTRzYCDo
        NSBELajnalwiUjLrDYSkXUeHbZspReg=
X-Google-Smtp-Source: APXvYqwEqKKtsSFNgZYBf8LOAmNf9R+KCSYw9QROpKPcWgzN42iNW223FQu8hBKrfW75ptSDNc72EQ==
X-Received: by 2002:a2e:98d8:: with SMTP id s24mr2973536ljj.72.1570641429405;
        Wed, 09 Oct 2019 10:17:09 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m15sm568852ljh.50.2019.10.09.10.17.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:17:06 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u28so2247049lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:17:06 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr2845221lfc.79.1570641426174;
 Wed, 09 Oct 2019 10:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box> <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org>
In-Reply-To: <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 10:16:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
Message-ID: <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
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

On Wed, Oct 9, 2019 at 10:03 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> Nope, it handles the hugepages by ignoring them, since they should be
> read-only, but if pmd_entry() was called with something else than a
> hugepage, then it requests the fallback, but never a split.

But  PAGE_WALK_FALLBACK _is_ a split.

Oh, except you did this

-               split_huge_pmd(walk->vma, pmd, addr);
+               if (!ops->pmd_entry)
+                       split_huge_pmd(walk->vma, pmd, addr);


so it avoids the split.

No, that's unacceptable. And makes no sense anyway. If it doesn't
split the pmd, then it shouldn't walk the pte's - because they don't
exist. And if it's not a hugepmd, then the split is a no-op, so the
test makes no sense.

I hadn't noticed that part of the patch. That simply can't be right. I
don't think you've tested this, because you never actually have
hugepages, do you?

You didn't notice or realize that split_huge_pmd() just does that

                if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)   \
                                        || pmd_devmap(*____pmd))        \

thing and doesn't do anythign at all if it's not huge.

So no. That code makes no sense at all, and I didn't realize how
senseless it was, becasue I stupidly missed that "make the split
conditional" - which is insane and wrong - and I thought that you
wanted PAGE_WALK_FALLBACK to split a pmd and fall back to per-pte
entries, which is what the name implies.

But that's not what you wanted at all.

Just get rid of PAGE_WALK_FALLBACK entirely then, and make the rule be
that a zero return value just means "split and do ptes". Which is what
you want (see above why "split" simply is wrong, and isn't an issue
for you anyway.

That won't change any existing cases, since even if they do have a
zero return value, they don't have a pte_entry() callback, so they
won't do that "split and do ptes" anyway.

             Linus
