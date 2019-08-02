Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4C4C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B26420679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564753227;
	bh=NPjyN3WS8up8aDkolmRZtNvAOKXL1QR1GuC27tidpqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ui3S6R8TD7vd4Y39pamReuMpcTsKM9pBgjItpv4Z9eYKrsE2DbfZY5PHFcP5ZW9es
	 /AK8/HtvxOGhdkeEx5Buzl31BsaWu/eSAvmpbrDfAqMRb7EzCadrK4hzsDP1cfWNQB
	 4qnwquGHn9/8SunygxMiqOsst2xd1Q5BApPKbikI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406402AbfHBNk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:40:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391258AbfHBNkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:40:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D6C3B62C;
        Fri,  2 Aug 2019 13:40:24 +0000 (UTC)
Date:   Fri, 2 Aug 2019 15:40:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Masoud Sharbiani <msharbiani@apple.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190802134021.GJ6461@dhcp22.suse.cz>
References: <20190802121059.13192-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802121059.13192-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-08-19 20:10:58, Hillf Danton wrote:
> 
> On Fri, 2 Aug 2019 16:18:40 +0800 Michal Hocko wrote:
[...]
> > Huh, what? You are effectively saying that we should fail the charge
> > when the requested nr_pages would fit in. This doesn't make much sense
> > to me. What are you trying to achive here?
> 
> The report looks like the result of a tight loop.
> I want to break it and make the end result of do_page_fault unsuccessful
> if nr_retries rounds of page reclaiming fail to get work done. What made
> me a bit over stretched is how to determine if the chargee is a memhog
> in memcg's vocabulary.
> What I prefer here is that do_page_fault succeeds, even if the chargee
> exhausts its memory quota/budget granted, as long as more than nr_pages
> can be reclaimed _within_ nr_retries rounds. IOW the deadline for memhog
> is nr_retries, and no more.

No, this really doesn't really make sense because it leads to pre-mature
charge failures. The charge path is funadamentally not different from
the page allocator path. We do try to reclaim and retry the allocation.
We keep retrying for ever for non-costly order requests in both cases
(modulo some corner cases like oom victims etc.).
-- 
Michal Hocko
SUSE Labs
