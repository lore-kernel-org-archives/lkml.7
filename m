Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF379C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1693206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bA3OYws9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfEGVPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:15:19 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33876 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfEGVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:15:19 -0400
Received: by mail-vs1-f66.google.com with SMTP id q64so566717vsd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2lxvLvuhn3MckTQU8tH5e1XuN1xhSiuOf8AgLmEt4U=;
        b=bA3OYws9T0LnjkEW1s1ii1+HmUoOWve4rct1YI1IU0n/DLHsr18ZOgpj65OtQJrwqa
         qqrXwNIQ5su/IYrYnghuX4P2yCXZFfPQjVP01AccMNAO5PMAXHkBfjao/De7S5wBRgkz
         xcI/fNoLt8kFQ12Fy13BO7XCbP0Yer7+Sl3EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2lxvLvuhn3MckTQU8tH5e1XuN1xhSiuOf8AgLmEt4U=;
        b=RtdgIV28rMaY/qOA0AHrrSHE1FeVe4s8mgw0hBN5mu//5upJnbws3cgzUvrScVQrc3
         +1rVQOZ5gwgUE1gBKWw0tMGya+MsQYoQ2B2OWdFmy6MnMxgeHzsBl3x3Hsrty9fjNt+b
         /J01/PqcP1IHAOVG5y5/ZfwdPDoBHK65zt9uibAkNve0aT+q57+B1UrZPF5eIMT4bVKv
         BjUNilIvmviImxkKZTN6EOafzO3GoPu90I7Juwn5rxaPOUYyydjWCtP85jhJDiwbP1tw
         lFphFlRpOGZuvliWbKk4JPHLw4aQB+aErgRSqAwyei29z69/sj4Iljt5be075ZroZY+y
         x0kw==
X-Gm-Message-State: APjAAAVj+GiA/ZR5VGbi1BRr68GFnt+cNj9I18MiQRKd/k5ofi6jL9OY
        NiO4IJAl9429/jjmf5x3R2o9XABGDws=
X-Google-Smtp-Source: APXvYqxTLQX8zjgr0hd7BjDUtgxrh0v2fAU5M9VIvBK32hbf3sg+63Vg5HPfgNrTKViz3b9bseL0Gg==
X-Received: by 2002:a67:1a07:: with SMTP id a7mr18078109vsa.60.1557263717777;
        Tue, 07 May 2019 14:15:17 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id m189sm4312589vke.4.2019.05.07.14.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 14:15:17 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id s30so6574884uas.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:15:16 -0700 (PDT)
X-Received: by 2002:a9f:2e06:: with SMTP id t6mr17359140uaj.112.1557263716267;
 Tue, 07 May 2019 14:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190507044801.250396-1-dianders@chromium.org>
 <a3573253-e3de-0a82-8af3-6bacea20bd97@gmail.com> <CAD=FV=UAFUH12DbA++HML75E55BCttpNBxe9t-VEQvGjGx0=Wg@mail.gmail.com>
In-Reply-To: <CAD=FV=UAFUH12DbA++HML75E55BCttpNBxe9t-VEQvGjGx0=Wg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 7 May 2019 14:15:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5j++9LS-2aHR8CPoivT=5UUxkpUg=ZyEHfzXN8tGj8z7tg@mail.gmail.com>
Message-ID: <CAGXu5j++9LS-2aHR8CPoivT=5UUxkpUg=ZyEHfzXN8tGj8z7tg@mail.gmail.com>
Subject: Re: [PATCH] of: Add dummy for of_node_is_root if not CONFIG_OF
To:     Doug Anderson <dianders@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 10:59 AM Doug Anderson <dianders@chromium.org> wrote:
> On Tue, May 7, 2019 at 10:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > On 5/6/19 9:48 PM, Douglas Anderson wrote:
> > > We'll add a dummy to just return false.
> >
> > A more complete explanation of why this is needed please.
> >
> > My one guess would be compile testing of arch/sparc/kernel/prom_64.c
> > fails???
>
> Ah, sorry.  Needed for:
>
> https://lkml.kernel.org/r/CAD=FV=Vxp-U7mZUNmAAOja5pt-8rZqPryEvwTg_Dv3ChuH_TrA@mail.gmail.com

Should I take both patches via pstore, or should both go via DT tree?

-- 
Kees Cook
