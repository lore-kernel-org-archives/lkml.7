Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA654C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DFD222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569477434;
	bh=ECT2MO+Aszuj2efZmPVCgWf2qDYQTTW5PrrNsdL+0ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v0ipqZv/flqe5wAT4bCfUnta9a0/MIncTQpgtPGheruWTKGS+ycu3692xJs3HGfU1
	 i1wDnxKcqd6LIlujaPrWW+Rbsx8KxPbj9TJg0ZUldbCSzElSnZBvBuXDxxyGeWJl1q
	 Q8t1lTDw9rT7kItnlNgUYQBbDvLYYeJPjpOecMmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392587AbfIZF5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:57:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33073 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392526AbfIZF5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:57:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so756308lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 22:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tv1CVBkJYPlU1j1V6OUzMhflRJNxhhdmMY2H2CfxK90=;
        b=C9+szqlIsc7zvFxIYKWn1Pkfy4NeaJUiTLcbQlU9a+EdWag1x5IHGg4r2cn2PzWXRC
         PxERwGb2aHCd5b0alDoHjMubeEL2kvgcI0GWERk+Ywk/ROb2XZqq+XmsFusqHHCPQuu9
         ZQvgbRu5deFk1dlI1LZuglmcNYtn9UB9ddSKtcTYvIhOSbVCuOcNZiUuaxDUZDR7l0cr
         r1hJ9+PcqyWW1HdmrVekjJt6c0RSH8gpkFgXUEYXvjtH1OkX6Wl4zIwAcBzaN9u1X/Gm
         z9A0qC8i7uKrkt2aOaJidjKMbdwHlwmHBIj3x9XdzYIFFtzAwBEYD8s//rQs8zx1Uw7+
         5MJg==
X-Gm-Message-State: APjAAAWjzq8UMAaZDbgVhWK9SO/To3pwSy/3XJUbo7QnpvrBES3/afmG
        DbgbSO3ni9NJew0d6sgEheE=
X-Google-Smtp-Source: APXvYqyyf8wfTb2uxD9DIhyRKWC96iF9NBJAJEAox9HQ67JE5q5stO2z7v7nMB2vZVaz90d7+KLxgw==
X-Received: by 2002:a19:4bd7:: with SMTP id y206mr1029411lfa.9.1569477430290;
        Wed, 25 Sep 2019 22:57:10 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id y8sm246833ljh.21.2019.09.25.22.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 22:57:09 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iDMmB-0001Nn-BI; Thu, 26 Sep 2019 07:57:15 +0200
Date:   Thu, 26 Sep 2019 07:57:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: remove excessive check in
 gb_connection_hd_cport_quiesce()
Message-ID: <20190926055715.GI14159@localhost>
References: <20190925213656.8950-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925213656.8950-1-efremov@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 12:36:56AM +0300, Denis Efremov wrote:
> Function pointer "hd->driver->cport_quiesce" is already checked
> at the beginning of gb_connection_hd_cport_quiesce(). Thus, the
> second check can be removed.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/greybus/connection.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/greybus/connection.c b/drivers/greybus/connection.c
> index fc8f57f97ce6..e3799a53a193 100644
> --- a/drivers/greybus/connection.c
> +++ b/drivers/greybus/connection.c
> @@ -361,9 +361,6 @@ static int gb_connection_hd_cport_quiesce(struct gb_connection *connection)
>  	if (connection->mode_switch)
>  		peer_space += sizeof(struct gb_operation_msg_hdr);
>  
> -	if (!hd->driver->cport_quiesce)
> -		return 0;
> -
>  	ret = hd->driver->cport_quiesce(hd, connection->hd_cport_id,
>  					peer_space,
>  					GB_CONNECTION_CPORT_QUIESCE_TIMEOUT);

Nice catch, thanks.

Acked-by: Johan Hovold <johan@kernel.org>
