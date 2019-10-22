Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E51220684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfJVJk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:40:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730312AbfJVJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:40:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3A48B37A;
        Tue, 22 Oct 2019 09:40:56 +0000 (UTC)
Date:   Tue, 22 Oct 2019 11:40:54 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/16] mm,hwpoison: Rework soft offline for in-use
 pages
Message-ID: <20191022094049.GA20429@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-12-osalvador@suse.de>
 <20191018123901.GN5017@dhcp22.suse.cz>
 <20191021134846.GB11330@linux>
 <20191021140619.GQ9379@dhcp22.suse.cz>
 <20191022075626.GB19060@linux>
 <20191022083002.GE9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022083002.GE9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:30:02AM +0200, Michal Hocko wrote:
> But we have destructors for compound pages. Can we do the heavy lifting
> there?

Yes, we could.
Actually, I tried that approach, but I thought it was simpler this way.
Since there is no hurry in this, I will try to take that up again and
see how it looks.

> > > If the page is free then it shouldn't pin the memcg or any other state.
> > 
> > Well, it is not really free, as it is not usable, is it?
> 
> Sorry I meant to say the page is free from the memcg POV - aka no task
> from the memcg is holding a reference to it. The page is not usable for
> anybody, that is true but no particular memcg should pay a price for
> that. This would mean that random memcgs would end up pinned for ever
> without a good reason.

Sure, I will re-work that.

-- 
Oscar Salvador
SUSE L3
