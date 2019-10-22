Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D7CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB421783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571750531;
	bh=MeoYs3mE+9el3GE28fKqwkH8WEdxZBVlOlwsUQxe8Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kNO1ZkTyMFMVh8w9Yl3WFYVS3Z7mdH60GfH+C0f8on2IZm/Ih9pGRAwMtgIa78RKj
	 V1+foRim/AvLRUNc0B96N8S25zcojzyuknMtNn4DGUZOiuA41OtFXr579n/vakaxZG
	 pYrePDWsTOUiPoVHuuLi5GvFnRc3pWSOZ/Ea2XfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfJVNWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:22:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:34400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729146AbfJVNWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:22:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF5E6B486;
        Tue, 22 Oct 2019 13:22:06 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:22:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Message-ID: <20191022132206.GN9379@dhcp22.suse.cz>
References: <20191018002820.307763-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 17:28:04, Roman Gushchin wrote:
[...]
> Using a drgn* script I've got an estimation of slab utilization on
> a number of machines running different production workloads. In most
> cases it was between 45% and 65%, and the best number I've seen was
> around 85%. Turning kmem accounting off brings it to high 90s. Also
> it brings back 30-50% of slab memory. It means that the real price
> of the existing slab memory controller is way bigger than a pointer
> per page.

How much of the memory are we talking about here? Also is there any
pattern for specific caches that tend to utilize much worse than others?
-- 
Michal Hocko
SUSE Labs
