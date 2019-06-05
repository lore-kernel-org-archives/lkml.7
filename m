Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449CDC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1949E2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559727181;
	bh=9yRQKQmW+n1NU2z2O3UWtAUpNtMId+rKeTGOyyhWZf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2c5OLH8p3b4QvQcl3ENfL9ujC1u5jBnCwFDw+fsZoLFfCTD8Me7fmkaS2Z0KTg3JH
	 68ZqlsgFdgOzBTrLLI/anpVsfE7QUelSp1EH+ea24StoEocgfrgP4T3t45TjTx40LL
	 bxjjZLD2Ozp8ej5xyXfRgDxan6DX73reb2ANduVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfFEJdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:33:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:33780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbfFEJdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:33:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E493CAEA3;
        Wed,  5 Jun 2019 09:32:57 +0000 (UTC)
Date:   Wed, 5 Jun 2019 11:32:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
Message-ID: <20190605093257.GC15685@dhcp22.suse.cz>
References: <20190503223146.2312-1-aarcange@redhat.com>
 <20190503223146.2312-3-aarcange@redhat.com>
 <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com>
 <20190520153621.GL18914@techsingularity.net>
 <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
 <alpine.DEB.2.21.1905281907060.86034@chino.kir.corp.google.com>
 <20190531092236.GM6896@dhcp22.suse.cz>
 <alpine.DEB.2.21.1905311430120.92278@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905311430120.92278@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-05-19 14:53:35, David Rientjes wrote:
> On Fri, 31 May 2019, Michal Hocko wrote:
> 
> > > The problem which this patch addresses has apparently gone unreported for 
> > > 4+ years since
> > 
> > Can we finaly stop considering the time and focus on the what is the
> > most reasonable behavior in general case please? Conserving mistakes
> > based on an argument that we have them for many years is just not
> > productive. It is very well possible that workloads that suffer from
> > this simply run on older distribution kernels which are moving towards
> > newer kernels very slowly.
> > 
> 
> That's fine, but we also must be mindful of users who have used 
> MADV_HUGEPAGE over the past four years based on its hard-coded behavior 
> that would now regress as a result.

Absolutely, I am all for helping those usecases. First of all we need to
understand what those usecases are though. So far we have only seen very
vague claims about artificial worst case examples when a remote access
dominates the overall cost but that doesn't seem to be the case in real
life in my experience (e.g. numa balancing will correct things or the
over aggressive node reclaim tends to cause problems elsewhere etc.).

That being said I am pretty sure that a new memory policy as proposed
previously that would allow for a node reclaim behavior is a way for
those very specific workloads that absolutely benefit from a local
access. There are however real life usecases that benefit from THP even
on remote nodes as explained by Andrea (most notable kvm) and the only
way those can express their needs is the madvise flag. Not to mention
that the default node reclaim behavior might cause excessive reclaim
as demonstrate by Mel and Anrea and that is certainly not desirable in
itself.

[...]
> > > My goal is to reach a solution that does not cause anybody to incur 
> > > performance penalties as a result of it.
> > 
> > That is certainly appreciated and I can offer my help there as well. But
> > I believe we should start with a code base that cannot generate a
> > swapping storm by a trivial code as demonstrated by Mel. A general idea
> > on how to approve the situation has been already outlined for a default
> > case and a new memory policy has been mentioned as well but we need
> > something to start with and neither of the two is compatible with the
> > __GFP_THISNODE behavior.
> > 
> 
> Thus far, I haven't seen anybody engage in discussion on how to address 
> the issue other than proposed reverts that readily acknowledge they cause 
> other users to regress.  If all nodes are fragmented, the swap storms that 
> are currently reported for the local node would be made worse by the 
> revert -- if remote hugepages cannot be faulted quickly then it's only 
> compounded the problem.

Andrea has outline the strategy to go IIRC. There also has been a
general agreement that we shouldn't be over eager to fall back to remote
nodes if the base page size allocation could be satisfied from a local node.
-- 
Michal Hocko
SUSE Labs
