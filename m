Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C543C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD34D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564479586;
	bh=Ur80cZi+P7VGeE1gSAtDXzY4dUvDk299fULE493hOuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tUSLUT4A9YM0ZbHfdzhCOoDHk4WvDKa63ERjKZXMEi1uTJGNniufGWQZuVieF25kB
	 gyuOhx8rNxYsmX1gs6Vq7k/cmcRZNvg+OxFIzHtyKcXl8m2UJMA8Oxh3YF8sVUl2ol
	 6gGSAcLAtay/p+/jgU4HfrdEe9P6LgSaD1Mh91Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfG3Jjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfG3Jjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:39:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9212820665;
        Tue, 30 Jul 2019 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564479583;
        bh=Ur80cZi+P7VGeE1gSAtDXzY4dUvDk299fULE493hOuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1l18tcvaN9WqhaXVCiCE1h4lQUpkMOJ1MI0Cz02IeZgaDnBWOlK2ac9RW2deTg1G
         aOUPWAKMEjbkeRXd6wqcShM5LJ30w58TGaQ8qtQ/1HcxljlYSvhNghCMar/pUKYpwG
         ts/z5CzWdlZh/KgpEddGjjVeJs6VWK4oIlPqrUqU=
Date:   Tue, 30 Jul 2019 10:39:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20190730093938.bimxbvhd3alo3u37@willie-the-truck>
References: <20190730092547.1284-1-will@kernel.org>
 <20190730093713.GB15402@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730093713.GB15402@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:37:13AM +0200, Greg KH wrote:
> On Tue, Jul 30, 2019 at 10:25:47AM +0100, Will Deacon wrote:
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > [ Upstream commit 24951465cbd279f60b1fdc2421b3694405bcff42 ]
> > 
> > arch/arm/ defines a SIGMINSTKSZ of 2k, so we should use the same value
> > for compat tasks.
> > 
> > Cc: <stable@vger.kernel.org> # 4.9+
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > Reported-by: Steve McIntyre <steve.mcintyre@arm.com>
> > Tested-by: Steve McIntyre <93sam@debian.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > 
> > Aurelien points out that this didn't get selected for -stable despite its
> > counterpart (22839869f21a ("signal: Introduce COMPAT_SIGMINSTKSZ for use
> > in compat_sys_sigaltstack")) being backported to 4.9. Oops.
> 
> So this needs to go into 4.9.y, 4.14.y, and 4.19.y?

Yes, please.

Will
