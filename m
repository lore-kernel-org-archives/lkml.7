Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211BFC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69942075D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569536464;
	bh=p8wLa6uW7p0Dd8Mjn3PyYe848vVWjWwHSzfbvqPoeNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oklF4u3LqMrWCPXTKmpAtg0DeZhRxDcYiiOjlSyqdMXcUSAzs2WSLQ1CLh5m/+/iW
	 pFBphEdNhCCe4ePBIM/Zt0SUopMxoyK0PXG6XSmQsz3Giboyz/+XmTAFoPEOwUqUT0
	 gh6zwthEJ56AR6lnw49Nfk5BdM5cmxpE0mKIwWpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfIZWVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:21:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34544 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIZWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:21:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so392337lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ge4WC49pngiICthc1WDcavUjVJbMBv50VLzrcwA4/hc=;
        b=F0LSxC3wcSztazbG0uwCTRtKvGqprF/KA5I/kBqM8nEjAxsHAszHBhkaAnVSswq05I
         IPDhtPkVd/mlH10svz+m4SxGzJUZb8x7FqMDs4M8P0ZJ8e08izgtmsrZi+eLmVZ7fgoV
         8FC65G/EFwknPF5qvRjXEHu47uk9C2Rj8l8IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ge4WC49pngiICthc1WDcavUjVJbMBv50VLzrcwA4/hc=;
        b=q9FqO5FDR4SHXkNK6sAkg08gkQzCYGsdpdeq2Ae28rzs+CMv3Zoh2jKhpXgZDmWNzK
         OxQ9PjWMEK4ji/4cpK+EY0rKcRjVrWAd8CCG2sPgm7vOv6SAZ90AXzLO8s0WlNI/dRDX
         EdGLNRj9jiyIn5I66tquZka57+iTDG8OqHcutFczDhxz0cU8wkT8Wvhzwv/vMNOFE1kC
         sV+NwGtFcB0eb3Kv+E7bBB2VWbSFCweSshlfgY1/VDeDuv95bnfaIdPYbLK94jOTrcg2
         2tnCT5uFyxSuKy94HWCtczsJSvy2c9R/cXxOgokyw5+TTjvX96nykkxN0GqC1Q5XMH+5
         JUhQ==
X-Gm-Message-State: APjAAAVeOQAlzuT1DWejQB3cLLNVFIBeMUGsKAa4me82T2k0mwf+zgV7
        TJxDtTTcneCgByTLd2KlPZB4XLy+Hmw=
X-Google-Smtp-Source: APXvYqzaob7xHtjaQ1yidDQ2n9Ubcm1TjnTC6PtR4L4e1edwuJgqZa5Rkwc2DBPzifo/YiyKdbeV1w==
X-Received: by 2002:a19:f711:: with SMTP id z17mr499631lfe.58.1569536460062;
        Thu, 26 Sep 2019 15:21:00 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id a8sm89532ljf.47.2019.09.26.15.20.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 15:20:59 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w67so380886lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:20:58 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr487782lfe.79.1569536458354;
 Thu, 26 Sep 2019 15:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org> <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org> <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <c58cdb3d-4f5e-7bfc-06b3-58c27676d101@shipmail.org>
In-Reply-To: <c58cdb3d-4f5e-7bfc-06b3-58c27676d101@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Sep 2019 15:20:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_+Co=T8wG8vb5akMP=7H4BN=Qpq6PsKh8rcmT8MCV+Q@mail.gmail.com>
Message-ID: <CAHk-=wh_+Co=T8wG8vb5akMP=7H4BN=Qpq6PsKh8rcmT8MCV+Q@mail.gmail.com>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 1:55 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> Well, we're working on supporting huge puds and pmds in the graphics
> VMAs, although in the write-notify cases we're looking at here, we would
> probably want to split them down to PTE level.

Well, that's what the existing walker code does if you don't have that
"pud_entry()" callback.

That said, I assume you would *not* want to do that if the huge
pud/pmd is already clean and read-only, but just continue.

So you may want to have a special pud_entry() that handles that case.
Eventually. Maybe. Although honestly, if you're doing dirty tracking,
I doubt it makes much sense to use largepages.

> Looking at zap_pud_range() which when called from unmap_mapping_pages()
> uses identical locking (no mmap_sem), it seems we should be able to get
> away with i_mmap_lock(), making sure the whole page table doesn't
> disappear under us. So it's not clear to me why the mmap_sem is strictly
> needed here. Better to sort those restrictions out now rather than when
> huge entries start appearing.

zap_pud_range()actually does have that

               VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);

exactly for the case where it might have to split the pud entry.

Zapping the whole thing it does do without the assert.

I'm not going to swear the mmap_sem is absolutely required, since a
shared vma should be stable due to the i_mmap_lock, but splitting the
hugepage really is a fairly big deal.

It can't happen if you zap the *whole* mapping, but it can happen if
you have a start/end range. Like you do.

Also, in general it's probably not a great idea to look at
zap_page_range() (and copy_page_range()) for ideas.

They are kind of special, since they tend to be used for fundamental
whole-address-space operations (ie fork/exit) and so as a result they
get to do special things that a normal page walker generally shouldn't
do.

It's why they've never gotten translated to use the generic walker code.

           Linus
