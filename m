Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C6EC04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BF420843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="DH5hEGWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxm/GIBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfEPBrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:47:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34789 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfEPAva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:51:30 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 73D132594C;
        Wed, 15 May 2019 20:51:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2019 20:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        nUOGfNEnELr84sH3+7udhSvC4Y5B7HeBJX0EF2z10NM=; b=DH5hEGWuH0jMg6U1
        i0HbodrJ73e/pr2QYlw71DvEn+DTQ1G414t6ePtG4xKeV3SGYQnFRsK2EthVCp6g
        VV0HZe2ZwvUWMKT+mf5m7FH0LaFv7uN9FH/CrKnUK4GAAPUxV8UXL/ySWlfzBAv3
        2NV96R+xAvMUlTd8FGu0ByIG6cgGUpbzMSf9J+zphP26TM8FSxJUBOgbUPARfXOz
        QazFE9Ql2vJ65iTPRFnwrjAk9fFWQFkCyVPxQtQa4F4idVz8FG8LiHwUyvUo7oqU
        bO/zZyRjybWANu3iPvhZsmiTHhP1mEW1Ouwe1KnUospcQZExrfUeCj0jaGYy5Mnq
        0/oWLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nUOGfNEnELr84sH3+7udhSvC4Y5B7HeBJX0EF2z10
        NM=; b=kxm/GIBHNoPzxvJKF8QX5U8RjAkX+c263J9E4knrwl1udQc2kGcHajExa
        dolzp1ILCvwPnLB6Mmfoco5p+XkcNlptKi8+VVZNgz+TqdYMXTbxYLc3Nn6O2lz8
        AYboYsFMrH5o1W4rWiTcJypEqIariOrygRdk5yURm0i5vOoU9wlKKx1fARR3ZJbW
        KKz96JWWNY41F/gTq6jJkVEkns1lG5xMBluDMllWzI0nbGKFaMDszvRfqt1iBUd4
        n0F/E6BnJDvF016BhG/igE4rjlffmYunh8HPwQm1Mxd3mHzf5MrD5dkAuPE9BPbD
        5JcKQ6jpXRBA5bSsTeZQaxnlhVxiQ==
X-ME-Sender: <xms:DrTcXAgQ4m75SDKbO5CVXT9_lWhqxE_D-_307BIrqJZ9ZdvBdimZYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleelgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttder
    jeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhssh
    gvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghi
    lhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:DrTcXHcAy9u05Kd0lwjr6MbA0zcFEwL1uh1umEBaFSuVVnK_HSNuoA>
    <xmx:DrTcXK2nQ7QNeJLUBqSo_ZKXME8XADboRrZMDuGkfVvpkJfItgUEUA>
    <xmx:DrTcXGGYZnryUejGP9zo8njexRK9j94cB4OWX2ZYCCdMSHsHmwVAdQ>
    <xmx:D7TcXLAMv8H_wTmaVOOIYrZ-GPpl0Vjwz7vXFJKL3lnCkNVKBCDdYQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3524A80066;
        Wed, 15 May 2019 20:51:23 -0400 (EDT)
Message-ID: <2467361d57af7b9322e91b885b048eb014a6fe2d.camel@russell.cc>
Subject: Re: [RFC PATCH] powerpc/mm: Implement STRICT_MODULE_RWX
From:   Russell Currey <ruscur@russell.cc>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 16 May 2019 10:51:20 +1000
In-Reply-To: <df502ffe07caa38c46b0144fc824fff447f4105b.1557901092.git.christophe.leroy@c-s.fr>
References: <df502ffe07caa38c46b0144fc824fff447f4105b.1557901092.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 06:20 +0000, Christophe Leroy wrote:
> Strict module RWX is just like strict kernel RWX, but for modules -
> so
> loadable modules aren't marked both writable and executable at the
> same
> time.  This is handled by the generic code in kernel/module.c, and
> simply requires the architecture to implement the set_memory() set of
> functions, declared with ARCH_HAS_SET_MEMORY.
> 
> There's nothing other than these functions required to turn
> ARCH_HAS_STRICT_MODULE_RWX on, so turn that on too.
> 
> With STRICT_MODULE_RWX enabled, there are as many W+X pages at
> runtime
> as there are with CONFIG_MODULES=n (none), so in Russel's testing it
> works
> well on both Hash and Radix book3s64.
> 
> There's a TODO in the code for also applying the page permission
> changes
> to the backing pages in the linear mapping: this is pretty simple for
> Radix and (seemingly) a lot harder for Hash, so I've left it for now
> since there's still a notable security benefit for the patch as-is.
> 
> Technically can be enabled without STRICT_KERNEL_RWX, but
> that doesn't gets you a whole lot, so we should leave it off by
> default
> until we can get STRICT_KERNEL_RWX to the point where it's enabled by
> default.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

Thanks for this, I figured you'd know how to make this work on 32bit
too.  I'll test on my end today.

Note that there are two Ls in my name!  To quote the great Rusty, "This
Russel disease must be stamped out before it becomes widespread".


