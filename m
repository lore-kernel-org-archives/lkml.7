Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AACC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639DA21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 03:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVQ3+cgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404172AbfIJDmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 23:42:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45775 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfIJDmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 23:42:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id l16so16991253wrv.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I9JwKIwr+KcLef+7d1/5gjR3bCqIxL34IZ86LTorCns=;
        b=CVQ3+cgxLWw61FKj7yOWdKz1jojuyE5x8+YMKLQUh3cHfsAnx1GBOuXKoUfaKnjRTp
         267Pc+WAALy9205rd+jwgWl7mdvOpFEgg8bwKmFmktSFCm1WSLgRm4kFWYBMhUSHECh1
         gCGKVBwIf2PKCOuPiCP12Wh34KpSieSNo7nc1JL/bEbM/rn9K9l+K0XQpTL2uu57U2xO
         HndZDqRGBrH9oomuVwrqmvYGroEKvifAgp0ZG3YxCwV69jr21gjTYBUtNYI1wXgL9Whv
         SwceE4gu3ZqPSpt0XahzXFL/R1FUlTMGZIO+46AotOR0rlLSaEms8mhzKyg9lMj2Xo5U
         iknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I9JwKIwr+KcLef+7d1/5gjR3bCqIxL34IZ86LTorCns=;
        b=dAl4+OqDTK8k1VF1idrLZeAZgJ07ZDoo7vhMfXFcGaHqCVHv7pA2GE9wh9mlsFUtAA
         faP33SJV+bUlq2yiiGep7dBfqzscIaYLfT6F6+js+S/gxfwO97REY1q/YmzVDxlW4WWr
         xwFNWvtkrdVdaLZcTOiDYW9fqoV9Y2e/pkYD3eX+UnJs9/hkMjsi30eXiHAOjbJNK6Ms
         j0bU5f9kymHfduPAykf7hp7i8nH8BEkxc4peFtV/9Zq9CCNyfNFvqJu57WOaxvXbwZSr
         AIE1/1OtIbChT7zhfQrd9ypdl0SBo8M9ToBFWdfe9MssGXn1zYIpT+iV9yrpTgQquNsF
         H48Q==
X-Gm-Message-State: APjAAAWUhKayI4L4gtp3Emt7/XCb87zIl8nOt6Vfv1rgKV6ejTzHOoEc
        WeqOK9IHQwMKkrb0BzMR1xs=
X-Google-Smtp-Source: APXvYqwFd/V3DElk6ZTAgVymeX7vhXdJdlcT95PolE9nZPbW6sNLcQZYU1WiKR3wmqMY4xNuV8QpWg==
X-Received: by 2002:adf:ef12:: with SMTP id e18mr22693738wro.65.1568086971953;
        Mon, 09 Sep 2019 20:42:51 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id 74sm1437257wma.15.2019.09.09.20.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 20:42:51 -0700 (PDT)
Date:   Mon, 9 Sep 2019 20:42:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190910034249.GA1673@archlinux-threadripper>
References: <20190909202153.144970-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909202153.144970-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:21:35PM +0200, Arnd Bergmann wrote:
> On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> when CONFIG_OPTIMIZE_INLINING is set.
> Clang then fails a compile-time assertion, because it cannot tell at
> compile time what the size of the argument is:
> 
> mm/memcontrol.o: In function `__cmpxchg_mb':
> memcontrol.c:(.text+0x1a4c): undefined reference to `__compiletime_assert_175'
> memcontrol.c:(.text+0x1a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__compiletime_assert_175'
> 
> Mark all of the cmpxchg() style functions as __always_inline to
> ensure that the compiler can see the result.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
