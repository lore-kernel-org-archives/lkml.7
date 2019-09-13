Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12494C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CFE21479
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568353342;
	bh=Dad/2dB2E/wqoGQmAFEVO2Ay51FWG0yohYBc/M581sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2payaKViouX7VOVN39A0T0endl0T3CbojpngyGYA2zjTOktDWz+NeLteZYtti181V
	 fmrVnCDvmeNmmECfGELuztEBx3I4AkpApTU1CuiJogECYqeJfr9V7QKiQGBd1M573y
	 m31eZriy5G0uhZqazxq5993eMFn1Btwfeku4jOVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfIMFmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 01:42:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfIMFmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 01:42:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so7992817wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 22:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSlNtFgitt14dDGHoASb+NTexJIytOoP8ixydWWFIH8=;
        b=mC1t5L+2lz1Hw1YIv2BhKKIkjwR5PK0ME+T3ztDo6YWqH+2oZ05VaG0vCcdyBY5QU+
         VeCxoxmLs4XcPdfzUIrxHjDJRv0PYdHUFYlG+l36yO3spe96pca/YBrF17ekuyhhe00N
         9BNXPjzIpXbBigy+lqkQ3+gL0MB5bxzJh+vC3E+K/ENBv5qVFbb868OAiFKm6rxYTExf
         L1Qnzz5XnrOCeWFjXUREeMxEC8AplbBezsaHiR7M4GUXACwhqss/Mo0bfn9JJcLHVCWK
         rh+DbZtAALXcpp7Bv9jNJar955HILMxMuSox8VJPe/aIurBGBWFG/anyP/wh45iruqvc
         JDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSlNtFgitt14dDGHoASb+NTexJIytOoP8ixydWWFIH8=;
        b=P6DW/KOJFj02x/iMN2Sk9QK41OBLGMTQjNkwFJGVTKGA0YV9FWss04HXanQT24OWuq
         dzg6QUcUse57alTXc02I4z2PT+yuKTSZkrOCLf9LtzZDMAy24ZCgCWvbSf9jeesCh6Ot
         8vtgKEOCQHC6oZ34bYC1ChB3y092klGdlEwkgbmnKIEDOfrYbYSdDoiGdnODych+N+mY
         m7ba03lvqrmEkCApQ+HB3QHzgvXZr5asu4i9oxEQN6BOVRAONZGj19ardjZjX0ziVd01
         5ZvEFG4Iy0BrhKi9qAQDykmd7MvktI71tw2IUa4qicanccqfsyDFSOckYunUF/ILHHkB
         rYrQ==
X-Gm-Message-State: APjAAAVc3DdwedxflQ12EBFrZ08aDmVlIXk3wuROXvGqMv+z/ArSTSQN
        pA0wT1tgAcQTVPFxAo6n6D4=
X-Google-Smtp-Source: APXvYqzcAJKt51S/9FTwPoHhARkpmDjREAn9SsJv+fA3xw4KzDExfEm46OhtSIpDObQiUYsoK8C7kw==
X-Received: by 2002:adf:a357:: with SMTP id d23mr10178038wrb.18.1568353338557;
        Thu, 12 Sep 2019 22:42:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s19sm40392869wrb.14.2019.09.12.22.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 22:42:18 -0700 (PDT)
Date:   Fri, 13 Sep 2019 07:42:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 6/6] x86: bug.h: use asm_inline in _BUG_FLAGS
 definitions
Message-ID: <20190913054215.GB118828@gmail.com>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-7-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912221927.18641-7-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> This helps preventing a BUG* or WARN* in some static inline from
> preventing that (or one of its callers) being inlined, so should allow
> gcc to make better informed inlining decisions.
> 
> For example, with gcc 9.2, tcp_fastopen_no_cookie() vanishes from
> net/ipv4/tcp_fastopen.o. It does not itself have any BUG or WARN, but
> it calls dst_metric() which has a WARN_ON_ONCE - and despite that
> WARN_ON_ONCE vanishing since the condition is compile-time false,
> dst_metric() is apparently sufficiently "large" that when it gets
> inlined into tcp_fastopen_no_cookie(), the latter becomes too large
> for inlining.
> 
> Overall, if one asks size(1), .text decreases a little and .data
> increases by about the same amount (x86-64 defconfig)
> 
> $ size vmlinux.{before,after}
>    text    data     bss     dec     hex filename
> 19709726        5202600 1630280 26542606        195020e vmlinux.before
> 19709330        5203068 1630280 26542678        1950256 vmlinux.after
> 
> while bloat-o-meter says
> 
> add/remove: 10/28 grow/shrink: 103/51 up/down: 3669/-2854 (815)
> ...
> Total: Before=14783683, After=14784498, chg +0.01%
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
