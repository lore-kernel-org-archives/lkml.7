Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A501BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F7620856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571902930;
	bh=Tchhd74JOKSSHBQpyDOodlVDwl+xM4pRX9R7bRqqP5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M87Eph+Pm6xF62gqMx2kt4ACAtKYYnmjmcBkrS6S8PHlv2NgTBDUHDIStFOuH124S
	 SUEelBLw4eZ7fyed3pnH+8AloWkZkc9FNw6LA5StuKQ8gRbKP2PjXpazQXvwjCeJqs
	 xFksrfguIo15SS3VG3Wt/nAkqvkUtSbFq+uvjKpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437917AbfJXHmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:42:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408661AbfJXHmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:42:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2899CB019;
        Thu, 24 Oct 2019 07:42:07 +0000 (UTC)
Date:   Thu, 24 Oct 2019 09:42:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191024074205.GQ17610@dhcp22.suse.cz>
References: <20191023153040.c7fff4bc7c86ed605fc4667f@linux-foundation.org>
 <4D23D83F-190F-40B3-9EB9-C167642321B2@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4D23D83F-190F-40B3-9EB9-C167642321B2@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-10-19 01:33:01, Qian Cai wrote:
> 
> 
> > On Oct 23, 2019, at 6:30 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > Yes, removing things is hard.  One approach is to add printk_once(this
> > is going away, please email us if you use it) then wait a few years. 
> > Backport that one-liner into -stable kernels to hopefully speed up the
> > process.
> 
> Although it still look like an overkill to me given,
> 
> 1) Mel given a green light to remove it.
> 2) Nobody justifies any sensible reason to keep it apart from it was
> probably only triggering by some testing tools blindly read procfs
> entries.

It's been useful for debugging memory fragmentation problems and we do
not have anything that would provide a similar information. Considering
that making it root only is trivial and reducing the lock hold times
likewise I do not really see any strong reason to dump it at this
moment.
 
> it is still better than wasting developers’ time to beating the “dead” horse.
> 
> > 
> > Meanwhile, we need to fix the DoS opportunity.  How about my suggestion
> > that we limit the count to 1024, see if anyone notices?  I bet they
> > don't!
> 
> The DoS is probably there since the file had been introduced almost 10
> years ago, so I suspect it is not that easily exploitable.

Yes you need _tons_ of memory. Reading the file on my 3TB system takes
sys     0m3.673s

The situation might be worse if the system is terribly fragmented which
is not the case here.
-- 
Michal Hocko
SUSE Labs
