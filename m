Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6116DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3107321E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS5LL+NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfHGO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:27:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39757 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfHGO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:27:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so41143316pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IV7gifFQp46H49cWxTh6Sk3Kt080hJvg+0jA2D4xXnE=;
        b=hS5LL+NGFi//l32zDr7/d4gdqMuQNQp6fYVDtPgmCS5+FWaojRhi7mQBadVXt2jSWr
         nCD9Vb7FDEsqrD5n6dTT+rwsAuXDcVDC/zbMokC7n/B5Q/v6Qth7bRSy3hXjsY3JF8L3
         Lib2tdyE46UPxzXwu2m0HqEbRFYvOuyDh3MK/Y1W7ypvskdDDuEjsFezE7FnxVOYGRZq
         kL0YtVYd6VofFPbqaOKONSccqHVDT+Qe3Zb7qox2szC0ATZANJnuNt46WaK2RymkxT+h
         2w94dwwEcxTJa1UGoMrXcKrQYprzY2GUkK9XrgUQbRJlAs/EKi4Z5PYXbJL2KKLrtD6H
         e8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IV7gifFQp46H49cWxTh6Sk3Kt080hJvg+0jA2D4xXnE=;
        b=OTYM4z1XS9zyIfzq58bWz0y6VIZi4GC7s/B+cNvVguwgrXpRhx6FFUTASwpu/P6HM+
         iQVFsKOiCJWKYJDCFS+V6NpIKZk5eromcMEkjMSr04Rr4BweNbTOryvE40z7YhU24B8U
         du3JGibe/q1ItJlU8CjPt7KqKlCdE0v9Q31kMlRtnfcewaNTWjoLbmDZFJWTesFDY0NK
         rGKk9VzA2sk/wR7qcUCsdOXdjG51nxUWRaF4rnaSNApqBm4df2JBBJ9NQOv6rVz3X5zx
         8K2PS53iIyHNrkzPylmbmGLiBPnv9WeakUXaiqJH+DKjkh7okHPCnCnuQBVJOBWMDMMr
         vVIQ==
X-Gm-Message-State: APjAAAX+TpbJmqnt5RQbWfc9FxD1p2ca4XDv8D5NiaTLNLJgV2BzYEl0
        BiSaZMzYYuakb+y7CNwtVtY=
X-Google-Smtp-Source: APXvYqwABYsvD2fMWNSqpSO1K8R0xRbmhMcHQlPTDPGh+bvWvNczgIhCV6XMnNVWCUQNOYBbsBj7xg==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id z12mr255701pjr.60.1565188050812;
        Wed, 07 Aug 2019 07:27:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j15sm123281384pfn.150.2019.08.07.07.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 07:27:29 -0700 (PDT)
Date:   Wed, 7 Aug 2019 07:27:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
Message-ID: <20190807142728.GA16360@roeck-us.net>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801230358.4193-2-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 01:03:58AM +0200, Rikard Falkeborn wrote:
> GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> as the first argument and the low bit as the second argument. Mixing
> them will return a mask with zero bits set.
> 
> Recent commits show getting this wrong is not uncommon, see e.g.
> commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> macro").
> 
> To prevent such mistakes from appearing again, add compile time sanity
> checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> arguments are known at compile time, and the low bit is higher than the
> high bit, break the build to detect the mistake immediately.
> 
> Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> of __builtin_constant_p().
> 
> If successful, BUILD_BUG_OR_ZERO() returns 0 of type size_t. To avoid
> problems with implicit conversions, cast the result of BUILD_BUG_OR_ZERO
> to unsigned long.
> 
> Since both BUILD_BUG_ON_ZERO() and __is_constexpr() only uses sizeof()
> on the arguments passed to them, neither of them evaluate the expression
> unless it is a VLA. Therefore, GENMASK(1, x++) still behaves as
> expected.
> 
> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> available in assembly") made the macros in linux/bits.h available in
> assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> compatible, disable the checks if the file is included in an asm file.
> 

Who is going to fix the fallout ? For example, arm64:defconfig no longer
compiles with this patch applied.

It seems to me that the benefit of catching misuses of GENMASK is much
less than the fallout from no longer compiling kernels, since those
kernels won't get any test coverage at all anymore.

Guenter
