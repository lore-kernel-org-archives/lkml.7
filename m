Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB50ACA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA2E208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJ3PPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:15:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52948 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727169AbfJ3PPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:15:14 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9UFEjKE010180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 11:14:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 16ABD420456; Wed, 30 Oct 2019 11:14:45 -0400 (EDT)
Date:   Wed, 30 Oct 2019 11:14:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
Message-ID: <20191030151444.GC16197@mit.edu>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030104345.GB170703@architecture4>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:43:45PM +0800, Gao Xiang wrote:
> > You're right, in low memory scenario, allocation with bioset will be faster, as
> > you mentioned offline, maybe we can add/use a priviate bioset like btrfs did
> > rather than using global one, however, we'd better check how deadlock happen
> > with a bioset mempool first ...
> 
> Okay, hope to get hints from Jaegeuk and redo this patch then...

It's not at all clear to me that using a private bioset is a good idea
for f2fs.  That just means you're allocating a separate chunk of
memory just for f2fs, as opposed to using the global pool.  That's an
additional chunk of non-swapable kernel memory that's not going to be
available, in *addition* to the global mempool.  

Also, who else would you be contending for space with the global
mempool?  It's not like an mobile handset is going to have other users
of the global bio mempool.

On a low-end mobile handset, memory is at a premium, so wasting memory
to no good effect isn't going to be a great idea.

Regards,

						- Ted
