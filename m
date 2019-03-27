Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256542063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="zZfAbUqB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1QCGt068"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbfC0S0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46655 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404276AbfC0SZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:25:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1597B219EB;
        Wed, 27 Mar 2019 14:25:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 27 Mar 2019 14:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=6ya/TRqV/AR/KMXtQfj6+BOK3Io
        c9vbZ4iNRalwWLlo=; b=zZfAbUqBZLWJ8xId4gN0lN+RpvYDO/8W7kHe5KLVd3/
        QZ2/UmtFhYUJgn/BDCa09wg9nDR+dv4xdss/zyOetznQtvAguznMdXEvOMyu5Qq1
        cx+i9D2aQmeeumLGg5an5niBbrsQo4TGtFpr42mwPqHRdjcSJVW6b+GWiXeNsVZ0
        L2hvizQPciFUK5DJRtINyK8V4ik2eQxnKwrQJD4ByGI4Pilspt0PjLYwwF7u3+OF
        HxCNApABBBwFareFFqouZmZ8yQ1jd0GvyF9O4UpWWUWCJT6VTvqWorwEEfvPABqU
        Mwa6UTIMCA4CZ3Ce4m0kSwXl5g/z9BnH2LXxEl9Z7lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6ya/TR
        qV/AR/KMXtQfj6+BOK3Ioc9vbZ4iNRalwWLlo=; b=1QCGt068Shpex0D4LMrfX6
        BxZr1JNCAxOIqgy4CGLfGCJKDmiK00lmvPmLKbWR7D4Cpz/gSRAv09EOHR1FwgIe
        3g0eDRi2f2nSC5VuUzYIeZ7PAsD+7sAmAt38r4Gk/nPu1xDw/BlXC8a/8N0FVEca
        gfO8p/UNCfVtkmCFAM6rePyehTXy/8hu3KQaCSANMccN5VKt50u+k2YcO0XCdMRA
        HB6h9xUX18nlH1kMdLTtIEt1pUlZzA5UYzCFmUVVX29ULbNQVHzU6nUjNY9boYQj
        q2nNyDRRRaEKph0hrdMcPVdh4GKr6p4M1JeGb//m2buWeQ/las+5Bm+10iP6u/2w
        ==
X-ME-Sender: <xms:LsCbXOVw28rOjKTMWAWNNpuCtJAvpEuTcFXuWqOxMJjXIo6JUp13Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekkedruddvkedrkedtrd
    dvfeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:LsCbXFModoAr0NaTRqb7n5MhXT_AA6yNs0gYllRzSIuPoOZ0Uxja1g>
    <xmx:LsCbXGeocsqAW2Lo8PbyuPcqspXIkhU1pgtyWioUH6rDEDBIY-6_IA>
    <xmx:LsCbXKnCiLs8VcYSpwRcM0t9TMshzJrK7RziZY5CI5u8IERAsbgL-w>
    <xmx:L8CbXFz9BV87QHHdcJw12KjHXH1PFb30vYC8kCFNhrak3MNwfn5iTA>
Received: from localhost (unknown [88.128.80.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F8A2E49DC;
        Wed, 27 Mar 2019 14:25:50 -0400 (EDT)
Date:   Wed, 27 Mar 2019 23:35:13 +0900
From:   Greg KH <greg@kroah.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "open list:ANDROID ION DRIVER" <devel@driverdev.osuosl.org>,
        "open list:ANDROID ION DRIVER" <dri-devel@lists.freedesktop.org>,
        "moderated list:ANDROID ION DRIVER" <linaro-mm-sig@lists.linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver : staging : ion: optimization for decreasing
 memory fragmentaion
Message-ID: <20190327143513.GA14931@kroah.com>
References: <1553063903-26768-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553063903-26768-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 02:38:23PM +0800, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Two action for this patch:
> 1. set a batch size for system heap's shrinker, which can have it buffer
> reasonable page blocks in pool for future allocation.
> 2. reverse the order sequence when free page blocks, the purpose is also
> to have system heap keep as more big blocks as it can.
> 
> By testing on an android system with 2G RAM, the changes with setting
> batch = 48MB can help reduce the fragmentation obviously and improve
> big block allocation speed for 15%.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  drivers/staging/android/ion/ion_heap.c        | 16 +++++++++++++++-
>  drivers/staging/android/ion/ion_system_heap.c |  2 +-
>  2 files changed, 16 insertions(+), 2 deletions(-)

What changed from v1?  Always put that below the --- line as the
documentation asks you to.

thanks,

greg k-h
