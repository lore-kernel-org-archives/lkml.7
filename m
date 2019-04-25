Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5108BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A6620717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfDYSVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:21:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49800 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfDYSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:21:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hJizU-0004tp-MH; Thu, 25 Apr 2019 18:21:00 +0000
Date:   Thu, 25 Apr 2019 19:21:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Message-ID: <20190425182100.GU2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:02:54AM -0700, Linus Torvalds wrote:

> I've pulled this, but maybe Jeff wants to look at whether that
> snapshotting model could have helped.

I really wonder if 76a495d666e5 (ceph: ensure d_name stability in
ceph_dentry_hash()) makes any sense; OK, you have ->d_lock held
over that, but what does it protect against?  Sure, you'll get
something that was valid while you held ->d_lock, but what good
does it do to the callers?  If they really have to care about
races with d_move(), which value do they want?
