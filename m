Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175B6217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCNBwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 21:52:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:62605 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfCNBwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 21:52:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 18:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,476,1544515200"; 
   d="scan'208";a="133894538"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2019 18:52:52 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKP ML <lkp@01.org>
Subject: Re: [LKP] [ext4] fde872682e: fsmark.files_per_sec -38.0% regression
References: <20190102004002.GB17624@shao2-debian>
        <CAC=cRTO8RC0kEz9B-vx5sO=6uXwsu2tE9rd_NKH1XjVRr9easA@mail.gmail.com>
        <20190313153056.GB672@mit.edu>
Date:   Thu, 14 Mar 2019 09:52:52 +0800
In-Reply-To: <20190313153056.GB672@mit.edu> (Theodore Ts'o's message of "Wed,
        13 Mar 2019 11:30:56 -0400")
Message-ID: <87h8c66x3f.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

 > On Wed, Mar 13, 2019 at 03:26:39PM +0800, huang ying wrote:
>> >
>> >
>> > commit: fde872682e175743e0c3ef939c89e3c6008a1529 ("ext4: force inode writes when nfsd calls commit_metadata()")
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> 
>> It appears that this is a performance regression caused by a
>> functionality fixing.  So we should ignore this?
>
> Yes, this is a correctness issue that we discovered while tracking
> down user data loss issue after a crash of the NFS server, so this is
> a change we have to keep.  When the NFS folks added the
> commit_metadata() hook, they didn't realize that the fallback path in
> nfsd/vfs.c using sync_inode_metadata() doesn't work on all file
> systems --- and in particular doesn't work for ext3 and ext4 because
> of how we do journalling.
>
> It only applies to NFS serving, not local ext4 use cases, so most ext4
> users won't be impacted on it; only those who export those file
> systems using NFS.
>
> I do have some plans on how to claw back the performance hit.  The
> good news is that it won't require an on-disk format change; the bad
> news is that it's a non-trivial change to how journalling works, and
> it's not something we can backport to the stable kernel series.  It's
> something we're going to have to leave to a distribution who is
> willing to do a lot of careful regression testing, once the change is
> available, maybe in 3 months or so.
>
>      	 	      	  	      	  - Ted
>
> P.S.  I *believe* all other file systems should be OK, and I didn't
> want to impose a performance tax on all other file systems (such as
> btrfs), so I fixed it in an ext4-specific way.  The more
> general/conservative change would be to fall back to using fsync in
> nfs/vfs.c:commit_metadata() unless the file system specifically set a
> superblock flag indicating that using sync_inode_metadata is safe.
> OTOH we lived with this flaw in ext3/ext4 for *years* without anyone
> noticing or complaining, so....

Got it!  Thanks for your detailed explanation!

Best Regards,
Huang, Ying
