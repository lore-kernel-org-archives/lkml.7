Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92515C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F8220651
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfCMPbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:31:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35882 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbfCMPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:31:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x2DFUvkB010270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Mar 2019 11:30:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D8BBE42080E; Wed, 13 Mar 2019 11:30:56 -0400 (EDT)
Date:   Wed, 13 Mar 2019 11:30:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKP ML <lkp@01.org>, Huang Ying <ying.huang@intel.com>
Subject: Re: [LKP] [ext4] fde872682e: fsmark.files_per_sec -38.0% regression
Message-ID: <20190313153056.GB672@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        huang ying <huang.ying.caritas@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, LKP ML <lkp@01.org>,
        Huang Ying <ying.huang@intel.com>
References: <20190102004002.GB17624@shao2-debian>
 <CAC=cRTO8RC0kEz9B-vx5sO=6uXwsu2tE9rd_NKH1XjVRr9easA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=cRTO8RC0kEz9B-vx5sO=6uXwsu2tE9rd_NKH1XjVRr9easA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 03:26:39PM +0800, huang ying wrote:
> >
> >
> > commit: fde872682e175743e0c3ef939c89e3c6008a1529 ("ext4: force inode writes when nfsd calls commit_metadata()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> It appears that this is a performance regression caused by a
> functionality fixing.  So we should ignore this?

Yes, this is a correctness issue that we discovered while tracking
down user data loss issue after a crash of the NFS server, so this is
a change we have to keep.  When the NFS folks added the
commit_metadata() hook, they didn't realize that the fallback path in
nfsd/vfs.c using sync_inode_metadata() doesn't work on all file
systems --- and in particular doesn't work for ext3 and ext4 because
of how we do journalling.

It only applies to NFS serving, not local ext4 use cases, so most ext4
users won't be impacted on it; only those who export those file
systems using NFS.

I do have some plans on how to claw back the performance hit.  The
good news is that it won't require an on-disk format change; the bad
news is that it's a non-trivial change to how journalling works, and
it's not something we can backport to the stable kernel series.  It's
something we're going to have to leave to a distribution who is
willing to do a lot of careful regression testing, once the change is
available, maybe in 3 months or so.

     	 	      	  	      	  - Ted

P.S.  I *believe* all other file systems should be OK, and I didn't
want to impose a performance tax on all other file systems (such as
btrfs), so I fixed it in an ext4-specific way.  The more
general/conservative change would be to fall back to using fsync in
nfs/vfs.c:commit_metadata() unless the file system specifically set a
superblock flag indicating that using sync_inode_metadata is safe.
OTOH we lived with this flaw in ext3/ext4 for *years* without anyone
noticing or complaining, so....
