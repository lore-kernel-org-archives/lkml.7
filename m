Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C585CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9722B206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564478858;
	bh=SKrtRvl5PY+xSQMY/2ee+4a4/9Fd63llyHB3gzj8fMw=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=HU7ocgBANI75FX+LHc8kwBgyl2LZDb3WbeLmS6AfG9DxUcCWwoUuZwe0OPpti/Mqy
	 EuniFD/Dh52Md0vGPUKmyg4iReAnTa7gYPKPwSKdVZBEvtuYnQ4Wt8k0LV+sm4iUwk
	 qLv/q1o759XL/eKSgzFaTe4RNanJWTm2aqgmvLkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfG3J1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfG3J1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:27:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2096C20665;
        Tue, 30 Jul 2019 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564478856;
        bh=SKrtRvl5PY+xSQMY/2ee+4a4/9Fd63llyHB3gzj8fMw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ygueO2xHBORMlwOlZoAFuDF440R5FDSKuhZ6cPycOBVLY2icVq7RQyfm3gj9MSltQ
         EHD+sP8Ok6RCtCfOCoL5CJl+xCOS2htNHA+QTX7X/jUH2Lk8lKAQqIijLVZ4zNz5SG
         yPCiZ48mMqNN5WmPkqyAY/FcD3m9BDPNi0n9uRZI=
Date:   Tue, 30 Jul 2019 10:27:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, steve.mcintyre@arm.com, dave.martin@arm.com
Subject: Re: [PATCH 0/2] Don't use SIGMINSTKSZ when enforcing alternative
 signal stack size for compat tasks
Message-ID: <20190730092730.q6djqrv6ag7fcofs@willie-the-truck>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
 <20190729202302.GA3443@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729202302.GA3443@aurel32.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:23:02PM +0200, Aurelien Jarno wrote:
> On 2018-07-25 14:45, Will Deacon wrote:
> > Hi all,
> > 
> > The Debian folks have observed a failure in the 32-bit arm glibc testsuite
> > when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
> > enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
> > which is higher for native arm64 tasks than compat 32-bit tasks.
> > 
> > These patches resolve the issue by allowing an architecture to define
> > COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
> > checking code.
> > 
> > Feedback welcome,
> > 
> > Will
> > 
> > --->8
> > 
> > Will Deacon (2):
> >   signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
> >   arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ
> 
> Only the first patch went to the stable kernels. The second one is
> missing, so the bug is still not fixed in those kernels. Would it be
> possible to also get it included?

Damn, you're right. I think the autosel bot picked the first commit but not
the second. In hindsight, we should've tagged them both, but oh well. I've
posted the patch here for -stable, with you on cc:

https://lore.kernel.org/lkml/20190730092547.1284-1-will@kernel.org/T/#u

Will
