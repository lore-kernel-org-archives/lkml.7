Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA3B222B0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553429948;
	bh=GMYEsqGc5cVyAdwd+ntKMzWFgRKoxSZLxuh3ZOYmEw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nmy+UdJbgKQbg5C0PPQjkvseAj60Oq7ytmp0AircTLtHpkYhD4YC9YJnWtQBwgxfG
	 FZtTKwCvB6OPKbuLAgxLg8sBpogMQ/Y5wVBx30sJJK1T4KtVojQaBBc2MYShM1Mc5z
	 p39zVoqyJhB7LeynYqWy91aqrDRHGmgCcuAFIGGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfCXMTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXMTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:19:06 -0400
Received: from localhost (unknown [88.128.80.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78BAB222B0;
        Sun, 24 Mar 2019 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553429946;
        bh=GMYEsqGc5cVyAdwd+ntKMzWFgRKoxSZLxuh3ZOYmEw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arJ8kNgBjjYYT4XhDucKFEGJ3FBF/GtMPS791UfGslL/mA6+HuwlfdsRtwGM2uOgN
         p5DaT+F65rUwlUhBfZj1s46+tNJ2ztf4gqmTufEfRzz7Z+iY4XTE6snAM+XpJwaaX2
         hMs/1XTCwXQ71snGTGUQPyPuXcIdf0Sr1zzZFeKM=
Date:   Sun, 24 Mar 2019 13:19:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] staging: olpc_dcon: Use WARN_ON instead of BUG_ON
Message-ID: <20190324121901.GB6569@kroah.com>
References: <20190324121208.GA24213@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324121208.GA24213@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 05:42:08PM +0530, Bharath Vedartham wrote:
> This is with respect to a checkpatch.pl CHECK: "Avoid crashing the
> kernel. Use WARN_ON instead of BUG_ON". But I maybe wrong here. Is a
> kernel crash desired if olpc_board_at_least(olpc_board(0xc2)) fails,
> will there be inconsistent results if execution continues?
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/staging/olpc_dcon/olpc_dcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
> index 6b714f7..900baab7 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.c
> @@ -138,7 +138,7 @@ static int dcon_bus_stabilize(struct dcon_priv *dcon, int is_powered_down)
>  	}
>  	if (x < 0) {
>  		pr_err("unable to stabilize dcon's smbus, reasserting power and praying.\n");
> -		BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
> +		WARN_ON(olpc_board_at_least(olpc_board(0xc2)));

Shouldn't you do something to handle this error, if it can actually
happen?  Don't just warn and keep on going, if this was all that was
needed to fix up these types of issues, we could do it all in one simple
search/replace step :)

thanks,

greg k-h
