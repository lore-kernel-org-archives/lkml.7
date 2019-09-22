Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DD1C4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 03:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A880217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 03:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="j20B1rh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfIVDGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 23:06:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46563 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfIVDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 23:06:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so6923261pfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=DcoF8SnI6DaECtY9bhX/OaglfSzgcvjrMi9Ez30k22c=;
        b=j20B1rh7utJ06pwS/CI39C/1Lgab/aQuLLyD9GV4ZQFbcahq17xzR28Kl6qSz04sbK
         gni94n3IdjU4zWuPPsoVtQukwm2NDpir2x2pNiDe7rLk7fP4AuvMkNQiwMWWHVuZ6eHt
         3vkNl0V0Op2RlZHmFV6Nv06s/SA4w/LAzXDjWZrAt17BI6WwRA1wnQCBjHzAWPPy/i6D
         K5qj0IwHb5jgtCbArxE6QxiitBjfmHaMZ+PjYKvDrQEamfm0Ke6d6JaGqv7Z22ndcIZk
         HyTS914oc3Yiusw+K6c4QYwrVGGQVSI5iw/+aRBEC5DJw+kX/PY/tPToeTQI2Ny8QcRU
         XgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DcoF8SnI6DaECtY9bhX/OaglfSzgcvjrMi9Ez30k22c=;
        b=JZFiuP/jhcIrLJWTJD/G1lAHnVThkDVkynWqpb7DCISB8fupeS+AVRCX/6+Mny3JNE
         rIa+QQZcAqog2iEKkoQiae8Uez+MhFGaxE0KFkcdFxEiQXD//fcYG9peWppA3l+fNxrV
         zDpIPF9YeO80W+yQKEKH5wxSxieoKgsg8tFZbgeNqIMo2xq20nkHx5zGTpAyfLsrMdeS
         +NizdE6Qq+c7d7MWMy+kc+IBM90F08IGIv2NCHUD19YbVYaK2r8qwdsvFqoZzS8Ue/e/
         VW3brUgMLAZBWDcgXYbPblJO6VNeH5PuIQrgcBOPCcVehAwTm4y4mXb9Wh0lgq97oEF/
         7ifQ==
X-Gm-Message-State: APjAAAWNnou04ocE+NuH+0JRKTXInLcz57uogH16X/9EkkbM9o5cpUzG
        /PypEK4WNnMjYkb5I5pYWtubwA==
X-Google-Smtp-Source: APXvYqynyO4uU5/MurUlqEVn0zeersUq/LYW86lNwgAskydNrIYWvzDFd9kiIsrDhBkYMbmvU7U9PA==
X-Received: by 2002:a62:64ca:: with SMTP id y193mr26590956pfb.164.1569121601682;
        Sat, 21 Sep 2019 20:06:41 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id 7sm6499110pfi.91.2019.09.21.20.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 20:06:41 -0700 (PDT)
Date:   Sat, 21 Sep 2019 20:06:38 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <uwe@kleine-koenig.org>
Cc:     Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] dimlib: make DIMLIB a hidden symbol
Message-ID: <20190921200638.5baf40a9@cakuba.netronome.com>
In-Reply-To: <20190920133115.12802-1-uwe@kleine-koenig.org>
References: <20190920133115.12802-1-uwe@kleine-koenig.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 15:31:15 +0200, Uwe Kleine-K=C3=B6nig wrote:
> According to Tal Gilboa the only benefit from DIM comes from a driver
> that uses it. So it doesn't make sense to make this symbol user visible,
> instead all drivers that use it should select it (as is already the case
> AFAICT).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  lib/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/lib/Kconfig b/lib/Kconfig
> index cc04124ed8f7..9fe8a21fd183 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -555,8 +555,7 @@ config SIGNATURE
>  	  Implementation is done using GnuPG MPI library
> =20
>  config DIMLIB
> -	bool "DIM library"
> -	default y
> +	bool
>  	help
>  	  Dynamic Interrupt Moderation library.
>  	  Implements an algorithm for dynamically change CQ moderation values

Hi Uwe! Looks like in the net tree there is a spelling mistake and
moderation is spelled "modertion":

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/tree/lib/Kcon=
fig#n562

I'm not seeing any patch to fix that anywhere, is it possible you have
some local change in your tree?
