Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD38C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDBD2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949933;
	bh=Imi9bY+6yhPMuvw82i8Qa+vwv8Dk8KW1mW9nmAIXFe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DaJUYP4qEKfr7wbmcbFO8NlDWvBlUEHAOlTBVc/fGv/YiyHP/7z/9Us0yQHPeGYtk
	 jN/VW11RDZ0LBmbQoA86XWjN1Z+0EfA59Hke6pIhVF0r5tLqMgRSmljyaUywE2S2sJ
	 rli5pVS8/lAxY9IdlAdBC27vqmPHXinkUao/tZ00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfJARMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfJARML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:12:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4012086A;
        Tue,  1 Oct 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569949931;
        bh=Imi9bY+6yhPMuvw82i8Qa+vwv8Dk8KW1mW9nmAIXFe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geALupBIgcBFHuj6zyoTCk/oBT+tBiwsHhHaHJWQ2b9e0SpvWFWc82N+LbVshFRBk
         f31tCJaL93eMsMWSstr3k34HhEAYiJFv7EzuXHlcMCF0LgTYCY46s2/gg7BGB5JFIK
         wBvuAFqqJR5B96/Qe+bX+8NlnyE3RlebOE0pzIIo=
Date:   Tue, 1 Oct 2019 18:12:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, nsaenzjulienne@suse.de,
        torvalds@linux-foundation.org, yamada.masahiro@socionext.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Partially revert "compiler: enable
 CONFIG_OPTIMIZE_INLINING forcibly"
Message-ID: <20191001171205.dubfntdlwifxik6z@willie-the-truck>
References: <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
 <20191001162121.67109-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001162121.67109-1-ndesaulniers@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:21:21AM -0700, Nick Desaulniers wrote:
> > So you'd prefer I do something like the diff below?
> 
> Yes, I find that diff preferable.  Use __always_inline only when absolutely
> necessary.  Even then, it sounds like this is a workaround for one compiler,
> so it should probably also have a comment. (I don't mind changing this for
> all compilers).

I wondered about a comment, but I couldn't find a good place to put it.
We basically need to say "If you're using explicit register variables in
your function, then you should use __always_inline", but there are other
functions too (such as arch/arm64/include/asm/vdso/gettimeofday.h) so
a random comment buried in the atomic code doesn't feel very helpful to
me.

Will
