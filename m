Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24879C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3B420873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfGSXXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 19:23:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41292 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfGSXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:23:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hocDU-0006cq-4i; Fri, 19 Jul 2019 23:23:08 +0000
Date:   Sat, 20 Jul 2019 00:23:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Luis Henriques <lhenriques@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ceph: fix buffer free while holding i_ceph_lock in
 __ceph_setxattr()
Message-ID: <20190719232307.GA17978@ZenIV.linux.org.uk>
References: <20190719143222.16058-1-lhenriques@suse.com>
 <20190719143222.16058-3-lhenriques@suse.com>
 <1dee14212043f12ef5b26e4aee0c3155e118abf3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dee14212043f12ef5b26e4aee0c3155e118abf3.camel@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 07:07:49PM -0400, Jeff Layton wrote:

> Al pointed out on IRC that vfree should be callable under spinlock.

Al had been near-terminally low on caffeine at the time, posted
a retraction a few minutes later and went to grab some coffee...

> It
> only sleeps if !in_interrupt(), and I think that should return true if
> we're holding a spinlock.

It can be used from RCU callbacks and all such; it *can't* be used from
under spinlock - on non-preempt builds there's no way to recognize that.
