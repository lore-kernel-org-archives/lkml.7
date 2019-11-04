Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9E6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFC8222C6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LDs+Eg5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfKDGLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:11:32 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16496 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKDGLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:11:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dbfc1190000>; Sun, 03 Nov 2019 22:11:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 03 Nov 2019 22:11:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 03 Nov 2019 22:11:31 -0800
Received: from [10.2.168.52] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov
 2019 06:11:30 +0000
Subject: Re: [RFC] mm: gup: add helper page_try_gup_pin(page)
To:     Hillf Danton <hdanton@sina.com>
CC:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8df14660-2ce3-eda8-dc33-c4d092915656@nvidia.com>
Date:   Sun, 3 Nov 2019 22:09:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104043420.15648-1-hdanton@sina.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572847897; bh=zbw7Y554hllJtnv1eRsmfK6TOZZDrBBKwtgxjnu5HG4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LDs+Eg5qBfLCCAS7p6r+hey7cbtxeqn05DwLQxeYdAJSXzCqVcMi82fHuKzbnRBgK
         z5ttg8ao83mNBKR2DouQ+cKzShskuNLr2hYFNvxIpUd00QzOSZtjfz3f97BrP3wqHM
         Z1R4Qz+5kl1sxo1QeRqz5aRYaFXSifqtCkYoRA0rM3uc6O8Gr9hlbbkleJHgtAWemU
         svjyebwumdZ+XVprOEUbtAL1ofj8LEp63cP1IxHxpMRZAL1ohSF/j8tJCaLQrxg4uE
         O9+8+A6nXqDhOifCtMnCJx1xn7uYeJqCz1+F/9QEKr4KShlY4B18f9XD1+cE1iG2oC
         1cnzxaBkEAL7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/19 8:34 PM, Hillf Danton wrote:
...
>>
>> Well, as long as we're counting bits, I've taken 21 bits (!) to track
>> "gupers". :)  More accurately, I'm sharing 31 bits with get_page()...please
> 
> Would you please specify the reasoning of tracking multiple gupers
> for a dirty page? Do you mean that it is all fine for guper-A to add
> changes to guper-B's data without warning and vice versa?

It's generally OK to call get_user_pages() on a page more than once.
And even though we are seeing some work to reduce the number of places
in the kernel that call get_user_pages(), there are still lots of call sites.
That means lots of combinations and situations that could result in more
than one gup call per page.

Furthermore, there is no mechanism, convention, documentation, nor anything
at all that attempts to enforce "for each page, get_user_pages() may only
be called once."


...
>>
>> I think you must have missed the many contentious debates about the
>> tension between gup-pinned pages, and writeback. File systems can't
>> just ignore writeback in all cases. This patch leads to either
>> system hangs or filesystem corruption, in the presence of long-lasting
>> gup pins.
> 
> The current risk of data corruption due to writeback with long-lived
> gup references all ignored is zeroed out by detecting gup-pinned dirty
> pages and skipping them; that may lead to problems you mention above.
> 

Here, I believe you're pointing out that the current situation in the
kernel is already broken, with respect to fs interactions (especially
writeback) with gup. Yes, you are correct, there is a problem.

> Though I doubt anything helpful about it can be expected from fs in near

Actually, fs and mm folks are working together to solve this.

> future, we have options for instance that gupers periodically release
> their references and re-pin pages after data sync the same way as the
> current flusher does.
> 

That's one idea. I don't see it as viable, given the behavior of, say,
a compute process running OpenCL jobs on a GPU that is connected via
a network or Infiniband card--the idea of "pause" really looks more like
"tear down the complicated multi-driver connection, writeback, then set it
all up again", I suspect. (And if we could easily interrupt the job, we'd
probably really be running with a page-fault-capable GPU plus and IB card
that does ODP, plus HMM, and we wouldn't need to gup-pin anyway...)

Anyway, this is not amenable to quick fixes, because the problem is
a couple of missing design pieces. Which we're working on putting in.
But meanwhile, smaller changes such as this one are just going to move
the problems to different places, rather than solving them. So it's best
not to do that.

thanks,
-- 
John Hubbard
NVIDIA
