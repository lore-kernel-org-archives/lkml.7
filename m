Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF393C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74184206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WbhijUgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfDQNhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:37:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aNBp8zZsCedFf/ZARbBZvKowVyAgmvU1Z2npQm6qDvY=; b=WbhijUgqDxk3tSxsB6+3IAGVf
        hnz5NpW/yiYjVgkKR93janCG9tRp6cwa/V6WUT+De6Kno7KfTc5BuO/iGFERNvZWdLLOBmlwFapt1
        DFxPEsaNxlWrc4dyTvI1K2xXCMf3ElwDCglCgunZHWMTk84w9p6Z3rM5+pn9SwUuPSViLTPQxlLmY
        9qWBmrm3Fky+DKKU3Y0lEPe1NQHx3H+/86xx7m/ZBE2y5Av6NijtS0pA6gjft9ohs08MW1l0skMvb
        tpi7OSS14pq2Z1+vRE5gFOBRkv3x1oh5sYWD+tiJSsey8sKaYPPn/yTAlv5fthdreuZri8a2YFy/I
        zKerzYQsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGkkf-0006w2-H9; Wed, 17 Apr 2019 13:37:25 +0000
Date:   Wed, 17 Apr 2019 06:37:25 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH] mm/workingset : judge file page activity via
 timestamp
Message-ID: <20190417133724.GC7751@bombadil.infradead.org>
References: <1555487246-15764-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznFCy-Fm1WObEk77shPGALWhn5dWS3ZLXY77+q_4Yp6bAQ@mail.gmail.com>
 <CAGWkznEzRB2RPQEK5+4EYB73UYGMRbNNmMH-FyQqT2_en_q1+g@mail.gmail.com>
 <20190417110615.GC5878@dhcp22.suse.cz>
 <CAGWkznH6MjCkKeAO_1jJ07Ze2E3KHem0aNZ_Vwf080Yg-4Ujbw@mail.gmail.com>
 <20190417114621.GF5878@dhcp22.suse.cz>
 <CAGWkznHgc68AHOs2WNPARmwMMKazuKXL1R4VsPD_jwtzQeVK_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHgc68AHOs2WNPARmwMMKazuKXL1R4VsPD_jwtzQeVK_Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:26:22PM +0800, Zhaoyang Huang wrote:
[quoting Johannes here]
> As Matthew says, you are fairly randomly making refault activations
> more aggressive (especially with that timestamp unpacking bug), and
> while that expectedly boosts workload transition / startup, it comes
> at the cost of disrupting stable states because you can flood a very
> active in-ram workingset with completely cold cache pages simply
> because they refault uniformly wrt each other.
> [HZY]: I analysis the log got from trace_printk, what we activate have
> proven record of long refault distance but very short refault time.

You haven't addressed my point, which is that you were only testing
workloads for which your changed algorithm would improve the results.
What you haven't done is shown how other workloads would be negatively
affected.

Once you do that, we can make a decision about whether to improve your
workload by X% and penalise that other workload by Y%.
