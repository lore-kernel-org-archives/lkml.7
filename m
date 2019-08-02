Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E1C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCA22173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564736392;
	bh=T0T81QntU9lHebUmO9cE2kDj+B6t5ng+xgqsdhZA234=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gumBe4d0k9JSnzuFLZhyl93w4MPLkZnxfwGiDzjOnHUZNqu6HhOolg8D2j4jf/KXS
	 iVOXVFUokh2glddbkFtghZVcaP0rrsvJBIcoNZsQKU/WFwYbsmGdDZEtvGpvGs5b10
	 Ic3t9HYgu+lgNE4buseVXYvZrHWulDLso2qxk684=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfHBI7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:59:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbfHBI7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:59:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA743AB8C;
        Fri,  2 Aug 2019 08:59:49 +0000 (UTC)
Date:   Fri, 2 Aug 2019 10:59:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Message-ID: <20190802085947.GC6461@dhcp22.suse.cz>
References: <20190801233513.137917-1-guro@fb.com>
 <20190802080422.GA6461@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802080422.GA6461@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-08-19 10:04:22, Michal Hocko wrote:
> On Thu 01-08-19 16:35:13, Roman Gushchin wrote:
> > Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
> > introduced css_tryget()/css_put() calls in drain_all_stock(),
> > which are supposed to protect the target memory cgroup from being
> > released during the mem_cgroup_is_descendant() call.
> > 
> > However, it's not completely safe. In theory, memcg can go away
> > between reading stock->cached pointer and calling css_tryget().
> 
> I have to remember how is this whole thing supposed to work, it's been
> some time since I've looked into that.

OK, I guess I remember now and I do not see how the race is possible.
Stock cache is keeping its memcg alive because it elevates the reference
counting for each cached charge. And that should keep the whole chain up
to the root (of draining) alive, no? Or do I miss something, could you
generate a sequence of events that would lead to use-after-free?
-- 
Michal Hocko
SUSE Labs
