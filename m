Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DEEC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CF722314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DGJ6nh5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgACNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:12:37 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45921 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgACNMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:12:36 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so41244453ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=30zoyA7P6Tv3skAoDZoq8xqN4o9iJa06FRbHK1Zh9ic=;
        b=DGJ6nh5/nf7PcSoztvP4CVhpVQb7hNYvrQZBRxdCB0AWSALZd+/ICTmeUaMSEb+yrw
         Vk/Z++sUZ2Nl+tDAzXYkqp4NODzCrJMqRgzsF7E3bjIgWWuocMtRfq7Ws8OeQyYooSYr
         goKkBVmJ+9WmO6Ov1n9/B12T2lXGA6u5bIr4BkTAa96IbfFQDh5r2IPMTbRXn/Ki5u6d
         vaZbt0Mmf18I3EafvXixEkiHZPCBo5yQrDJAlW+6CRo8S2zEyBcnErKwu8Fc0ATF8i5P
         jrH/hOVgna0BxsKEzxc1IZfv4/MwyO1Cc2/WAmtbYcCC+DuDDiv3BNltFmVHqAxy7ubB
         f4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=30zoyA7P6Tv3skAoDZoq8xqN4o9iJa06FRbHK1Zh9ic=;
        b=L7TFL+OeCQou4sg4OVpKaFLSssKfjWSJtYbS7SsemsYikMAGFTESj39YKkuLhXFTmU
         TI0xQW1/gn7N4KL0dAqJxrz257B1jr/JpIzL0YbzzjcNzZLfOA3xXMIsDC5hxcn4SwPc
         jWpR09n0vEBq2D+GOTft6MDmfOCYELm91Xu+Rrae1dt/HH+kFL1vbutNvZC6a57znBPT
         +75SVIc7UVkSua86s88PV8AqSmUA5IIkiPIeSfNRVlPIHQc+nf8O20uRHnmT/N9m+mZq
         YMPj3F1LAjLuXvX+YM7QO2t9HZIO92Z+tNSH9nnzZlt6y3lpLR6zEelQ51sDbdzUkb0O
         MmTg==
X-Gm-Message-State: APjAAAX/qOJRP5ltOq+Hqbs8LqVLWP3ke85CaSavT/JYd4WRrvCRowNh
        eH9au6e2YbgzPk0qxoCH/EQLugFYXN0Fw18+gsuxfw==
X-Google-Smtp-Source: APXvYqy0pZUNAtl/Nu2tduflgj0dhUAGTOGl95cPZjOxBUjRtKp24RYctuGBbX6S2rM2LVnts2snudB1ZdXB3M5WsM0=
X-Received: by 2002:a05:6602:2352:: with SMTP id r18mr50032452iot.220.1578057155997;
 Fri, 03 Jan 2020 05:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20191210100753.11090-1-brgl@bgdev.pl>
In-Reply-To: <20191210100753.11090-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 3 Jan 2020 14:12:25 +0100
Message-ID: <CAMRc=MfZmMV58kYD=bhuUCY0n3eb5iVy1kY=6NJsx6guagCd=Q@mail.gmail.com>
Subject: Re: [PATCH] input: max77650-onkey: add of_match table
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 11:08 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We need the of_match table if we want to use the compatible string in
> the pmic's child node and get the onkey driver loaded automatically.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Gentle ping.

Bart
