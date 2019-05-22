Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214EBC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1DF20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="wvIeLbs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfEVVor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:44:47 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38187 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfEVVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:44:46 -0400
Received: by mail-yw1-f65.google.com with SMTP id b74so1445487ywe.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+U25ugincLLIJzKVGUO4d13q2ofk13rCni/NM43MthE=;
        b=wvIeLbs8tXj/V+7dlsuremfP54xMre97ghIYRAw2d80LxF7Prs6jbpJ7qGIblN5DaQ
         fzfHrfnOkUwUjWSiM6g04vId8nMdZaINNerfjXFSZ8B5K9Y3t5nkhSvUrzDJT8TH6/uc
         PrcanSUgxv6jFO1Tejr9Fpp5L6RPFKVZ3B4tjFtE2P7m/1d7cJY+oQBHxoFHVHMSahLE
         KJKJ4OiE0FZmlkjyVq8R7a8UXBpQdnS+AykXYcdy3kAPTpQRv9cUwbCsGkpR6Pp2ebzp
         ALax8ChcW1STMNollaxZPG/xFxaPgszasu52tqkIADBQpKhg0NLCwJ9zr+DpGJMM1OZg
         fjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+U25ugincLLIJzKVGUO4d13q2ofk13rCni/NM43MthE=;
        b=FvbXQp4CMgXfGA1E45SIZ8XznrG+4xpO3Ua/fAguA3iF8ckQa0Z0i8J7B4t0dykH4z
         GJvqOzGdYU3jzSOcFkanGgRMj68Tlo52m0z6vvBULdL2duM1fIP+1PZec6Aa1mAu72oq
         yPXyJkem+AsfwmsiCQcIC9UUJuxdqhKgP5Bv4XcM1/xc54yvAJOX8fLpvh8qpKYkEABp
         HyEHWytu07PB3uwpwKzJJTa3YDePUufWleJaznDKkJF4d3HxWs9o5puysaULHSC6Xetu
         h5j+HCYISw0RIguHB6QoCS2DWYjTdQo4nTx15PKuatcuYDU3ayqbf0R9KSywnXDt/qT6
         rFKA==
X-Gm-Message-State: APjAAAXy5ItnqWfaPSYv5C4aEg1tm6mq4rIe4Tgay2rOGAchL6l9UoCe
        xa9kb1bIY9U28XKOPrzQROM3Yw==
X-Google-Smtp-Source: APXvYqwd42palRiYNvvsXAgQvmQ8qs/chUXHybI4l4rSQdA0/uaMWee5epSYw38d2XETjIEwM0IOJg==
X-Received: by 2002:a0d:e544:: with SMTP id o65mr44187293ywe.382.1558561485696;
        Wed, 22 May 2019 14:44:45 -0700 (PDT)
Received: from t480s.mkb.name (047-049-164-163.biz.spectrum.com. [47.49.164.163])
        by smtp.gmail.com with ESMTPSA id x125sm9892550ywx.47.2019.05.22.14.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 14:44:44 -0700 (PDT)
Date:   Wed, 22 May 2019 17:44:37 -0400
From:   martin@omnibond.com
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
Subject: Re: [PATCH AUTOSEL 5.1 025/375] orangefs: truncate before updating
 size
Message-ID: <20190522214437.GA87137@t480s.mkb.name>
References: <20190522192115.22666-1-sashal@kernel.org>
 <20190522192115.22666-25-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522192115.22666-25-sashal@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it makes much sense to put this one in stable.  Without
the rest of the pagecache patches the race doesn't exist.

Martin

On Wed, May 22, 2019 at 03:15:25PM -0400, Sasha Levin wrote:
> From: Martin Brandenburg <martin@omnibond.com>
> 
> [ Upstream commit 33713cd09ccdc1e01b10d0782ae60200d4989553 ]
> 
> Otherwise we race with orangefs_writepage/orangefs_writepages
> which and does not expect i_size < page_offset.
> 
> Fixes xfstests generic/129.
> 
> Signed-off-by: Martin Brandenburg <martin@omnibond.com>
> Signed-off-by: Mike Marshall <hubcap@omnibond.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/orangefs/inode.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index c3334eca18c7e..3260f757c0803 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -172,7 +172,11 @@ static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
>  	}
>  	orig_size = i_size_read(inode);
>  
> -	truncate_setsize(inode, iattr->ia_size);
> +	/* This is truncate_setsize in a different order. */
> +	truncate_pagecache(inode, iattr->ia_size);
> +	i_size_write(inode, iattr->ia_size);
> +	if (iattr->ia_size > orig_size)
> +		pagecache_isize_extended(inode, orig_size, iattr->ia_size);
>  
>  	new_op = op_alloc(ORANGEFS_VFS_OP_TRUNCATE);
>  	if (!new_op)
> -- 
> 2.20.1
> 
