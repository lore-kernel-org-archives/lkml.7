Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FCAC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCE620815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KTu4I3iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfEPQ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:58:45 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35765 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEPQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:58:45 -0400
Received: by mail-ua1-f67.google.com with SMTP id r7so1574702ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CIeWtimA7P9rrGuoEHFDb0M7OKtOA8ZV+AgbfX3hOsY=;
        b=KTu4I3iLkD6d25Qx/9ZfdJuiwwImY8tkog2XfJWMae7fnJz7hMQfsB3YluYGPWvkva
         W4oEQ+Mw86+nSDZlWZtIs7Vzh74xCnOKR7hFZCSSiAylCoIO5s+qZLGaqJKDS8QblmzJ
         7+AnU7kiJ3qf5MhmefdogpR3nFeT9Mrs0FqkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CIeWtimA7P9rrGuoEHFDb0M7OKtOA8ZV+AgbfX3hOsY=;
        b=UJnqywW+1Hnb4fIvgO5JkWSpkGDlGqi17mOxViQOc8qyFbUH7TbyQjJY6nLUe6KvFB
         c4tgc6O6WIKmL72OC1xVc52hOgCBkJ3Q2sVelNGby4AH7BuXs53zgHfa8dBf4tVaczHI
         /TwQWenBMaqCkrXUuTv/+x2/Po5+T70LD3Rq/DdlImQ/zRbGkipaG42kiXGUVzOJMjyp
         OOeMREvMkBUkET9SNsYOaRW5oiXSQrBaG8ck5jRwzhZK4kP7Ph3SYvJw9kABbsUvshbf
         YViDxQb8L0+DIF681Tv8AEA/FU6AKk08yWZXJ6Ah0uMTxYylTQl2/gvFmH6V2BIUYjhT
         J+YQ==
X-Gm-Message-State: APjAAAWlHRkAUZuYnCr69ank1YvkhJtko/3aYQm3c8hjYpVqoZKDF5UI
        fyUwaxcGVOZJq8XJ87F32xoIQayQrOg=
X-Google-Smtp-Source: APXvYqyAgHJz1nfS5JB98d6SXQbzaU+KTiJEyquLk856g8h+ClM7zXq+tQYsyqOOz8dG6nYvXz2fcg==
X-Received: by 2002:a9f:3381:: with SMTP id p1mr752936uab.40.1558025923632;
        Thu, 16 May 2019 09:58:43 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id j63sm2175659vke.8.2019.05.16.09.58.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:58:42 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id l20so2800109vsp.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:58:42 -0700 (PDT)
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr17782417vsk.149.1558025921921;
 Thu, 16 May 2019 09:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190516162942.154823-1-mka@chromium.org> <20190516162942.154823-3-mka@chromium.org>
In-Reply-To: <20190516162942.154823-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 09:58:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJrfAPMvK99QycHLuoTqXG8UWWojF+DpGZwB9ijckLig@mail.gmail.com>
Message-ID: <CAD=FV=WJrfAPMvK99QycHLuoTqXG8UWWojF+DpGZwB9ijckLig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: raise GPU trip point temperature for
 speedy to 80 degC
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 16, 2019 at 9:29 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> Raise the temperature of the GPU thermal trip point for speedy
> to 80=C2=B0C. This is the value used by the downstream Chrome OS 3.14
> kernel, the 'official' kernel for speedy.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - add entry at position in alphabetical order
> ---
>  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
