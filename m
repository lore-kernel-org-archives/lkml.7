Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5540C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C13E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555501585;
	bh=RwkFnXr/uoD3P62yfD/tFAkp7I2IJV+HMntTkDiwEqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b/5YWqJXw+5isoAtB+mKlgBLTCf0JRQOnqlPV6Tc1QxHT8efFWjB4/P/H9f5Z5sDx
	 tJukRNbjroT16/WF2TE2fmmpksCzzmRFag6/f/WJIh7CQ5XevI41XZLNhtPrOJfjs1
	 vZagkn5h05UD80RJ0A7TxitVK2DHdDEDvhEHs0Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfDQLqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:46:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729522AbfDQLqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:46:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8FE3AFBD;
        Wed, 17 Apr 2019 11:46:22 +0000 (UTC)
Date:   Wed, 17 Apr 2019 13:46:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH] mm/workingset : judge file page activity via
 timestamp
Message-ID: <20190417114621.GF5878@dhcp22.suse.cz>
References: <1555487246-15764-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznFCy-Fm1WObEk77shPGALWhn5dWS3ZLXY77+q_4Yp6bAQ@mail.gmail.com>
 <CAGWkznEzRB2RPQEK5+4EYB73UYGMRbNNmMH-FyQqT2_en_q1+g@mail.gmail.com>
 <20190417110615.GC5878@dhcp22.suse.cz>
 <CAGWkznH6MjCkKeAO_1jJ07Ze2E3KHem0aNZ_Vwf080Yg-4Ujbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznH6MjCkKeAO_1jJ07Ze2E3KHem0aNZ_Vwf080Yg-4Ujbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 19:36:21, Zhaoyang Huang wrote:
> sorry for the confusion. What I mean is the basic idea doesn't change
> as replacing the refault criteria from refault_distance to timestamp.
> But the detailed implementation changed a lot, including fix bugs,
> update the way of packing the timestamp, 32bit/64bit differentiation
> etc. So it makes sense for starting a new context.

Not really. My take away from the previous discussion is that Johannes
has questioned the timestamping approach itself. I wasn't following very
closely so I might be wrong here but if that is really the case then it
doesn't make much sense to improve the implementation if there is no
consensus on the approach itself.

-- 
Michal Hocko
SUSE Labs
