Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8AFC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A220206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kam.mff.cuni.cz header.i=@kam.mff.cuni.cz header.b="l+MW6Rd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfHAPyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:54:36 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:43704 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHAPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:54:36 -0400
Received: from campbell.kam.mff.cuni.cz (campbell.kam.mff.cuni.cz [195.113.17.233])
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id 7F190280D66;
        Thu,  1 Aug 2019 17:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kam.mff.cuni.cz;
        s=gen1; t=1564674874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GU7+iDu/nK46PLF4K/D+X5Kf5BcQEh/YuFAbSeHeWNw=;
        b=l+MW6Rd3/PIe6D8Dh8fADFE63RqDL5NyRHd8uO7bK3Pl7lI/KlwN0xNJlMjHU+LSN8pUfX
        fiSFMYVOWTCKnfDFHuPWb0nyafqzfIgqFVhFP34KxOAZBHX+spZ9Jlt+H9kL09wPfq9RsS
        gukaWQJk9x2D3J09ZQw5itO2nA9OH0E=
Received: by campbell.kam.mff.cuni.cz (Postfix, from userid 3081)
        id 75DD2940CF5; Thu,  1 Aug 2019 17:54:34 +0200 (CEST)
Date:   Thu, 1 Aug 2019 17:54:34 +0200
From:   Jan Hadrava <had@kam.mff.cuni.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wizards@kam.mff.cuni.cz, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [BUG]: mm/vmscan.c: shrink_slab does not work correctly with
 memcg disabled via commandline
Message-ID: <20190801155434.2dftso2wuggfuv7a@kam.mff.cuni.cz>
References: <20190801134250.scbfnjewahbt5zui@kam.mff.cuni.cz>
 <20190801140610.GM11627@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801140610.GM11627@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:06:10PM +0200, Michal Hocko wrote:
> On Thu 01-08-19 15:42:50, Jan Hadrava wrote:
> > There seems to be a bug in mm/vmscan.c shrink_slab function when kernel is
> > compilled with CONFIG_MEMCG=y and it is then disabled at boot with commandline
> > parameter cgroup_disable=memory. SLABs are then not getting shrinked if the
> > system memory is consumed by userspace.
> 
> This looks similar to http://lkml.kernel.org/r/1563385526-20805-1-git-send-email-yang.shi@linux.alibaba.com
> although the culprit commit has been identified to be different. Could
> you try it out please? Maybe we need more fixes.

Yes, it is same. So my report is duplicate and I'm just bad in searching the
archives, sorry.

Just to be sure, i run my tests and patch proposed in the original thread
solves my issue in all four affected stable releases:

> > This issue is present in linux-stable 4.19 and all newer lines.
> >     (tested on git tags v5.3-rc2 v5.2.5 v5.1.21 v4.19.63)

And culprit commit is in fact also the same: b0dedc49a2da introduces one issue
in one place and aeed1d325d42 (culprit according to original thread) moves it
few lines up:

> > Git bisect is pointing to commit:
> > 	b0dedc49a2daa0f44ddc51fbf686b2ef012fccbf
(...)
> > Following commit aeed1d325d429ac9699c4bf62d17156d60905519
> > deletes conditional continue (and so it fixes the problem). But it is creating
> > similar issue few lines earlier:
