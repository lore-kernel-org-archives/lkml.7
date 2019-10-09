Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BA7ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B37920B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Y3li1p0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfJIDlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:41:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42307 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfJIDlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:41:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so921398qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 20:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GB2JHMDYknhXIEFLDvzLbVAnPjI4gpNqH62WS5f+KO0=;
        b=Y3li1p0GvAcuYEMAfII+AXzeP3Dx8hfezlCNCNYgS2sWDa6jIyh66uvJ57+0elcPg9
         2KP6OkXwBFZ/4WxKWGgk9HYvka2SwYDMvbGiEaqJ4D15iaJ02LPyaOd2pE5VmS4Uz9it
         xx14N3M8d+hrlnI6acRKn8V0lHwuv8p2wUsfny2rfRlTc1PO8iRAix0vMY1fmW6x/awK
         vg1wkPKaJX973Rd5h2BdY3ZIbnxSRHikFC1CYoXWxa5YEEdx1lwr67q9Pavx7v0OY8Vs
         cl6NGBtXDtmTMXSJmKameI0SBqPrXCkaJKgaCHUlF7gPIkBmTZQgAy2ngKdCZVw2p/SO
         SnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GB2JHMDYknhXIEFLDvzLbVAnPjI4gpNqH62WS5f+KO0=;
        b=fGZXrZFgSCAKnVFHyMD19iNwh6MN7tH1nc4TGuYfivC66JK3ZV0Zu1BSq46ZqZc3/X
         f6/c1B5DP8YirHAqo3+oe80/JMUTPzafNF9eZHFrDqMWOZwFZdcfnQahagPYJK21oebK
         BXHrK7NULxfCN130IucApLYxt7oRZlajMkRpuEZlxLJ09tjulLLQo7uDHTE8FBZ+H1+2
         aZlPGLnhPK1yDyRVnb2/yAsyQ5qGIReYlycd1UqhZyOC+Fz9BfNgh/o9BjW7s2BKaFQo
         sWE28Y7+6lH3XugHRoZFnB6OArtNB2ugZWkEImTu2B8sEEZUPSsn9uUnKC4qOtC4DDoy
         XBDA==
X-Gm-Message-State: APjAAAUHC7hfelJGGOOVOOmKISFfpEogvGfViQgXT6+I8qhpHGzxyDFz
        qWq3NZnGY6givIl7Rog2VWXj/GiE+rhS+dPpy8oC2Q==
X-Google-Smtp-Source: APXvYqx2ZXU+O9i2Vvy57W7zl6Wi5IMyt4opmNHluxW45LI5MUotyZgXc8b1ZqQ9neqS1WTVjRXCYY+Jxb1xS0PAkew=
X-Received: by 2002:ae9:e203:: with SMTP id c3mr1549046qkc.366.1570592463516;
 Tue, 08 Oct 2019 20:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191002121808.59376-1-chiu@endlessm.com>
In-Reply-To: <20191002121808.59376-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 9 Oct 2019 11:40:52 +0800
Message-ID: <CAB4CAwdzJT90aKBLoS2XLxM1sqwojXLhP52mNZj7c36jUfJyqw@mail.gmail.com>
Subject: Re: [PATCH v8] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 8:18 PM Chris Chiu <chiu@endlessm.com> wrote:

>   v7:
>    - Fix reported bug of watchdog stop
>    - refer to the RxPWDBAll in vendor driver for SNR calculation
>   v8:
>    - Add missing break in switch case
>
> +               case WIRELESS_MODE_N_24G:
> +               case WIRELESS_MODE_N_5G:
> +               case (WIRELESS_MODE_G | WIRELESS_MODE_N_24G):
> +               case (WIRELESS_MODE_A | WIRELESS_MODE_N_5G):
> +                       if (priv->tx_paths == 2 && priv->rx_paths == 2)
> +                               ratr_idx = RATEID_IDX_GN_N2SS;
> +                       else
> +                               ratr_idx = RATEID_IDX_GN_N1SS;
> +                       break;

Hi,
    I have fixed the missing break problem in v7. Please let me know if there is
any problem. Thanks.

Chris
