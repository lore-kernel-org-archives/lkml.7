Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6392C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF58A218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AZ1omCiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGCQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:10:33 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:59100 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbfGCQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1562170231;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=wRhFAPDN9W31/7q1dT/zdEt3Cu7N780+Gi6e7xOeZoI=;
        b=AZ1omCiJcuo1xOM8hwRxHYsOmsp7QmftZ/s2l9pRNQ0/UpulCa0XIDjkDIJhXeHD
        pEGlkzc0c6EGKQ3xgeTyAVXNbkiyJdKJTl1et6y1CcBPnwLyUJdn1wOHCPxXaEx/N20
        SGvnPPNX4Ry6+ie176GFa9Q7j5m6Rn7y0m3ld11U=
Date:   Wed, 3 Jul 2019 16:10:31 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Waiman Long <longman@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
In-Reply-To: <9ade5859-b937-c1ac-9881-2289d734441d@redhat.com>
Message-ID: <0100016bb89a0a6e-99d54043-4934-420f-9de0-1f71a8f943a3-000000@email.amazonses.com>
References: <20190702183730.14461-1-longman@redhat.com> <20190703065628.GK978@dhcp22.suse.cz> <9ade5859-b937-c1ac-9881-2289d734441d@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.07.03-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019, Waiman Long wrote:

> On 7/3/19 2:56 AM, Michal Hocko wrote:
> > On Tue 02-07-19 14:37:30, Waiman Long wrote:
> >> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> >> file to shrink the slab by flushing all the per-cpu slabs and free
> >> slabs in partial lists. This applies only to the root caches, though.
> >>
> >> Extends this capability by shrinking all the child memcg caches and
> >> the root cache when a value of '2' is written to the shrink sysfs file.
> > Why do we need a new value for this functionality? I would tend to think
> > that skipping memcg caches is a bug/incomplete implementation. Or is it
> > a deliberate decision to cover root caches only?
>
> It is just that I don't want to change the existing behavior of the
> current code. It will definitely take longer to shrink both the root
> cache and the memcg caches. If we all agree that the only sensible
> operation is to shrink root cache and the memcg caches together. I am
> fine just adding memcg shrink without changing the sysfs interface
> definition and be done with it.

I think its best and consistent behavior to shrink all memcg caches
with the root cache. This looks like an oversight and thus a bugfix.

