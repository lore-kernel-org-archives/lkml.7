Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DE6C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6F5217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560506833;
	bh=00YDveKIzRA/Wgmz9r0i+z4w5SAjetUkYHtuL3H2+hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QKxWOETNcEEChcgWLEJFGJBe4drTs5wihj3E3EtRbq4YZIAoVBsVni9LIEf8MgQXU
	 0o3h3IO2VxYZ+9G1HwtPDtSyjRjvqprm0HMxiIq6hcpuBmju9muFNV/B7KKfFkViUx
	 Kh6QlBwr3mMhGatuT/66dkX2K0NjuLqHQsX3LEFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfFNKHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFNKHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:07:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23EB521773;
        Fri, 14 Jun 2019 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560506831;
        bh=00YDveKIzRA/Wgmz9r0i+z4w5SAjetUkYHtuL3H2+hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vW2Rktp3ulPmd/QTN+ZzUshT/ebz7+LLiXzio4Syen++SbD8ngo7mZv9TjU/sAnGm
         I/iGLyxFxHpzSwqWbjFQ7YpiLvTOGRYOp51Yb4B4cRKKuYSd6BcYiTch484z7PvgDF
         7HKwuV8X3wga35W2QHI1MY5mhjpmc/a6NaR+OII0=
Date:   Fri, 14 Jun 2019 12:07:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Enrico Weigelt <lkml@metux.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH] drivers: Inline code in devm_platform_ioremap_resource()
 from two functions
Message-ID: <20190614100709.GB8466@kroah.com>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
 <032e347f-e575-c89c-fa62-473d52232735@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032e347f-e575-c89c-fa62-473d52232735@web.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:22:40AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 14 Jun 2019 11:05:33 +0200
> 
> Two function calls were combined in this function implementation.
> Inline corresponding code so that extra error checks can be avoided here.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/base/platform.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)

Hey, looks like you timed out from my kill-file and this snuck through
somehow.  Let me go add you again to it, so I'm not bothered by
pointless stuff like this anymore.

*plonk*

