Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76988214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565705157;
	bh=OPKZSwfUQHEIt/8tweQffCk9ctSLq4PjQ33LJ1k4ht8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wstb/baPMp1OPzuwSFx65/Uwpy+0yaflHcyinLfTpzO3XxYzWmLnB37js+Jk3w8Wc
	 0F4pt+rxdhnhzXAgIZ8hYIxBGHOtwyNrOr1NHcWE8g4MUCkZ22E5u3vzSNA3rdUzqV
	 hLwRpv73KKbDgkUm+qJkLGZhEoK/oP0XbrLJIIC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfHMOF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:05:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729331AbfHMOFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06D4CADF1;
        Tue, 13 Aug 2019 14:05:53 +0000 (UTC)
Date:   Tue, 13 Aug 2019 16:05:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, dan.j.williams@intel.com,
        osalvador@suse.de, richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
Message-ID: <20190813140553.GK17933@dhcp22.suse.cz>
References: <20190813014012.30232-1-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813014012.30232-1-khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 19:40:10, Khalid Aziz wrote:
[...]
> Patch 1 adds code to maintain a sliding lookback window of (time, number
> of free pages) points which can be updated continuously and adds code to
> compute best fit line across these points. It also adds code to use the
> best fit lines to determine if kernel must start reclamation or
> compaction.
> 
> Patch 2 adds code to collect data points on free pages of various orders
> at different points in time, uses code in patch 1 to update sliding
> lookback window with these points and kicks off reclamation or
> compaction based upon the results it gets.

An important piece of information missing in your description is why
do we need to keep that logic in the kernel. In other words, we have
the background reclaim that acts on a wmark range and those are tunable
from the userspace. The primary point of this background reclaim is to
keep balance and prevent from direct reclaim. Why cannot you implement
this or any other dynamic trend watching watchdog and tune watermarks
accordingly? Something similar applies to kcompactd although we might be
lacking a good interface.
-- 
Michal Hocko
SUSE Labs
