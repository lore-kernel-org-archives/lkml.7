Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D48FC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFE22085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568203207;
	bh=TRZPhDUn3fCmyadj4io3KMR6sEvY1Axe1o0mYIWtiqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CYBKYqp6ltxpZAFwZCN1F6W69oOoZcklKs/GpiqWF0W+O1r6NcXPBnbUYCwCaXz6r
	 yC+dKiIDfxOpjy5oOoyCal5X3f0tznwPdRimQqA9k++vGEMeo2JLuexYX339VdYJIJ
	 SGdf9d/u2TPBkqq+73s87ZcKMNtA/kwS9I2B/R9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfIKMAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:00:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfIKMAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:00:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A9D9B64B;
        Wed, 11 Sep 2019 12:00:04 +0000 (UTC)
Date:   Wed, 11 Sep 2019 14:00:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] memcg, kmem: do not fail __GFP_NOFAIL charges
Message-ID: <20190911120002.GQ4023@dhcp22.suse.cz>
References: <31131c2d-a936-8bbf-e58d-a3baaa457340@gmail.com>
 <20190906125608.32129-1-mhocko@kernel.org>
 <CALvZod5w72jH8fJSFRaw7wgQTnzF6nb=+St-sSXVGSiG6Bs3Lg@mail.gmail.com>
 <20190909112245.GH27159@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909112245.GH27159@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-09-19 13:22:45, Michal Hocko wrote:
> On Fri 06-09-19 11:24:55, Shakeel Butt wrote:
[...]
> > I wonder what has changed since
> > <http://lkml.kernel.org/r/20180525185501.82098-1-shakeelb@google.com/>.
> 
> I have completely forgot about that one. It seems that we have just
> repeated the same discussion again. This time we have a poor user who
> actually enabled the kmem limit.
> 
> I guess there was no real objection to the change back then. The primary
> discussion revolved around the fact that the accounting will stay broken
> even when this particular part was fixed. Considering this leads to easy
> to trigger crash (with the limit enabled) then I guess we should just
> make it less broken and backport to stable trees and have a serious
> discussion about discontinuing of the limit. Start by simply failing to
> set any limit in the current upstream kernels.

Any more concerns/objections to the patch? I can add a reference to your
earlier post Shakeel if you want or to credit you the way you prefer.

Also are there any objections to start deprecating process of kmem
limit? I would see it in two stages
- 1st warn in the kernel log
	pr_warn("kmem.limit_in_bytes is deprecated and will be removed.
	        "Please report your usecase to linux-mm@kvack.org if you "
		"depend on this functionality."
- 2nd fail any write to kmem.limit_in_bytes
- 3rd remove the control file completely
-- 
Michal Hocko
SUSE Labs
