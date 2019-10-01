Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEA021A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nTBOO2eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfJAMby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:31:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33212 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJAMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:31:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so11761592edl.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+oZPiXvOUSLu8pkEA5SDtoDi+xBvTxdx9cy3tZSs02c=;
        b=nTBOO2ehdswnIRiiaQ7rY4WuMupCCDuJZUaa9lgIqlkHHq6rj6LN5WT+neLB3y4ilS
         odNR6OoL6dhvcBF0a16atyWyRg3Ceeomj11YLqBQ9fEXVNQyGW2o7jlREYG2fygUTM/p
         TbJpRxd3UDh7wrj4mzpSpkmQmu4WGgqCTPRCMYynH9xZmn/v5PQrpdGz0A27I4USKStW
         thUynNxVUidvltlv0o9dywQM72PH2f+40HPaKKVstOm6NR5Hmv3VM/WVtlbnyVRKo1oj
         07AotumHD5wx816uU5v2DHRq8pjHmueBMIyTURDXd01roAJtUqucW1g2llsZcbT9UnoI
         17eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+oZPiXvOUSLu8pkEA5SDtoDi+xBvTxdx9cy3tZSs02c=;
        b=L85oHQP/i2W2lXdjK5XYAiQpPdTHEYAlbWwF/stplwNWHdweOTAtkIsCG1oxXrLyO2
         J/y/+Xrcy9G9vZF15G7ZfTtgtvjRrHr3WR8s0DrH4SRE5pHeK2UntL1dJd1yteRkTzAa
         KOYwdVe6JV/IwT0tSENxe/QYx0ayMBWPKrlGZVZMQFjopr1m0EUNNcap9rqc4LVo/YZk
         GtNV2fivz5dakP44V/aFV5QC/CYHPFP5pNLS1ITZ8bGCKBdQdLavt90lgePgl92lfaTy
         yBI037KsHLjQWhlyaayXcmnsdRNsNkfKj0qR17tjOBDwhKhdfM29SOY9aPuHJM6ZRUTa
         SSgQ==
X-Gm-Message-State: APjAAAUApUCPI8BEee480fnah/gSd3UO/fFiWtWaNhEDwHEnhtrEYck1
        VqvDtCTxqFAwMmirrQ+PhHc7ZQ==
X-Google-Smtp-Source: APXvYqypWkwrGVpNNaehcIUoKO0hW2eDDQ90dumJqHMiwm0z5DHfLIqGRB3hKyoRBwr+sf9nN0spzQ==
X-Received: by 2002:a17:907:20c4:: with SMTP id qq4mr24003067ejb.161.1569933111868;
        Tue, 01 Oct 2019 05:31:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id ot24sm1833844ejb.59.2019.10.01.05.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 05:31:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BCA03102FB8; Tue,  1 Oct 2019 15:31:51 +0300 (+03)
Date:   Tue, 1 Oct 2019 15:31:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace from
 debug_pagealloc
Message-ID: <20191001123151.qmv4ist3enq65uha@box>
References: <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
 <731C4866-DF28-4C96-8EEE-5F22359501FE@lca.pw>
 <218f6fa7-a91e-4630-12ea-52abb6762d55@suse.cz>
 <20191001115114.gnala74q3ydreuii@box>
 <1569932788.5576.247.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569932788.5576.247.camel@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 08:26:28AM -0400, Qian Cai wrote:
> On Tue, 2019-10-01 at 14:51 +0300, Kirill A. Shutemov wrote:
> > On Tue, Oct 01, 2019 at 10:07:44AM +0200, Vlastimil Babka wrote:
> > > On 10/1/19 1:49 AM, Qian Cai wrote:
> > > > 
> > > > 
> > > > > On Sep 30, 2019, at 5:43 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > > 
> > > > > Well, my use case is shipping production kernels with CONFIG_PAGE_OWNER
> > > > > and CONFIG_DEBUG_PAGEALLOC enabled, and instructing users to boot-time
> > > > > enable only for troubleshooting a crash or memory leak, without a need
> > > > > to install a debug kernel. Things like static keys and page_ext
> > > > > allocations makes this possible without CPU and memory overhead when not
> > > > > boot-time enabled. I don't know too much about KASAN internals, but I
> > > > > assume it's not possible to use it that way on production kernels yet?
> > > > 
> > > > In that case, why can’t users just simply enable page_owner=on and
> > > > debug_pagealloc=on for troubleshooting? The later makes the kernel
> > > > slower, but I am not sure if it is worth optimization by adding a new
> > > > parameter. There have already been quite a few MM-related kernel
> > > > parameters that could tidy up a bit in the future.
> > > 
> > > They can do that and it was intention, yes. The extra parameter was
> > > requested by Kirill, so I'll defer the answer to him :)
> > 
> > DEBUG_PAGEALLOC is much more intrusive debug option. Not all architectures
> > support it in an efficient way. Some require hibernation.
> > 
> > I don't see a reason to tie these two option together.
> 
> Make sense. How about page_owner=on will have page_owner_free=on by default?
> That way we don't need the extra parameter.

It's 0.1% of system memory. Does it matter for a debug option? I don't know.

-- 
 Kirill A. Shutemov
