Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43ADC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922422075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552394919;
	bh=c39m1ZoQm3UHx3UWy8R2/wmrQiL89KMNRtZJQvDIUqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nOEqncZVve5P/QX1UT8gFMfPXfVQfuPOJrqEOYl6MgF5M0PXLS/F/qoRE/ON/1bpE
	 1VUhWzm5eq58nrHt2AqPhPtDkQ2EXJ+ZE9KC5ZiR+kR1wvCXIZtg1/AbtFLsN1PEmD
	 +Wf5pBExeFL0YcS3zJlXFvdTiGM8I+U2RFEz5730=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCLMsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:48:37 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28411206BA;
        Tue, 12 Mar 2019 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552394917;
        bh=c39m1ZoQm3UHx3UWy8R2/wmrQiL89KMNRtZJQvDIUqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faTttj98owX8lt7fpImc3J4aikWZUsUB7d7dAUQdVkbHmnlS2mWHGIJ7FKI08HraL
         PadZK5vdtADYbx2LVwch0mSuVNmxjFqhfeQix09ZCIf7X6HCL9cmq//F8z6+JkhOiq
         6JIjLaoClWKnNHgjWHRaxEDqjUQuoqLhZadhd6f4=
Date:   Tue, 12 Mar 2019 05:48:36 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH 4.19 1/5] staging: erofs: add error handling for xattr
 submodule
Message-ID: <20190312124836.GA23414@kroah.com>
References: <20190311060858.28654-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311060858.28654-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 02:08:54PM +0800, Gao Xiang wrote:
> commit cadf1ccf1b0021d0b7a9347e102ac5258f9f98c8 upstream.
> 
> This patch enhances the missing error handling code for
> xattr submodule, which improves the stability for the rare cases.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> 
> This series resolves the following conflicts:
>  FAILED: patch "[PATCH] staging: erofs: fix fast symlink w/o xattr when fs xattr is" failed to apply to 4.19-stable tree
>  FAILED: patch "[PATCH] staging: erofs: fix memleak of inode's shared xattr array" failed to apply to 4.19-stable tree
>  FAILED: patch "[PATCH] staging: erofs: fix race of initializing xattrs of a inode at" failed to apply to 4.19-stable tree
>  FAILED: patch "[PATCH] staging: erofs: keep corrupted fs from crashing kernel in" failed to apply to 4.19-stable tree
> 
> In addition, there is another patch called
>  staging: erofs: add error handling for xattr submodule
> that needs to be backported to 4.19 as well (4.20+ already has this patch.)
> 
>  drivers/staging/erofs/internal.h |   5 +-
>  drivers/staging/erofs/xattr.c    | 112 +++++++++++++++++++++++++++------------
>  2 files changed, 81 insertions(+), 36 deletions(-)

All now queued up, thanks.

greg k-h
