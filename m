Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B6C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5289D208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfDZQvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:51:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39292 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfDZQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:50:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hK43r-0003ZP-QS; Fri, 26 Apr 2019 16:50:55 +0000
Date:   Fri, 26 Apr 2019 17:50:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Message-ID: <20190426165055.GY2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk>
 <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:25:03PM -0400, Jeff Layton wrote:

> It turns out though that using name_snapshot from ceph is a bit more
> tricky. In some cases, we have to call ceph_mdsc_build_path to build up
> a full path string. We can't easily populate a name_snapshot from there
> because struct external_name is only defined in fs/dcache.c.

Explain, please.  For ceph_mdsc_build_path() you don't need name
snapshots at all and existing code is, AFAICS, just fine, except
for pointless pr_err() there.

I _probably_ would take allocation out of the loop (e.g. make it
__getname(), called unconditionally) and turned it into the
d_path.c-style read_seqbegin_or_lock()/need_seqretry()/done_seqretry()
loop, so that the first pass would go under rcu_read_lock(), while
the second (if needed) would just hold rename_lock exclusive (without
bumping the refcount).  But that's a matter of (theoretical) livelock
avoidance, not the locking correctness for ->d_name accesses.

Oh, and
        *base = ceph_ino(d_inode(temp));
        *plen = len;
probably belongs in critical section - _that_ might be a correctness
issue, since temp is not held by anything once you are out of there.

> I could add some routines to do this, but it feels a lot like I'm
> abusing internal dcache interfaces. I'll keep thinking about it though.
> 
> While we're on the subject though:
> 
> struct external_name {
>         union {
>                 atomic_t count;
>                 struct rcu_head head;
>         } u;
>         unsigned char name[];
> };
> 
> Is it really ok to union the count and rcu_head there?
> 
> I haven't trawled through all of the code yet, but what prevents someone
> from trying to access the count inside an RCU critical section, after
> call_rcu has been called on it?

The fact that no lockless accesses to ->count are ever done?
