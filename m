Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CE4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECF9222BD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573478844;
	bh=3khfY817g3PS5TkES+rklqgKgMSJFdurf0htRIWV3E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KXhbXw1HoJI4gtXC8NnZbtm+04+V8TwOA9pPSNo6RCNm4MnhD4ddLiEAbjd3YEssT
	 2PrIbKhCgNU2xm0U/vqhIwZ8HfNeaBrY2GkLrUT3/lG1g9GNS83kR5E3mXAWPs4IJ/
	 mrFxa18lw0L5M3P2Ez5B6bvGqPoxjPp1k/5JorP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKN1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfKKN1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:27:23 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCC32196E;
        Mon, 11 Nov 2019 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573478842;
        bh=3khfY817g3PS5TkES+rklqgKgMSJFdurf0htRIWV3E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+qMg8uHBw99MxUsk26njdjGjDT/Ta8ES+ZVEG2GQ0udk7tYSiKb+Jd1xciKXpB8F
         twU/HuO8oIndjNsYOzuMjoEa907GWnUixaMXCV1d3Wa3GFZc5BFH+gfgMfWCP1lcli
         Fpo2XworndBJncJiA4o6dYYhc2YNDoBJat65lfPM=
Date:   Mon, 11 Nov 2019 13:27:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, tangnianyao@huawei.com,
        xiexiangyou@huawei.com, linux-kernel@vger.kernel.org,
        arm@kernel.org
Subject: Re: [RFC PATCH v2] arm64: cpufeatures: add support for tlbi range
 instructions
Message-ID: <20191111132716.GA9394@willie-the-truck>
References: <5DC960EB.9050503@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DC960EB.9050503@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:23:55PM +0800, Zhenyu Ye wrote:
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This patch adds support for this feature.
> This is the second version of the patch.
> 
> I traced the __flush_tlb_range() for a minute and get some statistical
> data as below:
> 
> 	PAGENUM		COUNT
> 	1		34944
> 	2		5683
> 	3		1343
> 	4		7857
> 	5		838
> 	9		339
> 	16		933
> 	19		427
> 	20		5821
> 	23		279
> 	41		338
> 	141		279
> 	512		428
> 	1668		120
> 	2038		100
> 
> Those data are based on kernel-5.4.0, where PAGENUM = end - start, COUNT
> shows number of calls to the __flush_tlb_range() in a minute. There only
> shows the data which COUNT >= 100. The kernel is started normally, and
> transparent hugepage is opened. As we can see, though most user TLBI
> ranges were 1 pages long, the num of long-range can not be ignored.
> 
> The new feature of TLB range can improve lots of performance compared to
> the current implementation. As an example, flush 512 ranges needs only 1
> instruction as opposed to 512 instructions using current implementation.
> 
> And for a new hardware feature, support is better than not.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
> ChangeLog v1 -> v2:
> - Change the main implementation of this feature.
> - Add some comments.

How does this address my concerns here:

https://lore.kernel.org/linux-arm-kernel/20191031131649.GB27196@willie-the-truck/

?

Will
