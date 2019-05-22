Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8CFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56EF20644
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558540343;
	bh=4+paJsk9Jg68SzcArVnCCYX3wNU5uSeCx1DZ/waAoU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XKF2JFNr54x2RC6Hv0XjuUKpgZQwlHPC2dKL/wvW2oJ9jsa6vT634l9LxMQMIMpGI
	 wAI4NI2AKILbB+K4ZgDTIYc3OCRc33mgwSLdCCdSZIlrYgVC+phYbSvdiuLggL7zmj
	 HFFNNpZ2a6amBmrXk7iEFOag1pUGQDYYckrb7Ecs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfEVPwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729656AbfEVPwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:52:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77824AEE2;
        Wed, 22 May 2019 15:52:21 +0000 (UTC)
Date:   Wed, 22 May 2019 17:52:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] proc/meminfo: add MemKernel counter
Message-ID: <20190522155220.GB4374@dhcp22.suse.cz>
References: <155853600919.381.8172097084053782598.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155853600919.381.8172097084053782598.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-05-19 17:40:09, Konstantin Khlebnikov wrote:
> Some kinds of kernel allocations are not accounted or not show in meminfo.
> For example vmalloc allocations are tracked but overall size is not shown
> for performance reasons. There is no information about network buffers.
> 
> In most cases detailed statistics is not required. At first place we need
> information about overall kernel memory usage regardless of its structure.
> 
> This patch estimates kernel memory usage by subtracting known sizes of
> free, anonymous, hugetlb and caches from total memory size: MemKernel =
> MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Hugetlb.

Why do we need to export something that can be calculated in the
userspace trivially? Also is this really something the number really
meaningful? Say you have a driver that exports memory to the userspace
via mmap but that memory is not accounted. Is this really a kernel
memory?

-- 
Michal Hocko
SUSE Labs
