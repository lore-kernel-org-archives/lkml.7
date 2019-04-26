Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F001AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C052B2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556311769;
	bh=VDya2lOzdc+RdKcdfCo3hUrniD8ewq64O1hFjOcwj48=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=sDGkb03f+H+lqKQ6VT5ipJQqvxINwygDGD6NZnv1si7FfSfeJSCkHczZxN5W1ML1C
	 6NIOLuPCr2dHACqgt74pyrvwY4MEBqs8iK1t56MxspvK0hL23BO7p7vS5UqKQEDus6
	 rE06y6b4sWsNtxOjNO8REt388gd+W72k1FDit5hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDZUt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfDZUt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:49:28 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D4F20869;
        Fri, 26 Apr 2019 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556311767;
        bh=VDya2lOzdc+RdKcdfCo3hUrniD8ewq64O1hFjOcwj48=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X5WsDu+AGCrVW4BRziq1TQ7sUHhMra2/yLde3Wklx9S/KfV42V4q2buexmb5BnOuH
         M6s3YaBr3w5noxJdV+MknqAqpkbWiZyCd6KegT+x62L6nKpSSSETx+1GUPgBkLejl6
         3ymXXK1sJLRKHPO4yWjhW4vpR5fZ86lulA1/XeMM=
Message-ID: <fd4327a68e79540e9faee40bd198dfee373e59fb.camel@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Apr 2019 16:49:24 -0400
In-Reply-To: <20190426170108.GZ2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
         <20190425200941.GW2217@ZenIV.linux.org.uk>
         <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
         <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
         <20190426170108.GZ2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 18:01 +0100, Al Viro wrote:
> On Fri, Apr 26, 2019 at 09:36:00AM -0700, Linus Torvalds wrote:
> > On Fri, Apr 26, 2019 at 9:25 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > Is it really ok to union the count and rcu_head there?
> > 
> > It should be fine, because the rcu_count should only ever be used once
> > the count has gone to zero and the name cannot be found any more.
> > 
> > And while RCU path walking may find and use the *name* after the
> > dentry has been killed off (but not free'd yet), all the actual
> > external_name() accesses should be serialized by the dentry lock, so
> > there's no access to those fields once the dentry is dead.
> 
> It's not quite that; access to external_name contents is fine,
> ->d_lock or not.  __d_lookup_rcu() does read it under rcu_read_lock
> alone.
> 
> However:
> 	* we never free it without an RCU delay after the final
> drop of refcount.  RCU delay might happen on dentry->d_rcu (if
> it's dentry_free()) or on name->p.rcu (if it's release_dentry_name_snapshot()
> or d_move() dropping the final reference).
> 	* it's never observed in ->d_name after the refcount
> reaches zero.
> 	* no lockless access ever looks at the refcount.  It
> can look at ->name[], but that's it.
> 

Got it, thanks. Why use an atomic_t for the refcount if it's always
accessed under spinlock?

> What I don't understand is why would anyone want to mess with
> name snapshots for dentry_path() lookalikes...

Mostly because the place where the ceph code needs to use and free these
strings is rather far removed from where they are created. It simplifies
that part if we can access and free them all in the same way.

I was planning to just use name_snapshots universally for that purpose,
but they have a rather specific method of freeing things that is hard to
duplicate if you don't have a dentry to clone.

Probably that means I'm approaching this problem in the wrong way and
need to do it differently.
-- 
Jeff Layton <jlayton@kernel.org>

