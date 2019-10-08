Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE8C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6B7206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570562253;
	bh=17f9i3oR5PbDQJgABtFQNuHXK2qtBHl7SdFLyVRsNd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XXmahsf7Uw/+oNvVQn30t+VoMQnL8Whi1IR6oCC2ii/Tbd81aOhEKncFfb29AwOi1
	 E/RDMvMORyEHAaNV5nTfssbB162Ic1bvJBc1qEWONPDirVOoRgVga+c/Giey9VMlUc
	 pJaMYWsq9gjbS9Jm/HIVx7XGc7raYTIbE6vBjHjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJHTRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:17:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:34248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfJHTRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:17:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F338B112;
        Tue,  8 Oct 2019 19:17:30 +0000 (UTC)
Date:   Tue, 8 Oct 2019 21:17:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008191728.GS6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <20191008183525.GQ6681@dhcp22.suse.cz>
 <1570561573.5576.307.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570561573.5576.307.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 15:06:13, Qian Cai wrote:
> On Tue, 2019-10-08 at 20:35 +0200, Michal Hocko wrote:
[...]
> > I fully agree that this class of lockdep splats are annoying especially
> > when they make the lockdep unusable but please discuss this with lockdep
> > maintainers and try to find some solution rather than go and try to
> > workaround the problem all over the place. If there are places that
> > would result in a cleaner code then go for it but please do not make the
> > code worse just because of a non existent problem flagged by a false
> > positive.
> 
> It makes me wonder what make you think it is a false positive for sure.

Because this is an early init code? Because if it were a real deadlock
then your system wouldn't boot to get run with the real userspace
(remember there is zone->lock spinlock involved and that means that you
would hit hard lock after few seconds - but I feel I am repeating
myself).
-- 
Michal Hocko
SUSE Labs
