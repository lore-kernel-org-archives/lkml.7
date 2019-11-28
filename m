Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED62FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C283C21775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jXLwhfyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfK1LfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:35:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43647 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1LfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:35:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so4957288ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 03:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XOqt1jA1mHDLa304qf2rgZ/MgYLbFa3pf/BnMQUaDUU=;
        b=jXLwhfyTQDXvRp9KdmQMJpPvWCMrvfQGfjoalvLtnweIxV6eaWL6+FxOW54SN3/lCi
         O8wSfDPhKFc69w1M5A955/eZVWOjKZCY/VB7lrcL39YTZx+dE4acIA6eJOzhzHS4CzKa
         VCxz0bz0HA6fDAJnVxCT0n7LlVuwO7g3xojM1ysv1c/UlW/yOQavAWvsJMFoopU+AeCa
         yrGiEyCYkuRjGYQcrkmvfPA3+2JFT3nyOxyLG+kO5sEvy+SMFWuPQEby779MxARBw7+0
         4+N8ie63zkjuc/DuanK9ypI5ccyxAyMBz4aB6uafa3Kb/4C7OcOLaXQfXzQudgKPd0RU
         QYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XOqt1jA1mHDLa304qf2rgZ/MgYLbFa3pf/BnMQUaDUU=;
        b=f2+XuEdUO0cXo8uCBViI1ffe5xQEjPk88UicuOOrQJ/XF4uwow7QhA7oSIhqQFLhT8
         ZYPx4Z2L/Z9K0vTntM9MYmKQFdeBsu3aBIqDffAn+IjJMKybPEyDjuaGF04FJsxA+ccp
         ejlyM2ZCUToamz5MxCOlHD2tN03g6mapDnrLn78MN41Ys5QXE5T4JFwzEoJtK4o2gZJx
         WOZ5CWl8XO45wCwROYcpJlRCI1aKe5nNosEHkXNNVPnHMmzUX5sIMwQurbRPDgIhF0er
         HJyti7yGzsVmJs1CX//lzIM7Q9jM3YmKMCXx3zcinl8brD6MSsER3qG9jwpZ2UanBCpl
         o4rw==
X-Gm-Message-State: APjAAAUzr6XU9pHTwxTn0kcfoyOueouugX//gy+sAzi3cIr7s1oCXQj/
        4PcvpQFVZMNW9FAdE/a6NPLe2w==
X-Google-Smtp-Source: APXvYqxtsM0j/fet/8Hd0wppyL5kmHFHQSC8L5N/GAw4xOFXmFoZ5D9szeElJt5bgd2+LoHbl99hcA==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr34842858ljk.101.1574940898131;
        Thu, 28 Nov 2019 03:34:58 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f11sm4228455lfa.9.2019.11.28.03.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 03:34:57 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6B5A310188A; Thu, 28 Nov 2019 14:34:56 +0300 (+03)
Date:   Thu, 28 Nov 2019 14:34:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
Message-ID: <20191128113456.5phjhd3ajgky3h3i@box>
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191125093611.hlamtyo4hvefwibi@box>
 <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
 <20191125183350.5gmcln6t3ofszbsy@box>
 <9a68b929-2f84-083d-0ac8-2ceb3eab8785@linux.alibaba.com>
 <14b7c24b-706e-79cf-6fbc-f3c042f30f06@linux.alibaba.com>
 <alpine.LSU.2.11.1911271718130.652@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.11.1911271718130.652@eggly.anvils>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 07:06:01PM -0800, Hugh Dickins wrote:
> On Tue, 26 Nov 2019, Yang Shi wrote:
> > On 11/25/19 11:33 AM, Yang Shi wrote:
> > > On 11/25/19 10:33 AM, Kirill A. Shutemov wrote:
> > > > On Mon, Nov 25, 2019 at 10:24:38AM -0800, Yang Shi wrote:
> > > > > On 11/25/19 1:36 AM, Kirill A. Shutemov wrote:
> > > > > > On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
> > > > > > > Currently when truncating shmem file, if the range is partial of
> > > > > > > THP
> > > > > > > (start or end is in the middle of THP), the pages actually will
> > > > > > > just get
> > > > > > > cleared rather than being freed unless the range cover the whole
> > > > > > > THP.
> > > > > > > Even though all the subpages are truncated (randomly or
> > > > > > > sequentially),
> > > > > > > the THP may still be kept in page cache.  This might be fine for
> > > > > > > some
> > > > > > > usecases which prefer preserving THP.
> > > > > > > 
> > > > > > > But, when doing balloon inflation in QEMU, QEMU actually does hole
> > > > > > > punch
> > > > > > > or MADV_DONTNEED in base page size granulairty if hugetlbfs is not
> > > > > > > used.
> > > > > > > So, when using shmem THP as memory backend QEMU inflation actually
> > > > > > > doesn't
> > > > > > > work as expected since it doesn't free memory.  But, the inflation
> > > > > > > usecase really needs get the memory freed.  Anonymous THP will not
> > > > > > > get
> > > > > > > freed right away too but it will be freed eventually when all
> > > > > > > subpages are
> > > > > > > unmapped, but shmem THP would still stay in page cache.
> > > > > > > 
> > > > > > > To protect the usecases which may prefer preserving THP, introduce
> > > > > > > a
> > > > > > > new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting THP
> > > > > > > is
> > > > > > > preferred behavior if truncating partial THP.  This mode just makes
> > > > > > > sense to tmpfs for the time being.
> 
> Sorry, I haven't managed to set aside enough time for this until now.
> 
> First off, let me say that I firmly believe this punch-split behavior
> should be the standard behavior (like in my huge tmpfs implementation),
> and we should not need a special FALLOC_FL_SPLIT_HPAGE to do it.
> But I don't know if I'll be able to persuade Kirill of that.
> 
> If the caller wants to write zeroes into the file, she can do so with the
> write syscall: the caller has asked to punch a hole or truncate the file,
> and in our case, like your QEMU case, hopes that memory and memcg charge
> will be freed by doing so.  I'll be surprised if changing the behavior
> to yours and mine turns out to introduce a regression, but if it does,
> I guess we'll then have to put it behind a sysctl or whatever.
> 
> IIUC the reason that it's currently implemented by clearing the hole
> is because split_huge_page() (unlike in older refcounting days) cannot
> be guaranteed to succeed.  Which is unfortunate, and none of us is very
> keen to build a filesystem on unreliable behavior; but the failure cases
> appear in practice to be rare enough, that it's on balance better to give
> the punch-hole-truncate caller what she asked for whenever possible.

I don't have a firm position here. Maybe you are right and we should try
to split pages right away.

It might be useful to consider case wider than shmem.

On traditional filesystem with a backing storage semantics of the same
punch hole operation is somewhat different. It doesn't have explicit
implications on memory footprint. It's about managing persistent storage.
With shmem/tmpfs it is lumped together.

It might be nice to write down pages that can be discarded under memory
pressure and leave the huge page intact until then...

[ I don't see a problem with your patch as long as we agree that it's
desired semantics for the interface. ]

-- 
 Kirill A. Shutemov
