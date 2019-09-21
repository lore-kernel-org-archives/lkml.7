Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA1C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A842086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YRLwwaS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407722AbfIUQAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 12:00:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407710AbfIUQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 12:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BAoSG7fLK5HP9+dUCxFgXfWJ4nlU3nJsgbTBl8j3hLg=; b=YRLwwaS3U+t+MgM7paZ0WNocC
        lyp8QoiGrD28Ur6fGeQEGCgQDykn47KhE0hJ8ouYP/K3oOTlPTq5XKfVv0mPs9W/WGm00VrZ5kkkx
        1GY8NykZ2rUKfTOwy34XC005U/NtXq0Pu2g12xTZJy20cb6stFmpFVk/pNos7ACy4Hhh5o6EByVbw
        xxZ6YfXeD28897vsfPSiiwvtPiYMzpYDZZOXpqxOKVtYvR98HLTrKzSVX7onREbguaqgR/2JGPQH+
        iORi8ZAfrVUmtIP7KQt6Z/J2E5XDvpuuoKQBd29RVgQf6iv9iW7ZIIf9A+glf9KgrnLeU+CSA7qLh
        74NSikOeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBho2-0000xH-73; Sat, 21 Sep 2019 16:00:18 +0000
Date:   Sat, 21 Sep 2019 09:00:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm: slub: print_hex_dump() with DUMP_PREFIX_OFFSET
Message-ID: <20190921160018.GF15392@bombadil.infradead.org>
References: <20190920104849.32504-1-miles.chen@mediatek.com>
 <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 02:08:59AM -0700, David Rientjes wrote:
> On Fri, 20 Sep 2019, Miles Chen wrote:
> 
> > Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> > The use DUMP_PREFIX_OFFSET instead of DUMP_PREFIX_ADDRESS with
> > print_hex_dump() can generate more useful messages.
> > 
> > In the following example, it's easier get the offset of incorrect poison
> > value with DUMP_PREFIX_OFFSET.
> > 
> > Before:
> > Object 00000000e817b73b: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000816f4601: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000169d2bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000f4c38716: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000917e3491: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000c0e33738: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 000000001755ddd1: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > 
> > After:
> > Object 00000000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000010: 63 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
> 
> I agree it looks nicer for poisoning, I'm not sure that every caller of 
> print_section() is the same, however.  For example trace() seems better 
> off as DUMP_PREFIX_ADDRESS since it already specifies the address of the 
> object being allocated or freed and offset here wouldn't really be useful, 
> no?

While it looks nicer, it might be less useful for debugging.  The point of
obfuscated %p is that you can compare two "pointer" values for equality.
So if you know that you freed object 00000000e817b73b from an earlier
printk, then you can match it up to this dump.  It's obviously not
perfect since we're only getting the pointers at addresses that are
multiples of 16, but it's a help.
