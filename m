Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257EC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F0320673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562116386;
	bh=7BKwrn5ZR0EvyKBoBdw71Sjqy+1SUbMyW6AzU7/ufH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HIocCK/1tNfnqgtTuQ05xZl4bOVEYB59k3YxxAl53wuJxP9vTFRenxGQwRDV4D3v9
	 vCA7kvhH10N9SH7iHem+CUGtzo/dG+NLpzjqBAhKcc2zwbg33GRPVsEvh0PzP7D4kF
	 5P314mOHXnoMaCfPToCOzc8ANZX3syC1RAo3VOzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfGCBNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGCBNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:13:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1AE218CA;
        Tue,  2 Jul 2019 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562103221;
        bh=7BKwrn5ZR0EvyKBoBdw71Sjqy+1SUbMyW6AzU7/ufH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RBa6CBZoD/h1b3spSkXt/s5mk4/LF71sNM0q6jPS2dnne68logM7RJmnQeYqnoPlk
         We4S37hoCXN1vJ/SylpXLdidWn8wQovBsN3zWD/thJwRlA5V0kPWzkSRUxdgTRtCMR
         lCSW1e94ZmkPHXhQYrDUGU4rHNsLYjp0UCC4jn8o=
Date:   Tue, 2 Jul 2019 14:33:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
Message-Id: <20190702143340.715f771192721f60de1699d7@linux-foundation.org>
In-Reply-To: <78879b79-1b8f-cdfd-d4fa-610afe5e5d48@redhat.com>
References: <20190702183730.14461-1-longman@redhat.com>
        <20190702130318.39d187dc27dbdd9267788165@linux-foundation.org>
        <78879b79-1b8f-cdfd-d4fa-610afe5e5d48@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 16:44:24 -0400 Waiman Long <longman@redhat.com> wrote:

> On 7/2/19 4:03 PM, Andrew Morton wrote:
> > On Tue,  2 Jul 2019 14:37:30 -0400 Waiman Long <longman@redhat.com> wro=
te:
> >
> >> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> >> file to shrink the slab by flushing all the per-cpu slabs and free
> >> slabs in partial lists. This applies only to the root caches, though.
> >>
> >> Extends this capability by shrinking all the child memcg caches and
> >> the root cache when a value of '2' is written to the shrink sysfs file.
> > Why?
> >
> > Please fully describe the value of the proposed feature to or users.=20
> > Always.
>=20
> Sure. Essentially, the sysfs shrink interface is not complete. It allows
> the root cache to be shrunk, but not any of the memcg caches.=A0

But that doesn't describe anything of value.  Who wants to use this,
and why?  How will it be used?  What are the use-cases?

