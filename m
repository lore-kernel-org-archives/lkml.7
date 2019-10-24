Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57191CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2716F20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571924345;
	bh=vua3rl+jfj3mQkdazyKiysuDEtf/LrM/PTTNpTWXmpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNtQfajBQQUS/NhlmOLrNCNG1/nmfEFh0OwTL2okkAVgkXsjZYhnb5LSy+RKwDZKg
	 oTsdIX0Fzc9auwdwYfR9pRdionYGXzc59rkPC21bUGALRKAxSdOzTdcHTA9uQr1sW/
	 s8e34EHWmnDUAsQYfLmBvpRPCxCxRp4FNwK2xGFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393633AbfJXNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733296AbfJXNjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:39:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4BAABD14;
        Thu, 24 Oct 2019 13:39:01 +0000 (UTC)
Date:   Thu, 24 Oct 2019 15:38:59 +0200
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
Message-ID: <20191024133859.GX17610@dhcp22.suse.cz>
References: <20191024074205.GQ17610@dhcp22.suse.cz>
 <B292E9D2-D619-4A57-BBE3-A4D10826AA60@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B292E9D2-D619-4A57-BBE3-A4D10826AA60@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-10-19 07:11:52, Qian Cai wrote:
> 
> 
> > On Oct 24, 2019, at 3:42 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > It's been useful for debugging memory fragmentation problems and we do
> > not have anything that would provide a similar information. Considering
> 
> Actually, zoneinfo and buddyinfo are somewhat similar to it. Why
> the extra information in pagetypeinfo is still useful in debugging
> today’s real-world scenarios?

Because the migrate type is the information that helps to understand
fragmentation related issues. I am pretty sure Vlastimil would tell you
much more.

> > that making it root only is trivial and reducing the lock hold times
> > likewise I do not really see any strong reason to dump it at this
> > moment.
> 
> There is no need to hurry this, and clearly this is rather a good
> opportunity to discuss the consolidation of memory fragmentation
> debugging to ease the maintenance in long term.

Right. I think we should address the issue at hands first and then
handle any possible consolidations.

-- 
Michal Hocko
SUSE Labs
