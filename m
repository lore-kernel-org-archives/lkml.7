Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391DAC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1923E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfFSMcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:32:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60531 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbfFSMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:32:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B7458046F; Wed, 19 Jun 2019 14:32:03 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:32:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        Randall Huang <huangrandall@google.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 33/75] f2fs: fix to avoid accessing xattr across the
 boundary
Message-ID: <20190619123210.GA14477@xo-6d-61-c0.localdomain>
References: <20190617210752.799453599@linuxfoundation.org>
 <20190617210754.076823433@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617210754.076823433@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When we traverse xattr entries via __find_xattr(),
> if the raw filesystem content is faked or any hardware failure occurs,
> out-of-bound error can be detected by KASAN.
> Fix the issue by introducing boundary check.

Ok, so this prevents fs corruption from causing problems,

> @@ -340,7 +347,11 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>  	else
>  		cur_addr = txattr_addr;
>  
> -	*xe = __find_xattr(cur_addr, index, len, name);
> +	*xe = __find_xattr(cur_addr, last_txattr_addr, index, len, name);
> +	if (!*xe) {
> +		err = -EFAULT;
> +		goto out;
> +	}

Is -EFAULT suitable here? We do not have userspace passing pointers to us, we
have fs corruption. -EUNCLEAN?

Should it do some kind of printk to let the user know fs is corrupted, and mark
it as needing fsck?

Thanks,
									Pavel
