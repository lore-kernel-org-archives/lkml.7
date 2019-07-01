Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0F4C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959CF21721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XShNbisf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfGAKLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:11:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43238 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfGAKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:11:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so8358701lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7LB99b1qzJUqx9SmCRa+EsWNHIydh4ATXZtXVbwfnQ=;
        b=XShNbisfpbRo+ipmO1lFLAt44cpIs6OV3XEjkyB4LWB5d9CXKYMgR/cfL/ZbGzB2D3
         5NY4e4L+juq3egHqXrmn6gkO9p0s6EEhbd+f4M0l3pTspJmfyPyC2CV5q44g8NBpSLT/
         mkHl1KFrzH+nDkpKXxBbrMF5dtyXsFff9heHYAnRqcQN8LynZ2yOjDJYcPDINxra0sbf
         M9hF8n3Ja7XFK0qsbKKBSZMszK7fZQv2pM3Eoq/6tt8oUsxgteUa8iQ3VCHHUgqiUZOt
         YlhWOza1dIMag9/ajlN+Ioo3gAbP8JalhGidMIPsvUUW3yoVZAkUwJll1tbCqxNWjfKc
         KE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7LB99b1qzJUqx9SmCRa+EsWNHIydh4ATXZtXVbwfnQ=;
        b=MGowK8JKAArwda07F0tunNq3v7JmzG2yyiIRr6O7CsY642BL/xHGq6tveFx3Gzm+In
         BC91MdbmdQ9p6pi3t26T6ZRZLDYUBDMgeHZvdj5fkGpndnY8aglx1HbEwIxQSEG/JnXd
         ERLRwriXfRU/2i1/5vAcXmhObeSqscpWJ3kZ8khld5z4CUMheNOf2CqxzJotXMBPfiyw
         POjDEnAi6ODBcGN084Mw962hDAcp3VK0LC13e/Kxv5q0HQ26/gq+i7/8b4gw47HrAckW
         ThKMrcGfsJ65aEqhUcIakENzesgfTIlj7vTSpZb/AEq6M79VBkXmWjt6zPipruAKyvws
         1dZA==
X-Gm-Message-State: APjAAAXp0GwFoPW/vbs9o1Dh+Ecq+tAY93lXHZ7wcBqgVcDwnMMQs6+p
        ELwdhnVl3DV9NIyktm8x7fM=
X-Google-Smtp-Source: APXvYqxGMSKGWwcnh0QtFlSYyKGfsaUplzIpRiz8atO/XLiTZSSU6i+tSZ6IyKASWltGYakGfSYNBg==
X-Received: by 2002:ac2:5e9b:: with SMTP id b27mr10418308lfq.45.1561975891456;
        Mon, 01 Jul 2019 03:11:31 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id j7sm3536968lji.27.2019.07.01.03.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 03:11:30 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 1 Jul 2019 12:11:21 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org,
        peterz@infradead.org, urezki@gmail.com, rpenyaev@suse.de,
        guro@fb.com, aryabinin@virtuozzo.com, rppt@linux.ibm.com,
        mingo@kernel.org, rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm/vmalloc.c: improve readability and rewrite
 vmap_area
Message-ID: <20190701101121.kyg65fbcd7reszk7@pc636>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
 <20190701092037.GL6376@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701092037.GL6376@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:20:37AM +0200, Michal Hocko wrote:
> On Sun 30-06-19 15:56:45, Pengfei Li wrote:
> > Hi,
> > 
> > This series of patches is to reduce the size of struct vmap_area.
> > 
> > Since the members of struct vmap_area are not being used at the same time,
> > it is possible to reduce its size by placing several members that are not
> > used at the same time in a union.
> > 
> > The first 4 patches did some preparatory work for this and improved
> > readability.
> > 
> > The fifth patch is the main patch, it did the work of rewriting vmap_area.
> > 
> > More details can be obtained from the commit message.
> 
> None of the commit messages talk about the motivation. Why do we want to
> add quite some code to achieve this? How much do we save? This all
> should be a part of the cover letter.
> 
> > Thanks,
> > 
> > Pengfei
> > 
> > Pengfei Li (5):
> >   mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
> >   mm/vmalloc.c: Introduce a wrapper function of
> >     insert_vmap_area_augment()
> >   mm/vmalloc.c: Rename function __find_vmap_area() for readability
> >   mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
> >   mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
> > 
> >  include/linux/vmalloc.h |  28 +++++---
> >  mm/vmalloc.c            | 144 +++++++++++++++++++++++++++-------------
> >  2 files changed, 117 insertions(+), 55 deletions(-)
> > 
> > -- 
> > 2.21.0

> > Pengfei Li (5):
> >   mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
> >   mm/vmalloc.c: Introduce a wrapper function of
> >     insert_vmap_area_augment()
> >   mm/vmalloc.c: Rename function __find_vmap_area() for readability
> >   mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
> >   mm/vmalloc.c: Rewrite struct vmap_area to reduce its size
Fitting vmap_area to 1 cacheline boundary makes sense to me. I was thinking about
that and i have patches in my pipeline to send out but implementation is different.

I had a look at all 5 patches. What you are doing is reasonable to me, i mean when
it comes to the idea of reducing the size to L1 cache line. 

I have a concern about implementation and all logic around when we can use va_start
and when it is something else. It is not optimal at least to me, from performance point
of view and complexity. All hot paths and tree traversal are affected by that.

For example running the vmalloc test driver against this series shows the following
delta:

<5.2.0-rc6+>
Summary: fix_size_alloc_test passed: loops: 1000000 avg: 969370 usec
Summary: full_fit_alloc_test passed: loops: 1000000 avg: 989619 usec
Summary: long_busy_list_alloc_test loops: 1000000 avg: 12895813 usec
<5.2.0-rc6+>

<this series>
Summary: fix_size_alloc_test passed: loops: 1000000 avg: 1098372 usec
Summary: full_fit_alloc_test passed: loops: 1000000 avg: 1167260 usec
Summary: long_busy_list_alloc_test passed: loops: 1000000 avg: 12934286 usec
<this series>

For example, the degrade in second test is ~15%.

--
Vlad Rezki
