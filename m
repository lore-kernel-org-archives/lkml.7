Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35EDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B026621D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="CaZlvtsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395455AbfJYPiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:38:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37506 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395444AbfJYPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:38:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id b20so2128563lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jZwcIBK9RBpNXXg9fliYtzI+/uqYeUg76xB5KS/2/GI=;
        b=CaZlvtsIdJSGaCGsSEutmaEjlETDVj0z2zcKh4y/f5q6VmMyMWWfw9W4igLnCz2gto
         kybYYHdF64SLB9oMncELVhKUBg+MJ3zdmrGdZfsLXogSgBPMCcppNgcP4CjLitcUGoCb
         CBbcEhRkBNOPC7QwMRwLKiOFjHNzWLsoDHCzX+LoCAgmDabQdcCK4rb7DPmRd2BNOu74
         irqY8xFwMSWaSzMRgqvI2MJhl/9+GOe1AekPuHGWQlq8F+i3qP1fS/wNHvBlopL7BeyI
         zo+56m7GL05H92aQ57vQyDKGW06gJ41yuPdu3/PDjFp/xNS8K7CTll3TOZqFYe3dTMX9
         3NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZwcIBK9RBpNXXg9fliYtzI+/uqYeUg76xB5KS/2/GI=;
        b=Fv1gOF2fcnobxiq1LXAvPBjBvsiK8aS7llyolhcw1r7W0J9J8+k9OdV16o/yaSr276
         sGJGK5aI6AoEp0O5v9WEbOYP4+QckhHWLySNWq6OHJKl8DtzO/tunO5tyNH4iiocOalU
         tSVaktPtarEwlYyEnqQN4KxvJ1XFEGUe3TI875J46TTz0hL7k+Ulx+jVK7KQcpDACVts
         jswQi/c0oFIWdCD2EcJJzUnIkf4bymQyBv542ukvHSYpWTJmP5sTQUO5w9q5ja20JHJ9
         nXbI0tYlpTTdyYEhQaONGTM8qxmsPOierGAcePHBKj8IN1TLlXYm/7wlIKVbugwD4/A+
         TNtA==
X-Gm-Message-State: APjAAAVWm4aKAQ/Cbk1l1WAWXo0EppqE8AHoO+QUUuPgROoBox3a24qL
        QyH4JYOLC4gHPYmBwHamL1PudJyAVF4=
X-Google-Smtp-Source: APXvYqwZ7NC3dbzVTye/dsPqwRnL1JaFu5EVWGZ15w9KFP+J0lzpl9W7KBLDC0L4Rxa1fX6dkqUbJQ==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr3117042lfl.161.1572017886130;
        Fri, 25 Oct 2019 08:38:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k10sm946788lfo.76.2019.10.25.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 08:38:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3774510267F; Fri, 25 Oct 2019 18:38:05 +0300 (+03)
Date:   Fri, 25 Oct 2019 18:38:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hughd@google.com,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        gavin.dg@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [v4 PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
Message-ID: <20191025153805.6unvxxjzmq4gsxzs@box>
References: <1571865575-42913-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191024135547.GH2963@bombadil.infradead.org>
 <c3932146-1b91-fa90-b947-9d4ebe5c5135@linux.alibaba.com>
 <20191025153205.GQ2963@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025153205.GQ2963@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:32:05AM -0700, Matthew Wilcox wrote:
> On Thu, Oct 24, 2019 at 09:33:11AM -0700, Yang Shi wrote:
> > On 10/24/19 6:55 AM, Matthew Wilcox wrote:
> > > On Thu, Oct 24, 2019 at 05:19:35AM +0800, Yang Shi wrote:
> > > > We have usecase to use tmpfs as QEMU memory backend and we would like to
> > > > take the advantage of THP as well.  But, our test shows the EPT is not
> > > > PMD mapped even though the underlying THP are PMD mapped on host.
> > > > The number showed by /sys/kernel/debug/kvm/largepage is much less than
> > > > the number of PMD mapped shmem pages as the below:
> > > > 
> > > > 7f2778200000-7f2878200000 rw-s 00000000 00:14 262232 /dev/shm/qemu_back_mem.mem.Hz2hSf (deleted)
> > > > Size:            4194304 kB
> > > > [snip]
> > > > AnonHugePages:         0 kB
> > > > ShmemPmdMapped:   579584 kB
> > > > [snip]
> > > > Locked:                0 kB
> > > > 
> > > > cat /sys/kernel/debug/kvm/largepages
> > > > 12
> > > > 
> > > > And some benchmarks do worse than with anonymous THPs.
> > > > 
> > > > By digging into the code we figured out that commit 127393fbe597 ("mm:
> > > > thp: kvm: fix memory corruption in KVM with THP enabled") checks if
> > > > there is a single PTE mapping on the page for anonymous THP when
> > > > setting up EPT map.  But, the _mapcount < 0 check doesn't fit to page
> > > > cache THP since every subpage of page cache THP would get _mapcount
> > > > inc'ed once it is PMD mapped, so PageTransCompoundMap() always returns
> > > > false for page cache THP.  This would prevent KVM from setting up PMD
> > > > mapped EPT entry.
> > > > 
> > > > So we need handle page cache THP correctly.  However, when page cache
> > > > THP's PMD gets split, kernel just remove the map instead of setting up
> > > > PTE map like what anonymous THP does.  Before KVM calls get_user_pages()
> > > > the subpages may get PTE mapped even though it is still a THP since the
> > > > page cache THP may be mapped by other processes at the mean time.
> > > > 
> > > > Checking its _mapcount and whether the THP has PTE mapped or not.
> > > > Although this may report some false negative cases (PTE mapped by other
> > > > processes), it looks not trivial to make this accurate.
> > > I don't understand why you care how it's mapped into userspace.  If there
> > > is a PMD-sized page in the page cache, then you can use a PMD mapping
> > > in the EPT tables to map it.  Why would another process having a PTE
> > > mapping on the page cause you to not use a PMD mapping?
> > 
> > We don't care if the THP is PTE mapped by other process, but either
> > PageDoubleMap flag or _mapcount/compound_mapcount can't tell us if the PTE
> > map comes from the current process or other process unless gup could return
> > pmd's status.
> 
> But why do you care if the THP is PTE mapped by _this_ process?
> This process has a reference to the page; the page is PMD sized and PMD
> aligned, so you can use a PMD mapping in the guest, regardless of how
> it's mapped by userspace.  Maybe this process doesn't even have the page
> mapped at all?

Consider the case with MAP_PRIVATE. If part of the THP was overritten in
the process, you want EPT to reflect the case, not map the page from page
cache regardless.

-- 
 Kirill A. Shutemov
