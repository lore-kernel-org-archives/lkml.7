Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863CC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA2520872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="jyrVkq/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437003AbfIJRCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:02:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39843 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436822AbfIJRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:02:36 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so39208595iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHtCrm1vpXjKX4N1mnKNL5adU51DyAdSJlvxQv4V/NA=;
        b=jyrVkq/p5eQw4U+Mv8R/PTxlwrcoanUBD8qToBzvsm7AsDl6twYT9p4XWSZqJDNJ5p
         3VKo9ciCZHcmDF6KsWFpou1Ua10XLcrP1Lp0lYi5VwMKg9cf+5CHWorgM+lESrxz2jNl
         Q2vFyKqMjsqOEu06rZLI4vLvl9zU55j+RNlEkJf4oec3Qu8wgz95GMGcXoPOXgEmyQE+
         ovx2uST1e/+ZPGFjUZ72npKnofo3cQ/dj0PFpjC50V9PbhP8Xi3gfea+Swci9+6xPFUR
         Y/sC1rQpfHyWlpjKA5BDYVbt45e198hyp1rkKgkfQhot2HX0Z33FVRBIVG0qc3gP3Fxz
         v/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHtCrm1vpXjKX4N1mnKNL5adU51DyAdSJlvxQv4V/NA=;
        b=to+TdX6f8EwXUUpt4GvNoLEg+ziVXwaoMN5X1wma6w8k3OYdSBMdIKO48qffKa+LOf
         nIyCkq+D0ahXxfyEEObSauP8xIr8OBD6HDOuJ6Tt1wLl2sygW6kxZsRWzRGx08ZcHj5v
         kyF8hMY0D+jIHlrdfd8pNp4CC5G5DmspcesE4Mc/BSOUPwrvYs3j+ayktq1EOXf941ut
         b1bzGNlA5h+UX6uezslS4j5kg5sT6zPVh3djOLF3qySIaFfmEvYdiq03A/hrY91xedQl
         dYLp65glnv98/Fdo3TINNTFYST743El1YNSMCJtvfU+E0AVTCvyA8FqFgf/ap/1d3FLE
         KJ4A==
X-Gm-Message-State: APjAAAWlObEzZs7kRZVOWnX6SO75s7q8Le8j1YsTMfERoeE7m+dQKUvi
        qBs8we9ot6PIrMQHcScVv24hDxDic2WUNUdO/QWRqw==
X-Google-Smtp-Source: APXvYqyrjjhYX1ifjAiN3g+ZP7Erd1VsBjPued7BNbEEL3rXO5YRWzGhAKzH27PO0NALlFJOKcpub1H1J61YN4gV0KI=
X-Received: by 2002:a6b:ac85:: with SMTP id v127mr4880488ioe.97.1568134955308;
 Tue, 10 Sep 2019 10:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190818185349.15275-1-colin.king@canonical.com>
In-Reply-To: <20190818185349.15275-1-colin.king@canonical.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Tue, 10 Sep 2019 18:02:27 +0100
Message-ID: <CAPoiz9z-e_oK2urbkWcoa2qqybAFbR54SR7gGzU1EA19zrxc=A@mail.gmail.com>
Subject: Re: [PATCH] NTB: ntb_transport: remove redundant assignment to rc
To:     Colin King <colin.king@canonical.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 7:53 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable rc is initialized to a value that is never read and it
> is re-assigned later. The initialization is redundant and can be
> removed.

Applied to ntb-next, thanks

> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 40c90ca10729..00a5d5764993 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -292,7 +292,7 @@ static int ntb_transport_bus_match(struct device *dev,
>  static int ntb_transport_bus_probe(struct device *dev)
>  {
>         const struct ntb_transport_client *client;
> -       int rc = -EINVAL;
> +       int rc;
>
>         get_device(dev);
>
> --
> 2.20.1
>
