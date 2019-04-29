Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA519C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B7020656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556533058;
	bh=39BBryQLuWOuI4Cl28HNzU0hwM/myaN0PUK+Iyifel8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wwXyAoB2NiiKCBc/nnjuAOEgL7BjWbEsJghC/irLrO42RG1o/FXeIHn2nFaodDqDl
	 rbXvViVu6qBzMoAupDlpfZh9XylQ7aoQpuTZ0UFei1hplBuEgW5jiYI+R7fH03OLd7
	 ws7cb9uNsGvRH+S+znN36YZirx1wxY+cVIITX3Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfD2KRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfD2KRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:17:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8327AD22;
        Mon, 29 Apr 2019 10:17:35 +0000 (UTC)
Date:   Mon, 29 Apr 2019 12:17:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, mm <linux-mm@kvack.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: memcg causes crashes in list_lru_add
Message-ID: <20190429101732.GB21837@dhcp22.suse.cz>
References: <f0cfcfa7-74d0-8738-1061-05d778155462@suse.cz>
 <2cbfb8dc-31f0-7b95-8a93-954edb859cd8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbfb8dc-31f0-7b95-8a93-954edb859cd8@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-04-19 11:25:48, Jiri Slaby wrote:
> On 29. 04. 19, 10:16, Jiri Slaby wrote:
[...]
> > Any idea how to fix this mess?
> 
> memcg_update_all_list_lrus should take care about resizing the array. So
> it looks like list_lru_from_memcg_idx returns a stale pointer to
> list_lru_from_kmem and then to list_lru_add. Still investigating.

I am traveling and on a conference this week. Please open a bug and if
this affects upstream kernel then report upstream as well. Cc linux-mm
and memcg maintainers. This doesn't ring bells immediately. I do not
remember any large changes recently.
-- 
Michal Hocko
SUSE Labs
