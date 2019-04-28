Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC5AC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D9B20645
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0L2gQS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfD1Otx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 10:49:53 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41225 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfD1Otx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 10:49:53 -0400
Received: by mail-qk1-f180.google.com with SMTP id l199so4575008qke.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4s/3bpEy2IfN4KLV+MX3ORvx14BWTQjG55RPnmwONvk=;
        b=U0L2gQS7eNAdZnjJ1z2cCrGQFrxn90Sdw2FzBKpj32Y0kOQXEPbyhwvyfgMtpAutd7
         TdwQYJcBXjZFjEJw3SJT74VizypiiqaNX21XmICNw7p7pw+f1i2IRkXmXDFgeHGI90HT
         oeG5jjRZ/jWnKDOIwSa5f6ynprQlCiBJGy8xT//aYIsoy7dT9fX4HFQV6PXgtPFJBrJA
         r3RLUfoD3I4NqentgE7eGDFmwYwyfNIojcYa6Johg2zp29bmSZGIKH3XFufk2yiNi5Yn
         f+E2ZDOHuBRxBIFmH1tUxPe0IjkzrOVOyjwfrvbsB3B7ySpY8p9u2h6p2cxjOO/twEhi
         O4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4s/3bpEy2IfN4KLV+MX3ORvx14BWTQjG55RPnmwONvk=;
        b=X6o+gpT6AO1RtKjsU0blo/bfuC1TF6uceXWVJuDJgPw0Qh8MFPGdWDEDwm7naNd+wh
         kk9turkejsU8u8zIOT0v2sVmzRt/5Jx4DI4Zqkmjt/ZzyD+k3XlQI8Rz4jxByJ82fvmt
         LnNPuiutaHyyaC/pIqMtDHFJ8MNVVapVFZgw4nwyQFGcIw+MSshi8JT7soeDt5DNyMTk
         dZs8hHjeQtqPlaQz+qSLsoiAad0Yn5jYph3TVm9w6ozeU+vJiu9PLN+g+J8+jNB7Tprz
         9UMiRt9zWufGd2rgthwzvhF62Q8muh6Vuzr1kCyDfzEL2grC9Caxg9ZolzcboKY2ETSl
         ifvQ==
X-Gm-Message-State: APjAAAXVyWxdM0GjFJMgdr9jJFsg58LdL1LAVsTSGxLqc3+nsx+pYcYq
        tUX3l8NyeSSVtyGyxeTeGwEtPO+86FZ3bhsee2Vk+mse
X-Google-Smtp-Source: APXvYqzjVldrObXLiuVnW4byiIduTvXCh9S6tUXW5yk+UcoJv+GhvppObHQZmZf6jzrS7X00IkgJQqhE2udZBVfaXvg=
X-Received: by 2002:a37:80c6:: with SMTP id b189mr35593082qkd.144.1556462992346;
 Sun, 28 Apr 2019 07:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190423143258.96706-1-smuchun@gmail.com> <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
 <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com> <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
In-Reply-To: <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
From:   Muchun Song <smuchun@gmail.com>
Date:   Sun, 28 Apr 2019 22:49:42 +0800
Message-ID: <CAPSr9jHCVCHNK+AmKkUBgs4dPC0UC5KdYKqMinkauyL3OL6qrQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue directory
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhaowuyun@wingtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Rafael:


Benjamin Herrenschmidt <benh@kernel.crashing.org> =E4=BA=8E2019=E5=B9=B44=
=E6=9C=8828=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:10=E5=86=99=E9=
=81=93=EF=BC=9A
>
> The basic idea yes, the whole bool *locked is horrid though. Wouldn't it
> work to have a get_device_parent_locked that always returns with the mute=
x held,
> or just move the mutex to the caller or something simpler like this ?
>

Greg and Rafael, do you have any suggestions for this? Or you also
agree with Ben?

Yours,
Muchun
