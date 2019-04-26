Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E810214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556299858;
	bh=Bj1jsg50TdLt33qVgLo9ICACP/IhpTZnI3gkRKk49U4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=qOyr1iM7CRIEaZr04dfauOHcNJhstzM6MhdPJ80zIvxb+T9frPkimGt1UMRbvUcur
	 Jgg6qo+UI2xzd5xnLMyp0rwgf7OsYGMNLdL5zfmOphn9g0Xg5T2pPBS2sXv0Nh9U7H
	 0KY/7OKwLM5qUULrwyYb4WRBKNtuTeKdWHv9EjDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfDZRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfDZRa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:30:56 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49E62146E;
        Fri, 26 Apr 2019 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556299855;
        bh=Bj1jsg50TdLt33qVgLo9ICACP/IhpTZnI3gkRKk49U4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hpIUpTZ8ur5Mwe6Wes7zT5o+hJprutZ7x3ZNTHcFCCu1oekkgjiZby2aPjFg4S0rS
         F++JdTIcYCJUlRuPwAdAMgLEaq/2CKh69yMDYS1OLCADsHm3/cPNVfKvvdiR/Lq+2O
         q/+jWfil3nAhaiy/Cv7ucGFVWrMjhf7xHlufvVG0=
Message-ID: <b175faae4bb98d3379a8642fe5f4e00587c3a734.camel@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Apr 2019 13:30:53 -0400
In-Reply-To: <20190426165055.GY2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
         <20190425200941.GW2217@ZenIV.linux.org.uk>
         <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
         <20190426165055.GY2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 17:50 +0100, Al Viro wrote:
> On Fri, Apr 26, 2019 at 12:25:03PM -0400, Jeff Layton wrote:
> 
> > It turns out though that using name_snapshot from ceph is a bit more
> > tricky. In some cases, we have to call ceph_mdsc_build_path to build up
> > a full path string. We can't easily populate a name_snapshot from there
> > because struct external_name is only defined in fs/dcache.c.
> 
> Explain, please.  For ceph_mdsc_build_path() you don't need name
> snapshots at all and existing code is, AFAICS, just fine, except
> for pointless pr_err() there.
> 

Eventually we have to pass back the result of all the
build_dentry_path() shenanigans to create_request_message(), and then
free whatever that result is after using it.

Today we can get back a string+length from ceph_mdsc_build_path or
clone_dentry_name, or we might get direct pointers into the dentry if
the situation allows for it.

Now we want to rip out clone_dentry_name() and start using
take_dentry_name_snapshot(). That returns a name_snapshot that we'll
need to pass back to create_request_message. It will need to deal with
the fact that it could get one of those instead of just a string+length.

My original thought was to always pass back a name_snapshot, but that
turns out to be difficult because its innards are not public. The other
potential solutions that I've tried make this code look even worse than
it already is.


> I _probably_ would take allocation out of the loop (e.g. make it
> __getname(), called unconditionally) and turned it into the
> d_path.c-style read_seqbegin_or_lock()/need_seqretry()/done_seqretry()
> loop, so that the first pass would go under rcu_read_lock(), while
> the second (if needed) would just hold rename_lock exclusive (without
> bumping the refcount).  But that's a matter of (theoretical) livelock
> avoidance, not the locking correctness for ->d_name accesses.
> 

Yeah, that does sound better. I want to think about this code a bit

> Oh, and
>         *base = ceph_ino(d_inode(temp));
>         *plen = len;
> probably belongs in critical section - _that_ might be a correctness
> issue, since temp is not held by anything once you are out of there.
> 

Good catch. I'll fix that up.

> > I could add some routines to do this, but it feels a lot like I'm
> > abusing internal dcache interfaces. I'll keep thinking about it though.
> > 
> > While we're on the subject though:
> > 
> > struct external_name {
> >         union {
> >                 atomic_t count;
> >                 struct rcu_head head;
> >         } u;
> >         unsigned char name[];
> > };
> > 
> > Is it really ok to union the count and rcu_head there?
> > 
> > I haven't trawled through all of the code yet, but what prevents someone
> > from trying to access the count inside an RCU critical section, after
> > call_rcu has been called on it?
> 
> The fact that no lockless accesses to ->count are ever done?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

