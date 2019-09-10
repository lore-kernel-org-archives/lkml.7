Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F3BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803D12168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ronRdJi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfIJJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:16:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38891 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfIJJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:16:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id a23so14117828edv.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=So7xGEH+BMu4Cmi8/o4Tvt2NsS5FGolcX6sEtWgNC0A=;
        b=ronRdJi2C02VhhJUQoBvrvkdjEj9VZp6F/5OVMp/Tvq5efLXBnWTmpct2yAdWjw8vz
         MNK4D3AdTEVHu1HPXiyCfQH23vA5XGHpBWvLYDACfhfFSPZZjyXZOoZbJocqpJG7z4Z0
         wzdqhh8s3hog4Bz3Ltk37/j6PRajE8ldhKKILb8ujQyEAcXfuC5111cvqi6bXaE2ASYu
         FSN8NvbcjTDCYiWOxXFSRvZuNWk9YQPRwpU1g1iU0FvRYWuf0RzzIgckHJGAW3MjOHtS
         /69dyzoTUQg0CPNtMVjuMmd0biCJpjrd4GYRPmrvMKNgyaMWkD5xo9pMu/GYXhk+baIt
         U6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=So7xGEH+BMu4Cmi8/o4Tvt2NsS5FGolcX6sEtWgNC0A=;
        b=YHMlV+fp3htArcxVWfsuMhgqtMrPzt1Oga7HR+qtW5jdnuKGbCm9I3eTF79Hfh0dl+
         y0ahpbTqZ9aW54xNnT5KnLydKtY/nEiVQyOgy96cc4YBkjLrA93jDIRw5B/rvQ85lyTx
         DlCEjpP0/qc0eIQUDVW+5nyrI6mYLAcHvVHPttqjTh1uiHqtOLaPom5galOgQLhsm4b+
         I8Vyoy1VRMHkO/gDS7b+zBrMTJc742mSCvd71x1ORie17H1yCz9YPkUBDXL2TCc5eq1a
         bP3KmbD9U79ACZj4E0A4SMpSR0SdMnw9XTZHqnWvxpd1w+6oKqdRhy1jbpyYRIZhgqUg
         B1gw==
X-Gm-Message-State: APjAAAWpLAQtyBKrOapzbXYwl+aNCZ3EVgVr/m7EqATGDhNkKX/lzoN3
        d5JlMfGiGA9L1coNloTQ67Q8fQ==
X-Google-Smtp-Source: APXvYqxHBjTDGATRfQdbsKxUN6wcTweHctBP2RCdTije64kGWl+/NnSqzCFEB1FWYrnsfc0H8uUK7w==
X-Received: by 2002:a50:eb93:: with SMTP id y19mr22422147edr.65.1568106984968;
        Tue, 10 Sep 2019 02:16:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c1sm3415525edr.37.2019.09.10.02.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 02:16:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6A440102FF1; Tue, 10 Sep 2019 12:16:24 +0300 (+03)
Date:   Tue, 10 Sep 2019 12:16:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid slub allocation while holding list_lock
Message-ID: <20190910091624.3knf6mzorkki67nb@box.shutemov.name>
References: <20190909061016.173927-1-yuzhao@google.com>
 <20190909160052.cxpfdmnrqucsilz2@box>
 <e5e25aa3-651d-92b4-ac82-c5011c66a7cb@I-love.SAKURA.ne.jp>
 <20190909213938.GA53078@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909213938.GA53078@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 03:39:38PM -0600, Yu Zhao wrote:
> On Tue, Sep 10, 2019 at 05:57:22AM +0900, Tetsuo Handa wrote:
> > On 2019/09/10 1:00, Kirill A. Shutemov wrote:
> > > On Mon, Sep 09, 2019 at 12:10:16AM -0600, Yu Zhao wrote:
> > >> If we are already under list_lock, don't call kmalloc(). Otherwise we
> > >> will run into deadlock because kmalloc() also tries to grab the same
> > >> lock.
> > >>
> > >> Instead, allocate pages directly. Given currently page->objects has
> > >> 15 bits, we only need 1 page. We may waste some memory but we only do
> > >> so when slub debug is on.
> > >>
> > >>   WARNING: possible recursive locking detected
> > >>   --------------------------------------------
> > >>   mount-encrypted/4921 is trying to acquire lock:
> > >>   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
> > >>
> > >>   but task is already holding lock:
> > >>   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
> > >>
> > >>   other info that might help us debug this:
> > >>    Possible unsafe locking scenario:
> > >>
> > >>          CPU0
> > >>          ----
> > >>     lock(&(&n->list_lock)->rlock);
> > >>     lock(&(&n->list_lock)->rlock);
> > >>
> > >>    *** DEADLOCK ***
> > >>
> > >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > 
> > > Looks sane to me:
> > > 
> > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > 
> > 
> > Really?
> > 
> > Since page->objects is handled as bitmap, alignment should be BITS_PER_LONG
> > than BITS_PER_BYTE (though in this particular case, get_order() would
> > implicitly align BITS_PER_BYTE * PAGE_SIZE). But get_order(0) is an
> > undefined behavior.
> 
> I think we can safely assume PAGE_SIZE is unsigned long aligned and
> page->objects is non-zero.

I think it's better to handle page->objects == 0 gracefully. It should not
happen, but this code handles situation that should not happen.

-- 
 Kirill A. Shutemov
