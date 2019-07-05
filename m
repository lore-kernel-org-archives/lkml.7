Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE32FC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D85216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562360353;
	bh=blb3ParGsikEh+pFK9nY3PgBtuvBfyUvOjCyCqbNYME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DLK0Lob6ph5k8Og1bf7l0i8tsDnI0+WJPgPMEqteYhJfuLo2qJFY/MpVEp0zuFdxw
	 LvURh/N26O7AQhy190NJ/nXppK/RCYc+RZyxOckUJC/a5uqmLaCIwT5RKXFwX7nDr3
	 9vyfeytHzw97pQMmsBOgVPE7LiDQ9xNFWy/ICN7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGEU7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGEU7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:59:12 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33A92133F;
        Fri,  5 Jul 2019 20:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562360351;
        bh=blb3ParGsikEh+pFK9nY3PgBtuvBfyUvOjCyCqbNYME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK5T1WpJIKPq7+htupiCX8IYnFYw2prXmCoNV96uroJmlSbcnoPtKp+RvmwaYA1lL
         b4Hmcg2m7pxxkjXucAEuovmcYqd9bD9GO4DPOP+KMKQCVrE2ixVY4GQY3EK+hD3u5q
         9/467hFwZ3d49hmMAPVzOy6ksur+rDfhCIFE13l0=
Date:   Fri, 5 Jul 2019 16:59:09 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@kernel.org, Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [STABLE backport 4.9] arm64, vdso: Define
 vdso_{start,end} as array
Message-ID: <20190705205909.GJ10104@sasha-vm>
References: <20190705184726.3221252-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190705184726.3221252-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 08:47:20PM +0200, Arnd Bergmann wrote:
>From: Kees Cook <keescook@chromium.org>
>
>Commit dbbb08f500d6146398b794fdc68a8e811366b451 upstream.
>
>Adjust vdso_{start|end} to be char arrays to avoid compile-time analysis
>that flags "too large" memcmp() calls with CONFIG_FORTIFY_SOURCE.
>
>Cc: Jisheng Zhang <jszhang@marvell.com>
>Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>Suggested-by: Mark Rutland <mark.rutland@arm.com>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>Signed-off-by: Will Deacon <will.deacon@arm.com>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
>Backported to 4.9, which is lacking the rework from
>2077be6783b5 ("arm64: Use __pa_symbol for kernel symbols")

I've queued both this and the 4.4 backport, thanks!

--
Thanks,
Sasha
