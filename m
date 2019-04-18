Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C60C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9393214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555569142;
	bh=a6TcY4NDn654iRe26wHBWmi1P0ogCH8rBAaFTg0XiUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C2KN+HEV3ltaTjrFXV28YnNA4YwTY/UFMZTR0/hzvGuZ26qMv3BznwaZekaeps3su
	 3DMmNgJLALa/erzRl1EzThtIcdBwNhXy3Zx2GhB7EFjYGG+aHS8T9Vl/fF2xZIbeTq
	 vqP8Y6AQHTYSb1mo6VxTBTNa7oMPSP1m8ayz6Ihc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfDRGcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:32:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388084AbfDRGcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:32:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D71EAF8A;
        Thu, 18 Apr 2019 06:32:20 +0000 (UTC)
Date:   Thu, 18 Apr 2019 08:32:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTIONS] THP allocation in NUMA fault migration path
Message-ID: <20190418063218.GA6567@dhcp22.suse.cz>
References: <aa34f38e-5e55-bdb2-133c-016b91245533@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa34f38e-5e55-bdb2-133c-016b91245533@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 21:15:41, Yang Shi wrote:
> Hi folks,
> 
> 
> I noticed that there might be new THP allocation in NUMA fault migration
> path (migrate_misplaced_transhuge_page()) even when THP is disabled (set to
> "never"). When THP is set to "never", there should be not any new THP
> allocation, but the migration path is kind of special. So I'm not quite sure
> if this is the expected behavior or not?
> 
> 
> And, it looks this allocation disregards defrag setting too, is this
> expected behavior too?H

Could you point to the specific code? But in general the miTgration path
should allocate the memory matching the migration origin. If the origin
was a THP then I find it quite natural if the target was a huge page as
well. How hard the allocation should try is another question and I
suspect we do want to obedy the defrag setting.
-- 
Michal Hocko
SUSE Labs
