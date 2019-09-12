Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27DC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA6420CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568293910;
	bh=1BVRp6Jdhq2LIzfXH91FkdH1Pyx1eRvvXJVHjQ5DMrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bd9fAbA+wpjM3Y607lUFHEMToCjMk+NT/hUXDX8mQhonsFxVKTg0twV55sYpNBG+6
	 OyTPfdHj3sU/QlffytK6C0bKKGtt2v6zwgaSRfHRvndgoD7AIqB73gP7q4Rjc2a2jG
	 tNplu73uxQbX6/zYDl2BFIS/huepn2YhdFVIPR8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfILNLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILNLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:11:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC3C2084D;
        Thu, 12 Sep 2019 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568293908;
        bh=1BVRp6Jdhq2LIzfXH91FkdH1Pyx1eRvvXJVHjQ5DMrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwR5uMriy0MozL8gyPhsCQ6j9MrbR7tKEdL3o9VMuwaAacTIvttZSreG0nYE1A/7m
         sJnTtIoSHNhRMxBHiYtv9f7iKLVSGDrt9iOTH2xscPYScJmgOMuwYOebUu4fDpOE6A
         rpbKjPwmaGwU6DBvfsFwrXM/5Fwfr20h6y3KNRC8=
Date:   Thu, 12 Sep 2019 14:11:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix function types in COND_SYSCALL
Message-ID: <20190912131143.u3rncvqdgx4z3ckz@willie-the-truck>
References: <20190910224044.100388-1-samitolvanen@google.com>
 <20190911151545.GD3360@blommer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911151545.GD3360@blommer>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:15:46PM +0100, Mark Rutland wrote:
> On Tue, Sep 10, 2019 at 03:40:44PM -0700, Sami Tolvanen wrote:
> > Define a weak function in COND_SYSCALL instead of a weak alias to
> > sys_ni_syscall, which has an incompatible type. This fixes indirect
> > call mismatches with Control-Flow Integrity (CFI) checking.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> This looks correct to me, builds fine, and I asume has been tested, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> In looking at this, I came to the conclusion that we can drop the ifdeffery
> around our SYSCALL_DEFINE0(), COND_SYSCALL(), and SYS_NI(), which I evidently
> cargo-culted from x86 (where the ifdeffery is actually necessary).

Curious: why is it required on x86?

> I can send a follow up for that.

Yes, please.

Will
