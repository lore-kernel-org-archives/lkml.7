Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E63BC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C1120842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXDNtZP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfJBNAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:00:22 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39846 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:00:22 -0400
Received: by mail-yw1-f68.google.com with SMTP id n11so6039450ywn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7MxrKuI5sPe4orcfFy2pIM27MTW0kfpe0fT8luuNjM4=;
        b=GXDNtZP2zjopSwjq0nyxQ5XSQ5zGN38LpZib81E3XoR1dL9OW17mrq7PEoZhW+LAcU
         EhuerB9ZdlFoKPdqXPMxy9S7Hx6bEtL723TN9APpkthiTTPwLhcVwrq5mDjypyDve0hd
         ads9QQUqzHFd22hABBj+VClQ/PjWF6BeW/qrm1WN7lTpJ9z5KIL3A6p/F5XRCCEt2TuJ
         rcIGaE8iznAR0nYG9XeRpiBVR1+6Tm+ISFiCmuXVgi+OraSqJyHJPIEH2gFdXEbuMDrS
         PBGQ3Zgqv7pc3DdgPORlw+3gfRE8ikBnLNurksJeaAuFVM21wy5eKbOOIV/tcFB6we25
         N6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7MxrKuI5sPe4orcfFy2pIM27MTW0kfpe0fT8luuNjM4=;
        b=OD+OnzM/oj0YQ/hbXNR8AeH6dCx5qrxDdz4077GTRobhUWyoFtSSj+COK15XOqpdpw
         Io7HfHi3NI0L/1LFdOLwIrYMdeGusQHtFOILEOlxm5hStfasYfZdlEQ7Guqz4uerl73u
         /bELNEvBFFV96r6vSheWRlK25Weesng7avHEdA8qkIcz98R8SwFTH/AyQsJO+patOKgi
         tiJj79t9y/u5WgMLdT8k7uX4BEt13BMwoClpmQOHi3oWntcj2fb3L8LM06JyuVtOXVPy
         6+FB130WTzCsQ2ZHeYLKZMDwEzznZOouTK0bT34TWUJPKuYp1NZYiZ77MDM4iP1LjMYk
         SUOQ==
X-Gm-Message-State: APjAAAUT6Y5McBqTp1q1MHa0JdyqngT388A4pC+9P0sFiYqwnne2348k
        0gvqaK5snseyyyiZn7CTFcPesmYvmJnCXkVD+EXe/J3tdbE=
X-Google-Smtp-Source: APXvYqzR7JQn1ndsqASj0leEIvy9DfGHuMILlcQ8HgYMNL5BSQ5MAUFSHVCs0BGJ63vyGGkLWxswGdtyfzCUo0H5MTI=
X-Received: by 2002:a81:92c8:: with SMTP id j191mr2566314ywg.57.1570021219382;
 Wed, 02 Oct 2019 06:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190905214553.1643060-1-guro@fb.com> <20191001151202.GA6678@blackbody.suse.cz>
 <20191002020906.GB6436@castle.dhcp.thefacebook.com>
In-Reply-To: <20191002020906.GB6436@castle.dhcp.thefacebook.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Wed, 2 Oct 2019 22:00:07 +0900
Message-ID: <CABCjUKBZxJJrUzpgXafqtXOYXZbYXEh0ku8fZLpPHXWnrTw1hg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
To:     Roman Gushchin <guro@fb.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 11:09 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Oct 01, 2019 at 05:12:02PM +0200, Michal Koutn=C3=BD wrote:
> > On Thu, Sep 05, 2019 at 02:45:44PM -0700, Roman Gushchin <guro@fb.com> =
wrote:
> > > Roman Gushchin (14):
> > > [...]
> > >   mm: memcg/slab: use one set of kmem_caches for all memory cgroups
> > From that commit's message:
> >
> > > 6) obsoletes kmem.slabinfo cgroup v1 interface file, as there are
> > >   no per-memcg kmem_caches anymore (empty output is printed)
> >
> > The empty file means no allocations took place in the particular cgroup=
.
> > I find this quite a surprising change for consumers of these stats.
> >
> > I understand obtaining the same data efficiently from the proposed
> > structures is difficult, however, such a change should be avoided. (In
> > my understanding, obsoleted file ~ not available in v2, however, it
> > should not disappear from v1.)
>
> Well, my assumption is that nobody is using this file for anything except
> debugging purposes (I might be wrong, if somebody has an automation based
> on it, please, let me know). A number of allocations of each type per mem=
ory
> cgroup is definitely a useful debug information, but currently it barely =
works
> (displayed numbers show mostly the number of allocated pages, not the num=
ber
> of active objects). We can support it, but it comes with the price, and
> most users don't really need it. So I don't think it worth it to make all
> allocations slower just to keep some debug interface working for some
> cgroup v1 users. Do you have examples when it's really useful and worth
> extra cpu cost?
>
> Unfortunately, we can't enable it conditionally, as a user can switch
> between cgroup v1 and cgroup v2 memory controllers dynamically.

kmem.slabinfo has been absolutely invaluable for debugging, in my experienc=
e.
I am however not aware of any automation based on it.

Maybe it might be worth adding it to cgroup v2 and have a CONFIG
option to enable it?

-- Suleiman
