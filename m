Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC92AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313921D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576595830;
	bh=il1CvCc9YvCKbEZZGWzWIzWhs7dSJR3F9V+6YYPouT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cHTF3FP1gozWqLMa3iUdxdRJJKq38nV/kGeVhVoLp6H/eMNhgJDW81CEkNTv7cVbu
	 hO6Yk1YWLUS3Oe7kvmaEtI8fQ+3uf5jQTAgfvcTPcpo0+HvKlRgIZ7ZECBy9gQnUmU
	 /AAwEdgV3U9xVN6vSgsa1K3CGuO707a7VLR1Azhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfLQPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfLQPRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:17:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6809E2146E;
        Tue, 17 Dec 2019 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576595828;
        bh=il1CvCc9YvCKbEZZGWzWIzWhs7dSJR3F9V+6YYPouT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrqWdS5vHLlXxM/XFKetJ7/abKxVz1BiJLGP3Lp/LrbG8dvDVbo6G4lp/c2EsGhjw
         1+5jAyMfIwd0oPbC3UJYEa9sR4HEzzk4Ss88c0ZzN+ixABvoDIWSTU6F+2p0A1gECT
         FznJoURH/gUoIQE+dYmC8ChHNoYTeTd9bWZNZfH8=
Date:   Tue, 17 Dec 2019 16:17:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeff_chang@richtek.com
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20191217151706.GA3654493@kroah.com>
References: <1576148934-27701-1-git-send-email-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576148934-27701-1-git-send-email-richtek.jeff.chang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 07:08:54PM +0800, Jeff Chang wrote:
ookup("ext_dev_io", NULL);
> +	if (!d->rt_root) {
> +		d->rt_root = debugfs_create_dir("ext_dev_io", NULL);
> +		if (!d->rt_root)
> +			return -ENODEV;

No need to ever check the result of this function

> +		d->rt_dir_create = true;
> +	}
> +	d->ic_root = debugfs_create_dir(di->dirname, d->rt_root);
> +	if (!d->ic_root)
> +		goto err_cleanup_rt;

Same here.

> +	if (!debugfs_create_u16("reg", 0644, d->ic_root, &d->reg))
> +		goto err_cleanup_ic;

No need to ever check any result of any debugfs_create_* function.  In
fact, this function doesn't even return a value anymore, so if you tried
to build this against Linus's latest tree, it wouldn't work :)

thanks,

greg k-h
