Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E9CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E0920843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxhYWoPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEOSa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:30:28 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37507 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfEOSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:30:28 -0400
Received: by mail-vs1-f68.google.com with SMTP id o5so591548vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x1GsAM8bhdilQ74FwqzJHpjAIW1mRUZnatlHpEToBDY=;
        b=QxhYWoPZ+1PlCeInJqiH5EdtHpzqJylxhCJeEIF6Jo3c2n26Xg9zJvIAjyi21FRb1E
         shfVV0sjHTkIk+XT0LuVrMEHJjAIGk1WL7tVbohxb8T16rinc4xS01nUc4/e6KTE5MTA
         PeT9fUG9BtVkJC9XKXysA0q0GuB+i28ib1IbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x1GsAM8bhdilQ74FwqzJHpjAIW1mRUZnatlHpEToBDY=;
        b=iIEhnkDRQ9ZEngUSxBdhzLtNo76BKeY3wJuQnNTy7FeSqotxL5ulyafCLCmYlrhZgB
         OP9BkzJKE1/oS6MPfmPCEcYDMGWXE7m1OSJ38GTI3yR+drAWkbFnk+JZ13qCvrr89AZx
         jh0sl6nqIkomYleO+82eJ0J7SXyNzRj66g5WJ9jE2uNj4CDJ7FKmXaYGx3JZT1YJLiR/
         exZdMXDARw9MtCAOy6Ot2EdCxN5RdhgStQaNmZbybbYxHQl8eL36aiWC80HcHzLrYAca
         7Gc+TQBkVh8BdPSQMsbsygX48xbeuRg9jNMLJcQYLu54OX8OsfVelLxkwAM27S1PdBTw
         34Qw==
X-Gm-Message-State: APjAAAWUKRZJM9Ns6jNbgRYQ7zTHBcBXAWlgRGVTpVlzSD+/ms6Vrbg0
        PG0nV8nDMK4LzEBxZxoE+LHCbniq39Q=
X-Google-Smtp-Source: APXvYqx8UfGu5r6EHKA6mCb7i983spTXFLE/yfq+j0d+OlAzfID5ZEeDSjLyFEfyim5HLoX8Zi5SnA==
X-Received: by 2002:a67:6f07:: with SMTP id k7mr20723694vsc.117.1557945026102;
        Wed, 15 May 2019 11:30:26 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id c39sm8915650uac.3.2019.05.15.11.30.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:30:24 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id m1so578860vsr.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:30:24 -0700 (PDT)
X-Received: by 2002:a67:79ca:: with SMTP id u193mr20058967vsc.20.1557945024176;
 Wed, 15 May 2019 11:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190515153127.24626-1-mka@chromium.org> <20190515153127.24626-2-mka@chromium.org>
In-Reply-To: <20190515153127.24626-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 11:30:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgoG5hiT=vAhNtUF4iVj1-Lmj7S5tvk86ehxB1uUZyxw@mail.gmail.com>
Message-ID: <CAD=FV=XgoG5hiT=vAhNtUF4iVj1-Lmj7S5tvk86ehxB1uUZyxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: raise GPU trip point temperature for speedy
 to 80 degC
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

On Wed, May 15, 2019 at 8:31 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> Raise the temperature of the GPU thermal trip point for speedy
> to 80=C2=B0C. This is the value used by the downstream Chrome OS 3.14
> kernel, the 'official' kernel for speedy.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/d=
ts/rk3288-veyron-speedy.dts
> index 2ac8748a3a0c..394a9648faee 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> @@ -64,6 +64,10 @@
>         temperature =3D <70000>;
>  };
>
> +&gpu_alert0 {
> +       temperature =3D <80000>;
> +};
> +
>  &edp {

Similar comments to patch set #1 about sort ordering.

...I'll also notice that if we do end up setting the "critical" to 100
C for most of veyron then I guess we'll have to switch it back to 90 C
here for speedy to match downstream?  Maybe that's an argument for
doing it in this patchset so we don't forget?  I'm somewhat amazed
that downstream has only 10 C between "alert" and 'critical" for GPU
for speedy, but I guess it's OK?

-Doug
