Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F433C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AA320640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AKJTyjYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJALvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:51:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45116 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJALvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:51:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33so11587329edh.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WwRvxBteqT86BHeeOqI/ZRhly3cYrwnuA1zRjDpe2Bw=;
        b=AKJTyjYWQ780+va38hELwk915ZrVX8Czx4v0JlPi0ArAKGbq12iiBTtVn8Hs+PWnoq
         TbbW29cKSRm5TRz+w4UYwHAyU+dQdFpyPtRds27cBqVYl6tJ6rIA22iLwa7JxAqjHYoo
         fSD9o0w8n4C6dBV3VgVT7bvFGZxJ5FDNqjFRL8gBnrO61363iInKUw8Oi3c8ehTUqflr
         pAhZsEco5QURGIn+n2yxxNFrsKme9luUOgPC8N+o7u6CbuNQXtWzSOGV5Z9+TgPWxeph
         4Ji7DH0zSeBs+sg143ASUjgxS+hMHm+TOFlR/l82xeolHCLFEfOMRLccCPDPe/fW5Q3n
         UTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WwRvxBteqT86BHeeOqI/ZRhly3cYrwnuA1zRjDpe2Bw=;
        b=lKnVbVjh2dRXEBB/GyhZ02CGIuwxnNkHgVjosOZzTUShkZT58SNr7XtlrNX4qkIM2S
         OUp8MTP/O4KWoq9iOAjF1WtMQXUit5xjoHZU11GdZoCXvemG2rw0S58dZuL7bwwIBrHH
         Y/Nm6cTb8AiIyBoZBEhwGM8QPfMlw2G9T5vZAPcqKVnfsOD1BW2FNLvEeOeIlHO/No7m
         SHoGHSPAJsCLtabZQub7//XZtnvANxi166zZH426JPK6lK5jxtvDMEa+8bzd8a4ZIfSI
         tco6VL7mxhQ5TQOy1W9xZyUVzsIZ6BYGs00IQhVqf4FO7P38iiShnmQX8iGXORx+JqMO
         Hntg==
X-Gm-Message-State: APjAAAXhGO2KagO+XAm1Df1I2FAliNET+4v0xIjIFBQ3HCftTMsavO5R
        mgOdBRs5DPEGYpmPO3+B33cHKA==
X-Google-Smtp-Source: APXvYqz+GamY3Ru0CdQT/sU/Q/oDdsj7Hh5ho70H8ToYhwfIqDdI2ZoB+7fverkSDvUFbvgRau2yEA==
X-Received: by 2002:a17:907:40bc:: with SMTP id nu20mr23547119ejb.309.1569930674891;
        Tue, 01 Oct 2019 04:51:14 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z24sm1818728ejr.83.2019.10.01.04.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:51:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A87D7102FB8; Tue,  1 Oct 2019 14:51:14 +0300 (+03)
Date:   Tue, 1 Oct 2019 14:51:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace from
 debug_pagealloc
Message-ID: <20191001115114.gnala74q3ydreuii@box>
References: <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
 <731C4866-DF28-4C96-8EEE-5F22359501FE@lca.pw>
 <218f6fa7-a91e-4630-12ea-52abb6762d55@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <218f6fa7-a91e-4630-12ea-52abb6762d55@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:07:44AM +0200, Vlastimil Babka wrote:
> On 10/1/19 1:49 AM, Qian Cai wrote:
> > 
> > 
> >> On Sep 30, 2019, at 5:43 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> Well, my use case is shipping production kernels with CONFIG_PAGE_OWNER
> >> and CONFIG_DEBUG_PAGEALLOC enabled, and instructing users to boot-time
> >> enable only for troubleshooting a crash or memory leak, without a need
> >> to install a debug kernel. Things like static keys and page_ext
> >> allocations makes this possible without CPU and memory overhead when not
> >> boot-time enabled. I don't know too much about KASAN internals, but I
> >> assume it's not possible to use it that way on production kernels yet?
> > 
> > In that case, why can’t users just simply enable page_owner=on and
> > debug_pagealloc=on for troubleshooting? The later makes the kernel
> > slower, but I am not sure if it is worth optimization by adding a new
> > parameter. There have already been quite a few MM-related kernel
> > parameters that could tidy up a bit in the future.
> 
> They can do that and it was intention, yes. The extra parameter was
> requested by Kirill, so I'll defer the answer to him :)

DEBUG_PAGEALLOC is much more intrusive debug option. Not all architectures
support it in an efficient way. Some require hibernation.

I don't see a reason to tie these two option together.

-- 
 Kirill A. Shutemov
