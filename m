Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04E0C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905292173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK6QowY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfDQM0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:26:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38950 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfDQM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:26:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so20792323edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3b2uZe+gBUttgntQPw/pLBUTjB9i8teUhwUDcx5nvkU=;
        b=KK6QowY/D/XJnf34A9ek6IxXn6rQC/5Kq9psSCHLgXaFoDYONhAxg7uNNIS3wIeseQ
         dernRPR92l9iqju3XdqqdFaOvjahmacxMyrtT8stUEqcJOIBMNOcxO80y2Ze2hqITnqT
         ZD+Q7LnT5ovRNk24Cuaq0BKEaMrx8qnTqwPYm0ejr6FzX2bHTsoS+qMldVJ3n/wKugVX
         H/aXvxrJF90ZD1xcFEeaI9rSano/K/P7kbB6LIicMTQf7D1UnMyFYQHKT0LSOyo/rnDz
         P/v2yxpVYnFjQQJSwspEOytvbCU5af/7wEV4SY5QA/w+6h/7Hir7GSaWdrlmPh0AEX8k
         idvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3b2uZe+gBUttgntQPw/pLBUTjB9i8teUhwUDcx5nvkU=;
        b=KpFxwZ5Y1o1vLOG4jcHXacYVcdZGeRZJFaGLhxb+UaJlrAeUyYQGbPWrMSEs7fCSCy
         A0YNKQ7ABjgRSf8gYV1qG7RZqAidL113jtTeDpSwyMO7wMUx3OOS1D5jATV7vg2+oeBa
         p9hmaD9bBa4jtqhAuBkGLxZzICfoTC73riGSkJJ6blGJ1WP2bGFAG4hi/z4o9dJSdpFO
         0ToWX52hmIlBvPhf3KReDP+CENAgy5Z1Ai4NsYLCHvjjtVJlAh6bDXd24GNKXIIlodNe
         JQk3YohzUhI7hS6BOcOZhtfAnqHv0aQBf1BnU+5In5zaqD1UdmtKyXmqVB9NQIvstVOh
         8V3Q==
X-Gm-Message-State: APjAAAUbZlMjq8Tr3S80FZLPuSV9+w4doM5gQiNbyCTSxg2l1K7zPeb7
        1jv5v5+t1GaMPC84B8XdjAgrCcJK3+bZwhOzDFs=
X-Google-Smtp-Source: APXvYqx0Wip+oc7EhgVnQowF25cIy00yB1LazPefnMEy3YkhKtVYai8VkPbsXXR6VZH7ei3AgU3Uvmxd+7WGlxnPcCg=
X-Received: by 2002:a17:906:1119:: with SMTP id h25mr26182051eja.233.1555503993060;
 Wed, 17 Apr 2019 05:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <1555487246-15764-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznFCy-Fm1WObEk77shPGALWhn5dWS3ZLXY77+q_4Yp6bAQ@mail.gmail.com>
 <CAGWkznEzRB2RPQEK5+4EYB73UYGMRbNNmMH-FyQqT2_en_q1+g@mail.gmail.com>
 <20190417110615.GC5878@dhcp22.suse.cz> <CAGWkznH6MjCkKeAO_1jJ07Ze2E3KHem0aNZ_Vwf080Yg-4Ujbw@mail.gmail.com>
 <20190417114621.GF5878@dhcp22.suse.cz>
In-Reply-To: <20190417114621.GF5878@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 17 Apr 2019 20:26:22 +0800
Message-ID: <CAGWkznHgc68AHOs2WNPARmwMMKazuKXL1R4VsPD_jwtzQeVK_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/workingset : judge file page activity via timestamp
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

repost the feedback by under Johannes's comment
When something like a higher-order allocation drops a large number of
file pages, it's *intentional* that the pages that were evicted before
them become less valuable and less likely to be activated on refault.
There is a finite amount of in-memory LRU space and the pages that
have been evicted the most recently have precedence because they have
the highest proven access frequency.
[HZY]: Yes. I do agree with you about the original thought of
sacrificing long distance access pages when huge memory demands arise.
The problem is what is the criteria of selecting the page, which you
can find from what I comment in the patch, that is, some pages have
long refault_distance while having a very short access time in
between.

Of course, when a large amount of the cache that was pushed out in
between is not re-used again, and don't claim their space in memory,
it would be great if we could then activate the older pages that *are*
re-used again in their stead.But that would require us being able to
look into the future. When an old page refaults, we don't know if a
younger page is still going to refault with a shorter refault distance
or not. If it won't, then we were right to activate it. If it will
refault, then we put something on the active list whose reuse
frequency is too low to be able to fit into memory, and we thrash the
hottest pages in the system.
[HZY]: We do NOT use the absolute timestamp when page refaulting to
indicate young or old of the page and thus to decide the position of
LRU. The criteria which i use is to comparing the "time duration of
the page's out of cache" and "the active files shrinking time by
dividing average refault ratio". I inherite the concept of deeming
ACTIVE file as deficit of INACTIVE files, but use time to avoid the
scenario as suggested in patch's [1].

As Matthew says, you are fairly randomly making refault activations
more aggressive (especially with that timestamp unpacking bug), and
while that expectedly boosts workload transition / startup, it comes
at the cost of disrupting stable states because you can flood a very
active in-ram workingset with completely cold cache pages simply
because they refault uniformly wrt each other.
[HZY]: I analysis the log got from trace_printk, what we activate have
proven record of long refault distance but very short refault time.

On Wed, Apr 17, 2019 at 7:46 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 17-04-19 19:36:21, Zhaoyang Huang wrote:
> > sorry for the confusion. What I mean is the basic idea doesn't change
> > as replacing the refault criteria from refault_distance to timestamp.
> > But the detailed implementation changed a lot, including fix bugs,
> > update the way of packing the timestamp, 32bit/64bit differentiation
> > etc. So it makes sense for starting a new context.
>
> Not really. My take away from the previous discussion is that Johannes
> has questioned the timestamping approach itself. I wasn't following very
> closely so I might be wrong here but if that is really the case then it
> doesn't make much sense to improve the implementation if there is no
> consensus on the approach itself.
>
> --
> Michal Hocko
> SUSE Labs
