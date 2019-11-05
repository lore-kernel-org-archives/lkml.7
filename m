Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE91C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8412087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572975597;
	bh=y2opLO7+HSMdSjVhYh/qVkiMvhFsEgpR1zbUKDSf3Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GXC2s85jIlrHU+izNgvN8q8+RO5NzP0fGRAhOkpv7ui7r4w3RFu7ASyd3OLZ9iYg3
	 nRwhNcpVbfHRNgLPWF6kSC1GpUHowvLB7jE4idCQKoPlnl7jNFPFX0iDK2vMMk3OPf
	 JPbreDx9/2pmbJT740Wp6CnoNW08aaGIp1wM+Clo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbfKERj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387776AbfKERj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:39:56 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A3B52087E;
        Tue,  5 Nov 2019 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572975594;
        bh=y2opLO7+HSMdSjVhYh/qVkiMvhFsEgpR1zbUKDSf3Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTa4wDimisYBqz8aF7I1lGHjb8jutSs34fju9pKAYwPMva15JxywK6ltHJb/UVVJb
         ObxHekeCseV2L5njEMMgtlrsDltq+EEY/CYfSP96c9Oxyp2jVvkK3DulaDCi2bzYYV
         NLrHucRF/mAZlwSTgkqBCky7bja5uN5D2kieWzu0=
Date:   Tue, 5 Nov 2019 18:33:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v3 0/8] drivers: add new variants of
 devm_platform_ioremap_resource()
Message-ID: <20191105173358.GA2876364@kroah.com>
References: <20191022084318.22256-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022084318.22256-1-brgl@bgdev.pl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:43:10AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Note: resending with Arnd's review tags and rebased on top of char-misc-next
> 
> The new devm_platform_ioremap_resource() helper has now been widely
> adopted and used in many drivers. Users of the write-combined ioremap()
> variants could benefit from the same code shrinkage. This series provides
> a write-combined version of devm_platform_ioremap_resource() and uses it in a
> relevant driver with the assumption that - just like was the case
> previously - a coccinelle script will be developed to ease the transition
> for others.
> 
> There are also users of platform_get_resource_byname() who call
> devm_ioremap_resource() next, so provide another variant that they can use
> together with two examples.

I've queued these up in my driver-core tree as there were some conflicts
with other work that happened in platform.h and device.h that I figured
would be good to get out of the way now and not have to wait until the
merge window to resolve.

thanks,

greg k-h
