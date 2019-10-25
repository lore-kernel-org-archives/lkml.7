Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7153CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90E121872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572038733;
	bh=kEfjHO6oNibA4rpD7BZt5/bc6vP5kbCOVkqfe8i1laE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xqpTCUB0RQc97dr/Xp4y+j0Le5wg8cXcIhI4kyvEudET6nPF/heOSS22wMoN9NNWK
	 QFNMBc8J0Upvv3Ug+fNqfPM1P56yITABgCphttrL9iISGSWQByWZM+bemO+UgbFHaq
	 fW09YcLvDCBcOIfQOmcVR6zwKPldFUyToJSZygEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfJYVZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfJYVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:25:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 537C92084C;
        Fri, 25 Oct 2019 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572038729;
        bh=kEfjHO6oNibA4rpD7BZt5/bc6vP5kbCOVkqfe8i1laE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vBxLZda3SmNmIzubNaJAHWdryG5otSiXjxJo39W1tZUQUwHG1J/Udt9gww0bvwi7G
         G20Cp/tzU39paZxYD6ka53naYFEFeBbM3G+JOrzkw5m9FeIWxtWzMqHgTncMl0aEhK
         OsRipbz7jkiF7DWKiv5fEfAk2WRjMnKGDvTKnpeU=
Date:   Fri, 25 Oct 2019 14:25:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-Id: <20191025142528.366148a0ffadf80946d62bbb@linux-foundation.org>
In-Reply-To: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
References: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 07:18:37 -0400 Qian Cai <cai@lca.pw> wrote:

> ﻿
> 
> > On Oct 25, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Considering the pagetypeinfo is a debugging tool we do not really need
> > exact numbers here. The primary reason to look at the outuput is to see
> > how pageblocks are spread among different migratetypes and low number of
> > pages is much more interesting therefore putting a bound on the number
> > of pages on the free_list sounds like a reasonable tradeoff.
> > 
> > The new output will simply tell
> > [...]
> > Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648
> 
> It was mentioned that developers could use this file is to see the movement of those numbers for debugging, so this supposed to introduce regressions as there is no movement anymore for those 100k+ items?

There are risks, but we have to do something!

I'd be inclined to remove the ">" though - that'll unnecessarily break
code which parses this data.

otoh, maybe that's a feature: breaking those parsers will alert people
to go in and find out what changed.

