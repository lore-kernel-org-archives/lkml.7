Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5009F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575982277;
	bh=0A/hPgb/VmIjf6B11djQ2NlMpritWU6jqE7/zjVBSP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdW1UKfEeVzM0XyTMgXijLdJ2bIq3adzZdg6pgGqmzQ0p+7VMeK68twN1cO26pzZ7
	 5dq8WW6mO7VdXaBNeWUQvo6tXVJ2yuhqXxsef9PXzIBpok/XxhS3XGRyaCd9XTxE/n
	 rMqRa/VJ53Bc/olF5g0F16qmkOfJrx/6q3d+nn2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLJMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfLJMvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:51:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF262073B;
        Tue, 10 Dec 2019 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575982275;
        bh=0A/hPgb/VmIjf6B11djQ2NlMpritWU6jqE7/zjVBSP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCKhh6twfzNGvNXTRZOpOM4hKwKWJQh7rL++4yY4OApg/oHeNInM0Ec7CGv3D1F7S
         QnjEYElbKmJ0DOs1XXVZzAui04IYXtaUhOK2vCJbaHrWnAgyH4452kh6AoiThAwghN
         v2uF0xSZjfUoXofMziaMU7cJDrnX0b8rYypjSZIE=
Date:   Tue, 10 Dec 2019 13:51:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Simon Geis <simon.geis@fau.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH v2 09/10] PCMCIA/i82092: improve enter/leave macro
Message-ID: <20191210125112.GB3810481@kroah.com>
References: <20191210114333.12239-1-simon.geis@fau.de>
 <20191210114333.12239-10-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210114333.12239-10-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:43:34PM +0100, Simon Geis wrote:
> Improve the log output by adding additional macros dev_enter/dev_leave
> in i82092aa.h which print out device information. 
> 
> dev_leave takes a second parameter to print out further
> information when needed. Use __func__ instead of function name
> in the header file.
> 
> Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Simon Geis <simon.geis@fau.de>
> 
> ---
>  drivers/pcmcia/i82092.c   | 59 ++++++++++++++++++++-------------------
>  drivers/pcmcia/i82092aa.h | 16 ++++++++---
>  2 files changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
> index f523a810ab66..668a2188ef66 100644
> --- a/drivers/pcmcia/i82092.c
> +++ b/drivers/pcmcia/i82092.c
> @@ -76,7 +76,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
>  	unsigned char configbyte;
>  	int i, ret;
>  
> -	enter("i82092aa_pci_probe");
> +	dev_enter(&dev->dev);

Ugh, these should just all be deleted now that we have ftrace, right?
There is no need for any "we entered/left a function!" print messages
needed in the kernel anymore.

thanks,

greg k-h
