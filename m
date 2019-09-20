Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF41208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="tOoNnDAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438100AbfITKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:23:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40442 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438089AbfITKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:23:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id x5so8021312qtr.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KRYh78mW4SdPF70IJ1RhDBVtlq4LObNU1qGDDQxBs0=;
        b=tOoNnDAmZES+tYlRwv1BDJ5tc/c8uonUgoCJSanG/N6cxUUYQoeu5LP1MxcyskPr7+
         9tDDCvJLigvz3UwafsvzuE++dDIpk6xSb5AU1UMFGIwZzm+Sr81VHNni+jl729noqpAF
         i9ksNxKYjkPAw49oj/maGCIQ/qef2i/NVdTNwkvXC8gPONA9jB8igaMmwBrciL1s3G5s
         8xt0/L7/Mq3C5hoLiRgdPB0euTb5vzE/KGbeoowsaOG0qzgV8UgPagJZxPcJEK+wTjFQ
         46KRAOfX/sibqEp054jtv0xOSN6wOdVVN1vfXUBdae0IPYifLcZsZzvwdvdP6aGv5gV+
         xVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KRYh78mW4SdPF70IJ1RhDBVtlq4LObNU1qGDDQxBs0=;
        b=BW4zfbT5biWl8AxedtQM6aFKw7wLsN+0lMoDtHfAZnMnZFoVddVdgh332vhe9By1G1
         0hIs1XBGtUO+JORNa5Uct1yC6Xo/YhxoY9YI0fQ9VPJHUPDFk6B/ue0zFnWv/kSudZz5
         FpVwjKaRtvGqy6PjychObMgiq5ElRkTVb5+AX8QpJceKB+/lhMhATpCTD2GggcT/0X7O
         dG/jJjWAA+sHQqg2B61m6ruk7uPiIoDKZUVDwqga0+cxZvYmWMmZ9CY7fK1/3HMNk4nJ
         /pnWwX2lCqCOtksRu6am8my2r/+e1iIHV8fY0zoiwh9lNm6I6aFHq8v//+hQ6Y57gC5d
         OOQg==
X-Gm-Message-State: APjAAAV89qb1WPgxs7//8mizuhcpwpA8fIRh+3kTNCSur+yvQc6+5sRB
        9zxcvw7ehFd+4HOd8YRHvcueWkf4F6Cc7hnjNDaKww==
X-Google-Smtp-Source: APXvYqycUexjcYpUbAA6viTRHrluaYbe8beqhFKg88II3Oyet91p8bdZ1huPfn6oJReTol4y7D3T60HEKnuPzIRpUTY=
X-Received: by 2002:ac8:7310:: with SMTP id x16mr2416972qto.382.1568975030782;
 Fri, 20 Sep 2019 03:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190920030043.30137-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190920030043.30137-1-navid.emamdoost@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 20 Sep 2019 18:23:40 +0800
Message-ID: <CAB4CAwf34TFGqTCz0BGGj3MC4pTTW10qvfJaPsNxMcXB6_EbEg@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: prevent leaking urb
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:01 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In rtl8xxxu_submit_int_urb if usb_submit_urb fails the allocated urb
> should be released.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>


> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5443,6 +5443,7 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
>         ret = usb_submit_urb(urb, GFP_KERNEL);
>         if (ret) {
>                 usb_unanchor_urb(urb);
> +               usb_free_urb(urb);
>                 goto error;
>         }
You're right. There's a usb_alloc_urb in the beginning of this
function and should be
handled after submit failure.

Chris
