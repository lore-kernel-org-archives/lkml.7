Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A6CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E2B214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572923094;
	bh=ayQqU8Qbemc32/HIUooa1m/XuTOUikPJAAUvS/qaxjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tRQHf2tKdF+U9THIyjD0ck8GUJgZbq790KXZFV+fVZj0ib3AQzl8+8yEsCHNDSNZB
	 xVaO0ytzXPuHGengB0LMWhc2GbvTsVA/ljoPwpDWrlKRwN0IvzZptSrZkqcNzalgEp
	 hYLMofIGSBNiw3QWTP0FeIujc5EEkI7qnhDcYnk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfKEDEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 22:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKEDEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 22:04:53 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF300206B8;
        Tue,  5 Nov 2019 03:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572923092;
        bh=ayQqU8Qbemc32/HIUooa1m/XuTOUikPJAAUvS/qaxjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4fbfC66Tih/uZITmA1N9W/HcX5rt9+ugMU/5Z3rcTE3omxFQXy4jw67GFv8tbBg9
         tACLhT3w+YOkMDSBb9ubrP70uZKwt5Wva5IeHIprFRpTdoXop48AZfklA245kBm7C6
         3XQ8sPBdy+FZrB11Cbde8HdqVp896Z/3h0f9SFKg=
Date:   Mon, 4 Nov 2019 19:04:51 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] Revert "f2fs: use kvmalloc, if kmalloc is failed"
Message-ID: <20191105030451.GA55090@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191101095324.9902-1-yuchao0@huawei.com>
 <20191101095324.9902-3-yuchao0@huawei.com>
 <20191105000249.GA46956@jaegeuk-macbookpro.roam.corp.google.com>
 <40d0df3f-cc55-d31a-474b-76f57d96bd89@huawei.com>
 <20191105023835.GD692@sol.localdomain>
 <00ade77c-5451-4953-0232-89342a029f33@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ade77c-5451-4953-0232-89342a029f33@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05, Chao Yu wrote:
> On 2019/11/5 10:38, Eric Biggers wrote:
> > On Tue, Nov 05, 2019 at 10:17:41AM +0800, Chao Yu wrote:
> >> On 2019/11/5 8:02, Jaegeuk Kim wrote:
> >>> On 11/01, Chao Yu wrote:
> >>>> This reverts commit 5222595d093ebe80329d38d255d14316257afb3e.
> >>>>
> >>>> As discussed with Eric, as kvmalloc() will try kmalloc() first, so
> >>>> when we need allocate large size memory, it'd better to use
> >>>> f2fs_kvmalloc() directly rather than adding additional fallback
> >>>> logic to call kvmalloc() after we failed in f2fs_kmalloc().
> >>>>
> >>>> In order to avoid allocation failure described in original commit,
> >>>> I change to use f2fs_kvmalloc() for .free_nid_bitmap bitmap memory.
> >>>
> >>> Is there any problem in the previous flow?
> >>
> >> No existing problem, however, it's redundant to introduce fallback flow in
> >> f2fs_kmalloc() like vmalloc() did, since we can call f2fs_vmalloc() directly in
> >> places where we need large memory.
> >>
> >> Thanks,
> >>
> > 
> > f2fs_kmalloc() also violated the naming convention used everywhere else in the
> > kernel since it could return both kmalloc and vmalloc memory, not just kmalloc
> > memory.  That's really error-prone since people would naturally assume it's safe
> > to free the *_kmalloc()-ed memory with kfree().
> 
> Agreed.

Then, why not just keeping f2fs_kvmalloc() and replace all f2fs_kmalloc() with
f2fs_kvmalloc()?

f2fs_kvmalloc()
- call kmalloc()
- vmalloc(), if failed

I'd like to keep the allocation behavior first.

Thanks,
