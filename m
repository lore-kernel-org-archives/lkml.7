Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EDCC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB83720659
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfJILtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:49:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbfJILtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:49:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5CF7B117;
        Wed,  9 Oct 2019 11:49:03 +0000 (UTC)
Date:   Wed, 9 Oct 2019 13:49:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
References: <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <20191008183525.GQ6681@dhcp22.suse.cz>
 <1570561573.5576.307.camel@lca.pw>
 <20191008191728.GS6681@dhcp22.suse.cz>
 <1570563324.5576.309.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570563324.5576.309.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-10-08 15:35:24, Qian Cai wrote:
> On Tue, 2019-10-08 at 21:17 +0200, Michal Hocko wrote:
> > On Tue 08-10-19 15:06:13, Qian Cai wrote:
> > > On Tue, 2019-10-08 at 20:35 +0200, Michal Hocko wrote:
> > 
> > [...]
> > > > I fully agree that this class of lockdep splats are annoying especially
> > > > when they make the lockdep unusable but please discuss this with lockdep
> > > > maintainers and try to find some solution rather than go and try to
> > > > workaround the problem all over the place. If there are places that
> > > > would result in a cleaner code then go for it but please do not make the
> > > > code worse just because of a non existent problem flagged by a false
> > > > positive.
> > > 
> > > It makes me wonder what make you think it is a false positive for sure.
> > 
> > Because this is an early init code? Because if it were a real deadlock
> 
> No, that alone does not prove it is a false positive. There are many places
> could generate that lock dependency but lockdep will always save the earliest
> one.

You are still mixing the pasted lockdep report and other situations
that will not get reported because of the first one.

We believe that the pasted report is pasted is false positive. And we
are against complicating the code just to avoid this false positive.

Are you sure that the workaround will not create real deadlocks
or races?

I see two realistic possibilities:

   + Make printk() always deferred. This will hopefully happen soon.

   + Improve lockdep so that false positives could get ignored
     without complicating the code.

Best Regards,
Petr

