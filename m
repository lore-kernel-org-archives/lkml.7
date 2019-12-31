Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F636C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25115206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577811030;
	bh=OrQoLAFQuxv9ST20C22yNuOyuDPJ/JzuMuHVY+QZ1z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IBDPpyBJ21lx3MgAJZajyiy8TVHXsWS2mLs2KfrLRdrq6/VpqcG4wdojRE5Yqs7Ar
	 FDTLdX2qLJpj8t6ROED6aTlxd4sUo9aUDBJcD1sdvWj9DDtewG/2Ojq23+nSp4bDZR
	 3XoVbUZbU9ieiw2QzVTuKYonocaVTdXXLzW7/Z0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLaQu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 11:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaQu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 11:50:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAAC8206DB;
        Tue, 31 Dec 2019 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577811028;
        bh=OrQoLAFQuxv9ST20C22yNuOyuDPJ/JzuMuHVY+QZ1z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zqIF6aE0dLChLp5dlf06PPcBCp09sH0Qt/jFrN9dibZCtaDmuxlt8ofhGuhVYqDEa
         /OI3ZhznfB8f02NKta4eC165lqzkdWtDdxJoFFzDcm/oRF85SffwnqydZapIl9qqc4
         mHIFYhS0DgCkNQJjOpw6RvYx+l91BHWNECOxCjj0=
Date:   Tue, 31 Dec 2019 17:50:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/434] 5.4.7-stable review
Message-ID: <20191231165025.GD2279398@kroah.com>
References: <20191229172702.393141737@linuxfoundation.org>
 <20191231160910.GC11542@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231160910.GC11542@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 08:09:10AM -0800, Guenter Roeck wrote:
> On Sun, Dec 29, 2019 at 06:20:53PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.7 release.
> > There are 434 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 31 Dec 2019 17:25:52 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For -rc2:
> 
> Build results:
> 	total: 158 pass: 148 fail: 10
> Failed builds:
> 	<almost all mips>
> Qemu test results:
> 	total: 385 pass: 320 fail: 65
> Failed tests:
> 	<all mips>
> 	<ppc64 as with mainline and v4.19.y>
> 
> mips and ppc as previously reported.
> 
> mips:
> 
> In file included from kernel/futex.c:60:
> arch/mips/include/asm/futex.h:19:10: fatal error: asm/sync.h: No such file or directory

Ugh, I thought I caught this already.  I'll go queue up a revert for the
next 5.4.y release with this fixed.

thanks,

greg k-h
