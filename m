Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC3C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91C205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ou1cPBP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfJAM0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:26:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39575 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJAM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:26:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so10958172qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9jiZXdMxIIkyZWDEljTg7/li1H7K2+Hf7E7i2HKYGc=;
        b=ou1cPBP9atvCZ8eFdUXv2lPlMctqRAA+W5PPLgdRZMpza7Ir7nvCVx5jy6W5STmezz
         ymrIIvsoPwxIBYC2tqVoaOVBWYO5lqzrQP4aRhqfa2yOpUXjlkIY5XsTPnEakhn6GGdm
         h7Bh7oeJJkzcRV4/zKtRE/BALBRs7t5Se6fBX+5ivuM8mYDf7vC/piminIc7KUH2LuHP
         G4hNXkYVXJKGGSrdu4H+fh7wYV/Vbt3JYgpzVGuOQp1BuuO2Y/9nX3jAyzE6J5/XmsKQ
         DP5mehMeXbeibx10PrT5YAfErkQz2GxsCd6P86UCEykSlgyHffM9HupWcc2AMH0yfWon
         WrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9jiZXdMxIIkyZWDEljTg7/li1H7K2+Hf7E7i2HKYGc=;
        b=Q4M+b6xJ/RNGkenHyS4KBtI14h7lYyWb9VmLRwJCjsWUXsxgzyTJkoUuGqMDxDp1GQ
         K8JXtIGm0PDQZTQSUNSBp5ar1HEq6B1ENGBeFv4UF2F5n4tIWxmHXY24ZY1eGTEUOAMn
         D5stHTTlbAUKeip/Zg7dxE/7tcJJwddST4XM5m2bZRkClofkA5a71RQil3QMdajFZ8p8
         0LZYRMSsrjeHorq2t9QHtP4bdM4wbYpXFPGrOYiHwd4CwG5IV/xdp2ODtMPOodhVCpbN
         rOTxy8fqLMvMklLWwK8H/JCC0+CjWYzrjPbyQ6XkHbzmmuT9L1kd7HhlQTfo9eOmvS2v
         /pyA==
X-Gm-Message-State: APjAAAXWxfmQ+HpdX7QAJ9zyqD/WdYKUTOLxiuwYjjJf/lJ2RBCU4+OT
        RVjhX+GgiqikMTqW44jKw8Oc6g==
X-Google-Smtp-Source: APXvYqykJpzpAMiKTTDl8UdnfFKBlbpKoN9nyd2Hna2WY+IXGQQpTm0QavLwq7y7hDtL3+CuxX3rEw==
X-Received: by 2002:a37:b184:: with SMTP id a126mr5748865qkf.105.1569932791327;
        Tue, 01 Oct 2019 05:26:31 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z5sm7042642qkl.101.2019.10.01.05.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 05:26:30 -0700 (PDT)
Message-ID: <1569932788.5576.247.camel@lca.pw>
Subject: Re: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace
 from debug_pagealloc
From:   Qian Cai <cai@lca.pw>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Date:   Tue, 01 Oct 2019 08:26:28 -0400
In-Reply-To: <20191001115114.gnala74q3ydreuii@box>
References: <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
         <731C4866-DF28-4C96-8EEE-5F22359501FE@lca.pw>
         <218f6fa7-a91e-4630-12ea-52abb6762d55@suse.cz>
         <20191001115114.gnala74q3ydreuii@box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 14:51 +0300, Kirill A. Shutemov wrote:
> On Tue, Oct 01, 2019 at 10:07:44AM +0200, Vlastimil Babka wrote:
> > On 10/1/19 1:49 AM, Qian Cai wrote:
> > > 
> > > 
> > > > On Sep 30, 2019, at 5:43 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > 
> > > > Well, my use case is shipping production kernels with CONFIG_PAGE_OWNER
> > > > and CONFIG_DEBUG_PAGEALLOC enabled, and instructing users to boot-time
> > > > enable only for troubleshooting a crash or memory leak, without a need
> > > > to install a debug kernel. Things like static keys and page_ext
> > > > allocations makes this possible without CPU and memory overhead when not
> > > > boot-time enabled. I don't know too much about KASAN internals, but I
> > > > assume it's not possible to use it that way on production kernels yet?
> > > 
> > > In that case, why can’t users just simply enable page_owner=on and
> > > debug_pagealloc=on for troubleshooting? The later makes the kernel
> > > slower, but I am not sure if it is worth optimization by adding a new
> > > parameter. There have already been quite a few MM-related kernel
> > > parameters that could tidy up a bit in the future.
> > 
> > They can do that and it was intention, yes. The extra parameter was
> > requested by Kirill, so I'll defer the answer to him :)
> 
> DEBUG_PAGEALLOC is much more intrusive debug option. Not all architectures
> support it in an efficient way. Some require hibernation.
> 
> I don't see a reason to tie these two option together.

Make sense. How about page_owner=on will have page_owner_free=on by default?
That way we don't need the extra parameter.
