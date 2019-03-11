Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF732075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbxHlRGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfCKORO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:17:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42945 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:17:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id j89so4152425edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5rcubpvl8ydHyF4FSnjvUWfh7Gku08IrvuepOCg5T8=;
        b=GbxHlRGwQ7TP2Cu2vZ1ETcF1bTTGN2c/k6lbM/FzzoPZqfDb4a5ZqihEFx+ihNhTBP
         HLe1nYV/4ket0lPYbIKdfES0F4D3SJ9A7JQxVAq3Bff/0x0PZidgDw6TvlMQarUUqqTR
         hXCkMgwulAPhKUUQKQrWWqLVa0yLzP+YuVG287YMBwLsNQ0f0tmqhWWmMpAo7VehCDHU
         eKzGhXThJPF+Z/XhYF20PfOfarUySQnzE05Fs3/UvD1LplswZXAVxf3ezlvOnov1FBth
         z9p2Y6D7B+KJ3iSJ8MowVC3zI9QozdpNt98lMXeivFYOC7G6Ilkm8yUbZJp3XTH7U+YV
         LZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5rcubpvl8ydHyF4FSnjvUWfh7Gku08IrvuepOCg5T8=;
        b=hXGAOxzAGkiU/fxcg4Gcoy5W9Pk03b3raMeUsgavthY0nvdMTl1xQPCeUsqXLrGwKN
         LA+6LMXrGzge2pBbSviOqRJ2Oj/aTkZNeoKdhIBGOze3vNNDI8RaKALQr9FXMAu/4HIe
         TXmm4wFf59ezEL8hI072GMJ4TGxvwVCqO1UW0nlIJhJOc621elKJX6ZShzh9DTGjgv8r
         BITinnTW5UvpqHI/sQSitEl7znvtAZndwfkMvO/UWcBzHYGuMmr9bTdpJIRiN5b2F32O
         kTy/uKmpI98E2TiWfikIb4VkenCf+qsOu0PmdZX+AxEVHZcAZPy3fyno3XdCk1R1qMEk
         sMaw==
X-Gm-Message-State: APjAAAX+J7eYwhqj409fP3Z1F0bT8MZoYlcSbL9c+PlOGYv2QotNh4qP
        pMnHZpycaC+3/PplkBdKw7lugfUmq6LamQiAtoZXhQ==
X-Google-Smtp-Source: APXvYqwq2Z5StMtvwR7SZVjlZjE+0OHJqECiAiYcxrkjx+1rm8bp1QXSE9LGl2J9xjlfV99kAYsjNIYWbNwgoNsHf84=
X-Received: by 2002:aa7:d795:: with SMTP id s21mr43028508edq.116.1552313831797;
 Mon, 11 Mar 2019 07:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
 <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org> <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
 <7c37c201-8bca-ffa4-5e8d-5e0b4b268b3f@kernel.org> <CACT4Y+ZV2aMWjobgV=-aUdSLnGU=_2yuf2TOx4TD8ApoVqRVYw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZV2aMWjobgV=-aUdSLnGU=_2yuf2TOx4TD8ApoVqRVYw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Mar 2019 15:16:58 +0100
Message-ID: <CACT4Y+abRq25axHrxNczh7sVw2RjYJB8y7JOBmyMmVF5xJ+Y1w@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     Shuah Khan <shuah@kernel.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 6:25 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Sep 7, 2018 at 6:20 PM, Shuah Khan <shuah@kernel.org> wrote:
> > On 09/07/2018 10:14 AM, Dmitry Vyukov wrote:
> >> On Fri, Sep 7, 2018 at 6:03 PM, Shuah Khan <shuah@kernel.org> wrote:
> >>> Hi Dmitry,
> >>>
> >>> On 09/07/2018 04:54 AM, Dmitry Vyukov wrote:
> >>>> Hi,
> >>>>
> >>>> I am getting the following error while booting kernel on upstream
> >>>> commit a49a9dcce802b3651013f659813df1361d306172, config is attached.
> >>>> Seems there is some kind of resource leak.
> >>>>
> >>>> Thanks
> >>>
> >>> Odd. This commit has nothing to do with vudc.
> >>
> >> This is not the guilty commit, I just described state of my tree.
> >>
> >
> > Can you send me the full dmesg?
>
> Here it is:
>
> https://gist.githubusercontent.com/dvyukov/e9dec59fb23da9cedd8ab07a7d8c78ae/raw/3ee13c7a1f406c9927ca3b16db262f2c78e84536/gistfile1.txt

Hello,

The boot seems to be fixed now, but what commit fixed it?

This bug makes all kernels starting from 4.14 unbootable for the
purposes of bisection. If we figure out what was the bug and what
fixed it, we can think of possible ways of unbreaking kernel boot.

Thanks
