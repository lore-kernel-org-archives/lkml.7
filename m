Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F72C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D022133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="f/GZd8pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfELIe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:34:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39165 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:34:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id y42so11486267qtk.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=YS8lOVyUI9iJFP4yg7Sjig4QezC9K7Qq6O5JPLoem+A=;
        b=f/GZd8pr2jEa7bn3f6Sv8EQMYXVvEge9HfY5U0r5/idilp5+qyfbid/SD5TwbAHXDT
         92hhcR0AZVCN/1pFZXh26OKli1iIHKhtT1CHAkuGlDa/YFYtcE57WtIe/AlIQknDNJ7D
         6e8aCFv8Td3cmZS8EOZOHXcUePbTyI5KuRhpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=YS8lOVyUI9iJFP4yg7Sjig4QezC9K7Qq6O5JPLoem+A=;
        b=Z4KnnKi5mHtXExDqIul8V5DSibrZzdOVuOxoidQnjEjKOxGLpkvyAhRf8C9QAKhOlP
         A9tcFPN94qQIKgNpRJjrNZm2UfjZ7ww1IAOWeKEckLC+ip6kKNSVCKGGR13z10XyMzR3
         i0b0nhr/xgMPEJiD6iMZbk2NZBbyoACDm+sAx5+Zgz0BmG+7/FY5Fdf56CN2xXSwFTO8
         RfqKEX4Jp4SbR2lJE86mN/uOAP5DVTTIadJYg5hDC5vja9l+AbK1idY0qhRystJvw/C3
         TEk7FRRtzYo7k/zZ6GS/qK7tUu/gyHj0YN36GvMW/iUTIDlH3k/Aqu6u9wwK0szartj+
         2uWQ==
X-Gm-Message-State: APjAAAUfDmQqffxjqDkGhkttBh+O8T6dJTkNkC76uMqbo6Vr79WsQR0+
        XdLQLnWExrcwQd9vSoDi4dAJ+B/Q3W3qWg==
X-Google-Smtp-Source: APXvYqyuONQxRAqHeQlL6H9J0HbTLtYG3STPn0UWbrH9YesnnhBVt/NKz7J+WaSAVpjmPkZlwQ0IsQ==
X-Received: by 2002:ac8:1b31:: with SMTP id y46mr18530725qtj.203.1557650096935;
        Sun, 12 May 2019 01:34:56 -0700 (PDT)
Received: from warpc ([2600:4040:4001:1e00::f7aa])
        by smtp.gmail.com with ESMTPSA id b22sm2433859qtc.37.2019.05.12.01.34.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 01:34:55 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     "'LKML'" <linux-kernel@vger.kernel.org>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
In-Reply-To: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
Subject: RE: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at ffffea0002030000
Date:   Sun, 12 May 2019 04:34:55 -0400
Message-ID: <000901d5089d$93b52e70$bb1f8b50$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGt2wXR3r0HRU76js3YxxANuuc/M6a1hM2Q
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Justin Piszcz [mailto:jpiszcz@lucidpixels.com]
> Sent: Sunday, May 12, 2019 4:28 AM
> To: LKML
> Subject: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
> ffffea0002030000
>=20
> Hello,
>=20
> I've turned off zram/zswap and I am still seeing the following during
> periods of heavy I/O, I am returning to 5.0.xx in the meantime.
>=20
> Kernel: 5.1.1
> Arch: x86_64
> Dist: Debian x86_64

[ .. ]

Reverting back to linux-5.0.15, will see if it recurs (I've never seen =
this before moving to 5.1.x)

$ diff -u linux-5.1.1/mm/compaction.c linux-5.0.15/mm/compaction.c | wc =
-l
1628



