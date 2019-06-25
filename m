Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D02CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBD5216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="u8A/ZyMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfFYJfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:35:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33678 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfFYJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:35:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so26219813edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xajd/k2gt2AWyDnLyY/AO4TDQLUBuztihD5Mc8Zw4LY=;
        b=u8A/ZyMMg+ASFoP0CxSfIGHRwcuoSefnAvR87vTdQuoOH/kgLRyJqZ+7uOFMi0bgiJ
         dk+qC4xcH2rhooiooNXuxohrqhNjez+fVF3JRNmo5xmYY3dtviF5xQblarGj5TLHLd2K
         nf75P+qC62KhHGqjrkgPxsMyv3RQ5MQ4R2pONk2R9UcF7UP8jzAV3n+V/6Of3jktoLd7
         bkefb78CSiMB65hWzWRpeWlNJ+zaLomo73yTZIo6td5zN8UjGVMkIhvkgqnOuBR5sH2N
         Yo3YMJPwBhwuu6V/bUf5a+DK/jZRVyudE5em8pXaz92JXIfp15cuuv7fRvQdpvOttuAU
         hkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xajd/k2gt2AWyDnLyY/AO4TDQLUBuztihD5Mc8Zw4LY=;
        b=GNU/YIsLu0F7UMzW7el0Z0ZFLhthRlxypWwpt0iFpN+wfEqojrHp7UvpCXquSTPvjD
         yBFkH1sHXM1j2fJw98i7trwRzsd0B2v6MDXt+kwqC9d9HnY6XJHlOxsL/JW4UBmdetQH
         5ixEZgXt6RIAuV0IzPkYGVfPGwI05XcDvSrNMylyi6eJ4qGmBytwn2nTd6K+IxNW310I
         fgbpMIIb6+hn8bCbRhIZ2aVxuI2wXxg+xxG3E0vT69RcmLehn5jLjBEDLzXyOfq30hMG
         jZ9u/8zk40FV8h2FMq5ZnVvV6GPqQyLvk765NfQbdMLZMRmqbr58PAPrJCCxe6W09V73
         uPDA==
X-Gm-Message-State: APjAAAWVfxCkcAN+6N3q8FNVjSwL1YSk28FiuvbCIlyI8CpZqGT7EbbA
        wgbjc0/y5bwNIMUodmL9rV5P52QPhVk=
X-Google-Smtp-Source: APXvYqy9NLic55lASyMIY85+B+lQ1OjCWknehk/dmFVfpM4MYN73JlWt87c6/wD1FtJpl/gjOy5Bcg==
X-Received: by 2002:a50:8dcb:: with SMTP id s11mr106881027edh.144.1561455344282;
        Tue, 25 Jun 2019 02:35:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a3sm4467108edr.48.2019.06.25.02.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 02:35:43 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 601D61043B7; Tue, 25 Jun 2019 12:35:43 +0300 (+03)
Date:   Tue, 25 Jun 2019 12:35:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/4] mm: move mem_cgroup_uncharge out of
 __page_cache_release()
Message-ID: <20190625093543.qsl5l5hyjv6shvve@box>
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560376609-113689-3-git-send-email-yang.shi@linux.alibaba.com>
 <20190613113943.ahmqpezemdbwgyax@box>
 <2909ce59-86ba-ea0b-479f-756020fb32af@linux.alibaba.com>
 <df469474-9b1c-6052-6aaa-be4558f7bd86@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df469474-9b1c-6052-6aaa-be4558f7bd86@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:54:05AM -0700, Yang Shi wrote:
> 
> 
> On 6/13/19 10:13 AM, Yang Shi wrote:
> > 
> > 
> > On 6/13/19 4:39 AM, Kirill A. Shutemov wrote:
> > > On Thu, Jun 13, 2019 at 05:56:47AM +0800, Yang Shi wrote:
> > > > The later patch would make THP deferred split shrinker memcg aware, but
> > > > it needs page->mem_cgroup information in THP destructor, which
> > > > is called
> > > > after mem_cgroup_uncharge() now.
> > > > 
> > > > So, move mem_cgroup_uncharge() from __page_cache_release() to compound
> > > > page destructor, which is called by both THP and other compound pages
> > > > except HugeTLB.  And call it in __put_single_page() for single order
> > > > page.
> > > 
> > > If I read the patch correctly, it will change behaviour for pages with
> > > NULL_COMPOUND_DTOR. Have you considered it? Are you sure it will not
> > > break
> > > anything?
> > 
> 
> Hi Kirill,
> 
> Did this solve your concern? Any more comments on this series?

Everyting looks good now. You can use my

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

for the series.

-- 
 Kirill A. Shutemov
