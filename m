Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09795C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F302086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566199817;
	bh=8LHi5b5YETBMuPI0EdFIgJosz78GCOwzrWoc33QMEPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FSUviI80MpS1p9b0+Zh6XLp2u7U6Sqx2dXjDtoXQfUqyJkl7RY89qqjhVeaT4sXrc
	 9/ft9JJU8XQPyMeplYBq+xIBboxSkg32u9HYnBXHXJVGZBu+b8YBMAYKL323jW39+m
	 ME+Pu3pSRI6Bz/A22J3m6MqsZj9cDjCXxC+MKE1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfHSHaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:30:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38535 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSHaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:30:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so796685ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 00:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0aM4cxzKTnaQf1FTgzfMVGOxCL1YqvaygnqPvmQitI=;
        b=oP0ZxtM6oj+y/Ys93NJjyH0hv3YGYHsfQTMswf/Wy4D3+KbtLNTuiOLkokcaWCxtjB
         Ai0U5bScZFUalzZLtZq7CZVN9n7L9DUdXwyzrmU8llPl6tgtOl5dHpFPQ3Aypc8eynHk
         y6oZ0W6I4js52q2KTdA3hcrAfUfaXh99IpJUITW/wbajsafUtSxFMVn27TEimjjuSlDY
         oY+BnJLp/SySdk+ncA1f34V+ltQuTnMWjvMehFlf83wQ5Zy0R2O+MMDeRtJzza77R/I2
         ZoDh7tMpxR+cBOSCWVRZSNZmfgJSNJKCyNqm5RG47UdE8qs2R8UEDECRWhCbIT7BeRDN
         xSkQ==
X-Gm-Message-State: APjAAAWtemuxc66upJq88vAMxCrdlXW5R0xwGRe+Fze/S6En4pZIv6Gn
        CwSp0HFkISl15Z/pQRF1ceZxzDoW0DLroZpK3a14dA==
X-Google-Smtp-Source: APXvYqxxfd/Avpth6OEoJBDLlB7YePTH3pbLoMdFv83fefwvNcpvcnLYOHUhkK2XRWjbzRIUqb2iP9oZZA8E1StgfEE=
X-Received: by 2002:a9d:674c:: with SMTP id w12mr13528361otm.118.1566199815508;
 Mon, 19 Aug 2019 00:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190819071606.10965-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190819071606.10965-1-yamada.masahiro@socionext.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Aug 2019 09:30:04 +0200
Message-ID: <CAJZ5v0i7FOiLn693qS24EVAp2AzNHfFg3NyQKHRfoj2Jn9rkrw@mail.gmail.com>
Subject: Re: [PATCH] driver-core: add include guard to linux/container.h
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 9:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Add a header include guard just in case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
>  include/linux/container.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/container.h b/include/linux/container.h
> index 0cc2ee91905c..2566a1baa736 100644
> --- a/include/linux/container.h
> +++ b/include/linux/container.h
> @@ -6,6 +6,9 @@
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
>
> +#ifndef _LINUX_CONTAINER_H
> +#define _LINUX_CONTAINER_H
> +
>  #include <linux/device.h>
>
>  /* drivers/base/power/container.c */
> @@ -20,3 +23,5 @@ static inline struct container_dev *to_container_dev(struct device *dev)
>  {
>         return container_of(dev, struct container_dev, dev);
>  }
> +
> +#endif /* _LINUX_CONTAINER_H */
> --
> 2.17.1
>
