Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B8EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AEC2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDZRBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:01:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39480 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDZRBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:01:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hK4Dl-0003lY-0m; Fri, 26 Apr 2019 17:01:09 +0000
Date:   Fri, 26 Apr 2019 18:01:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Message-ID: <20190426170108.GZ2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk>
 <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:36:00AM -0700, Linus Torvalds wrote:
> On Fri, Apr 26, 2019 at 9:25 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > Is it really ok to union the count and rcu_head there?
> 
> It should be fine, because the rcu_count should only ever be used once
> the count has gone to zero and the name cannot be found any more.
> 
> And while RCU path walking may find and use the *name* after the
> dentry has been killed off (but not free'd yet), all the actual
> external_name() accesses should be serialized by the dentry lock, so
> there's no access to those fields once the dentry is dead.

It's not quite that; access to external_name contents is fine,
->d_lock or not.  __d_lookup_rcu() does read it under rcu_read_lock
alone.

However:
	* we never free it without an RCU delay after the final
drop of refcount.  RCU delay might happen on dentry->d_rcu (if
it's dentry_free()) or on name->p.rcu (if it's release_dentry_name_snapshot()
or d_move() dropping the final reference).
	* it's never observed in ->d_name after the refcount
reaches zero.
	* no lockless access ever looks at the refcount.  It
can look at ->name[], but that's it.

What I don't understand is why would anyone want to mess with
name snapshots for dentry_path() lookalikes...
