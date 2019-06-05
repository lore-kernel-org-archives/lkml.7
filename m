Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D715C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40C52083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3SHbq+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFETv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:51:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41907 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:51:26 -0400
Received: by mail-yb1-f194.google.com with SMTP id d2so26117ybh.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADSrVTY729P8giks2VI3lL/ewrVA0y+ziy53/CJHjbI=;
        b=l3SHbq+tQMcR8JiOwkKI+rqmX8UZZye9PTtYe2D5QDQJbkEw4tn4YzYjfj1Avcsc8J
         cRSil6+QYDOrKQcFibXBl8KHBvqgfc+1gWOKhOe5AQUjTBRcaA3c9aZHM9gXxsy42Uaj
         XaKe/llBw2BCOk7t9sYKNJWXw59+a0I7dELeuw9kQpYWeGkMxRiRyXAcTSC6Y+L4A1hI
         8NfTciR75XJzP+w3pQnIvURLV7LJhtCB6aKw4xvZuKpyq0I/nCGRAMJWlVW7ec6CpZJy
         ACUbqKujEVikDTF5Sng3n0OT3pwVrcF9Was5/ZEXf62lg8i+p7yOdy49gg/QBSLKQy/T
         wMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADSrVTY729P8giks2VI3lL/ewrVA0y+ziy53/CJHjbI=;
        b=prA1aXO7JT9yWOAkxSA4lTVJPrBH29RkF49SFlY+2Tn+b/jkS5g0kUI0es3LXWNhbc
         1YFKLJH76SaefETwFxSjkAtyWh00u8EycwZ8J4H1qp7KSCUi6/ub8aFKjEvTzLQoG7sJ
         en9uPPkewzYXZ8vredc6n3oxbMgLbpfsJLTKhw6TnkVrHkoa7lOVOdNA++/0pkzYVm83
         hYQYJ+8kUdX++YDmquNwZBDuGQXZsmjvgCHuKlK77mBGX07QvYDr06IbYg7YjiY8fXjY
         JMeE/+2eBXDtnmYJH+gCAvF3qdXngow+8YhFImbefDjgZVBEtEnUe+4aFKDrSR2m3e0a
         Bnlg==
X-Gm-Message-State: APjAAAUsWenv/XRkfVK7+6jqIgc+HeXjyykz418UkNfYnSfHphIQNdQQ
        B61rlpH9g+hrGFkuXo79RDaeqCJzNnKDBWe5Ux2Gpg==
X-Google-Smtp-Source: APXvYqxszqUD/k5nU1g4wHGqDzn8YOE0ACTETUwVMD6KIg9ukVr7Jucv9S+W7J8xRSISnfIGsWcd/E7G53G2roOi1so=
X-Received: by 2002:a25:7c05:: with SMTP id x5mr19854493ybc.358.1559764285452;
 Wed, 05 Jun 2019 12:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190605024454.1393507-1-guro@fb.com> <20190605024454.1393507-2-guro@fb.com>
 <CALvZod4F4FqO27Y+msXrxT9yaDLLN7njmBsRoTkmQSPE_7=FtQ@mail.gmail.com> <20190605171355.GA10098@tower.DHCP.thefacebook.com>
In-Reply-To: <20190605171355.GA10098@tower.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 Jun 2019 12:51:14 -0700
Message-ID: <CALvZod6Cu+Uyy-Jp-er0Kz9dwLhmb5KO0XP3X55PVcSx4A4w3g@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] mm: add missing smp read barrier on getting
 memcg kmem_cache pointer
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 10:14 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jun 04, 2019 at 09:35:02PM -0700, Shakeel Butt wrote:
> > On Tue, Jun 4, 2019 at 7:45 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Johannes noticed that reading the memcg kmem_cache pointer in
> > > cache_from_memcg_idx() is performed using READ_ONCE() macro,
> > > which doesn't implement a SMP barrier, which is required
> > > by the logic.
> > >
> > > Add a proper smp_rmb() to be paired with smp_wmb() in
> > > memcg_create_kmem_cache().
> > >
> > > The same applies to memcg_create_kmem_cache() itself,
> > > which reads the same value without barriers and READ_ONCE().
> > >
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> >
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> >
> > This seems like independent to the series. Shouldn't this be Cc'ed stable?
>
> It is independent, but let's keep it here to avoid merge conflicts.
>
> It has been so for a long time, and nobody complained, so I'm not sure
> if we really need a stable backport. Do you have a different opinion?
>

Nah, it's fine as it is.
