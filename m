Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2BAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147D3216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568101573;
	bh=qCKK+ZwRK74U3hEJqtiKQ6iZ3hduhTpM7HIjKwVnRAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eKVES5vV3mVNgS6mdH0jn6FjY/QM4EWQ88218GVeNJL8hVpIEnxgtnCcNzGCkwDXF
	 9W+XVnDm6RpQLmmJUttNS3ipGEyUqPkyksHMMLS+8hHq7XAG6nSfbm65r6eulwT0SE
	 2NLKvR6BEMvPAvPci+VWBmV0bl48P4HMRtoB9wKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404472AbfIJHqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbfIJHqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:46:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543572084D;
        Tue, 10 Sep 2019 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568101571;
        bh=qCKK+ZwRK74U3hEJqtiKQ6iZ3hduhTpM7HIjKwVnRAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJ/93vM+ibiNNsFQ20UdNU0QlCSEGDrjjQUbJ+KkjzfSHA6Sw7uz7zsxA7NhROsPX
         ybDjrsp1raImjF8GF4aAGP6SeLOPIroLeB9b8PSJnrgVKb4Q3KJCFtu51yrav9/eLc
         I90k87aOmYsFr5tqlILmZ+H6GnfXYceZi+3Q0oNA=
Date:   Tue, 10 Sep 2019 08:46:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
References: <20190909202153.144970-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909202153.144970-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:21:35PM +0200, Arnd Bergmann wrote:
> On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> when CONFIG_OPTIMIZE_INLINING is set.

Hmm. Given that CONFIG_OPTIMIZE_INLINING has also been shown to break
assignment of local 'register' variables on GCC, perhaps we should just
disable that option for arm64 (at least) since we don't have any toolchains
that seem to like it very much! I'd certainly prefer that over playing
whack-a-mole with __always_inline.

Will
