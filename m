Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E86FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D18218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+70zlfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSN5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:57:34 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33842 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLSN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:57:31 -0500
Received: by mail-yw1-f66.google.com with SMTP id b186so2188006ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 05:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yn+mK/5xEg4fegs3phGOsQ7/Ct6TERF9p632E4MnVU=;
        b=Z+70zlfpfDFUhG4zCZN0o7aK311Wb9wqmTfhJspMn390U/L7t8E4FJKmpey+FMMx+m
         MTrrHYTduZesm6fol+ZJfFmbXUWIpqMnwaYzeIw4f74e8jT8uVqAV65Rga3P/rBzQz12
         t3fhOs6j8YhRorlFhHq64M1oHtQQOHmkXE/UgtMGS/SQwbqOXSNKOW3/cr9q2XF8EoaT
         S8zSoSXCT9OwRrk+rJUEubK+m3qxHSe5oZ1JUCTlhyjI8QrEfKD/sOXaX44xHEOlYR0P
         QJU5pdTCLdk9Pu7p6orkgIjjgAjT/7ZDfZ4a49i0E9kzIhy8mQRWWEl8xV8Bzxfk+rQo
         u7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yn+mK/5xEg4fegs3phGOsQ7/Ct6TERF9p632E4MnVU=;
        b=s7cmLehoYqY4crKoN7zIOC68nfWeyWRN52e0LZ9Bh3m2FRqpnL6dM0onRfKLqHdgh9
         /RnzWMvm+c55LcXvl0lju7TE0RgI1pxuz4LYaBsbHJoGxkA7xge4UrPcDOO1V8yfBlb/
         blQ/H9GsnxWKtkEr963TGal1bbxm2TWXVzzutAoLjxD24clRxC2oFz4akvPEOQ9YkxKa
         MzWRYSONf9SjCTkVFrhFFywKf3A1g+l6k1nMvdtUWLZHSve/dhYELt8Pu8w/2ErEQVKJ
         ocVHUDIg5s4S8ibjYqt4U6cnS0UBScVjw35DxZ7dMF+AmSGh5lIbwOlzk3/8DAVseOkw
         Xp9w==
X-Gm-Message-State: APjAAAX45Wt0T0QKXbqgEiU2PSkEcAWZq3drT4Oanz1cy+IJZNOvzEHD
        BfURhqwkUvGJ/jNIH257l+/vs+mU
X-Google-Smtp-Source: APXvYqzt2fj6wCO6Qq71sZ4ncEG5/+MhnIwegBhkKw6OdwNjVrzB6Hc3UpyCUHpeYdoJPr2kN7LjZQ==
X-Received: by 2002:a81:230c:: with SMTP id j12mr6064433ywj.501.1576763849564;
        Thu, 19 Dec 2019 05:57:29 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id d137sm375874ywd.86.2019.12.19.05.57.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 05:57:28 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id f130so2192969ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 05:57:27 -0800 (PST)
X-Received: by 2002:a5b:348:: with SMTP id q8mr6431302ybp.83.1576763847446;
 Thu, 19 Dec 2019 05:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20191219013344.34603-1-maowenan@huawei.com>
In-Reply-To: <20191219013344.34603-1-maowenan@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 19 Dec 2019 08:56:50 -0500
X-Gmail-Original-Message-ID: <CA+FuTScgWi905_NhGNsRzpwaQ+OPwahj6NtKgPjLZRjuqJvhXQ@mail.gmail.com>
Message-ID: <CA+FuTScgWi905_NhGNsRzpwaQ+OPwahj6NtKgPjLZRjuqJvhXQ@mail.gmail.com>
Subject: Re: [PATCH net] af_packet: refactoring code for prb_calc_retire_blk_tmo
To:     Mao Wenan <maowenan@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, maximmi@mellanox.com,
        Paolo Abeni <pabeni@redhat.com>, yuehaibing@huawei.com,
        Neil Horman <nhorman@tuxdriver.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 8:37 PM Mao Wenan <maowenan@huawei.com> wrote:
>
> If __ethtool_get_link_ksettings() is failed and with
> non-zero value, prb_calc_retire_blk_tmo() should return
> DEFAULT_PRB_RETIRE_TOV firstly. Refactoring code and make
> it more readable.
>
> Fixes: b43d1f9f7067 ("af_packet: set defaule value for tmo")

This is a pure refactor, not a fix.

Code refactors make backporting fixes across releases harder, among
other things. I think this code is better left as is. Either way, it
would be a candidate for net-next, not net.

> -       unsigned int mbits = 0, msec = 0, div = 0, tmo = 0;
> +       unsigned int mbits = 0, msec = 1, div = 0, tmo = 0;

Most of these do not need to be initialized here at all, really.
