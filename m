Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E99EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B69B208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="yBmL4jvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWqN69+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfF1DCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:02:21 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40623 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbfF1DCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:02:21 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F20F13BD;
        Thu, 27 Jun 2019 23:02:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 27 Jun 2019 23:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        0nIuPza9JXPm3s5p5IiEosU7RutHY/f00ebuDHdt7wE=; b=yBmL4jvp7rsPCcLb
        IFhKyImO+XZO73g5TJWxS8NOeQ5IbHCf7weaSg5c4SRoAy7LhC5Tnu4REDcKdS16
        GDTwQMxvlucc2qIRQ2+5u5cryC5vZhqMQNCYsk6Lopy2CyveX3N0g35P99xUK+32
        QSei7TgwqhnavXquPrZhUTG+NPimxeOKCaRMlXRv1ljVJQSZymj6u+aoMvBSLli8
        QO1qzdatYoyqNHPAADcsxX7W9bY6lod/m7z72c0r5clLVeIIpFXzx75nFUAM3m+x
        ag6smrGFXtHT/GL8CXwi3ZF7BIbm4ULFiS0vLO6qtOGP3T61M78/Oj2ESKJL9Eat
        R47dIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=0nIuPza9JXPm3s5p5IiEosU7RutHY/f00ebuDHdt7
        wE=; b=VWqN69+vW80b8fJeaUpDr3ZtpRa5initaPO3nllJh1y8C09Ny2bps/qtv
        Am5Lm85JkJW5fPAJUAYQBqzxTnXYfhjxp2b5iN+bs8bVhSmb0vApwpklxozJz8nN
        9pGguPWYeG+A9XHKJYvqyWnErNWAGdFOp4xB9MeIuRL7ZcONCKBVQJtLdCkJlFur
        QTpGEicvP3gNnMYCjjdH0b4dzzeJGm7k8e97SKNQ+bGdeJCdhoiXb7SV211QEJ/B
        yW/ELRvOLIXOCKNKuGcczLyjBRYx3sf/bf71uHkF2GPW2puBlAN4EA5RCsQrqc4l
        0b8n5UF0WkfJsGArK+pjpgpHSxo+g==
X-ME-Sender: <xms:OYMVXdWSnAhGXFUij_cwVzqcpyRXb60ehByjbd6TZe9afTgioDttCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudelgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhepkffuhf
    fvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhushhsvghllhcuvehurhhr
    vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvdegrddujedurd
    ejvddrudegfeenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgv
    lhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OYMVXRgqHDdtoR6Hjpq70ACrAlC9WqVYKFF3C0Pspeen7-kJZgmOFQ>
    <xmx:OYMVXR68rKtKTSmx-QPU2ES6WC5DvklTpYGDzFYDsutFxxMnYThzKA>
    <xmx:OYMVXZ4dEytgzHDjJXuQ7kSI5Az4q9MRwIRzQPt5OUShJNAULBiNQQ>
    <xmx:O4MVXTt8JfGAHUz5QQQXn31QqxAwrUUWv21HndsriD6gcJ40BiobZQ>
Received: from crackle.ozlabs.ibm.com (124-171-72-143.dyn.iinet.net.au [124.171.72.143])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA70C380076;
        Thu, 27 Jun 2019 23:02:14 -0400 (EDT)
Message-ID: <b21dc7e6aa44f984fe64a2bd6c9a3158c6a10bf8.camel@russell.cc>
Subject: Re: [PATCH] powerpc/eeh_cache: fix a W=1 kernel-doc warning
From:   Russell Currey <ruscur@russell.cc>
To:     Qian Cai <cai@lca.pw>, mpe@ellerman.id.au
Cc:     sbobroff@linux.ibm.com, oohall@gmail.com, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 13:02:11 +1000
In-Reply-To: <1559767579-7151-1-git-send-email-cai@lca.pw>
References: <1559767579-7151-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 16:46 -0400, Qian Cai wrote:
> The opening comment mark "/**" is reserved for kernel-doc comments,
> so
> it will generate a warning with "make W=1".
> 
> arch/powerpc/kernel/eeh_cache.c:37: warning: cannot understand
> function
> prototype: 'struct pci_io_addr_range
> 
> Since this is not a kernel-doc for the struct below, but rather an
> overview of this source eeh_cache.c, just use the free-form comments
> kernel-doc syntax instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Looks good to me.

Acked-by: Russell Currey <ruscur@russell.cc>

