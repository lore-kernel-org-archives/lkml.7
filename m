Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A8AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24414206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3xfUkCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfDQOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:37:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33349 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbfDQOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:37:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id e5so20226783oii.0;
        Wed, 17 Apr 2019 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVL9KF/YoHtzs8IjWHwRGHOY6DKDTBP7zc6ndr7tx5s=;
        b=e3xfUkCx499Q6ZWEuv72GXYEVXGDx+7aGV3XVxUyeFEoIihqBm6FuWKDh9k85LraPC
         FPDWDfh9VNEGQ1Oacjd+VFEKMG8t+2DaIVBhzLyJryqpeCMYgb9PvNW8ilS2WeHdQlYY
         s1yx5EL43kQ5aVZQLckp9ZuEa1uIsQbChvnG3DJVwMwlyktsnKQmnMHWvla97c5JNBbB
         coXPfWAZz16bq8iPuYkakDREYFwPomhRHWG+zu4ouHbIfJzyy9g5TkdWxYiVLhe4idji
         /178jEtlfgcqsW1Brt/zS7UKc399eFbJ0y0xbfFS09iZopZEfGliGDUThMCKftIaCmvh
         V1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVL9KF/YoHtzs8IjWHwRGHOY6DKDTBP7zc6ndr7tx5s=;
        b=JfT3nIUUL06TuMV+6sJJOMaOsHgGoEMU7EWZ/k3idwn6ehfVdJ1uAYNQEpjPzf1jBa
         EFMlCTld/SlWXeAOhm+oOBcuAuzwhkAipwgvEjPL2XOEuu8GcBOeNWhvtDfES9E0zXwn
         HeRHR+TJePTpuiRaK0U0inr81mWoE0CgH/s3qh0YxJC6X/x+N/WwXkZRVn5xFkDIZenO
         bzNhC9nW6zD6BPfiDvY430pJ+al4IvBD1UNFki0c+MDZ1cUpZUkND+zlMtouL9/CM+Jc
         wZpHNcISX1FjClNnINYeUy8MWWwKNLKEUPz+o5y9YPW/x+/Akm1rDkSkvG5HOVlSCvmh
         yKiA==
X-Gm-Message-State: APjAAAVtiNGFJQ99ToHD+f5Q6QRvaLVD6jHBvgMrOY6K/Sm7RsUUZQBJ
        dq8k6cdvL4YYzCVKCtdesI9A6gvdWXsWMl5QSyM=
X-Google-Smtp-Source: APXvYqwzzDkTed9Kh/UGRtG/0sH/YvObQ9TaaQaBnqTEbeqLHTGrdH2kSDOwSiAltGeQPXi68t/6LeQi8m9SrMWNciE=
X-Received: by 2002:aca:4202:: with SMTP id p2mr25429168oia.169.1555511842207;
 Wed, 17 Apr 2019 07:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net> <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
In-Reply-To: <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 17 Apr 2019 10:37:11 -0400
Message-ID: <CAGngYiVSibcSas+cGPVkvBb-kgUnDAbgd3m59yyqwp5j1D+Cew@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet card
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:21 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> Yet another question: does each fieldbus_dev instance talk to exactly
> one plc process memory, or can there be many ?

I'm by no means a fieldbus expert, so I had a little chat with one of
the fieldbus
people in the company here.

AFAIK if multiple plcs connect to the same device, all of them 'see' the same
process memory for that device. Any mechanism to prevent these plcs from
racing with each other is implemented in the application software. Could
be handshaking, could be each plc dealing with a separate section of
the process memory.

So for a fieldbus *device* (which is what this subsystem deals with) there can
only be a single process memory. So we have a single devnode per device.

A fieldbus *controller* would have one process memory per device it connects to.
But this subsystem does not deal with controllers.

This is my understanding, but I'd appreciate your input if I have overlooked
something.
