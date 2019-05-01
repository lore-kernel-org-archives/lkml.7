Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1166EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE592177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556727451;
	bh=9o1Wqby8GAdwNUTUXUjvvLYIGm1+ZXKZ7uOR3la3Q9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pVG4y1Lm/f3ajyD4ZVOeBWlrlRjKDaIpflY6jwQmr3vUyInficnHtnlOwIVC9neBB
	 WcArfyzV5dUVgfCeDApIiMr2/aEVeBYOlrkmGaeLi/oxcVz5jD0kHOyjLEjjdTzVxf
	 xx2RyCaVYvKnNeLpBUDskk93bWZWV0+iit2IZu8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfEAQRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfEAQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:17:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0548421848;
        Wed,  1 May 2019 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556727448;
        bh=9o1Wqby8GAdwNUTUXUjvvLYIGm1+ZXKZ7uOR3la3Q9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zsgeg9CitNEME7oMnzxZZpWt/O8gMNUcntPgXjPvbiQ+2Gimpww0039adfEae9wZ7
         FiX/L4ckz5hl32sW6lbjMPd/in6eVCRmCd+K/oF4Mz6G7Hmtzw0LC9tB9L33dtVIAo
         lYfMS4WG8cC7vUvHKTDGvbo4FdHINuk1DZQe0DrY=
Date:   Wed, 1 May 2019 18:17:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Christian Gromm <christian.gromm@microchip.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] staging: most: cdev: fix chrdev_region leak in mod_exit
Message-ID: <20190501161726.GA382@kroah.com>
References: <20190424192343.15418-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424192343.15418-1-erosca@de.adit-jv.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:23:43PM +0200, Eugeniu Rosca wrote:
> From: Suresh Udipi <sudipi@jp.adit-jv.com>
> 
> It looks like v4.18-rc1 commit [0] which upstreams mld-1.8.0
> commit [1] missed to fix the memory leak in mod_exit function.
> 
> Do it now.
> 
> [0] aba258b7310167 ("staging: most: cdev: fix chrdev_region leak")
> [1] https://github.com/microchip-ais/linux/commit/a2d8f7ae7ea381
>     ("staging: most: cdev: fix leak for chrdev_region")
> 
> Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
>  drivers/staging/most/cdev/cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Christian, I'd like your ack/review on this before applying it.

thanks,

greg k-h
