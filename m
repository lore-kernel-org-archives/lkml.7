Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC5C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D78921D79
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKwoMfpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfIIVjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 17:39:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45926 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfIIVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 17:39:45 -0400
Received: by mail-io1-f68.google.com with SMTP id f12so32458735iog.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9A2W1+/pDxGxYRPcaK1DCduelqs+osiN4mh03CF6afg=;
        b=JKwoMfpPDH1KZnGdzKvZxf1vzkwjCXbumdKbmZPQNRak4Swrz2KHspmWpXoCESTR3Q
         14F35cfLl0FjFJmWqdSmg9fdXXd9iEhxbRlg/s6Rx5qNPV0/l0kplBGPQfh/2nA4wAkI
         TJ0IKq2iz6DMMzQIfUYPcJzx6tD55/dPVNhazvHFq59H0gv4Cz/f2G2hRr+Sazi9p+Ju
         30NN1+daZfVKX7iUYCmRQ0pluFvCr056vM23LZ4amDGPNQttybMzcp6LmaZ8t+xyZlsx
         K78L8FIur8C/B7TF/GK9AsuGKlTWmQcHkG1W3HiFJTYQTrFFw+Iu/NzBXULGiM4Hy6PU
         Cfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9A2W1+/pDxGxYRPcaK1DCduelqs+osiN4mh03CF6afg=;
        b=OnYtdU6ty52L1pN92QrRgYP955GycNXYYmMnBbJMT32FXpEqhHKm01jpDwKj5w/3Qo
         jja9PhV3tc5bvmYFACfjaQXwnphomZd6YY4zBdn7e+QMmtHXqYe9fHHbxsVQKOtrQ9Ci
         sd9ehV+wl+qWRCinIKsxazuY7jMj5UYGTsciWlRP63mPVrXONJukCDJRuehSDO16CI+6
         4Pa5g++Iv+F7JVdGdquHuuo+Q1mz8LzjdtFWnLozjOHPUq7KsW2tY4Xyj+xGYKjDe+6j
         Is3bVpzAztipv0E48sCD/l3kRxrHy+fcJBRMpts8lMOz0teqs1eezErj8yhYw3P5SlLs
         C1Cg==
X-Gm-Message-State: APjAAAVOaoWwNb7UWK3AQMbEsqcn6sSoCJgTGwkWhvvOkSCUQvfknDiL
        rHjyjIIlP26VQPXzpgRY7yGiPQ==
X-Google-Smtp-Source: APXvYqy6X7NR4sCyX1rBAqURyIjElt77BPKru3gblZURd6J93B8RZyjnubodlWDMQY6ac/kwfSLHGw==
X-Received: by 2002:a02:aa84:: with SMTP id u4mr8262398jai.14.1568065182934;
        Mon, 09 Sep 2019 14:39:42 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id x26sm11702665iob.11.2019.09.09.14.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 14:39:42 -0700 (PDT)
Date:   Mon, 9 Sep 2019 15:39:38 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid slub allocation while holding list_lock
Message-ID: <20190909213938.GA53078@google.com>
References: <20190909061016.173927-1-yuzhao@google.com>
 <20190909160052.cxpfdmnrqucsilz2@box>
 <e5e25aa3-651d-92b4-ac82-c5011c66a7cb@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e25aa3-651d-92b4-ac82-c5011c66a7cb@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:57:22AM +0900, Tetsuo Handa wrote:
> On 2019/09/10 1:00, Kirill A. Shutemov wrote:
> > On Mon, Sep 09, 2019 at 12:10:16AM -0600, Yu Zhao wrote:
> >> If we are already under list_lock, don't call kmalloc(). Otherwise we
> >> will run into deadlock because kmalloc() also tries to grab the same
> >> lock.
> >>
> >> Instead, allocate pages directly. Given currently page->objects has
> >> 15 bits, we only need 1 page. We may waste some memory but we only do
> >> so when slub debug is on.
> >>
> >>   WARNING: possible recursive locking detected
> >>   --------------------------------------------
> >>   mount-encrypted/4921 is trying to acquire lock:
> >>   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
> >>
> >>   but task is already holding lock:
> >>   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
> >>
> >>   other info that might help us debug this:
> >>    Possible unsafe locking scenario:
> >>
> >>          CPU0
> >>          ----
> >>     lock(&(&n->list_lock)->rlock);
> >>     lock(&(&n->list_lock)->rlock);
> >>
> >>    *** DEADLOCK ***
> >>
> >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> > 
> > Looks sane to me:
> > 
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> 
> Really?
> 
> Since page->objects is handled as bitmap, alignment should be BITS_PER_LONG
> than BITS_PER_BYTE (though in this particular case, get_order() would
> implicitly align BITS_PER_BYTE * PAGE_SIZE). But get_order(0) is an
> undefined behavior.

I think we can safely assume PAGE_SIZE is unsigned long aligned and
page->objects is non-zero. But if you don't feel comfortable with these
assumptions, I'd be happy to ensure them explicitly.
