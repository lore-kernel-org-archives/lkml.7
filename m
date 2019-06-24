Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4135C48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98922089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gzoyrUbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZujrtc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFXIuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:50:21 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37083 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfFXIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:50:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 64729451;
        Mon, 24 Jun 2019 04:50:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 24 Jun 2019 04:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=EU0+mxXojtdj4zHaqAU8jA2ho/O
        yu47FKR2tInc3jcQ=; b=gzoyrUbC1SvqfuIKJiA6NPwpWrx6QQAzTrlfu5JDSQv
        nV9LNtFNibzWoJh/Z3HXSRpuZM365UB9sZjX9KHhGkpCz50/vB7/t6OtnvEIK4mV
        s2fZxtti0WZwJ8XuE5b+zEtMsOcjGeeD6bboAzKo+IeYbwYJ4LbFazu+jOMnhcDe
        utvdMywWZKO7/sb6aQhoIEFP3vUPpo3aE4hanT7eirKskQNwL7co9N13KerCHJnQ
        paohrvzgOzc+YsaxQlUOdvLgeyfCEZSMkrXMOaBGKzqc5QC5gQi9oELgAedHK8F2
        vwX4aLc6Z5Ol6AJ4lgjRaYvfBLjM5QvQEQHA3UdLuhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EU0+mx
        Xojtdj4zHaqAU8jA2ho/Oyu47FKR2tInc3jcQ=; b=fZujrtc4Wv/3VD7HaLb9ed
        GQaZqMikjJlS4eLd4y0dOECG9yntA0qvmvmh24MB2ATC6WyFNu4xDt12AASSxbzQ
        J3SAHo0eolXPwp+JnWDcNONpZ99t82cKhcQpcRUMEL5TU1br6lH2B7Pu2AYEP0lq
        4s3Dg/XwvgnaFvXeqsoKByj+928jWAVAXB3BR5hrIKiYhhOsDrspP+Av87eWRiEL
        9I50fuVfdFFMXu5h0YzZAT5wX/4mldcM9VsmgsGFnyc4cX5yGYd9PNIwUycwAQUL
        of8hqdwXPlYm5xOae7NmJ/tlfQihoVw3LMBPFRZmcUJaQwwmNeud+zO9bXTBDAaA
        ==
X-ME-Sender: <xms:yo4QXeilSKt0JtGM2o2DbM6-jq3g1ciNBzLaxM8SNV3jQyMjvBUsXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepudduledrkedurddugeefrd
    dvgeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:yo4QXXNmpSNHHTTn-bQJiqfz2WhhxU3zS78GEqO8SVnWQVxZStVLhw>
    <xmx:yo4QXdYCxfL3BZS6nJrEAVf5JVqrJK_W4lrbxhMhyT9Z7g_-p189EA>
    <xmx:yo4QXU-fp98q4pyyJgXZAaJ8NlAB5K_xebGhvrjGyEF7hS46X74y0w>
    <xmx:y44QXYEJH_aGQygz3iKiPvQ2Lfi6El13S2bCYLmevMCzi-GwM9byMA>
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E54D80066;
        Mon, 24 Jun 2019 04:50:17 -0400 (EDT)
Date:   Mon, 24 Jun 2019 16:46:44 +0800
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: linux-next: build failure after merge of the staging tree
Message-ID: <20190624084644.GB2481@kroah.com>
References: <20190624173855.3c188955@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624173855.3c188955@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:38:55PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the staging tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> lib/Kconfig:132:error: recursive dependency detected!
> lib/Kconfig:132:        symbol CRC32 is selected by XZ_DEC
> lib/xz/Kconfig:2:       symbol XZ_DEC is selected by FW_LOADER_COMPRESS
> drivers/base/firmware_loader/Kconfig:158:       symbol FW_LOADER_COMPRESS depends on FW_LOADER
> drivers/base/firmware_loader/Kconfig:4: symbol FW_LOADER is selected by KS7010
> drivers/staging/ks7010/Kconfig:2:       symbol KS7010 depends on CRYPTO_HASH
> crypto/Kconfig:65:      symbol CRYPTO_HASH is selected by CRYPTO_CRC32_ARM_CE
> arch/arm/crypto/Kconfig:123:    symbol CRYPTO_CRC32_ARM_CE depends on CRC32
> For a resolution refer to Documentation/kbuild/kconfig-language.rst
> subsection "Kconfig recursive dependency limitations"
> 
> This is just while doing the "make multi_v7_defconfig".
> 
> Caused by commit
> 
>   3e5bc68fa596 ("staging: ks7010: Fix build error")
> 
> I have reverted that commit for today.

Odd.  I'll go revert this now too.

thanks,

greg k-h
