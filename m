Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03202C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6029214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM7G97jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfIOVil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 17:38:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41280 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfIOVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:38:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so22507pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iqcLBM+n789oO9D4B4n7QIy38Iivlg6PKsWpya+em6A=;
        b=kM7G97jxdHw8YVzdyyaHeQYLaPoKqJFxCB3Og1jctbDSOqF/U5eyF/dDAAEnz3Qvko
         GsFj7yyGpriBpbxWDbnJRo74hVLWMnOl18nGYE23szfaWTnL3kxNgQck36BxjJGV014/
         lymowmIpR9a+tv/A3e4AUZTWHedab6fgqulHsbFrbgIp9qGqYLguBeMVuhTA55O2WOOp
         zEnqGaFwxCsorhzjcpzSYvhnhz8D7mjWFLWRcbHS4Yp60gT3HarRlTQsOtS0nGThnlrO
         cU0EM7d8QVy5dMVZ4sxegL9kl5iY3Wi/ZiGaU9dFDgofJuGG9W9+5WUQalziTFX183+Q
         9kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iqcLBM+n789oO9D4B4n7QIy38Iivlg6PKsWpya+em6A=;
        b=okdi4Ns10RwgEAEdbdS50iRe7iJYABpn4V4VGi4ZEy/QeOz/6ZqwXjQeiE90qYDq1a
         aUvN12mpGBQI6p9A9Lsg4ar9cTx89fgBip7jEIEh/YXxPxLEsgXIAv2YBJ89q8nR7Usk
         +znlsraY2NvRIrX3slCbfZ1tO6mEB6LgZoCyPB4fyKGq6VWoyks+RUp4gwJv+Zq0AvAp
         ws0xX9fZbvcEuYGHIENAvqyJhxdHQCqDUWLgFDx/OV+qQZEB53e6R9oq3m33vCD1DXJo
         oU6POYxQvbIMUC7DwK3KBgq80zlozmLZj3IQnZKQdRjbd3bWbMbsSZvvUC9A15HiAr2I
         gbNw==
X-Gm-Message-State: APjAAAWL9bfjmimERYWqFR4WJj87ofuKs7quSqXDe/qTIJrcSBYWNYTV
        qHXIoj4tDAIkB9/Dfj4y8gF0VQ==
X-Google-Smtp-Source: APXvYqxF3+647bKDGiEPA1W8sdT5qORaNLeswIi1yi2+um9DvosoquGyl+pjwddqV3Y3L0Ncl0v+6Q==
X-Received: by 2002:a17:90a:8006:: with SMTP id b6mr17107382pjn.4.1568583516601;
        Sun, 15 Sep 2019 14:38:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c128sm25937293pfc.166.2019.09.15.14.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 14:38:36 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:38:35 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
Subject: Re: [RESEND v4 5/7] mm, slab_common: Make kmalloc_caches[] start at
 size KMALLOC_MIN_SIZE
In-Reply-To: <20190915170809.10702-6-lpf.vector@gmail.com>
Message-ID: <alpine.DEB.2.21.1909151425490.211705@chino.kir.corp.google.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-6-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Pengfei Li wrote:

> Currently, kmalloc_cache[] is not sorted by size, kmalloc_cache[0]
> is kmalloc-96, kmalloc_cache[1] is kmalloc-192 (when ARCH_DMA_MINALIGN
> is not defined).
> 
> As suggested by Vlastimil Babka,
> 
> "Since you're doing these cleanups, have you considered reordering
> kmalloc_info, size_index, kmalloc_index() etc so that sizes 96 and 192
> are ordered naturally between 64, 128 and 256? That should remove
> various special casing such as in create_kmalloc_caches(). I can't
> guarantee it will be possible without breaking e.g. constant folding
> optimizations etc., but seems to me it should be feasible. (There are
> definitely more places to change than those I listed.)"
> 
> So this patch reordered kmalloc_info[], kmalloc_caches[], and modified
> kmalloc_index() and kmalloc_slab() accordingly.
> 
> As a result, there is no subtle judgment about size in
> create_kmalloc_caches(). And initialize kmalloc_cache[] from 0 instead
> of KMALLOC_SHIFT_LOW.
> 
> I used ./scripts/bloat-o-meter to measure the impact of this patch on
> performance. The results show that it brings some benefits.
> 
> Considering the size change of kmalloc_info[], the size of the code is
> actually about 641 bytes less.
> 

bloat-o-meter is reporting a net benefit of -241 bytes for this, so not 
sure about relevancy of the difference for only kmalloc_info.

This, to me, looks like increased complexity for the statically allocated 
arrays vs the runtime complexity when initializing the caches themselves.  
Not sure that this is an improvement given that you still need to do 
things like

+#if KMALLOC_SIZE_96_EXIST == 1
+	if (size > 64 && size <= 96) return (7 - KMALLOC_IDX_ADJ_0);
+#endif
+
+#if KMALLOC_SIZE_192_EXIST == 1
+	if (size > 128 && size <= 192) return (8 - KMALLOC_IDX_ADJ_1);
+#endif
