Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E043C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BC9217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555491667;
	bh=BEasVom47PMugj24F1KQvqhVPi/jf4xgcIShQ0cct9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K3keO8LJ37PrHPyK++EYzpjUUDvSTCGQQ69QpQDCbUzXCVxcTvxE/KnDrCkGE/gog
	 YHa2hQ004xfL8YVcrSLHKNj952OBUzppGAOBLFS2QDW/sm58MawsJoNMTZjA+ZHKzh
	 2IWdMVf4aWHuFkMzG6tzZQw0rgaJ0lL7TpPnQ9k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfDQJBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfDQJBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:01:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DA621773;
        Wed, 17 Apr 2019 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555491664;
        bh=BEasVom47PMugj24F1KQvqhVPi/jf4xgcIShQ0cct9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QspXLNjinfzU9rdPnzoDUmzYu+ZBLtgi1/C5H/RtSr6uCWUIOmCVE46zf6esKcOru
         0zfa7igR1qJ/ZdLWMoYZdW7eGE/eNhKGcZjbQoMrhmgurXyOgkd2qwKkx4nnsHYF5M
         DWd41Wmk5zsEyxsctviG4vKhIAVMd6bposfoTndY=
Date:   Wed, 17 Apr 2019 11:01:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: futex: Restore oldval initialization to work
 around buggy compilers
Message-ID: <20190417090102.GA11773@kroah.com>
References: <20190417072121.4450-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417072121.4450-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
