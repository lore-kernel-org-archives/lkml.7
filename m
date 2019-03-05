Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73082C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C26A206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dx2+S8Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfCEI0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:26:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37974 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCEI0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:26:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id 199so6810263ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 00:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=80UeaXg4IUedyAUcI3zlaVRqw4KRHv1i5h4aQrChDzc=;
        b=dx2+S8HxXjQYkXtV0cB8MwOamzxzk896amgVgcubhQ9AMocBgUDGyqIshP8U3DdqCK
         EDUm2Yt63oE4N7frNz5RUHi3D36q2UTk/x4Ryuxz6DsoIkvw7PrP4gUfkSdY4i3bb4EX
         r2tHZQkQB1JiFjQqkY1mYpLF6LA7a308hwoL29SRHI2aZkPSgqZnyD1XS0/Ur7YgaYg6
         2EzzdhetsraVgtIiswNEonuLy9NcucjRLBzz2ygAMvSdmUpVtBsv0qlIKnRDqvht4FpM
         UPElUTHHaruRG7S1eeUU+KqIEIv9XFh+0lg7yPSYDwZQ+tSnxaJYVXEreOPsZZEZrQp9
         DRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=80UeaXg4IUedyAUcI3zlaVRqw4KRHv1i5h4aQrChDzc=;
        b=nha5S7hZc9SWDaKcDDKS8gGdk+MqwBI6xDH9vliCV+1DlEHa7WHjT+QrvTvE6QsivP
         fTSugpSh+ct8L+ILSy9XSPCnO4fKB9Ov/iR7yh7NwWx0U/M9RABZudziNlk4VQhkQFeL
         0XvqWO8zdTbRDrl5inKRPP/o3PcwyVSU37DFOYQv9r3KiCEOBwYJzcr+pxQ17IXFEWQB
         5rRqhYZR15U5iO04+RTzP3EXWd42HZpMKloq0O5MXlsOxGx5n4dpONVz2ipLE9123UGS
         pmoIysmj2lQIcx/iABFpRgIxHSkKaLgcIZ9P+DLtOR4553onZ0gG+uMqqlhW4LS7ghEr
         /IbA==
X-Gm-Message-State: APjAAAWBbkitSY3QUJryd/mOSyqgJHY8RhNPsDdwM8pJQ6WY1VDEhtIW
        gHwueqjsJzDp/9+CYIbSpe83R1jkzvKoGCyZWVsp1g==
X-Google-Smtp-Source: APXvYqx4nfK40jW2snMNeC3o2Rj1kZQrBX6M/YRpbydBZ1mXnWCLTtrhgIGjuuyXqF5ARfC/aBlcC+eVm4ZcP58LB+M=
X-Received: by 2002:a2e:6505:: with SMTP id z5mr13303269ljb.180.1551774378026;
 Tue, 05 Mar 2019 00:26:18 -0800 (PST)
MIME-Version: 1.0
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com> <mvmfts228vu.fsf@suse.de>
In-Reply-To: <mvmfts228vu.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 5 Mar 2019 13:55:41 +0530
Message-ID: <CAJ2_jOE=8_c6aN2FTQVt0wTpBAkL8BYyF3UFaMmqdvWYWAAmvg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] PWM support for HiFive Unleashed
To:     Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:39 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 01 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > This patch series adds a PWM driver and DT documentation
> > for HiFive Unleashed board. The patches are mostly based on
> > Wesley's patch.
>
> That doesn't appear to work with the heartbeat trigger, the led doesn't
> flash.

Make sure you modify the DTS file since with this patch the period is
now passed through the conventional way.
Example:
pwmleds {
    compatible =3D "pwm-leds";
    heartbeat {
        pwms =3D <&L45 0 100000 0>;
        max-brightness =3D <255>;
        linux,default-trigger =3D "heartbeat";
    };
};

I have tested the heartbeat trigger on HiFive Unleashed board and it's
working with this PWM patch.


>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
