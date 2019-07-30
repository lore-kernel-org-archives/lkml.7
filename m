Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E3C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D314C20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564479439;
	bh=ACBlNakQ/oKIl6NGWB/sfYV8/tSIhvEY9neGq9na4Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GCcmWqI6rpk7UNpR4Uq2JS/8FCjddwPYlzaQpd/sknwWMiAk+NwSBnICyhPac/k08
	 MiE+TWkwn9bLjZGDp/gEpsy4IQ1F/YBN9GFKz3CjtHNkt31PEa6lMkqsCOp6sSZsp3
	 DVN49aYaKFmwCT5IYmr2qqkeNOjpfeNI7i1SPuXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfG3JhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfG3JhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:37:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE32520665;
        Tue, 30 Jul 2019 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564479437;
        bh=ACBlNakQ/oKIl6NGWB/sfYV8/tSIhvEY9neGq9na4Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfJ9o/vNLPQu4yWfxwA5aRJpEucP8Z27NRBVVTKEKgFe8mmTudurerR/wlHABg+Cl
         8v4iVBgFwHZWdpEJ7r0VGR53jODTLlbeAA+T07mAPLrVF3nCnEZoWecOBApOVLwdds
         zWwHEgcy6RLOqjNnM9caXI1+iKSZ7evs/rmW/hQo=
Date:   Tue, 30 Jul 2019 11:37:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "# 4 . 9+" <stable@vger.kernel.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ
Message-ID: <20190730093713.GB15402@kroah.com>
References: <20190730092547.1284-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730092547.1284-1-will@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:25:47AM +0100, Will Deacon wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> [ Upstream commit 24951465cbd279f60b1fdc2421b3694405bcff42 ]
> 
> arch/arm/ defines a SIGMINSTKSZ of 2k, so we should use the same value
> for compat tasks.
> 
> Cc: <stable@vger.kernel.org> # 4.9+
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Reported-by: Steve McIntyre <steve.mcintyre@arm.com>
> Tested-by: Steve McIntyre <93sam@debian.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> Aurelien points out that this didn't get selected for -stable despite its
> counterpart (22839869f21a ("signal: Introduce COMPAT_SIGMINSTKSZ for use
> in compat_sys_sigaltstack")) being backported to 4.9. Oops.

So this needs to go into 4.9.y, 4.14.y, and 4.19.y?

thanks,

greg k-h
