Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E43C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D5A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfDAOsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:48:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33830 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfDAOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:48:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so11164741qtm.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nt8nCkiL/lmRXg5mImkQVFR8ydDkGxqOHtXpP9B9HMI=;
        b=p6BmT3usqoedl3gL1c/0RqW30YEEdPf4JnXJTCdhYLuBZQsEU39SGDJtH0SrC+b+1i
         gHfrjy6FdBuGstgOpv4sKbG2wrc+hnlN1B6iiM+RZKTNhFVRaVKmaaoVj7cjtEOZeGIa
         cqpe4xNJN0M/e0AVzcMRN1/8EGzr5W6t3TCq2erPbBZVD6mb/CG4QGUgRkz0CIJTG0L+
         JbGJjjcORENLaGHwYP6NHuPT4bBLp+TdfOZxXDQir3/RMGTaIQrA2T7cJ1XEd88+I01N
         UigFDQR7C1O7g/jvfVqTisXaSJeo/p/Jp3kmFvV4s3qJiTNxvEDeDOo5PAryRJ6pXhzR
         a9jQ==
X-Gm-Message-State: APjAAAUnKlhS6B0TynW9LbI8uavFH/mJ7JVtiaWmwXa1F0wyhkTeTaPw
        25yavTa87Ne2/ANYEdlQorCuNQ==
X-Google-Smtp-Source: APXvYqwzMFehCXyKpzmyvfdZzFoZbM7plT1F+hAXxH2SANmhbRwnjoxXtZ7V+qdz4DDg0+b8E538ew==
X-Received: by 2002:a0c:d1a6:: with SMTP id e35mr53515321qvh.174.1554130079126;
        Mon, 01 Apr 2019 07:47:59 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id u16sm7752118qtc.84.2019.04.01.07.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 07:47:58 -0700 (PDT)
Date:   Mon, 1 Apr 2019 10:47:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190401104608-mutt-send-email-mst@kernel.org>
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com>
 <20190329104311-mutt-send-email-mst@kernel.org>
 <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com>
 <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org>
 <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org>
 <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
 <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 04:11:42PM +0200, David Hildenbrand wrote:
> > The interesting thing is most probably: Will the hinting size usually be
> > reasonable small? At least I guess a guest with 4TB of RAM will not
> > suddenly get a hinting size of hundreds of GB. Most probably also only
> > something in the range of 1GB. But this is an interesting question to
> > look into.
> > 
> > Also, if the admin does not care about performance implications when
> > already close to hinting, no need to add the additional 1Gb to the ram size.
> 
> "close to OOM" is what I meant.

Problem is, host admin is the one adding memory. Guest admin is
the one that knows about performance.

> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
