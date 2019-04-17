Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58249C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B282173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfDQJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:53:42 -0400
Received: from foss.arm.com ([217.140.101.70]:42038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfDQJxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:53:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4975A374;
        Wed, 17 Apr 2019 02:53:41 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FACD3F68F;
        Wed, 17 Apr 2019 02:53:39 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:53:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: futex: Restore oldval initialization to work
 around buggy compilers
Message-ID: <20190417095337.xnbdaki7kolqmchx@mbp>
References: <20190417072121.4450-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417072121.4450-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:21:21AM -0700, Nathan Chancellor wrote:
> Commit 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with
> non-zero result value") removed oldval's zero initialization in
> arch_futex_atomic_op_inuser because it is not necessary. Unfortunately,
> Android's arm64 GCC 4.9.4 [1] does not agree:
> 
> ../kernel/futex.c: In function 'do_futex':
> ../kernel/futex.c:1658:17: warning: 'oldval' may be used uninitialized
> in this function [-Wmaybe-uninitialized]
>    return oldval == cmparg;
>                  ^
> In file included from ../kernel/futex.c:73:0:
> ../arch/arm64/include/asm/futex.h:53:6: note: 'oldval' was declared here
>   int oldval, ret, tmp;
>       ^
> 
> GCC fails to follow that when ret is non-zero, futex_atomic_op_inuser
> returns right away, avoiding the uninitialized use that it claims.
> Restoring the zero initialization works around this issue.
> 
> [1]: https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/
> 
> Cc: stable@vger.kernel.org
> Fixes: 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks. That compiler version doesn't seem very smart. I'll queue this
for -rc6.

-- 
Catalin
