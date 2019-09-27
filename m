Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D112C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D521906
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Js5q4lD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfI0M0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:26:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36977 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0M0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:26:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so2171578edy.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MLpaVux2E5Ma8rfAsYk3Q/0a9jF4YNQVNjLuUjERIwU=;
        b=Js5q4lD+A5EtYma3P8PemetzNBMs7ohd2kxsZRV/XUHWHotVYaRs6vDe1pWcT7zE7J
         54Hyer007sKbB3MNGI+y38bGmLRx7Nq7UkQO10kupTbe1Z8xWZAORHKu7jntTtMN4Yv6
         IHTBdlDrR1iuNBsPF3XlddLM7fOWrvUnB0PPEvNnBnyPv/UqxhJpyG70UqtCxCoM8Jud
         BB9LzNMy6kmbYjTU7r2uP4oO8nJw2StVOGWSNb9PvsWzmsuwG+mWIdbQKCnIPqqq1eO3
         s6/c+36AJgA9/dM0ncR//xpZ7s1mJgkuVFDb6OJYucA/EOyBE4tGQRsc1ZPP6jjrxvvY
         1UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MLpaVux2E5Ma8rfAsYk3Q/0a9jF4YNQVNjLuUjERIwU=;
        b=qERL6NqV6Ulx6+S+7kBlYbI9M1N7AA+IQtf8MFOqK3dReaNNdniDYhaWtWpqbU+Dvi
         Pt31zlbAyYRjbksZzBBBvYqUHOhBtzSvlfFXyQboLOAmXyKz/93qw8aF1KcqP2oMzU62
         I9KAaff+FJGIwT0tK45gLaHQ2QaSMejs4cwDu0nGnDCwl3LkgqerZkZENeNyInytslge
         KvNSN1YERHGzb9UzZ9EqL7wbkCFqbA/x5o9ZbBhw/CXUEGNX+Lf731AVY2N6ohHDMWWf
         jP+AxH944QHDGtMKsfe37+6/q2ebE2IQ4Q8kQvGBM9NdFBkxfsswq6EMtG0tS/xm6+Oc
         4Lvg==
X-Gm-Message-State: APjAAAUp3ZQgFi+99TuZHHfbpxgMPqls8Mbaf/89oE4O/FHfmeSz1Ca1
        nMafGtjMTQqezSYoxCVbvgm5Wg==
X-Google-Smtp-Source: APXvYqzv9a01DzZigIrxklIuOXJfyd+toe/1RrwfEGr3f1/wzZbbNkfR0iv1STW7wTw/jLxvMFgK8g==
X-Received: by 2002:a05:6402:2cb:: with SMTP id b11mr4179069edx.285.1569587194900;
        Fri, 27 Sep 2019 05:26:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j43sm500196eda.19.2019.09.27.05.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 05:26:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 147A7101F61; Fri, 27 Sep 2019 15:26:38 +0300 (+03)
Date:   Fri, 27 Sep 2019 15:26:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
Message-ID: <20190927122638.wtn5idrt4btir6be@box>
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org>
 <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
 <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <c58cdb3d-4f5e-7bfc-06b3-58c27676d101@shipmail.org>
 <CAHk-=wh_+Co=T8wG8vb5akMP=7H4BN=Qpq6PsKh8rcmT8MCV+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh_+Co=T8wG8vb5akMP=7H4BN=Qpq6PsKh8rcmT8MCV+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:20:42PM -0700, Linus Torvalds wrote:
> On Thu, Sep 26, 2019 at 1:55 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
> >
> > Well, we're working on supporting huge puds and pmds in the graphics
> > VMAs, although in the write-notify cases we're looking at here, we would
> > probably want to split them down to PTE level.
> 
> Well, that's what the existing walker code does if you don't have that
> "pud_entry()" callback.
> 
> That said, I assume you would *not* want to do that if the huge
> pud/pmd is already clean and read-only, but just continue.
> 
> So you may want to have a special pud_entry() that handles that case.
> Eventually. Maybe. Although honestly, if you're doing dirty tracking,
> I doubt it makes much sense to use largepages.
> 
> > Looking at zap_pud_range() which when called from unmap_mapping_pages()
> > uses identical locking (no mmap_sem), it seems we should be able to get
> > away with i_mmap_lock(), making sure the whole page table doesn't
> > disappear under us. So it's not clear to me why the mmap_sem is strictly
> > needed here. Better to sort those restrictions out now rather than when
> > huge entries start appearing.
> 
> zap_pud_range()actually does have that
> 
>                VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);

The VM_BUG is a blind copy from PMD layer and it's bogus. i_mmap_lock()
works fine for file mappings.

The PMD was intended for THP case at the time when there were only
anon-THP. The check was relaxed and later dropped for file-THP on PMD
level. It has to be dropped on PUD too. We don't have anon-THP on PUD
level at all, only DAX played with them.
 
-- 
 Kirill A. Shutemov
