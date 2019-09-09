Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084ADC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D2A2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="xUhNbtb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfIIQA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:00:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45827 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388386AbfIIQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:00:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id f19so13397323eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CFK1lbGHffDm6umuM9k3uT7cdf40jo8hdVkVwtcY2GY=;
        b=xUhNbtb86aVkAx3yfWip/bShT1PRDlmu68HwjTSCKcyChoYWBFNqtiTj5YLOV2fRw4
         DZFuTG9sDIyndJxyuR44cobnRO6ty5IQ8eTAx0v07Ss/uSEqyIFEt+X9QvMaYzI5qkxC
         NiZSua7Sf//B63lXA8gRAJexdeAHzk8Azpnhy9e/n9BXG/GfL6cfytmP2l46amtBg1td
         QA2PzGBw/D+tegK8OKSbMqntzXJpo5ca7S7yKauQEinx+bZ5lPT/300tIha6SJAHXTfN
         ZbbLwqe0MfWDdb7H19gfXghj7RoWSai5/QfrsGWtEYdTaOp7+dOx9ptJs87f6MraLnAg
         kcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CFK1lbGHffDm6umuM9k3uT7cdf40jo8hdVkVwtcY2GY=;
        b=eQ1AnCUtNhR3EpKpJ6W0JT0ylhSiXgfDPFCZ0oDnallr1f9KIaJrqOWBx5NtCZU4ib
         sYMtyUw6AabVTud7A/Zk4+V4KT/9mY3r2gWfxowXP9XfdYHS7nPHSWfs5RQ5NaYbTODm
         i4VbtT9eBwUvpzCpjOSSauu2uZEV6QA1vf+s+P/viiXoF3tlkvp/8EoZhBlY8+JgK/6Q
         Q2Vqv4MkQYYBTRILit8qU50BQDFBTPKwjaZ4LWCMhULaTOfJ6ffVaFfwgfdcOubX48xz
         SUhgV8DAsSHef427nZyLOB0LcxNXbebULSOPMhasazXGszJQOJtv/4p6JHiY+u6QcgRB
         fP3g==
X-Gm-Message-State: APjAAAUOOAHm/8irmO37IrG+p9t67of6R4RQsOTuvClqA3Tfj8HUXN5S
        MAzthY4I6uZMOES5y00LXIsQ2g==
X-Google-Smtp-Source: APXvYqx83SYfaQIZNNdqeTrgytehrdeUAFD5eiOanG1H+SCZAn2dIW5NEvmeLWTKygMcElxeZFvigA==
X-Received: by 2002:a17:906:c401:: with SMTP id u1mr20456482ejz.254.1568044854982;
        Mon, 09 Sep 2019 09:00:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z26sm1802345ejb.51.2019.09.09.09.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 09:00:54 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E70B81003B5; Mon,  9 Sep 2019 19:00:52 +0300 (+03)
Date:   Mon, 9 Sep 2019 19:00:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid slub allocation while holding list_lock
Message-ID: <20190909160052.cxpfdmnrqucsilz2@box>
References: <20190909061016.173927-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909061016.173927-1-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 12:10:16AM -0600, Yu Zhao wrote:
> If we are already under list_lock, don't call kmalloc(). Otherwise we
> will run into deadlock because kmalloc() also tries to grab the same
> lock.
> 
> Instead, allocate pages directly. Given currently page->objects has
> 15 bits, we only need 1 page. We may waste some memory but we only do
> so when slub debug is on.
> 
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   mount-encrypted/4921 is trying to acquire lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
> 
>   but task is already holding lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
> 
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(&(&n->list_lock)->rlock);
>     lock(&(&n->list_lock)->rlock);
> 
>    *** DEADLOCK ***
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Looks sane to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
