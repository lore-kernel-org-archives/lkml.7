Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F26C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE8420659
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="uhN/KAyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF1QjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:39:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36410 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF1QjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:39:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so6604817oti.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XLI89+7Lb6wfVp1bMUmxbBSBywMikjF0UqTHc4ZmMY=;
        b=uhN/KAyqmQJIfXv831E6f5gCDD4M7DPJutn9seJLci/a+sjZWkNPOQkf4lWIlPxwGD
         wMJOdt7G3K51qZNGI32EaXEHFWXMsveXMVkqEPxlkaTlEw1EBzhFfuapGlvfNcBcrdL8
         f/oqvyCxWz01YIuY/ynYX7NCy59SZ0R5gEnlrM241o+azp5zCI0tGPyPwJCui9wr6IgY
         jtsQL9yrZizohktvGl0vlFQn2LyUDsaLvo9BzEfVLM292cR04kl53Lpy8I5hyHVV6Ru8
         hH0ENXRysaq4iaAGqfrO2x1mMegw9G1ixN1TNPBbhj80FdYkvhaMt1tohfYCgxXPvFfq
         l7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XLI89+7Lb6wfVp1bMUmxbBSBywMikjF0UqTHc4ZmMY=;
        b=CBaGq7ao0iZntnbfE4ZDGUz6f5/3SpEL0uMsVz0CHuO8PYZdV3B6YOP8sycsPne4I0
         ibmHPwsUnYPprQx8D6zLqAcopYxeXBNp2Grcy1HlpgCELaxR+3WH8BGYz1i4NCp96XSi
         fRfZGLJ06zCoOrT66yO7s6XANb4xPsQpEnozhD8y0NJGK8RyUcMv/fmN+JxiHKZrRf2s
         P7sUGPTTgNBi/rSIguK50j95MceW0/sjZ5WDwghZFRg6jGAkaQ4m1wKoWGrlr3D40n6b
         e3Gylk3m24Gm57Hs4bUt7+flMEoMQ2TCmtkcTJc5+B0dJJ22SeGx8GbSvj4NPZvBbSv9
         s0xA==
X-Gm-Message-State: APjAAAXE016XOlYAvEh0yJlPnJNrhLJooV6J+9+FdDXNdA+OC8wHay3Y
        ULbYhZMtR8/aiPdJqLpukf+dWBIpZakHeSrqwQQPQw==
X-Google-Smtp-Source: APXvYqy7YGYkJSjiaanIgBTFDjBOm0MW6GQ0Eu+LrM/c/o1FCTwV4rvL/QeDyZWVusE9P5L/uXi6G63VRJfQmLXqzk4=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr8613500oto.207.1561739952508;
 Fri, 28 Jun 2019 09:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org> <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
 <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org> <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190628163721.GC4286@bombadil.infradead.org>
In-Reply-To: <20190628163721.GC4286@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 09:39:01 -0700
Message-ID: <CAPcyv4jeRwhYWnGw9RrfDA54RRa9LK4JPuF3zQ-av=HdRqCTJw@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 9:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 27, 2019 at 07:39:37PM -0700, Dan Williams wrote:
> > On Thu, Jun 27, 2019 at 12:59 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Thu, Jun 27, 2019 at 12:09:29PM -0700, Dan Williams wrote:
> > > > > This bug feels like we failed to unlock, or unlocked the wrong entry
> > > > > and this hunk in the bisected commit looks suspect to me. Why do we
> > > > > still need to drop the lock now that the radix_tree_preload() calls
> > > > > are gone?
> > > >
> > > > Nevermind, unmapp_mapping_pages() takes a sleeping lock, but then I
> > > > wonder why we don't restart the lookup like the old implementation.
> > >
> > > If something can remove a locked entry, then that would seem like the
> > > real bug.  Might be worth inserting a lookup there to make sure that it
> > > hasn't happened, I suppose?
> >
> > Nope, added a check, we do in fact get the same locked entry back
> > after dropping the lock.
>
> Okay, good, glad to have ruled that out.
>
> > The deadlock revolves around the mmap_sem. One thread holds it for
> > read and then gets stuck indefinitely in get_unlocked_entry(). Once
> > that happens another rocksdb thread tries to mmap and gets stuck
> > trying to take the mmap_sem for write. Then all new readers, including
> > ps and top that try to access a remote vma, then get queued behind
> > that write.
> >
> > It could also be the case that we're missing a wake up.
>
> That was the conclusion I came to; that one thread holding the mmap sem
> for read isn't being woken up when it should be.  Just need to find it ...
> obviously it's something to do with the PMD entries.

Can you explain to me one more time, yes I'm slow on the uptake on
this, the difference between xas_load() and xas_find_conflict() and
why it's ok for dax_lock_page() to use xas_load() while
grab_mapping_entry() uses xas_find_conflict()?
