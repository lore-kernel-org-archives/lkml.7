Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F51C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3ED2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573840045;
	bh=rCRRtesiccdYDCXwaVE6TpZ6yZ1Ah/Dk3pZgJXH7spE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OJmb2HuM/c0lwsQD97YvzOzZBDAXFb8CagMisaDT5lCmHFZl6J7bRKMxzQaYlxuph
	 6SRo/+/QeINRC/oX8mOwuFslHo3+gIUR/VzIlfDv1tu46BZbgT9zqvW/eymrEW/WNU
	 ojutS1Z70VYRx4BUL5xZgEN07+wCBWLEu610meyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKORrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:47:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfKORrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:47:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 956CEAFF1;
        Fri, 15 Nov 2019 17:47:22 +0000 (UTC)
Date:   Fri, 15 Nov 2019 18:47:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in
 get_mem_cgroup_from_mm()
Message-ID: <20191115174721.GB15216@dhcp22.suse.cz>
References: <20191106225131.3543616-1-guro@fb.com>
 <20191113162934.GF19372@blackbody.suse.cz>
 <20191113170823.GA12464@castle.DHCP.thefacebook.com>
 <20191114191657.GN20866@dhcp22.suse.cz>
 <20191114192018.GJ4163745@devbig004.ftw2.facebook.com>
 <20191114193340.GA24848@dhcp22.suse.cz>
 <20191114193736.GL4163745@devbig004.ftw2.facebook.com>
 <20191115174031.GA15216@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115174031.GA15216@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-11-19 18:40:31, Michal Hocko wrote:
> On Thu 14-11-19 11:37:36, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Nov 14, 2019 at 08:33:40PM +0100, Michal Hocko wrote:
> > > > It is useful for controlling admissions of new userspace visible uses
> > > > - e.g. a tracepoint shouldn't be allowed to be attached to a cgroup
> > > > which has already been deleted.
> > > 
> > > I am not sure I understand. Roman says that the cgroup can get offline
> > > right after the function returns. How is "already deleted" different
> > > from "just deleted"? I thought that the state is preserved at least
> > > while the rcu lock is held but my memory is dim here.
> > 
> > It's the same difference as between "opening a file and deleting it"
> > and "deleting a file and opening it".
> 
> I am sorry but I do not follow. How can css_tryget_online provide the
> same semantic when the css can go offline right after the tryget call
> returns so it is effectivelly undistinguishable from the case when the
> css was already online before the call was made.

s@online@offline@

And reading after myself it turned out to sound differently than I
meant. What I wanted to say really is, what is the difference that
css_tryget_online really guarantee when the css might go offline right
after the call suceeds so more specifically what is the difference
between
	if (css_tryget()) {
		if (online)
			DO_SOMETHING
	}
and
	if (css_tryget_online()) {
		DO_SOMETHING
	}

both of them are racy and do not provide any guarantee wrt. online
state.
-- 
Michal Hocko
SUSE Labs
