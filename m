Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7471EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B24215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567516960;
	bh=U2Z/6tSaKuZ4eMuKh+awd20GGBioRQSCxl/4tOVkZlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BLfERPXYWG7IfzHGAUiXZFp/wcczM023HzXmu0ddOep/TAsSJvNvxwJ6Ek8ERirXu
	 VNCqiL/i4rTa0w1pZaXBbtBy5gOvDogG1FsLK1OXNZm1r1PgdInB9vuYZJ7S5SESLF
	 o61g64JzmFB4Oms1wopVUI2OY0ywp2X3ubHtEOHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfICNWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:22:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728538AbfICNWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:22:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49677B11B;
        Tue,  3 Sep 2019 13:22:37 +0000 (UTC)
Date:   Tue, 3 Sep 2019 15:22:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, davem@davemloft.net, netdev@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
Message-ID: <20190903132231.GC18939@dhcp22.suse.cz>
References: <1567177025-11016-1-git-send-email-cai@lca.pw>
 <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
 <1567178728.5576.32.camel@lca.pw>
 <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 18:15:22, Eric Dumazet wrote:
> If there is a risk of flooding the syslog, we should fix this generically
> in mm layer, not adding hundred of __GFP_NOWARN all over the places.

We do already ratelimit in warn_alloc. If it isn't sufficient then we
can think of a different parameters. Or maybe it is the ratelimiting
which doesn't work here. Hard to tell and something to explore.

-- 
Michal Hocko
SUSE Labs
