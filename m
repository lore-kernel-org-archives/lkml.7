Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE68DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06D12166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573146322;
	bh=suEeE7KwP1izl/rCD0Y/Vv5c6KOXHEIBOSklRCpzCec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fEybKBdLNB/x4eyYL3kI15LGg3TBEsWkhNAOtOdIzZWR8uWuQxqQlabV5ZzBT+mAL
	 RH/6IgJslZPiR56KD1xoi5xZEOa5gRyPMsMqtgCQBh4Zv+2svFtqqJIY0ws2B4rcv2
	 WMcZivGMpl5cDoBsQW27KS/PbmnfQiO8GYfMqUz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfKGRFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfKGRFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:05:21 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A9CB2077C;
        Thu,  7 Nov 2019 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573146320;
        bh=suEeE7KwP1izl/rCD0Y/Vv5c6KOXHEIBOSklRCpzCec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lU/ax5EmmTN1jc10dY9Tf8BnVtFnHEzEc5WXGMVkVSD3rfRvqqAORta9ZCUybEOM8
         RdMd0YIVIpb1PKFeF8HpGQaXe9MvyC3wcxtIsVKzNxXswd8aMPFP5xrZrAamc2OpVU
         KR9sTRKkfurg2rEfeUwtb4/0KdFynvhppsgZP1TM=
Date:   Thu, 7 Nov 2019 09:05:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to update dir's i_pino during
 cross_rename
Message-ID: <20191107170519.GA766@sol.localdomain>
Mail-Followup-To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191107061205.120972-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107061205.120972-1-yuchao0@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:12:05PM +0800, Chao Yu wrote:
> As Eric reported:
> 
> RENAME_EXCHANGE support was just added to fsstress in xfstests:
> 
> 	commit 65dfd40a97b6bbbd2a22538977bab355c5bc0f06
> 	Author: kaixuxia <xiakaixu1987@gmail.com>
> 	Date:   Thu Oct 31 14:41:48 2019 +0800
> 
> 	    fsstress: add EXCHANGE renameat2 support
> 
> This is causing xfstest generic/579 to fail due to fsck.f2fs reporting errors.
> I'm not sure what the problem is, but it still happens even with all the
> fs-verity stuff in the test commented out, so that the test just runs fsstress.
> 
> generic/579 23s ... 	[10:02:25]
> [    7.745370] run fstests generic/579 at 2019-11-04 10:02:25
> _check_generic_filesystem: filesystem on /dev/vdc is inconsistent
> (see /results/f2fs/results-default/generic/579.full for details)
>  [10:02:47]
> Ran: generic/579
> Failures: generic/579
> Failed 1 of 1 tests
> Xunit report: /results/f2fs/results-default/result.xml
> 
> Here's the contents of 579.full:
> 
> _check_generic_filesystem: filesystem on /dev/vdc is inconsistent
> *** fsck.f2fs output ***
> [ASSERT] (__chk_dots_dentries:1378)  --> Bad inode number[0x24] for '..', parent parent ino is [0xd10]
> 
> The root cause is that we forgot to update directory's i_pino during
> cross_rename, fix it.
> 
> Fixes: 32f9bc25cbda0 ("f2fs: support ->rename2()")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Tested-by: Eric Biggers <ebiggers@kernel.org>

The i_pino field is only valid on directories, right?

- Eric
