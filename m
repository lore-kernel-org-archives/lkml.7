Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFF2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0614F21928
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571739901;
	bh=v9eWcLU09j3QL42DGPoQHIRo4DpDx0J1RFpJPRqU1iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EBY2N/dDlwy0L8nmAPyO8W8FZESN0jD8KWUX695QyFBLqxBZtxlANzSV1vqQ/ObgC
	 aPBAE2Y+tPKHbhSOjRz3CvLYRBZAu1L3jD4jb4g0UhonPAxMm/eqUKB+ZAW1UuVmZA
	 OoaPdwwrXF5VwR5Eej7NzWoFwgnM8/j3WeuUA50w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfJVKY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:24:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbfJVKY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5BE5AAF1;
        Tue, 22 Oct 2019 10:24:57 +0000 (UTC)
Date:   Tue, 22 Oct 2019 12:24:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022102457.GJ9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz>
 <20191022074615.GA19060@linux>
 <20191022082611.GD9379@dhcp22.suse.cz>
 <20191022083505.GA19708@linux>
 <20191022092256.GH9379@dhcp22.suse.cz>
 <20191022095852.GB20429@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022095852.GB20429@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 11:58:52, Oscar Salvador wrote:
> On Tue, Oct 22, 2019 at 11:22:56AM +0200, Michal Hocko wrote:
> > Hmm, that might be a misunderstanding on my end. I thought that it is
> > the MCE handler to say whether the failure is recoverable or not. If yes
> > then we can touch the content of the memory (that would imply the
> > migration). Other than that both paths should be essentially the same,
> > no? Well unrecoverable case would be essentially force migration failure
> > path.
> > 
> > MADV_HWPOISON is explicitly documented to test MCE handling IIUC:
> > : This feature is intended for testing of memory error-handling
> > : code; it is available only if the kernel was configured with
> > : CONFIG_MEMORY_FAILURE.
> > 
> > There is no explicit note about the type of the error that is injected
> > but I think it is reasonably safe to assume this is a recoverable one.
> 
> MADV_HWPOISON stands for hard-offline.
> MADV_SOFT_OFFLINE stands for soft-offline.
> 
> MADV_SOFT_OFFLINE (since Linux 2.6.33)
>               Soft offline the pages in the range specified by addr and
>               length.  The memory of each page in the specified range is
>               preserved (i.e., when next accessed, the same content will be
>               visible, but in a new physical page frame), and the original
>               page is offlined (i.e., no longer used, and taken out of
>               normal memory management).  The effect of the
>               MADV_SOFT_OFFLINE operation is invisible to (i.e., does not
>               change the semantics of) the calling process.
> 
>               This feature is intended for testing of memory error-handling
>               code; it is available only if the kernel was configured with
>               CONFIG_MEMORY_FAILURE.

I have missed that one somehow. Thanks for pointing out.

[...]

> AFAICS, for hard-offline case, a recovered event would be if:
> 
> - the page to shut down is already free
> - the page was unmapped
> 
> In some cases we need to kill the process if it holds dirty pages.

Yes, I would expect that the page table would be poisoned and the
process receive a SIGBUS when accessing that memory.

> But we never migrate contents in hard-offline path.
> I guess it is because we cannot really trust the contents anymore.

Yes, that makes a perfect sense. What I am saying that the migration
(aka trying to recover) is the main and only difference. The soft
offline should poison page tables when not able to migrate as well
IIUC.
-- 
Michal Hocko
SUSE Labs
