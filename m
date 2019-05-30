Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62525C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE025FF1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559242037;
	bh=BiCinUEZJuwbfzUkUUIrQUAoM6JZgZ0vBcoByy1RYRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2n3Np0RjCb+73VZJdgIowvs0JULFXufhD5LhTkFKSbd7TN+4D8NqazYkFNMTGrVT/
	 9nx2ZPWPIKtiGcXU4wzE5/qsslbYM0mF4d/dsMEk411qiIn3HupRcHD1NrSQ1Z1xCE
	 XbLhCaQeMt/QPBqRCF7VOA5Cr16+UABOkhgIRG3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE3SrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfE3SrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:47:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96A02AD35;
        Thu, 30 May 2019 18:47:14 +0000 (UTC)
Date:   Thu, 30 May 2019 20:47:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190530184713.GI6703@dhcp22.suse.cz>
References: <20190521024820.GG10039@google.com>
 <20190521062421.GD32329@dhcp22.suse.cz>
 <20190521102613.GC219653@google.com>
 <20190521103726.GM32329@dhcp22.suse.cz>
 <20190527074940.GB6879@google.com>
 <CAKOZuesK-8zrm1zua4dzqh4TEMivsZKiccySMvfBjOyDkg-MEw@mail.gmail.com>
 <20190529103352.GD18589@dhcp22.suse.cz>
 <20190530021748.GE229459@google.com>
 <20190530065755.GD6703@dhcp22.suse.cz>
 <20190530080214.GA159502@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530080214.GA159502@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-05-19 17:02:14, Minchan Kim wrote:
> On Thu, May 30, 2019 at 08:57:55AM +0200, Michal Hocko wrote:
> > On Thu 30-05-19 11:17:48, Minchan Kim wrote:
[...]
> > > First time, I didn't think about atomicity about address range race
> > > because MADV_COLD/PAGEOUT is not critical for the race.
> > > However you raised the atomicity issue because people would extend
> > > hints to destructive ones easily. I agree with that and that's why
> > > we discussed how to guarantee the race and Daniel comes up with good idea.
> > 
> > Just for the clarification, I didn't really mean atomicity but rather a
> > _consistency_ (essentially time to check to time to use consistency).
> 
> What do you mean by *consistency*? Could you elaborate it more?

That you operate on the object you have got by some means. In other
words that the range you want to call madvise on hasn't been
remapped/replaced by a different mmap operation.

-- 
Michal Hocko
SUSE Labs
