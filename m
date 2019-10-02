Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79818C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4932521783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="gq5itDKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfJBNSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:18:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37364 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJBNSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:18:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4so15241698edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E4uXiPQh5CilHJLER4hocaBvsNcCWt7kA1fG1frc5KM=;
        b=gq5itDKj0IoY9IxPzNtP49jnszJZvvR5zSQzt0qcvhvxVJYqvyjMY6d1LgRComtIEl
         ci5AdTu+8f7b3d69LbYjcnaw+orJSp9tCPY5UgU48BuoHyV/WnQLniehfDoPZmyTrh61
         R0hLu2Zqn94/IW5L3S0BWeF8GErkHbw8pho+sxjuQvaki2o5xzPT4x35UIKOz4ZCuyI6
         2QL0u44JtF1ladY9H0VI4Z8nCwv2etE58/Ohp3bfp1AhjIrYRa+Tc8VzomYVaaiNgmrA
         Pyr32xZwmkbmD3XUhhM9I1ZDs4PXhn59CcRBI1xU0VTclpmI2X7d0e0j0wEpuZiDk8Lr
         F3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E4uXiPQh5CilHJLER4hocaBvsNcCWt7kA1fG1frc5KM=;
        b=eDjNBegeK5AuCtNtbe9TUseZzJHMhAju18Ivqptacmj5aTPNrpU3lQKjW5ThRYAfu3
         7dfkhnklB960gUcq/6DNzrX1q54qDb2qXSyu9UrE+/riPDcEweUob+WE6bObg6P89Z/A
         sUyX4gBeG6po3tM9oXPZZRIkmZMa9LKQyhuyrCrwYQBG3ziDJnxePihRTjIqtDbdTzvz
         d80veTHV7OEWzE3d6G0CUaeFHlHVuCFsg2GfQIcgu2/2c1GQinansXKqL5wNOZNAenKs
         KsnDIZ1uRrHFfhE3OEGKf9DA4gDH+O7HN1u00sE6U8H0uc12zm0P2D3mtd2D/0ixsCcP
         XGSQ==
X-Gm-Message-State: APjAAAVducBnJ9hwpNMXPOnj6ZJjnS7RGGifXhan7Kx/InNC/QZS3op+
        0a3K6SJoeHCElYxk5b/MNXNn+EHitHiKXg==
X-Google-Smtp-Source: APXvYqwgwVGc3f1EL8dgSureN2TvxxLp+I/HhbuxR51KekTRd69Ckz2y0aHsSMpQwO9ILaz3/UazVw==
X-Received: by 2002:a17:906:e288:: with SMTP id gg8mr2976209ejb.24.1570022301120;
        Wed, 02 Oct 2019 06:18:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v22sm3895662edm.89.2019.10.02.06.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 06:18:20 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F209310410D; Wed,  2 Oct 2019 16:18:19 +0300 (+03)
Date:   Wed, 2 Oct 2019 16:18:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
Message-ID: <20191002131819.asjr2tsx6lcmmbof@box>
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org>
 <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
 <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <50e83aeb-e971-f0ad-f034-ed592588eba7@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50e83aeb-e971-f0ad-f034-ed592588eba7@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:21:01AM +0200, Thomas Hellström (VMware) wrote:
> On 9/26/19 10:16 PM, Linus Torvalds wrote:
> > On Thu, Sep 26, 2019 at 1:09 PM Thomas Hellström (VMware)
> > <thomas_os@shipmail.org> wrote:
> > > That said, if people are OK with me modifying the assert in
> > > pud_trans_huge_lock() and make __walk_page_range non-static, it should
> > > probably be possible to make it work, yes.
> > I don't think you need to modify that assert at all.
> > 
> > That thing only exists when there's a "pud_entry" op in the walker,
> > and then you absolutely need to have that mmap_lock.
> > 
> > As far as I can tell, you fundamentally only ever work on a pte level
> > in your address space walker already and actually have a WARN_ON() on
> > the pud_huge thing, so no pud entry can possibly apply.
> > 
> > So no, the assert in pud_trans_huge_lock() does not seem to be a
> > reason not to just use the existing page table walkers.
> > 
> > And once you get rid of the walking, what is left? Just the "iterate
> > over the inode mappings" part. Which could just be done in
> > mm/pagewalk.c, and then you don't even need to remove the static.
> > 
> > So making it be just another walking in pagewalk.c would seem to be
> > the simplest model.
> > 
> > Call it "walk_page_mapping()". And talk extensively about how the
> > locking differs a lot from the usual "walk_page_vma()" things.
> > 
> > The then actual "apply" functions (what a horrid name) could be in the
> > users. They shouldn't be mixed in with the walking functions anyway.
> > They are callbacks, not walkers.
> > 
> >               Linus
> 
> Linus, Kirill
> 
> I've pushed a reworked version based on the pagewalk code here:
> 
> https://cgit.freedesktop.org/~thomash/linux/log/?h=pagewalk
> 
> (top three patched)
> 
> with users included here:
> 
> https://cgit.freedesktop.org/~thomash/linux/log/?h=coherent-rebased
> 
> Do you think this could work? The reason that the "mm: Add write-protect and
> clean.." code is still in mm as a set of helpers, is of course that much of
> the needed functionality is not exported, presumably since we want to keep
> page table manipulation in mm.

Could you post it to the mailing list? It's easier to review this way.

-- 
 Kirill A. Shutemov
