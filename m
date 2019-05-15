Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7209C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E4A20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsFn1bjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfEOPY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:24:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44548 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfEOPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:24:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id n134so109061lfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bp9aZsP8Ihx3GbkK6sVw6F2oBHeQXKwNHmb8Yt9P0/A=;
        b=HsFn1bjMaUtH6jvwg7mjfmu3U0DtRpt953VIQJ/7/ad6c9WQN+io5di4dRZeS3BqEw
         FWsU1kKWqXgIihVIEKSV7Hp/aaja3i7d8aZ8iDK54Z+r5FpWx4wyfrDKdwtYpvEJIu4L
         mdmp2wGGaavoRnMbme7zB+9eHN0sYwRGd9mRYzfjKXIyyCUN/h9L0EuNU/gSc9eb09Or
         nHex62htpbDf4uSd+yEkV43l5gnYDOiq2MDu1p2vBx8x9Hjx7TOGyw0RPzGK35u9P1rQ
         7EAF52IqiycKQnEMUepkhO1xjmpVgdn6Dq2OoBNX4jLorYOnyC3tXJHdyquK3EbQ9gFg
         rUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bp9aZsP8Ihx3GbkK6sVw6F2oBHeQXKwNHmb8Yt9P0/A=;
        b=X24Sz2uDk1dCFnXYQEk2oM4nX2WvJOeP/b7zpfVLyLLn3jQzuLLC3yrnu/reiKeTXX
         jWuZuniHvCriosUM2PkCgyMgmjZaonb0tqKuREtvGMZH3mbEWxf0S+Fpkk4msiMSnLrK
         rEgf0IdPnb/M6yQEiRmjrD0RyAl8g+x+Fld2TQvyi2E8qt21wzJPQM4mkpSwxojOQnbk
         FBS+hB5pe1d6+mfMImVZWjVz+HrBK6NdLCrunM2Qj+9IOSh6z9kbXxzXP0FCX/KCeXQp
         rzJwFV9iuWaj1Tjsgt2Czpb2sMQjVepa8nWhFZBLdOQAQEKj7qeqPgrjkk9guNab+obV
         2S7A==
X-Gm-Message-State: APjAAAW/vGOPcW2XPhtp5Vm7PLE1QgCA+usUFRtFT0DROHDb49RYMJH3
        a2R2auHO5qzge0PkZYqwK5s=
X-Google-Smtp-Source: APXvYqwY1WTXGYR3o8YWyC3tnZWmG25a3r9RgDDvY4fSzidz1fEOKxmhCfonNsCioDkWtFA/gCSy9Q==
X-Received: by 2002:a19:5513:: with SMTP id n19mr7074764lfe.21.1557933864947;
        Wed, 15 May 2019 08:24:24 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h24sm398640ljk.10.2019.05.15.08.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 08:24:24 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 May 2019 17:24:15 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 1/3] mm/vmap: keep track of free blocks for vmap
 allocation
Message-ID: <20190515152415.lcbnqvcjppype7i5@pc636>
References: <20190406183508.25273-1-urezki@gmail.com>
 <20190406183508.25273-2-urezki@gmail.com>
 <20190514141942.23271725e5d1b8477a44f102@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514141942.23271725e5d1b8477a44f102@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

> An earlier version of this patch was accused of crashing the kernel:
> 
> https://lists.01.org/pipermail/lkp/2019-April/010004.html
> 
> does the v4 series address this?
I tried before to narrow down that crash but i did not succeed, so
i have never seen that before on my test environment as well as
during running lkp-tests including trinity test case:

test-url: http://codemonkey.org.uk/projects/trinity/

But after analysis of the Call-trace and slob_alloc(): 

<snip>
[    0.395722] Call Trace:
[    0.395722]  slob_alloc+0x1c9/0x240
[    0.395722]  kmem_cache_alloc+0x70/0x80
[    0.395722]  acpi_ps_alloc_op+0xc0/0xca
[    0.395722]  acpi_ps_get_next_arg+0x3fa/0x6ed
<snip>

<snip>
    /* Attempt to alloc */
    prev = sp->lru.prev;
    b = slob_page_alloc(sp, size, align);
    if (!b)
        continue;

    /* Improve fragment distribution and reduce our average
     * search time by starting our next search here. (see
     * Knuth vol 1, sec 2.5, pg 449) */
    if (prev != slob_list->prev &&
            slob_list->next != prev->next)
        list_move_tail(slob_list, prev->next); <- Crash is here in __list_add_valid()
    break;
}
<snip>

i see that it tries to manipulate with "prev" node that may be removed
from the list by slob_page_alloc() earlier if whole page is used. I think
that crash has to be fixed by the below commit:

https://www.spinics.net/lists/mm-commits/msg137923.html

it was introduced into 5.1-rc3 kernel.

Why ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
was accused is probably because it uses "kmem cache allocations with struct alignment"
instead of kmalloc()/kzalloc(). Maybe because of bigger size requests
it became easier to trigger the BUG. But that is theory.

--
Vlad Rezki
