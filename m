Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCD1C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7886021773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558436434;
	bh=EUZzAGl5nSuDrMkd4mE8HYCI4Qtvk4wHikM5OSI0yPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OXTZAnWUI27Ou3Qh6PHAGDL4dDl7FdbndD/WOntdPUr3O59S6TihFVKJFy+htQaCg
	 lsU4oInF+5jBEAWEhs8tsPNLzBURk4SaknrYO6s5vQDTLwfucr2ISo6B9fBQhcXXrQ
	 8Ppy+BIPuaGXv3cf0v5tc4v/GXaP+etbw1OJCkzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfEULAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:00:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfEULAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2064FAE31;
        Tue, 21 May 2019 11:00:32 +0000 (UTC)
Date:   Tue, 21 May 2019 13:00:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521110030.GR32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
 <20190521065000.GH32329@dhcp22.suse.cz>
 <20190521070638.yhn3w4lpohwcqbl3@butterfly.localdomain>
 <20190521105256.GF219653@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521105256.GF219653@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 19:52:56, Minchan Kim wrote:
> On Tue, May 21, 2019 at 09:06:38AM +0200, Oleksandr Natalenko wrote:
> > Hi.
> > 
> > On Tue, May 21, 2019 at 08:50:00AM +0200, Michal Hocko wrote:
> > > On Tue 21-05-19 08:36:28, Oleksandr Natalenko wrote:
> > > [...]
> > > > Regarding restricting the hints, I'm definitely interested in having
> > > > remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> > > > madvise() introduces another issue with traversing remote VMAs reliably.
> > > > IIUC, one can do this via userspace by parsing [s]maps file only, which
> > > > is not very consistent, and once some range is parsed, and then it is
> > > > immediately gone, a wrong hint will be sent.
> > > > 
> > > > Isn't this a problem we should worry about?
> > > 
> > > See http://lkml.kernel.org/r/20190520091829.GY6836@dhcp22.suse.cz
> > 
> > Oh, thanks for the pointer.
> > 
> > Indeed, for my specific task with remote KSM I'd go with map_files
> > instead. This doesn't solve the task completely in case of traversal
> > through all the VMAs in one pass, but makes it easier comparing to a
> > remote syscall.
> 
> I'm wondering how map_files can solve your concern exactly if you have
> a concern about the race of vma unmap/remap even there are anonymous
> vma which map_files doesn't support.

See http://lkml.kernel.org/r/20190521105503.GQ32329@dhcp22.suse.cz

-- 
Michal Hocko
SUSE Labs
