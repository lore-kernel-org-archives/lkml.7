Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DDBCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2FA217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572921519;
	bh=AO5GUw4uAQW7SjlfIGhGgEAuiI6q1O8trlvLX3b/MnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=We59o0tPC6jnOCHNg3JYDCLLlFAHzR/iZLZh4gft6iFEe/R1UDp+/5OhbTItgrS38
	 jIqWmYIqa4AJcgPuYXaI8yeomBuJeSF4wSuIEwaXTxqTwLoyJ9gERfWxzuwUUHX9Vf
	 XlQfgShUGAOG8xI+QRgd4OPiRtMzIHBsfrUkZtiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfKECih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbfKECih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:38:37 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C33214D8;
        Tue,  5 Nov 2019 02:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572921516;
        bh=AO5GUw4uAQW7SjlfIGhGgEAuiI6q1O8trlvLX3b/MnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhOIaSgg4PyeAcIv/11SHw83YohNkY+3PEl9C++E070AEg22bhyJOvAFZbG46GpDK
         Uz5ET1GLWnqSqOuiYrmnlCqUp6q+Bw40PITQWHqOjqYNWAMJ9sWU/4r07RWwIv8W0m
         0LIkohafg+2shuXJOSTN+UAjbuzhYtQFj6tBOxg8=
Date:   Mon, 4 Nov 2019 18:38:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] Revert "f2fs: use kvmalloc, if kmalloc is failed"
Message-ID: <20191105023835.GD692@sol.localdomain>
Mail-Followup-To: Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191101095324.9902-1-yuchao0@huawei.com>
 <20191101095324.9902-3-yuchao0@huawei.com>
 <20191105000249.GA46956@jaegeuk-macbookpro.roam.corp.google.com>
 <40d0df3f-cc55-d31a-474b-76f57d96bd89@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d0df3f-cc55-d31a-474b-76f57d96bd89@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 10:17:41AM +0800, Chao Yu wrote:
> On 2019/11/5 8:02, Jaegeuk Kim wrote:
> > On 11/01, Chao Yu wrote:
> >> This reverts commit 5222595d093ebe80329d38d255d14316257afb3e.
> >>
> >> As discussed with Eric, as kvmalloc() will try kmalloc() first, so
> >> when we need allocate large size memory, it'd better to use
> >> f2fs_kvmalloc() directly rather than adding additional fallback
> >> logic to call kvmalloc() after we failed in f2fs_kmalloc().
> >>
> >> In order to avoid allocation failure described in original commit,
> >> I change to use f2fs_kvmalloc() for .free_nid_bitmap bitmap memory.
> > 
> > Is there any problem in the previous flow?
> 
> No existing problem, however, it's redundant to introduce fallback flow in
> f2fs_kmalloc() like vmalloc() did, since we can call f2fs_vmalloc() directly in
> places where we need large memory.
> 
> Thanks,
> 

f2fs_kmalloc() also violated the naming convention used everywhere else in the
kernel since it could return both kmalloc and vmalloc memory, not just kmalloc
memory.  That's really error-prone since people would naturally assume it's safe
to free the *_kmalloc()-ed memory with kfree().

- Eric
