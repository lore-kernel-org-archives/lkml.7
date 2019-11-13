Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED53CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C011021872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573606593;
	bh=AeVAdOQHZbM78H5+lbSDE0evJ9M9UbpCzBBAu6LK0v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tUAZ4VD1fMLAtISCcXbmPe6u8Y/czZ4iLel0GbW7iwQAWxItn1I111Lyy5R+od7dM
	 pfoO5sQPm9T4PLkC6UkXv7/Nm9FpVVBzcSP3rR656mkIhOAe9J1MCGC+blqnn4heZ8
	 IgIPzFRB63P1Rrwwc9DsGqYa5IDVHiaq1n4107e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKMA4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:56:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44151 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:56:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so336433pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6OWH0qPWGOTHEJKjK2/6xrgg3xEKCtmqVG+m05FgjZI=;
        b=bl4ruUjpBpx3FNxjMoLyjjYavR5p3EM8qLFVFyslAqjxxLRZiBs2LaoQKiQHaNGj7S
         Gf5d2Ta3IJ8z0B82WOeDd64ZkKQbcm8YlNelNfLV+NEMBorC3UFzs2FwAqVCoGnWJPud
         U8YL/fH3m1ZwR3lQsM2/stPTUppWdR43oRkOItfjL7WwSmfRwPr2W5G/tPX1zOm0b/py
         zK6p1OAWEaNJRjSu30o2phcYyIKGuUrFoDI8loF+dqKP2TMpRws+2WV8WBw0b3DiEync
         eNBNKa+mxBnZGgUyTke6+Mt7vd1Wme/TRDZ/pgdbrs1b3TaWgsA8fmip9aq+dImGbgx0
         u72g==
X-Gm-Message-State: APjAAAVQZr+aJh+Q8njxqcRwRiWs8HWS7H1ADiysaZFox5lFFaMobg7d
        2tjfZqogrGf62+d4rhcGVwU=
X-Google-Smtp-Source: APXvYqzgljvex9nE6u9AvnGcN9O7lhmVSuuI17YV4+ZHFXOWgELsf11wTZEvNJwYcn+pEQs25LkwgA==
X-Received: by 2002:aa7:8210:: with SMTP id k16mr998280pfi.84.1573606590187;
        Tue, 12 Nov 2019 16:56:30 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f33sm203525pgl.33.2019.11.12.16.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 16:56:29 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 733CF403DC; Wed, 13 Nov 2019 00:56:28 +0000 (UTC)
Date:   Wed, 13 Nov 2019 00:56:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ~sircmpwn/public-inbox@lists.sr.ht, robbat2@gentoo.org
Subject: Re: [PATCH v2] firmware loader: log path to loaded firmwares
Message-ID: <20191113005628.GT11244@42.do-not-panic.com>
References: <20191103180646.34880-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103180646.34880-1-sir@cmpwn.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 01:06:46PM -0500, Drew DeVault wrote:
> 
> This is useful for users who are trying to identify the firmwares in use
> on their system.
> 
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
> v2 uses dev_dbg instead of printk(KERN_INFO)
> 
>  drivers/base/firmware_loader/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index bf44c79beae9..2537da43a572 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -504,6 +504,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>  					 path);
>  			continue;
>  		}
> +		dev_dbg(device, "Loading firmware from %s\n", path);

Because this is dev_dbg() I'm willing to consider it, so that its not
always enabled. However its not in the right place, the code path you
are addressing is only for direct filesystem lookups. If that fails
some systems do a fallback call out to userspace. To cover both cases,
you want it at the end of _request_firmware() on the success path. Can
you send a new patch?

  Luis

>  		if (decompress) {
>  			dev_dbg(device, "f/w decompressing %s\n",
>  				fw_priv->fw_name);
> -- 
> 2.23.0
> 
