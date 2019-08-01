Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB97C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D2C20679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564677139;
	bh=SaEwfEDFkx07yGasFuq1p7SfdiGG/f5qI2W534mUt6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H30c2RHbYGdt+bn2GGG6tnEb136bx36SFlPXfkQJgrnTzoLdTLVb3xDm238a0SmRY
	 67jsvEpL18V1SyDElQS8m5+LwletOVtb1xf2PD7m59KI6eWod74gvu/FqokxChXMoe
	 m73OyszvtNl7B8XPYIsjxy049bAPTjGfNx3LtlPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfHAQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:32:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730790AbfHAQcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:32:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F04C7AFF3;
        Thu,  1 Aug 2019 16:32:15 +0000 (UTC)
Date:   Thu, 1 Aug 2019 18:32:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jan Hadrava <had@kam.mff.cuni.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wizards@kam.mff.cuni.cz, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [BUG]: mm/vmscan.c: shrink_slab does not work correctly with
 memcg disabled via commandline
Message-ID: <20190801163213.GO11627@dhcp22.suse.cz>
References: <20190801134250.scbfnjewahbt5zui@kam.mff.cuni.cz>
 <20190801140610.GM11627@dhcp22.suse.cz>
 <20190801155434.2dftso2wuggfuv7a@kam.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801155434.2dftso2wuggfuv7a@kam.mff.cuni.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 17:54:34, Jan Hadrava wrote:
> On Thu, Aug 01, 2019 at 04:06:10PM +0200, Michal Hocko wrote:
> > On Thu 01-08-19 15:42:50, Jan Hadrava wrote:
> > > There seems to be a bug in mm/vmscan.c shrink_slab function when kernel is
> > > compilled with CONFIG_MEMCG=y and it is then disabled at boot with commandline
> > > parameter cgroup_disable=memory. SLABs are then not getting shrinked if the
> > > system memory is consumed by userspace.
> > 
> > This looks similar to http://lkml.kernel.org/r/1563385526-20805-1-git-send-email-yang.shi@linux.alibaba.com
> > although the culprit commit has been identified to be different. Could
> > you try it out please? Maybe we need more fixes.
> 
> Yes, it is same.

I am happy to hear that!

> So my report is duplicate and I'm just bad in searching the
> archives, sorry.

No worries. Your bug report was really good with great level of details.
I wish all the bug reports were done so thoroughly.
 
> Just to be sure, i run my tests and patch proposed in the original thread
> solves my issue in all four affected stable releases:

Cc Andrew. I assume we can assume your Tested-by tag?

Thanks a lot!
-- 
Michal Hocko
SUSE Labs
