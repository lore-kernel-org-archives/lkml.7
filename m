Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA23C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE920898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574319276;
	bh=Soi/YIivN4vUu2pouIaLtAtLyPpjLbNbJ0g6HzO+Nok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A9EQhr07cqbvS7kHSTXMSHgko40ayB0CyaKOPr4zrKjx6HJRl9j/YfUjw6ZqJEFfx
	 5l7b8gThVKNKW2f9yDF/9I/a89NC6thYYZ+Vc98a95dVqVsUdS3v3UnB/Jp99hJjuv
	 cTxySLoHlQU/pxkg4vcO88w9WtGfIGUjlaBvqrs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUGye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUGyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:54:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4B020898;
        Thu, 21 Nov 2019 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574319273;
        bh=Soi/YIivN4vUu2pouIaLtAtLyPpjLbNbJ0g6HzO+Nok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0zyqwOtJ8hRqt9t2BWslIYy2Vlgo4WNci9MIFnDA2MU65JHIP1MXYXYPmxoJWoEu
         knm3z6XeVys5Gq28V3DPvKq7Oansj1l36GxrmPzcqC4p243LMFEnAHdrt0+7H0qQDj
         rjK2CcKMHMDFiJT445v+wVR+qlymCJCjmct7Rs1U=
Date:   Thu, 21 Nov 2019 07:54:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 034/422] tee: optee: take DT status property into
 account
Message-ID: <20191121065431.GD340798@kroah.com>
References: <20191119051400.261610025@linuxfoundation.org>
 <20191119051402.211777274@linuxfoundation.org>
 <20191120021828.hwtwxfby3myn7mnh@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120021828.hwtwxfby3myn7mnh@toshiba.co.jp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:18:28AM +0900, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> On Tue, Nov 19, 2019 at 06:13:51AM +0100, Greg Kroah-Hartman wrote:
> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > 
> > [ Upstream commit db878f76b9ff7487da9bb0f686153f81829f1230 ]
> > 
> > DT nodes may have a 'status' property which, if set to anything other
> > than 'ok' or 'okay', indicates to the OS that the DT node should be
> > treated as if it was not present. So add that missing logic to the
> > OP-TEE driver.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> This patch requires the following additional commit:
> 
> commit c7c0d8df0b94a67377555a550b8d66ee2ad2f4ed
> Author: Julia Lawall <Julia.Lawall@lip6.fr>
> Date:   Sat Feb 23 14:20:36 2019 +0100
> 
>     tee: optee: add missing of_node_put after of_device_is_available
> 
>     Add an of_node_put when a tested device node is not available.
> 
>     The semantic patch that fixes this problem is as follows
>     (http://coccinelle.lip6.fr):
> 
>     // <smpl>
>     @@
>     identifier f;
>     local idexpression e;
>     expression x;
>     @@
> 
>     e = f(...);
>     ... when != of_node_put(e)
>         when != x = e
>         when != e = x
>         when any
>     if (<+...of_device_is_available(e)...+>) {
>       ... when != of_node_put(e)
>     (
>       return e;
>     |
>     + of_node_put(e);
>       return ...;
>     )
>     }
>     // </smpl>
> 
>     Fixes: db878f76b9ff ("tee: optee: take DT status property into account")
>     Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>     Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> Please apply this commit. And this is also required for 4.14.y.

Now queued up, thanks!

greg k-h
