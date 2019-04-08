Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6761C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D61B213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbUrc8a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDHWdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:33:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35574 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:33:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id s39so13179224edb.2;
        Mon, 08 Apr 2019 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zZ6MqEe/5u/116LxAogiG2NpDwuN4xleJLV8b87cz0=;
        b=nbUrc8a0BU8kBk7BiAqI+GrUztZRfylvmbsEGy2QhunADpk8S6VHI4KeKyeubCXPey
         JYAThEx05tzwJqktCKr5AXks5pt72CQwc1ZV+rBXoj7aOzKGaLMJZU3p28753Yafs20l
         X97E5lW6eq0Ko9cQ9FJvNzlRw7N2hTZf9ELRHKcVccUbZYzrXYLOUAy7lPCJowOkSJ5p
         o2th9g491vCpaTCmdtn82IFQgolSl8V6hKLyNRSXafIOyTN4ajsgsMHmpaS2mkS3A4W5
         NkpYmBW19E7JRqvuzOL0VyA3JXN44btf+RKzeVkL4K6HZuOi6JvsCFSdSu2hVABCvtip
         ftzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zZ6MqEe/5u/116LxAogiG2NpDwuN4xleJLV8b87cz0=;
        b=IsHuw2NsQ7wx489+Rrk8SmKZG6YYuroSshxuaBicv8YLuYW2zhFq/m9OCYDa9Ozgat
         uSHJ/U9jR0wrcjY9Pl66nMFzkaNXs/dfFTvdx/pWXHiOmjYFLUlr2g7vBNU1gc/HJOG4
         Dhu+TggvOqgjLrVkml7g1cvNBrCNX/v93/ccvkkxCeqMZA5VqvA1Tg7eBFG06G3sLwdB
         rO4MIcjz3Np2NR89sSuykG5gXMmQm4fZgWctBYLLfmcGy27qTqNHJPebZiPofUeSdczV
         1oznkInzz+t9WcfLuKf+45QPO1Wp6M7Ncg2/my/oG6XFjMsAlBUmI4UebDNXR5zh9kDD
         BdIA==
X-Gm-Message-State: APjAAAWSoIpG3q3zZDhazxZX3oY5d4YX34rbVLq3+Q12B1gLsysRn8DC
        OOfkYEXUdNgcwsrEgs2pDMI=
X-Google-Smtp-Source: APXvYqzuW+JJsI1VWkZ+AGhsrCWk95sE/CyjQtzQBT+s2LjM0DSs4PigHK5NmdET+ntFXS/geYZ22Q==
X-Received: by 2002:a50:a4aa:: with SMTP id w39mr20865551edb.206.1554762817169;
        Mon, 08 Apr 2019 15:33:37 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id w58sm9213684edd.69.2019.04.08.15.33.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 15:33:36 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:33:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] s390: ctcm: fix ctcm_new_device error return code
Message-ID: <20190408223334.GD18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-6-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:26:19PM +0200, Arnd Bergmann wrote:
> clang points out that the return code from this function is
> undefined for one of the error paths:
> 
> ../drivers/s390/net/ctcm_main.c:1595:7: warning: variable 'result' is used uninitialized whenever 'if' condition is true
>       [-Wsometimes-uninitialized]
>                 if (priv->channel[direction] == NULL) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1638:9: note: uninitialized use occurs here
>         return result;
>                ^~~~~~
> ../drivers/s390/net/ctcm_main.c:1595:3: note: remove the 'if' if its condition is always false
>                 if (priv->channel[direction] == NULL) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1539:12: note: initialize the variable 'result' to silence this warning
>         int result;
>                   ^
> 
> Make it return -ENODEV here, as in the related failure cases.
> gcc has a known bug in underreporting some of these warnings
> when it has already eliminated the assignment of the return code
> based on some earlier optimization step.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/s390/net/ctcm_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 7617d21cb296..f63c5c871d3d 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -1595,6 +1595,7 @@ static int ctcm_new_device(struct ccwgroup_device *cgdev)
>  		if (priv->channel[direction] == NULL) {
>  			if (direction == CTCM_WRITE)
>  				channel_free(priv->channel[CTCM_READ]);
> +			result = -ENODEV;
>  			goto out_dev;
>  		}
>  		priv->channel[direction]->netdev = dev;
> -- 
> 2.20.0
> 
