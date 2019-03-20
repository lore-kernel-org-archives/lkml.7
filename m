Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A3F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uw/1wxbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCTTH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:07:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45700 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTTH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:07:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id m16so2930849edd.12;
        Wed, 20 Mar 2019 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YgP5Igrf+i0XtbY2uoMQG3hU4nzhHB9A/1Y6jeUad+Q=;
        b=uw/1wxbBEHulO3i1tpiosMfbpPPeiGv7V7Buo0R2jzFb+tWFkFh/Ovhf1TPsHhixsY
         VkOqLk19dmx3KF9gKK+/IeUP/J2eisdoQfkl/ywmA7EkO3Ffxi8vIF3Lo8bdbkAJi+l6
         GQQLdzW2NOS39RbWkVlmbSlU8tERdIlEWc3cE2sCTOWnozRxghbN6pcsEP5lPjJAPK5r
         HvZCnWcc+k94Fx11ccCPPJHCAr5YrQ1g6onDVVZKKOfpqTF9Xeb2v4xP1RalOSwLNz1J
         EjXjGB+GpAyMquHxWBxHIiZMZLT66Wp/0tlHaba3P1nqncnKDQkuEDNq5IlQLIjtNMPC
         0aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgP5Igrf+i0XtbY2uoMQG3hU4nzhHB9A/1Y6jeUad+Q=;
        b=JwzdAOqXCyt39X6Unrzm2rEvGY0fg9GCMo0zApaUv1MUK6BBs1wpQFTZnrOb79i2oR
         0OMOM0FqlGzQlkiFM0/oAOlrj9VW7szrcbKmBQ2dl8PZGffUvKm1jOxCEAF7Pu9v8qUZ
         a68KvJCkKMccZhAfYZRd+29Nxw1IxScCVDVlVUs8gCjN+UcSsBv6+bmFvglY3lJ0U44x
         AdGUnQtUGjFtLqjsF2nyIPzfJE4PSt7ZmRYg17/libZA/8ZwNjxzkfKNIWXMkZMCPmKR
         tUvKe6wQZU78Q+y8bmaB7EQU7wQjCNxw7GniE8i8oEbYeBZUKBFIg+j7IKqSq2jbvBBx
         vS+w==
X-Gm-Message-State: APjAAAV61Ujz4Cn4mRx+vijxR6G92Bjl3HroOqhZe5X8EmNuRWov3xB6
        hSqwYnSOf/CncJPJuiAVDBY=
X-Google-Smtp-Source: APXvYqyD3R/deT5az9boyu8uIGuS16luOEaTTXH5DKQ5g+A2tMd/DP6bAcG7CHws9X4xwarGj6H1pw==
X-Received: by 2002:a17:906:33d5:: with SMTP id w21mr18055630eja.152.1553108875596;
        Wed, 20 Mar 2019 12:07:55 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f1sm872132edv.53.2019.03.20.12.07.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Mar 2019 12:07:54 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:07:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        tipc-discussion@lists.sourceforge.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
Message-ID: <20190320190752.GA28744@archlinux-ryzen>
References: <20190308001723.GA11197@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308001723.GA11197@archlinux-ryzen>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:17:23PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> kernel as it can catch some bugs that GCC can't. This warning came up:
> 
> net/tipc/node.c:831:6: warning: variable 'maddr' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>         if (!tipc_link_is_establishing(l)) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/tipc/node.c:847:46: note: uninitialized use occurs here
>         tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
>                                                     ^~~~~
> net/tipc/node.c:831:2: note: remove the 'if' if its condition is always true
>         if (!tipc_link_is_establishing(l)) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/tipc/node.c:821:31: note: initialize the variable 'maddr' to silence this warning
>         struct tipc_media_addr *maddr;
>                                      ^
>                                       = NULL
> 1 warning generated.
> 
> This definitely appears to be a legitimate warning but I'm not sure of
> the proper solution (should maddr be initialized to NULL or should it be
> set to something different in the else branch). Your input would be
> greatly appreciated.
> 
> Cheers,
> Nathan

Gentle ping (if there was a response to this, I didn't receive it). I
know I sent it in the middle of a merge window so I get if it slipped
through the cracks.

Thanks,
Nathan
