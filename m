Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04418C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69BE2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zIQhadd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437916AbfFLKLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:11:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45582 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437611AbfFLKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:11:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so22967788edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yBJOOYa+63AgBYj8hVQxRRZyU5YRkS/ufWkxMFtkQpw=;
        b=zIQhadd+m2T9tT/6mG1ziuNw3VMUalNu4Kz48WIlrtDQYzMP38mSSA9Jbqssq+cETX
         wj/ORIpO4Bj9LqPBqsJ5kAJ7SuygwJvhr4eGeF6cridQOyXQ1ETvJIT8hOAa6qbtkCfj
         XYkIDwzKSQbv+2LsM54cilOSMN0r9OIRCZy4N8EndEomyOavMVP/NXZ5/zYqZtME1xnW
         PuifSMFFGEujEnWkoe2tAlEvda/LQc8tVUFQ1LGnWYwUnRAaghvGuhr8xi5DhMkIlOhU
         TGeZz76wqc4IKqwqewFUwuYP6rd9OErqQ+4/OI8x6xWu8zJfmcT8HrjtRen9Z3EyE7u0
         J0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yBJOOYa+63AgBYj8hVQxRRZyU5YRkS/ufWkxMFtkQpw=;
        b=ZATS+wMpaWN4syXmswtMe+wImyjRqqiJElmPW9BWYWJ12ve8jnTeD0q8FJdykoR3Td
         6y3DI0PxZ63cbOIdMqIX9UXGnTDw79hSxGC7ImPKo8zYYOvh5fkb1W5je6TvaWB5gO5D
         3Y6biCLx2jkw8YpoPhh2swEuY0Rs1q1UmNl2gF/YCf185q9Fzsd4b15+WwUwEzo7+fh7
         VzzlSSRqEwOgClrZONYfmLIBhh7A+LBe1PpyfXucIWstqYMr49CQV0n8+9chpNa6yWF/
         Ium5EI6sWRBzi84Ssm2pNz8H8DCw2IRuLWzSN7A4W+PkalXMumE3ZkAwXvdpM0JgsI+I
         sjRw==
X-Gm-Message-State: APjAAAWyQDYV9Z3PN9vzGhd7vLM1aIK2mByiOl5aUdBJRRduN09WBDjI
        dH6yDeHO1fwi1Soaxmy3FdQpGw==
X-Google-Smtp-Source: APXvYqzRmP8bkDzJtJb53QwuVwjTPB6C7X3I5M9sEgDKVw9ul38KEs25tZVf2ubiErLjeWv2/fbQ1w==
X-Received: by 2002:a50:95ae:: with SMTP id w43mr57909279eda.115.1560334264050;
        Wed, 12 Jun 2019 03:11:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j3sm4419416edh.82.2019.06.12.03.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 03:11:03 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4FD7F102306; Wed, 12 Jun 2019 13:11:04 +0300 (+03)
Date:   Wed, 12 Jun 2019 13:11:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: shrinker: make shrinker not depend on memcg kmem
Message-ID: <20190612101104.7rmjzmfy5owhqcif@box>
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559887659-23121-5-git-send-email-yang.shi@linux.alibaba.com>
 <20190612025257.7fv55qmx6p45hz7o@box>
 <a8f6f119-fd72-9a93-de99-fc7bea6404c0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f6f119-fd72-9a93-de99-fc7bea6404c0@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:07:54PM -0700, Yang Shi wrote:
> 
> 
> On 6/11/19 7:52 PM, Kirill A. Shutemov wrote:
> > On Fri, Jun 07, 2019 at 02:07:39PM +0800, Yang Shi wrote:
> > > Currently shrinker is just allocated and can work when memcg kmem is
> > > enabled.  But, THP deferred split shrinker is not slab shrinker, it
> > > doesn't make too much sense to have such shrinker depend on memcg kmem.
> > > It should be able to reclaim THP even though memcg kmem is disabled.
> > > 
> > > Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker,
> > > i.e. THP deferred split shrinker.  When memcg kmem is disabled, just
> > > such shrinkers can be called in shrinking memcg slab.
> > Looks like it breaks bisectability. It has to be done before makeing
> > shrinker memcg-aware, hasn't it?
> 
> No, it doesn't break bisectability. But, THP shrinker just can be called
> with kmem charge enabled without this patch.

So, if kmem is disabled, it will not be called, right? Then it is
regression in my opinion. This patch has to go in before 2/4.

-- 
 Kirill A. Shutemov
