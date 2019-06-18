Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B4C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C31C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BWagP6n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfFRXVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:21:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39220 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFRXVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:21:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so6338347pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZfTdJ6aIMQJwzS251totZH4e8j1+FtxwNBavU5ugzX0=;
        b=BWagP6n0G1NjyfU/oMaA7agnVZ13RCCqLjCJU2wb+tXdmO3OeRVmyIS0C9gL88kMWW
         oKfMAx6mOUslDdEEVJiSJnquNzAFc/dNtlqfk2lxX/CNm0cTrTgkWuTQ4sOXMbFUbfzM
         nXdNtDkVdE3DbEu78vCn/NuK/IUDhm1tY37Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfTdJ6aIMQJwzS251totZH4e8j1+FtxwNBavU5ugzX0=;
        b=V+KxNqKnG8to9JXH2/yLCMkUBP8DcFklUAO2jiFhCO79XSLJaoNt9Yd+0zaNQUiYZ+
         jnXPob2vj/dr3YK+8uwYJPegszzLyuRe7VKhltX5MKeBiuWn34vOiS9g2lqjKDw6mJxX
         rNNSyOAWssrtSw2bsD0+YcFi1RF5Q1ZDYLI/O+C8D7UdsqMf828pcJOE3Ut5mKRwwALC
         kP1iRuuGdSVvG9FrDth0ai/vfb5fyNe9jNalMmDI1mbigSPJeveNykROAI2ydusq0zMF
         ItoWymOPYoYQyfgK+H1n3eZMJGbizBWuPHDZ+PtUoJDfRmdbXTPxWpfV3wKGQnYDx3IP
         T5Fg==
X-Gm-Message-State: APjAAAV0USz1aL6m3mROpo3XBpXECjE5nfKer+HFvR6FypqqS7YHr8w4
        cTEDV0PbDCRiAOIXu/w7icLuKQ==
X-Google-Smtp-Source: APXvYqzdlHfV2fjLKGboX1eKMLPkGFHswhIcGmdKWcLzHWynvJozKLsUlgfUdQogShJa1wssgZAOUg==
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr113081435pls.179.1560900102987;
        Tue, 18 Jun 2019 16:21:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b26sm17983691pfo.129.2019.06.18.16.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 16:21:42 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:21:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] net/ipv4: fib_trie: Avoid cryptic ternary expressions
Message-ID: <20190618232140.GW137143@google.com>
References: <20190618211440.54179-1-mka@chromium.org>
 <20190618230420.GA84107@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190618230420.GA84107@archlinux-epyc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 04:04:20PM -0700, Nathan Chancellor wrote:
> On Tue, Jun 18, 2019 at 02:14:40PM -0700, Matthias Kaehlcke wrote:
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
> 
> As an FYI, this is also being fixed in clang:
> 
> https://bugs.llvm.org/show_bug.cgi?id=42239
> 
> https://reviews.llvm.org/D63369

Great, thanks!

In this case it was actually useful to get the warning, even though it
didn't point out the actual bug. I think in general it would be
preferable to avoid such constructs, even when they are correct. But
then again, it's the reviewers/maintainers task to avoid unnecessarily
cryptic code from slipping in, and this just happens to be one instance
where the compiler could have helped.
