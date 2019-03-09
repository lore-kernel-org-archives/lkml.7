Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2782C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82225207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo9IDIi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCIND5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 08:03:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38449 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfCIND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 08:03:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so205090otf.5;
        Sat, 09 Mar 2019 05:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KuXqEiBSM8f3dFXLXwTQfqlgt9COvXmn96ZMFSltoU=;
        b=Yo9IDIi/2GTj1OGTYY213+C3kuHFxlg5VL1820pjUXMLzu6G6WlEhTZitr6lVSTy+T
         SnfOizQ4xV9D7h1kABGugkfVhGu9+6N/3AKEDvHPn815w07XSXB55QII92J9TjESggjR
         0CCzWnezYxXeqIo9kwxNSyHCLJBrHwHRLSJAksN1zLgtgbKdrY1gDTJQ+h80kbSGyadG
         t+DPYLoFBInHw2L3nYqDdzzVHekedJ6+qNMXPTGa82voEVGSiKx97VyYEYN0czLcNOsk
         kbAip8FEWTJFVMGuDmFB/GqP7gPBk2sOOLMQW0MesvQ9jodujeoS5qxCx5S7ZHy8CcLG
         bq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KuXqEiBSM8f3dFXLXwTQfqlgt9COvXmn96ZMFSltoU=;
        b=IitzfHJEZyry4Fy5UxGIiedFAj5M6vELygRhnbcsTiyVMKMjvs+pNJKYj7WN2TtGln
         ZnO+1N9Fsbtn1gk72fxsE9RNNcGMIr230JWgJ2PkY4q79wzpnXdBxsCsdK0T0KpjvZJy
         x+RdV7QGBjeIB09AO1DPv9yPlVaCbIeNfkSe/Jb5nUQ20sI6mKoFCCU7zOn7W7DySML0
         8BUIBZZNi8H/6xwG1XQUnZebqCuOb6jEncHR3sm4gUs07MEPfpcLouAbG6I1v0zP/S0h
         3F2fe6ZEy/2hKKt/48X9H2OCrnXEEbeAj8FSqingMIJTSO5zz6XzPDa95tFPnTneuR7t
         Bu6Q==
X-Gm-Message-State: APjAAAWOF0tU9puvCojO6Hp8+IL8fjULBy2yoEq07N6GHT5cWX+VrNDm
        +/d19NiL4phCtiN+bE6N4PfoQVFD7k/kyLhvt4c=
X-Google-Smtp-Source: APXvYqwGB7OrZsnNWhpjkxEj5Ipj/clW5jY+XkhSNbAX2yujl0TPejchgL+z+JlbML6eFnDMxm9MHT6Sy/ox7FCVHZA=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr13851310oti.95.1552136635507;
 Sat, 09 Mar 2019 05:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20190308175935.21904-1-TheSven73@gmail.com> <20190308202936.GA32641@arch>
 <CAGngYiVgEDTQxynjPDMO_ZApAX6uyvUL+iqyK-QHnhDz=E4eCw@mail.gmail.com>
 <20190308223249.GC32641@arch> <CAGngYiWSaJqtzUA+nUNJTcssUq1Y=UzYc2u8hDcKDjF6944o1Q@mail.gmail.com>
 <20190309102427.GA3565@arch>
In-Reply-To: <20190309102427.GA3565@arch>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 9 Mar 2019 08:03:44 -0500
Message-ID: <CAGngYiW9h1d1uHKTKE08OR+V-gBB0qxKE=kmo9NriC=FJddUGA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: fix use-after-free on device remove
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 9, 2019 at 5:24 AM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> What I meant is that delayed work initialization could stay where it was.
> The reason you moved it is readability improvement so to me it is more
> of a cleanup hence I suggested a separate patch. Up to you.

Ah, I see what you mean now.

I'm ok with splitting this up, but we should probably ask the maintainer
(Jonathan) what he prefers, because he's the one who will have to take
two small patches instead of one. And the second patch is a one-liner.
