Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53915C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0B12171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WaAJIxvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404778AbfHICqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 22:46:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHICqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 22:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k9ysUCj8sFdxJhtdA1rA7e9UmHUPqdKijogVrakBrS8=; b=WaAJIxvxqLMJwq4r0MuB186tS
        eB35TdZihw8we7T+6rzfXNcdc1BFrSHTsICCgF9IYxPFMXnH51MOTuYcDuzIEQFJTMbpdZHz7kU4l
        1gXCVm3zmGNat8g+4gEFOmlEJuABJAdswqsBLhwukirmbwfQV0VJh1UOgKcKX0IHlCnqa9ftb3GN5
        anKRc6DAtdHrlXV80dZ8UTLKLtWWw6siF34Vuvs30NBWsAIUoDuZlJjPXL5Z3iyVaI9c8MyiBg6a+
        ZzMgnF9fEFZkYUNsrMbPcS0zzVnVA5rZwBUyx3/flkMtA4BlYIqbgSIAqMmX6Ch8YNSw7wcyQUOQo
        SWWUHUk+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvuvU-0008Bg-Kn; Fri, 09 Aug 2019 02:46:44 +0000
Date:   Thu, 8 Aug 2019 19:46:44 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     miles.chen@mediatek.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, "Tobin C . Harding" <me@tobin.cc>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v2] mm: slub: print kernel addresses in slub debug
 messages
Message-ID: <20190809024644.GL5482@bombadil.infradead.org>
References: <20190809010837.24166-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809010837.24166-1-miles.chen@mediatek.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 09:08:37AM +0800, miles.chen@mediatek.com wrote:
> Possible approaches are:
> 1. stop printing kernel addresses
> 2. print with %pK,
> 3. print with %px.

No.  The point of obscuring kernel addresses is that if the attacker manages to find a way to get the kernel to spit out some debug messages that we shouldn't
leak all this extra information.

> 4. do nothing

5. Find something more useful to print.

> INFO: Slab 0x(____ptrval____) objects=25 used=10 fp=0x(____ptrval____)

... you don't have any randomness on your platform?

> INFO: Object 0x(____ptrval____) @offset=1408 fp=0x(____ptrval____)
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb
> Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> ...
> FIX kmalloc-128: Object at 0x(____ptrval____) not freed

But if you have randomness, at least some of these "pointers" are valuable
because you can compare them against "pointers" printed by other parts
of the kernel.

> After this patch:
> 
> INFO: Slab 0xffffffbf00f57000 objects=25 used=23 fp=0xffffffc03d5c3500
> INFO: Object 0xffffffc03d5c3500 @offset=13568 fp=0xffffffc03d5c0800
> Redzone 00000000: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone 00000010: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone 00000020: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone 00000030: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone 00000040: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone 00000050: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone 00000060: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Redzone 00000070: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> Object 00000000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000040: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000050: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000060: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000070: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
> Redzone 00000000: bb bb bb bb bb bb bb bb
> Padding 00000000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Padding 00000010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Padding 00000020: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Padding 00000030: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> ...
> FIX kmalloc-128: Object at 0xffffffc03d5c3500 not freed

It looks prettier, but I'm not convinced it's more useful.  Unless your
platform lacks randomness ...
