Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F3C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C0020B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BFv71SBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGBQyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:54:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42526 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGBQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:54:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so668646plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YOrD3L7+D3RpXOEWEmqtGQ4AmNUEkApY6aCdIXrEgrQ=;
        b=BFv71SBeG8l6/HWnTjNskf1n1SP8LlSsXw2u6O+8x6/9pd3cuE7Y1G5j29ueHBNhy8
         tm8Q20zcODk4NTg/feMq5Wvi17m41FI/dmfEqVHu9czAp1QyyG43DjRHN5sq0/DkUBQK
         Bnw2rITr1+Q/yJai9kbAe6wGlHWl2jlbV8UUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YOrD3L7+D3RpXOEWEmqtGQ4AmNUEkApY6aCdIXrEgrQ=;
        b=jelcYOZp60pNJ94SLhHgvsshP+qeyGluW9AiM7AR0kIptoMhG24p3LRGjIKS/Ij6Q5
         Cmay/i4d79BVbXk0tKIK94dqe0Nkd01j6RcZMDvOda79sLa4qY7a/G7Y/xmaR+lbdnPX
         tEdvXEZTXe7dXqua0vbZ13Tn+h6hX/TkP/1gLGF6K7DVAZ3LMiVHE3OcA3xJ6RXfL7RT
         Gj3SEtT4NEsIBPXkhI2nE587sr8jxEoa7ar8z973DKa6DBAgUR4HJcHmrmT2M+4VLtPu
         vLWsQO6hrgNrJpmQfOVLn9c0h02728ExdWRYh48OiRrJ8fZY45mc+Jx6tMJCbkWRR/zg
         t5aA==
X-Gm-Message-State: APjAAAXGULRc8xqmdtqqW11x3aWiBjqTOrSlLdxVH+ulFV/S7wcm2f0X
        A50Lq0/FXVMAO1ffIMmAupg6nw==
X-Google-Smtp-Source: APXvYqwOnSn4p4gc9nADX6fU8aROdR2ltn7O8xpjV3aZn4Lmnr47mVQ9H0Ozs1WomAeLwHs/wgs3wQ==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr38110074plb.25.1562086448544;
        Tue, 02 Jul 2019 09:54:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s16sm14039729pfm.26.2019.07.02.09.54.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 09:54:07 -0700 (PDT)
Date:   Tue, 2 Jul 2019 12:54:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] kheaders: remove meaningless -R option of 'ls'
Message-ID: <20190702165406.GD98338@google.com>
References: <20190701005845.12475-1-yamada.masahiro@socionext.com>
 <20190701005845.12475-6-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701005845.12475-6-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:58:43AM +0900, Masahiro Yamada wrote:
> The -R option of 'ls' is supposed to be used for directories.
> 
>        -R, --recursive
>               list subdirectories recursively
> 
> Since 'find ... -type f' only matches to regular files, we do not
> expect directories passed to the 'ls' command here.
> 
> Giving -R is harmless at least, but unneeded.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

