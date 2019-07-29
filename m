Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD05C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0082720657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JdsUH2cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfG2U5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:57:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36910 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfG2U5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:57:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so27989768plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OCBg8SJ3+ECtlnFhkK0FZXvrbbwZJ3DFrryZcy3S/yo=;
        b=JdsUH2cUj009zj5qFs6JLBlNIHzixuWaj4EX++fiyjyjAUYk0q1QkquWeGOmV28RdT
         g7AJHn7fhYhZUcEsJzj1uZMyAB9I1Hm4II76KnAIyVmBHwpyO1Wyk1q8s7iwbWMsJq00
         4qnIMSFw5yF77nQ0KJOIIuq3CXf6FrmnxUH9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OCBg8SJ3+ECtlnFhkK0FZXvrbbwZJ3DFrryZcy3S/yo=;
        b=d3+RmMOBMxMVKL8KAiv/FrVUhiW2QNmhr+z6POA2KH6g9R+kochpSjw4x61Z+Q59R6
         aE41aPIZ2Kj9d/cXawywO0N5FY5UUaw/rsfDr/UCFgS3Gq+/WFFP9gcm4XvYH/9f+i2R
         joYJ+m8HQCxpUEf50scCTBhQzSxYZsvmaoo45wjYAlYUJ2dmqKfSY4EZBm6CQ35WQRi4
         5yuCfnL4KH0HHxHq4DXWj41BkOr2LbwTQ4Ln993nYYlVUUMPl4Ckaxz5Q1j6iDyyaUpb
         xI5TBve1lAyA4mLAtHzBRS7x/c5qHLXLjX6khOWGt1Sjr5FBris5WVeE8qEBWlIVAkM6
         9RPw==
X-Gm-Message-State: APjAAAWE+w+iBvEaUkKnUhvmA6Jgf6VREsJ5G6kyLzticMCUggxGN4YW
        3lozv9wXXvknWymy4ImqO1woOg==
X-Google-Smtp-Source: APXvYqzar/FfnQX4QpmqJOe7FT2L2T2uBt6mTBYIzvHmIg2kjIKhIA3ABzb6W9VGt6pLkZhg0wS6bg==
X-Received: by 2002:a17:902:aa8a:: with SMTP id d10mr114252213plr.154.1564433869179;
        Mon, 29 Jul 2019 13:57:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q21sm48521374pgb.48.2019.07.29.13.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:57:48 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:57:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: [PATCH 5.2 083/215] net/ipv4: fib_trie: Avoid cryptic ternary
 expressions
Message-ID: <20190729205746.GI250418@google.com>
References: <20190729190739.971253303@linuxfoundation.org>
 <20190729190753.998851246@linuxfoundation.org>
 <20190729205422.GH250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729205422.GH250418@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:54:22PM -0700, Matthias Kaehlcke wrote:
> Hi Greg,
> 
> Toralf just pointed out in another thread that the commit message and
> the content of this patch don't match (https://lkml.org/lkml/2019/7/29/1475)
> 
> I did some minor digging, the content of the queued patch is:
> 
> commit 4df607cc6fe8e46b258ff2a53d0a60ca3008ffc7
> Author: Nathan Huckleberry <nhuck@google.com>
> Date:   Mon Jun 17 10:28:29 2019 -0700
> 
>     kbuild: Remove unnecessary -Wno-unused-value
> 
> 
> however the commit message is from:
> 
> commit 25cec756891e8733433efea63b2254ddc93aa5cc
> Author: Matthias Kaehlcke <mka@chromium.org>
> Date:   Tue Jun 18 14:14:40 2019 -0700
> 
>     net/ipv4: fib_trie: Avoid cryptic ternary expressions
> 
> 
> It seems this hasn't been commited to -stable yet, so we are probably
> in time to remove it from the queue before it becomes git history and
> have Nathan re-spin the patch(es).

s/Nathan/Sasha/

For some reason I thought Nathan backported this and wondered that his
SOB is missing. The correct SOB is actually there.

> On Mon, Jul 29, 2019 at 09:21:19PM +0200, Greg Kroah-Hartman wrote:
> > [ Upstream commit 25cec756891e8733433efea63b2254ddc93aa5cc ]
> > 
> > empty_child_inc/dec() use the ternary operator for conditional
> > operations. The conditions involve the post/pre in/decrement
> > operator and the operation is only performed when the condition
> > is *not* true. This is hard to parse for humans, use a regular
> > 'if' construct instead and perform the in/decrement separately.
> > 
> > This also fixes two warnings that are emitted about the value
> > of the ternary expression being unused, when building the kernel
> > with clang + "kbuild: Remove unnecessary -Wno-unused-value"
> > (https://lore.kernel.org/patchwork/patch/1089869/):
> > 
> > CC      net/ipv4/fib_trie.o
> > net/ipv4/fib_trie.c:351:2: error: expression result unused [-Werror,-Wunused-value]
> >         ++tn_info(n)->empty_children ? : ++tn_info(n)->full_children;
> > 
> > Fixes: 95f60ea3e99a ("fib_trie: Add collapse() and should_collapse() to resize")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  scripts/Makefile.extrawarn | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index 3ab8d1a303cd..b293246e48fe 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -68,7 +68,6 @@ else
> >  
> >  ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CFLAGS += -Wno-initializer-overrides
> > -KBUILD_CFLAGS += -Wno-unused-value
> >  KBUILD_CFLAGS += -Wno-format
> >  KBUILD_CFLAGS += -Wno-sign-compare
> >  KBUILD_CFLAGS += -Wno-format-zero-length
