Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D8C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 05:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EE921924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 05:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnFVSsjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfIIF56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 01:57:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39074 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfIIF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 01:57:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id q12so13075316wmj.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=00uQqKGc3ntry1sUHA28NuC7W2YW52OB0uzh/6SRnk4=;
        b=dnFVSsjoxqSQxLiFpd7+EBfRtZDxKWV8t82KXqAehO1Vsl2O22PFD7pPt3gzFtlblQ
         5FA9tNp5HySNWlDNCLPb7WPNYH1XzJH6mtgjEske8i+sUegf0BUZkw9A+9OSJczNf8al
         dhDX6UvKUJihuhitVElv3mGro33zvxV69SxtHBYFJ2HM1hWtOk+LrhidapysjUR0cd9M
         YmH6nlM2Wdsa0ALFBH2n753qXT5rddEiAyg5Ji4XcUSd/nJcotRIXyiLuCkJOHq+8UGP
         LC0hqVg+J2fq4kA8cJYMtD92Jz0Rodd/4o4Bf7qmvnKhnamI2KcLMP9IN6HPjuwbYb4H
         zd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=00uQqKGc3ntry1sUHA28NuC7W2YW52OB0uzh/6SRnk4=;
        b=DVHKymenBL7Enu4rMCHxasW7IfHMap+qldMzY5EMyxcytSYNt38Hf8IQS7NlK+Fz8Z
         b+NX2E+h8k3WmjPSLgSpuetixPRNfh1AQafcPwSayRW5o5RRmITsOaUiLQc+/pfMe3Xk
         /1aC9i78sDuzFuwfWXQmyk0y093vApGneYlYYRvtuVX4bWHTjWEgWaV+dMVMzWKZT/WY
         tPN82+8YPpmfC/hRYdSvBty/L+hJG9YdzqFmrXu4zbvgJm0jn4GU1w0G3VfH2B+qSoE1
         2PV4zc2vwixENKYQQ30SECxTq4gqzPWLsLEhE/JjcgCVpE9Kdo64ntzuNwhYSSj32HIJ
         u5xQ==
X-Gm-Message-State: APjAAAVhSL7hcvOzJ0cljYP7dd31E4QXMc3DVqkTmwrBf9jALRk2rOnS
        Nmz4dJP/npvHgs5Dw3lV1vqDVg==
X-Google-Smtp-Source: APXvYqyTuOYWiPrJQegHYIEdG0b8fajJCGI0sjBqLXu6MTa5++KDoPx8Kxrq8U2i/YY6IhYKXCtKjQ==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr17169399wmc.68.1568008676005;
        Sun, 08 Sep 2019 22:57:56 -0700 (PDT)
Received: from [192.168.0.102] (146-241-7-242.dyn.eolo.it. [146.241.7.242])
        by smtp.gmail.com with ESMTPSA id r18sm14513325wrx.36.2019.09.08.22.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 22:57:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/4] block, bfq: series of improvements and small fixes of
 the injection mechanism
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
Date:   Mon, 9 Sep 2019 07:57:55 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7AE7BB9-667F-4732-87D4-F28C2D864645@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
have you looked into this?

Thanks,
Paolo

> Il giorno 22 ago 2019, alle ore 17:20, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
> this patch series makes the injection mechanism better at preserving
> control on I/O.
>=20
> Thanks,
> Paolo
>=20
> Paolo Valente (4):
>  block, bfq: update inject limit only after injection occurred
>  block, bfq: reduce upper bound for inject limit to max_rq_in_driver+1
>  block, bfq: increase update frequency of inject limit
>  block, bfq: push up injection only after setting service time
>=20
> block/bfq-iosched.c | 35 ++++++++++++++++++++++++++---------
> 1 file changed, 26 insertions(+), 9 deletions(-)
>=20
> --
> 2.20.1

