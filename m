Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78970C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4283D205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="JtAVStV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfG2UOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:14:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33379 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbfG2UOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:14:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so19568087pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4keJAShqq2q/IDLzL2p7jjpoZMeQRV3FU23AJeNycVA=;
        b=JtAVStV+qYUB/ArkMRlEhkdK6ZnJDpeNjtT5z/JG5u9vUvaM01WO2YcLvVQHikjip2
         yXyEXrEWBIC/JnvrJGvWDf/+oxhnP2VEshm127BxsGbwVqqEhJbK9dW/muTeETtXui1W
         ozqImJGewtf163mLx/QF8Gmm7cpinTpKd/k4gD+j8PMiYx1LBAmbE8SgRYnVpvXWc6pX
         kvPoL0Xe9jFiH4tRZNk97oF6ubPo/GAMlK1oSjwIhjgQgjXQL4VPyOgFXgaVNbKwnTaV
         Q81p8VC26BE5lME7nv62flGyWCXwwYRxSONbcyLIwdiQ+Y0QbQkFQqTtSyADMpVZFNLg
         OODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4keJAShqq2q/IDLzL2p7jjpoZMeQRV3FU23AJeNycVA=;
        b=Vi6L7tE3ZephtMkK2gAesHdhUNdeUi9LpjYrH5k8980gLbzv36iBtyfn5e3P0k2aBd
         fl44pZ3zIZj/4H5XLafm2jpKhYPgEeHoopAPNckF/RjXC88G6fwGimDobbTMV6uVzxs1
         Y0sFQFz0d7O0N94QP8hZqZ9reqPxgUc2+u77eYpvj6ATFrvpflZKC5w3wyDI370fuGb6
         bs8K+zzi39A6VXJVvLYs9v6A4LCh7SGI5182a9IfG+nNnzGnvn6+pc2mqRM2sQSKQmQY
         1GoEMt48LXNCOQG9vpxnVrsYpPfRzCex8+/6B1wbUvW5R4kx/wL7poTejjCqoukEJy94
         XvEg==
X-Gm-Message-State: APjAAAVy5MMVpRXW1l8jYfBxMqDI9RHQU1smiXX8ceHMEyhUWGoUQaUe
        565InoC/ygmINx4zjsBNFIEhg0ry0ynDlyBJT9U=
X-Google-Smtp-Source: APXvYqy/5Bg/DGakidcOCN+mJroP8j11+A23pRgyE6m5fhgP67ISRmMTRVQId0R3vgBCuylnPSD8+jIMNZ1bBhJswSM=
X-Received: by 2002:a17:90a:28e4:: with SMTP id f91mr110090286pjd.99.1564431272178;
 Mon, 29 Jul 2019 13:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
 <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
 <201907181423.E808958@keescook> <CAG=yYwmTdW0THoVGJc-Le+TyGMaHKZD-NHTRfXczNes65T8qWA@mail.gmail.com>
 <ec210573-dada-bb6e-b0ee-f54bea62e2ce@kernel.dk>
In-Reply-To: <ec210573-dada-bb6e-b0ee-f54bea62e2ce@kernel.dk>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Tue, 30 Jul 2019 01:43:55 +0530
Message-ID: <CAG=yYw=w-Y2zJG-hfUdC7eZ+c7CykB82gBnHpgZMcpHquWzRXw@mail.gmail.com>
Subject: Re: BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello Kees,

please mention  me ...
Reported-by:  Jeffrin Jose T  <jeffrin@rajagiritech.edu.in>
Tested-by: Jeffrin Jose T  <jeffrin@rajagiritech.edu.in>

On Tue, Jul 30, 2019 at 1:25 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/29/19 1:34 PM, Jeffrin Thalakkottoor wrote:
> > hello Kees Cook,
> >
> > i tested your fix and i think it worked like a charm !
> > kasan message related disappeared during boot time and it does not
> > show in the output of "sudo dmesg -l err"
> > anyway thanks a lot !
>
> Kees, could you send that out as a proper patch?
>
> --
> Jens Axboe
>


-- 
software engineer
rajagiri school of engineering and technology
