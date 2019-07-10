Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82BCC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B562B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562787848;
	bh=eHGI2UH/1bx+uOYu8VQv93m0Mv4AyHid8CuZx3p8J24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nitVns8S2hM6aR77czAfNxCfWy+TuAUI2LfjId1SO5F8yjO7S9FzdnjfJVqP5+1dz
	 BhUM4A5mahE3iD14NaP6Q7n+E5idGGZbBcLUYPIVFSbG1Blc2wqBlIzqyLpYapVVLS
	 PJqiGCp/B6OX6KJTaQFUw/74ioUk6mbHymyDd+f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfGJToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:44:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbfGJToH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:44:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15100AC37;
        Wed, 10 Jul 2019 19:44:05 +0000 (UTC)
Date:   Wed, 10 Jul 2019 21:44:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190710194403.GR29695@dhcp22.suse.cz>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
 <885afb7b-f5be-590a-00c8-a24d2bc65f37@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885afb7b-f5be-590a-00c8-a24d2bc65f37@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-07-19 11:42:40, Mike Kravetz wrote:
[...]
> As Michal suggested, I'm going to do some testing to see what impact
> dropping the __GFP_RETRY_MAYFAIL flag for these huge page allocations
> will have on the number of pages allocated.

Just to clarify. I didn't mean to drop __GFP_RETRY_MAYFAIL from the
allocation request. I meant to drop the special casing of the flag in
should_continue_reclaim. I really have hard time to argue for this
special casing TBH. The flag is meant to retry harder but that shouldn't
be reduced to a single reclaim attempt because that alone doesn't really
help much with the high order allocation. It is more about compaction to
be retried harder.
-- 
Michal Hocko
SUSE Labs
