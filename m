Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B386C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BDD218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="tMtimk41";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2mLwOS6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfDXBjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:39:10 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58573 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729033AbfDXBjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:39:09 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2019 21:39:09 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0495C691;
        Tue, 23 Apr 2019 21:29:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 23 Apr 2019 21:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        0Buz22DogQK4lhUMfnJqX1XG8nFvJXUMOEVYem4e5xc=; b=tMtimk41BXLDbpZy
        VmBPTjYbuDLibbJGxg9yJg7bpqrUEh7aQmb0UJQkLCpXsPb0v22a0JHgAcJsArxc
        ww68pykN+LfbcZgStRFQJA9mkEmHvQ1hubdRIkHAwXPXtWcIrB85X85yYVS28pWp
        Tlrg8YH2ozC0lgQ+rj15A+h274ibRYh0EcvpXvoiw/Tw0HPRdeZuzLWGpFyAXONA
        8BvNIf0EzfEvyovTejh97ou4c1dVr6JKVMxvtUTns68QBlp14Vw7twwc4+Q8M1Lg
        ZN8h7YyvizWY9M0oltHWSpHjRqea31/hBfCTGHqt8COm0YVCuTPIKWQRT/U1Wsix
        D63jnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=0Buz22DogQK4lhUMfnJqX1XG8nFvJXUMOEVYem4e5
        xc=; b=2mLwOS6kMEH7jDqNElTP/EB9BgrmjbsK0xCcoY9TD43yZOOKjbU6EAWWp
        pzKvZUMLghYb9FxZc6KzUUb5BR8S+/D8KUF1LVf8fd4CZ8smbhlNXxl4lBA4fuRD
        mIMGc8raqNOTMXX8wWZNt/Aie+nUHzmiJewrNnkmnoT/XAyqgC2II5eBDAfo56jM
        I9aKjDhz2U5o7roPCWhrasAN5cVZ0+qfiSs1+0THUC4TamY0+aDtq0NSQBg39i5Y
        vbP3vevfkKFkMMFUgKaRQQc6sr9eveSo3UaNVHcp9Kix4dncu9iXma0pefrmEn1Z
        aiMr9Lh6gKIZFlPaNmxXCqFj3ckzQ==
X-ME-Sender: <xms:Ery_XCWE0bK0i3yw0S9-v853U02amYs8POGWWAl6xScF8CxlGnkjTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttder
    jeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhssh
    gvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghi
    lhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:Ery_XC13L-k4q1wdTeAuPpYip-bv_6c2-SztsTrSprzaCWh126eQYA>
    <xmx:Ery_XBYZb5MUy2jH99zhbgfStlWg5MmpWupBGfxY3GrGqRPxLX7bcA>
    <xmx:Ery_XNp7HtqzR8jT0x4osnCrezhm3v9AKjteUmQYZ-Qmp0fZrL_KhA>
    <xmx:E7y_XNsDCKfaOp5Yy5P3SZQQi-FRE02vWZ6fM4GECnYau_8_KV9SXg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55CF1103CF;
        Tue, 23 Apr 2019 21:29:51 -0400 (EDT)
Message-ID: <1b208e33c4f51630e2a336e95f25509fe7286e34.camel@russell.cc>
Subject: Re: [PATCH] powerpc/pseries: Use correct event modifier in
 rtas_parse_epow_errlog()
From:   Russell Currey <ruscur@russell.cc>
To:     Yue Haibing <yuehaibing@huawei.com>, paulus@samba.org,
        mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com, npiggin@gmail.com,
        ganeshgr@linux.ibm.com, anton@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Apr 2019 11:29:47 +1000
In-Reply-To: <20190423143533.26952-1-yuehaibing@huawei.com>
References: <20190423143533.26952-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-23 at 22:35 +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> rtas_parse_epow_errlog() should pass 'modifier' to
> handle_system_shutdown, because event modifier only use
> bottom 4 bits.
> 
> Fixes: 55fc0c561742 ("powerpc/pseries: Parse and handle EPOW
> interrupts")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Hello,

This fails to compile.

arch/powerpc/platforms/pseries/ras.c: In function
'rtas_parse_epow_errlog':
arch/powerpc/platforms/pseries/ras.c:288:26: error: 'event_modifier'
undeclared (first use in this function); did you mean 'modifier'?
   handle_system_shutdown(event_modifier);
                          ^~~~~~~~~~~~~~
                          modifier

So yes, I assume you meant "modifier" instead of "event_modifier" as
mentioned in your commit message.  Did you compile this before sending?

(found by snowpatch)

- Russell

