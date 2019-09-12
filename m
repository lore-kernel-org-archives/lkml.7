Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C18C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FE420872
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPNprPly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfILBbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 21:31:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41753 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfILBbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 21:31:06 -0400
Received: by mail-io1-f66.google.com with SMTP id r26so50510675ioh.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 18:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VAjn6U6N/arzAqTNNO05V4de66eq/g4N7k2+dh2Hohs=;
        b=pPNprPlyDZe9kCLCoAsHCrJIOoTusOUs87tHwEqMZVeeRErd6vEZCRNMVFhQfazg95
         DI/4xQ6A2/OcjcLW+MxKWYjFM9fyUBo0Xo+dgO/rdO0HI5iZShwsW+Q/h/CVUCg+R+Ew
         BZQO1wrCYZWmY1/DF5aysIhXAHoktZNTUFEnOz8scqbHHyOYSRKLFQf7fIS7/kagzwJc
         0MieTFBo4fmIOF8SLnGAmMfqW2mzSWN6UZDO/KYnfpzEXp1x90PW/OPgT798oZLzni+q
         gGkSRi3e4SYCbYU70EBzWSiGrlBNRFwGaX0pK7bOF7785Mq7eW3wz1N7e0LVlPO9Q9nq
         1hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VAjn6U6N/arzAqTNNO05V4de66eq/g4N7k2+dh2Hohs=;
        b=OdzIPk4g0qT57xYG1L5MYB9AnoumjR7l/cFeeokYl98DwTika6HUzi4kOTxA+RGQ2j
         jVtQHJZLKjaQri/OSOwsN0eIWRLGdyV68ZDKsXA1QOX1FN/eaj/LASOMtAhMkrsLC7eD
         0duOGsSrgvh4zDN3fmtujwr3PSsWsHemrwCR5zTPbE9xj4wtx320AhMCnvCzedKV6BaJ
         GQ+fJ8Cwmfefy4KXyqIGk/6rh7EYNe1RIht8bH6pulpJivkj+FiWArdaMQiE2dUzEjzk
         i7bKt4A1sLsMhTHn3NIsYhxlDwhUyFQINyfqSyZ6HYLWOeHauNUjez/DRRbWMEdpCYSc
         33LA==
X-Gm-Message-State: APjAAAVrpNzGxK3Rjh9iHh0nnj+b5GaOjzVNyDfg4bk+MJMVVg8klIzC
        eCYN4POHts8YQoClZ9G2TUZ/sg==
X-Google-Smtp-Source: APXvYqwiHKqhV5A2wXd8IRIqXKzw4cMZ9I6IeH3N094Evn8SYf82x91sqv1m3AKXh2WtLyPWThKsZw==
X-Received: by 2002:a6b:3705:: with SMTP id e5mr1172039ioa.213.1568251865760;
        Wed, 11 Sep 2019 18:31:05 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id q74sm36424390iod.72.2019.09.11.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:31:04 -0700 (PDT)
Date:   Wed, 11 Sep 2019 19:31:00 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: avoid slub allocation while holding list_lock
Message-ID: <20190912013100.GA114178@google.com>
References: <20190911071331.770ecddff6a085330bf2b5f2@linux-foundation.org>
 <20190912002929.78873-1-yuzhao@google.com>
 <20190912002929.78873-2-yuzhao@google.com>
 <20190912004401.jdemtajrspetk3fh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912004401.jdemtajrspetk3fh@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 03:44:01AM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 11, 2019 at 06:29:28PM -0600, Yu Zhao wrote:
> > If we are already under list_lock, don't call kmalloc(). Otherwise we
> > will run into deadlock because kmalloc() also tries to grab the same
> > lock.
> > 
> > Instead, statically allocate bitmap in struct kmem_cache_node. Given
> > currently page->objects has 15 bits, we bloat the per-node struct by
> > 4K. So we waste some memory but only do so when slub debug is on.
> 
> Why not have single page total protected by a lock?
> 
> Listing object from two pages at the same time doesn't make sense anyway.
> Cuncurent validating is not something sane to do.

Okay, cutting down to static global bitmap.
