Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925E0C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64658215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569852544;
	bh=CUY2DS6q7wSAIavwUIR9TnnZqiZpj6/VYvFvIYeBnkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JmeaIMCiTF82SRVqOTH4whsIjIJTChqQEX20nN2x60fY+iVopDBv4FzIsqbvrptdu
	 DLKfwd+HeNoYGLyg9AVW42fcKc6GOZ8btxdkCRxAauMOh2eErhXO8xMsAN4gLrZ6wt
	 CQ+ayQL8iIcpprIMXspbYcUxwHIRLdhuz8mnqswk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfI3OJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbfI3OJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:09:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68F120842;
        Mon, 30 Sep 2019 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852542;
        bh=CUY2DS6q7wSAIavwUIR9TnnZqiZpj6/VYvFvIYeBnkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+jYCb1eT/27GSczvMAgu3CCCuDPeRKe8Wdmo2yUjcgjAK3gzNkJqn6mXoulsEVdr
         do/hYMSfaMhfS5w/fY++zlSHfTYHUf7qbsfqbAsF7GWNpa4bLwCmhvm0nxuv7l5YDw
         vRlNw0m7H0MAqdsjGw4GuIWGOSs9WGs5xXS1tMtY=
Date:   Mon, 30 Sep 2019 16:05:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Enrico Weigelt <lkml@metux.net>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        jan.kiszka@siemens.com, Frank Iwanitz <friw@hms-networks.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 5/5] staging: fieldbus: add support for HMS FL-NET
 industrial controller
Message-ID: <20190930140519.GA2280096@kroah.com>
References: <20190918183552.28959-1-TheSven73@gmail.com>
 <20190918183552.28959-6-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918183552.28959-6-TheSven73@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 02:35:52PM -0400, Sven Van Asbroeck wrote:
> The Anybus-S FL-NET provides full FL-NET Class 1 functionality via the
> patented Anybus-S application interface. Any device supporting this
> standard can take advantage of the features offered by the module,
> providing seamless network integration regardless of network type.

Discussing "patented" in a changelog text is a big no-no.  Please don't
do that.  Talk to your corporate lawyers for why not...

> FL-NET is a control network, primarily used for interconnection of devices
> such as PLCs, Robot Controllers and Numerical Control Devices. It features
> both cyclic and acyclic data exchange capabilities, and uses a token-based
> communication scheme for data transmission. The Anybus module is classified
> as a 'Class 1'-node, which means that it supports cyclic data exchange in
> both directions.
> 
> Official documentation:
> https://www.anybus.com/docs/librariesprovider7/default-document-library
> /manuals-design-guides/hms-scm_1200_073.pdf
> 
> This implementation is an Anybus-S client driver, designed to be
> instantiated by the Anybus-S bus driver when it discovers the FL-NET
> card.
> 
> If loaded successfully, the driver registers itself as a fieldbus_dev,
> and userspace can access it through the fieldbus_dev interface.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/staging/fieldbus/anybuss/Kconfig     |  17 +
>  drivers/staging/fieldbus/anybuss/Makefile    |   1 +
>  drivers/staging/fieldbus/anybuss/hms-flnet.c | 520 +++++++++++++++++++

Why are you adding support for new things here?  New hardware support
should _only_ be added once the code is out of staging, otherwise there
is no pressure to get it out of this directory structure.

Please work on that first, before adding new stuff like this.

thanks,

greg k-h
