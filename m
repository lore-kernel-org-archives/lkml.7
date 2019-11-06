Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D23C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE9821929
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R62sOVIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfKFS7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:59:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43391 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:59:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so17764229pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BIQCSfOYMfSPPWp0Qb5BWbcN1l6pkF5qUeQHWu3kjSE=;
        b=R62sOVIcL3prslkSy42HxlOARu8i7/2Zfnyl/1paXE2qy1aWqSqiDIF3qJ8rvcEs4B
         XAqe5jVmPG8JqVIcfyWdW+5VKOuXGc7Q3spA59TYK9xVzSDrJLgySp9W6DuhmxZvrFeY
         O1asfFdpTVIVoD668/42+ah/31+DCARaCD5n5BSrtUkEjwiSGg560wGcF4Ql3XkYln49
         6S8h4ExLgJxIZLy7+p/7mP9ISRFH077BsmLrVToWkDIanGLs9dqAWqQHtFE0vZabj5A6
         3HuvGPrzwfiU2ylZFXBga1/j/tHB5UOXGUoHyYc20oE+hEJjn0Hr9NyUvz7kTGh37vd5
         YRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BIQCSfOYMfSPPWp0Qb5BWbcN1l6pkF5qUeQHWu3kjSE=;
        b=hZRLf65u3oOrkpXJxmI9fep0sj1t5lA/nKhZ1WoxP+2ckcj7CjfjcydFJ8Kzkn5HOG
         TF8Nk5MVEGCk0XbQMiAo7JXfOC5txniFfcLAaPZ7riXKsqatj24mnpMIe94ezObDMKqx
         pxBPNL1zxiIfwLkPWNHZ5adpVftU1UjlvhDPHc31HlSBJIvJAcNpln1cDBlJkMAAclDJ
         aaUqhns9UFyzfCnhVhAy9SKD7U8YUXozSCdnkdoy0kg8HqBhpEObenrgloJsbXMKQvha
         ddXBVDhMeSN1sNr7EErLD7cefttrHmg5bCO5eIHsx9PMhqfexpxF4FqenoyxwdOTjQod
         y1ZQ==
X-Gm-Message-State: APjAAAXwzDZt8dFRburyg7OUAVbhy7aQYqlgIp5GoOJU6LaPRrYsg7y1
        cq/Cy3UjD8LMMQOra3+ujtUdbg==
X-Google-Smtp-Source: APXvYqxDwFakqvr//ZgK1/vU58b12jUvY1mNW38GapLOAve+COSgTcbDlmnEFlZg/cxi2ZAzxzzjGg==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr5936926pje.107.1573066774325;
        Wed, 06 Nov 2019 10:59:34 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id y4sm17514559pfn.97.2019.11.06.10.59.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Nov 2019 10:59:33 -0800 (PST)
Date:   Wed, 6 Nov 2019 10:59:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Michal Hocko <mhocko@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: shmem: use proper gfp flags for shmem_writepage()
In-Reply-To: <733100ea-97aa-db27-4b43-cf42317afaf8@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1911061039540.1357@eggly.anvils>
References: <1572991351-86061-1-git-send-email-yang.shi@linux.alibaba.com> <20191106151820.GB8138@dhcp22.suse.cz> <733100ea-97aa-db27-4b43-cf42317afaf8@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1214476646-1573066773=:1357"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1214476646-1573066773=:1357
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Nov 2019, Yang Shi wrote:
> On 11/6/19 7:18 AM, Michal Hocko wrote:
> > On Wed 06-11-19 06:02:31, Yang Shi wrote:
> > > The shmem_writepage() uses GFP_ATOMIC to allocate swap cache.
> > > GFP_ATOMIC used to mean __GFP_HIGH, but now it means __GFP_HIGH |
> > > __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM.  However, shmem_writepage() shou=
ld
> > > write out to swap only in response to memory pressure, so
> > > __GFP_KSWAPD_RECLAIM looks useless since the caller may be kswapd its=
elf
> > > or in direct reclaim already.
> > What kind of problem are you trying to fix here?
>=20
> I didn't run into any visible problem. I just happened to find this
> inconsistency when I was looking into the other problem.

Yes, I don't think it fixes any actual problem: just a cleanup to
make the two calls look the same when they don't need to be different
(whereas the call from __read_swap_cache_async() rightly uses a=20
lower priority gfp).

If it does fix a problem, then you need to worry also about the
=09 * TODO: this could cause a theoretical memory reclaim
=09 * deadlock in the swap out path.
comment still against the call in add_to_swap(): but I think that
is equally theoretical, demanding no attention since 2.6.12.

>=20
> The add_to_swap() does:
>=20
> int add_to_swap(struct page *page)
> {
> ...
> err =3D add_to_swap_cache(page, entry,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __GFP_HI=
GH|__GFP_NOMEMALLOC|__GFP_NOWARN);
> ...
> }
>=20
> Actually, shmem_writepage() does almost the same thing and both of them a=
re
> called in reclaim context, so I didn't see why they should use different =
gfp
> flag. And, GFP_ATOMIC is also different from the old definition as I
> mentioned in the commit log.
>=20
> >=20
> > > In addition, XArray node allocations from PF_MEMALLOC contexts could
> > > completely exhaust the page allocator, __GFP_NOMEMALLOC stops emergen=
cy
> > > reserves from being allocated.
> > I am not really familiar with XArray much, could you be more specific
> > please?
>=20
> It comes from the comments of add_to_swap(), says:
>=20
> /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * XArray node allocation=
s from PF_MEMALLOC contexts could
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * completely exhaust the=
 page allocator. __GFP_NOMEMALLOC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * stops emergency reserv=
es from being allocated.
>=20
> And, it looks the original comment came from pre-git time, TBH I'm not qu=
ite
> sure about the specific problem which incurred this. I suspect it may be
> because PF_MEMALLOC context allows ALLOC_NO_WATERMARK.
>=20
> >=20
> > > Here just copy the gfp flags used by add_to_swap().
> > >=20
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > > ---
> > >   mm/shmem.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 220be9f..9691dec 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1369,7 +1369,8 @@ static int shmem_writepage(struct page *page,
> > > struct writeback_control *wbc)
> > >   =09if (list_empty(&info->swaplist))
> > >   =09=09list_add(&info->swaplist, &shmem_swaplist);
> > >   -=09if (add_to_swap_cache(page, swap, GFP_ATOMIC) =3D=3D 0) {
> > > +=09if (add_to_swap_cache(page, swap,
> > > +=09=09=09__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) =3D=3D 0) {
> > >   =09=09spin_lock_irq(&info->lock);
> > >   =09=09shmem_recalc_inode(inode);
> > >   =09=09info->swapped++;
> > > --=20
> > > 1.8.3.1
--0-1214476646-1573066773=:1357--
