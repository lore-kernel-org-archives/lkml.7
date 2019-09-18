Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E31C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1820882
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568794501;
	bh=qQZzL6ly9I6kH55d2tXDq6DR4DL9Zv92rVRrgf918SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MhX7mkAwV+BIuu8XjG1u7QXRGYrdkQKY/Yw0GvA1qCKpWS53HYn+xrFLnfupJKfIW
	 qUq0mHdlqcM6QwFDHT36+FkSQBlNH1eM+OhKDSpJ4FM2dwtwi9F3veIznJfQqCFe2u
	 0qgyS5zrLNZtg7DuURIOcH6z5TM5zMXT8SJ81ANo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfIRIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:15:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727569AbfIRIPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:15:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8004EAF80;
        Wed, 18 Sep 2019 08:14:58 +0000 (UTC)
Date:   Wed, 18 Sep 2019 10:14:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memalloc_noio: update the comment to make it cleaner
Message-ID: <20190918081431.GD12770@dhcp22.suse.cz>
References: <20190917232820.23504-1-xiubli@redhat.com>
 <20190918072542.GC12770@dhcp22.suse.cz>
 <315246db-ec28-f5e0-e9b3-eba0cb60b796@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315246db-ec28-f5e0-e9b3-eba0cb60b796@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-09-19 16:02:52, Xiubo Li wrote:
> On 2019/9/18 15:25, Michal Hocko wrote:
> > On Wed 18-09-19 04:58:20, xiubli@redhat.com wrote:
> > > From: Xiubo Li <xiubli@redhat.com>
> > > 
> > > The GFP_NOIO means all further allocations will implicitly drop
> > > both __GFP_IO and __GFP_FS flags and so they are safe for both the
> > > IO critical section and the the critical section from the allocation
> > > recursion point of view. Not only the __GFP_IO, which a bit confusing
> > > when reading the code or using the save/restore pair.
> > Historically GFP_NOIO has always implied GFP_NOFS as well. I can imagine
> > that this might come as an surprise for somebody not familiar with the
> > code though.
> 
> Yeah, it true.
> 
> >   I am wondering whether your update of the documentation
> > would be better off at __GFP_FS, __GFP_IO resp. GFP_NOFS, GFP_NOIO level.
> > This interface is simply a way to set a scoped NO{IO,FS} context.
> 
> The "Documentation/core-api/gfp_mask-from-fs-io.rst" is already very detail
> about them all.
> 
> This fixing just means to make sure that it won't surprise someone who is
> having a quickly through some code and not familiar much about the detail.
> It may make not much sense ?

Ohh, I do not think this would be senseless. I just think that the NOIO
implying NOFS as well should be described at the level where they are
documented rather than the api you have chosen.
-- 
Michal Hocko
SUSE Labs
