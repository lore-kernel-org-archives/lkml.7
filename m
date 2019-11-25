Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A77B20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5xNCOML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfKYSNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:13:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34764 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfKYSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:13:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id cx19so5892548edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnxcpMz5dNB2R0ZiMjMQv7ajBq4qcecqf6LvupZ/sR0=;
        b=Q5xNCOMLxN73mwQWlR3JO4ib7P8cr1bXyAiG/WlEd5AM1cIX0+MgMBFMDnxf57Dl+9
         +8ithnSkyAFcvXriItOzZRDpcOpCeHyNSUWY7er3QW32I8KsRGXkhf9LuRt1lNY7p5oI
         u5lw/tDvjbYLTSBvq/hexPE93yDkO6Yxz+39E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnxcpMz5dNB2R0ZiMjMQv7ajBq4qcecqf6LvupZ/sR0=;
        b=ng0SEIMSU7b4VjNJUyEa/UGk+ziNgMNgFVHqdb9HGkn8p0YnXhQitA0Jgryy7nDoqx
         4enByk9gXOukiQqZ2zyXZqCu3Gm3OH4z12UC9uUzazQDEytiLQ2VX9bJeZQRBiaDOUGo
         dvjmp17GTWIv6ovG21g42STveKg5TEw8yTetp/I2miCnq64ystYjao0PYPwmNP9DkQtH
         lUn19z+4d+Km37wXowNCUp4JnfTWF3r6b5L/gxEqTsrz4IipUjNySqYcHeg4wTrh8DLm
         FKbKNBWnGGoOfzIUsBRZja1/UKFisEMmVe8FKqj7Q+hcfLxvR8wc/b04fEliBeUn0sTU
         30vg==
X-Gm-Message-State: APjAAAVkeJOpHKn+plXIhY047dlqBL1Nh11M527R4PT+os93/MTfKIJw
        3n+B6sU6MKvSGTlT2OE6s6etfQK7buc=
X-Google-Smtp-Source: APXvYqy+v1tAyLq1vrAdtcWgokGoHsz1jh216KYvf9pzSSXYV6p4PByjIFvGilQy+NQ/e2gq5B2ABQ==
X-Received: by 2002:a50:b6f8:: with SMTP id f53mr20168710ede.29.1574705586760;
        Mon, 25 Nov 2019 10:13:06 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id b22sm257048edj.25.2019.11.25.10.13.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 10:13:05 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id s5so19314558wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:13:04 -0800 (PST)
X-Received: by 2002:a5d:5224:: with SMTP id i4mr32943767wra.303.1574705584339;
 Mon, 25 Nov 2019 10:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.2.I68b9a92ed4def031c3f247d3b49996a2512d762d@changeid>
 <d82806a6-101e-181b-60de-0b32ff153ec6@collabora.com>
In-Reply-To: <d82806a6-101e-181b-60de-0b32ff153ec6@collabora.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 25 Nov 2019 11:12:53 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Dyj18+KQHZ9a5xAqDaGS4+gLAxQ9n8Liusn8eqE6pjFA@mail.gmail.com>
Message-ID: <CAHQZ30Dyj18+KQHZ9a5xAqDaGS4+gLAxQ9n8Liusn8eqE6pjFA@mail.gmail.com>
Subject: Re: [PATCH 2/4] i2c: i2c-cros-ec-tunnel: Fix ACPI identifier
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        dlaurie@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 9:23 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Raul,
>
> On 21/11/19 22:10, Raul E Rangel wrote:
> > The initial patch was using the incorrect identifier.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > There are currently no boards using the identifier so it's fine to
> > change it.
> >
>
> Right, I don't see GOOG001A being used but also I don't see GOOG0012. Anyway,
> for the CrOS EC side, the change looks good to me. I think this will go through
> the I2C tree?
>
Is you were curious, here is the firmware patch:
https://chromium-review.googlesource.com/c/chromiumos/third_party/coreboot/+/1928674
