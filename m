Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C065C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416CD2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="VnaCb5ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfGHCEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:04:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38378 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfGHCEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:04:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so12125601qkk.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 19:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NfEQ74q5YeHXp4S32p0IuIICq4n7NqjdyeNRP0/fY4E=;
        b=VnaCb5ceImKjGG3OaJZM5hs9g550eeQygLJG38lV3zF9WNSTou6DT3VQOaKQ+uUfBQ
         iuPtzOFrVlS57rIJ90kfAQUkJoIVah6NuJLfXO/59c3ulj7BZaO+YWKGGJwtMjvpMZOD
         mYAq9bZdw+K/g4yexzckGg1GXrwr6854fA6jd7bXUZVu4HMB0xDxzK/wf5gj9D1CApqy
         RGGuCN8lQLaiBcZ41dBxASfGllsdZde5TneNfYoEupFZZNj+V2EAFPB7P9LWXOgdLyAq
         7LjQKvsMe4xxnfJ1ifnMReSSG1MOPypQMuqCKbY8qVfsZ4cmRmYt/ZxwhDYX6faGxrv9
         OYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NfEQ74q5YeHXp4S32p0IuIICq4n7NqjdyeNRP0/fY4E=;
        b=AIkNqBVz6MbcjrqfGnSZVAY6lfQ/KjwvLnTMY6nPd9Mlun6GE9qwOHMNKQ4LMLx/Nr
         2hu48jNBAlnEVCFd96SEcpnR+k9fC+Bc0xHqPFD1ha5vxa19V6Z2Mfs/q0MsTp1v6hRU
         gjTyxKib00MDr/XmQ74UBXGP4csqa3zrTfqZe34VfMMEIHFB2A5PCYXe4LUfEwJzYNr5
         TRicn6TWX9VZkTOAHzGbNL7JMjdT3DhlOXEdIH3pFga+HTZmgl2PFgJei/zzDTrh/gkc
         8fQSx/y6J4V39MlByEim9R4uUgi+wWY5dA05DwDZQqUssnnAQqL1GyCHgxrnVPNe8Zt7
         EH1A==
X-Gm-Message-State: APjAAAVf8QqHBqwHtwqpbK0/FzOVkHpMj7jOVwdnqxvhQ07mE/oKNQE/
        x3VIv4nql446EhNJmGXKMqwQ/31Um6K0xGXjzx7Ppg==
X-Google-Smtp-Source: APXvYqz77lsLSUshX4I7P4V2nccO2u0G8aFs/OT/eUHjoONaKFqhCJMlzILUKQB0tUg7WhwXNpMwGNHZGIo9/1tYHo4=
X-Received: by 2002:a37:a2cc:: with SMTP id l195mr11842858qke.362.1562551460481;
 Sun, 07 Jul 2019 19:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190626132632.32629-1-axel.lin@ingics.com> <20190626132632.32629-2-axel.lin@ingics.com>
 <e1ba816f-1ecc-acc1-1f69-bc474da1061a@ti.com> <CAFRkauCtHtG0mfqXp=FuBYYqGhhMGfP3o_N3iBoRHwkQNQYtNw@mail.gmail.com>
 <b5452465-3dd4-855b-1a17-3da96070903c@ti.com> <CAFRkauBxJKcYbiT6UmKw81SAKm=AuDFu1Ez6Ttuc_EcMh_SudQ@mail.gmail.com>
In-Reply-To: <CAFRkauBxJKcYbiT6UmKw81SAKm=AuDFu1Ez6Ttuc_EcMh_SudQ@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Mon, 8 Jul 2019 10:04:09 +0800
Message-ID: <CAFRkauCeayKSvxOz8_qdFs1PX8gAWj9H3iOp0XaZQ+kndf_cUw@mail.gmail.com>
Subject: Re: [RFT][PATCH 2/2] regulator: lm363x: Fix n_voltages setting for lm36274
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Lin <axel.lin@ingics.com> =E6=96=BC 2019=E5=B9=B46=E6=9C=8827=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > > With your current code where LM36274_LDO_VSEL_MAX and n_voltages is 0=
x34,
> > > the maximum voltage will become 400000 + 50000 * 0x34 =3D 6.6V which
> > > does not match the datasheet.
> >
> > Not sure how you get 6.6v the LDO max is 6.5v.
> >
> > After 0x32->0x7f maps to 6.5v
> >
> > 000000 =3D 4 V
> > 000001 =3D 4.05 V
> > :
> > 011110 =3D 5.5 V (Default)
> > :
> > 110010 =3D 6.5 V
> >
> > 110011 to 111111 map to 6.5 V <- Should never see 6.6v from LDO
> >
> > Page 7 of the Datasheet says range is 4v->6.5v
> Hi Dan,
>
> The device indeed can only support up to 6.5V, the point is you are using
> linear equation to calculate the voltage of each selecter.
> In your current code:
> #define LM36274_LDO_VSEL_MAX           0x34 (and it's .n_voltages)
> So it supports selector 0 ... 0x33.
> For selector 0x33 in the linear equation is
> 4000000 + 50000 * 51 =3D 6550000 (i.e. 6.55V)
> i.e. The device actually only support up to 6.5V but the driver
> reports it support up to 6.55V
>      because regulator_list_voltage() will return 6.55V for selector 0x33=
.
> (I have off-by-one in my previous reply because when .n_voltages is
> 0x34, it supports up to 0x33)

Similar comment as I mentioned in another path.
Did you check regulator_list_voltage() output for the boundary case
with and without this patch?
