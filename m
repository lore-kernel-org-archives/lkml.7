Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD1ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6116920842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lGp6SqYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfJANSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:18:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46879 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfJANSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:18:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so11111151qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjg5ezOc5p7km8S342IaUr3A38UGT2t2Rxceh2nlfUU=;
        b=lGp6SqYWxT9IFi+KGl1pHet+QbGKnv9h5fRA3tHQiPKK22pU5UvC0p7Tkp/LVSzNfB
         oh1GwarLvZcJfIFf6WzcDjApRPlIssJyX5fkvJ1K9zOPCv5gLlb6d4yOko9bEAKYxyny
         LUTciaMHBRbhSOJM0SLdXM82rrvJArFZnVVVzr+cywYp+Z7dud/o1KtefHReI/KLzX0X
         R+u2n/TS/gaiuZzcJy2anjMIQFf3IZ3m25aY6O0Fs6tbc+tlCzLm+XhcIQ1y1FDjZcg5
         bC7kfuyLqGzcpAfPFJrfP90cKr3almQWWlDHDEbn74QfhONlhED3nBcasTNfSxhcm+41
         ri0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjg5ezOc5p7km8S342IaUr3A38UGT2t2Rxceh2nlfUU=;
        b=fDX3sZ7eu8CEbkOyWNVghOWutcltyCMxQgv6eY41KWaVGpZygPNsMhIqi1WlRPFo1k
         +X7YSMSkccJfaUfkhmUtYZ1gQMABZOyAicHwlbVeGJMEHVW/wtAHEszt7G8/UBlIUTdx
         M4/52m4DJmBvWqTWPS/mNuTUjswcUHUdNQOM5Gc2riUh9ZuF95R9Du0OfYpQcXYG0pZx
         kfTHKa4pqqk1Wq8+D94o5qbf/SEObrwmgHqkEkaXPbbXbUgSv6Zb3UEF4BCFM0wfFM4x
         Vvo0PG1VNesuFp+7kRExDnyOu54UWiKCfDPRZHllGDCCANFdiqnwXShifoCNBqspQsHS
         gS8w==
X-Gm-Message-State: APjAAAUZWt+I10jK45AyiCw+EoX6JOtBOKJRZjds9jcAja/YvxZPDdbY
        pmItc/J4kCYZFSMrKAYDcYG7eA==
X-Google-Smtp-Source: APXvYqyNL9IyO0vyZzASB134qH8CPv466017882cxvJNuyos/hOCFC9v49BtrPBHXe4sgaMMLsantg==
X-Received: by 2002:a37:4286:: with SMTP id p128mr6108139qka.40.1569935893364;
        Tue, 01 Oct 2019 06:18:13 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a190sm8443634qkf.118.2019.10.01.06.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 06:18:12 -0700 (PDT)
Message-ID: <1569935890.5576.255.camel@lca.pw>
Subject: Re: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace
 from debug_pagealloc
From:   Qian Cai <cai@lca.pw>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Date:   Tue, 01 Oct 2019 09:18:10 -0400
In-Reply-To: <cb02d61c-eeb1-9875-185d-d3dd0e0b2424@suse.cz>
References: <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
         <731C4866-DF28-4C96-8EEE-5F22359501FE@lca.pw>
         <218f6fa7-a91e-4630-12ea-52abb6762d55@suse.cz>
         <20191001115114.gnala74q3ydreuii@box> <1569932788.5576.247.camel@lca.pw>
         <626cd04e-513c-a50b-6787-d79690964088@suse.cz>
         <cb02d61c-eeb1-9875-185d-d3dd0e0b2424@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 14:35 +0200, Vlastimil Babka wrote:
> On 10/1/19 2:32 PM, Vlastimil Babka wrote:
> > On 10/1/19 2:26 PM, Qian Cai wrote:
> > > On Tue, 2019-10-01 at 14:51 +0300, Kirill A. Shutemov wrote:
> > > > On Tue, Oct 01, 2019 at 10:07:44AM +0200, Vlastimil Babka wrote:
> > > > > On 10/1/19 1:49 AM, Qian Cai wrote:
> > > > 
> > > > DEBUG_PAGEALLOC is much more intrusive debug option. Not all architectures
> > > > support it in an efficient way. Some require hibernation.
> > > > 
> > > > I don't see a reason to tie these two option together.
> > > 
> > > Make sense. How about page_owner=on will have page_owner_free=on by default?
> > > That way we don't need the extra parameter.
> > 
> >  
> > There were others that didn't want that overhead (memory+cpu) always. So the
> > last version is as flexible as we can get, IMHO, before approaching bikeshed
> > territory. It's just another parameter.
> 
> Or suggest how to replace page_owner=on with something else (page_owner=full?)
> and I can change that. But I don't want to implement a variant where we store only
> the freeing stack, though.

I don't know why you think it is a variant. It sounds to me it is a natural
extension that belongs to page_owner=on that it could always store freeing stack
to help with debugging. Then, it could make implementation easier without all
those different  combinations you mentioned in the patch description that could
confuse anyone.

If someone complains about the overhead introduced to the existing page_owner=on
users, then I think we should have some number to prove that say how much
overhead there by storing freeing stack in page_owner=on, 10%, 50%?
