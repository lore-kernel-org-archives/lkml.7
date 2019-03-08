Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12043C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C162085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjMA0C3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCHOkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:40:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34930 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfCHOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:40:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so21408256qtk.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 06:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/UzdaxQ9ACqS+UVbyaPF7mwuYfnnJaCv3WnuPaGHOs=;
        b=fjMA0C3KREUT2ZDqBR7P1XyaKxrl+cq6a3pG9ape/Z4ShU0QZZ7qtKSTokbSKs8Nnj
         EQsLrjB0Y6rHCFh1VeC7bc/jlXdqHhOzBVxyE63/r2nAY+MTJ9S5XWn7trgWssihXwQC
         FbuT7+eYnwKeI4r+4+oHObGUZjUDpKjFiYXNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/UzdaxQ9ACqS+UVbyaPF7mwuYfnnJaCv3WnuPaGHOs=;
        b=qG0YW25y91MDBzCVVz5/lM5b6lU930V9D36y0mnMtn9AH6LHMYyb1RQnHBz1iaF+tB
         nK4oefYEuK4ob1ircN3/YiEHAIxhWU5mHNFsnfCnZFSM92EIsrsijhxB/LOoRyed9tGF
         g/jiJcU7rEoRI/1HCG8aQxObg4fXFjx/7cdwd+X+AFgtWmLT5PBjPLTXR0Jp7Ib8eP9c
         TgYQP9/pH0InD8TnnC6/oCQF3RsJggUr9hOcCaNzpmbN0dRV15XpmLCaBo5ejSrl6v/I
         76NizR9hylXjaw3JJ1h2uJVw66K+89lD4Eyl3a/KfVky16yjP+Wl1ztKCBtFjsTqDLG8
         12Bw==
X-Gm-Message-State: APjAAAWvBBoH8a1uUVOB3Xz92cmMVP6yoQTJKN2u4yMrO4vTfz3wDlz5
        /W5MyC47VO/dnEP7V0Fx/nNcZMxDdXX62FztxJTQZA==
X-Google-Smtp-Source: APXvYqwuXlZAj2Is7ebxIxgNJSYV1+u9aalZa2hA5n4kQurZf8EqmTRAzHmGzz/U8gAVZKAZVVsx7W9CC2wUuyfkbho=
X-Received: by 2002:ac8:1c71:: with SMTP id j46mr14685921qtk.307.1552056001300;
 Fri, 08 Mar 2019 06:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato> <20190215163657.fs6t7p3vqez53su3@ninjato>
 <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com> <20190308112919.GA1674@kunai>
In-Reply-To: <20190308112919.GA1674@kunai>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 8 Mar 2019 22:39:50 +0800
Message-ID: <CAJMQK-j9b3o+KQfN8nLXGiP+TXi8i77=yTTQsEARa6cotPhxzw@mail.gmail.com>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        qii.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 7:29 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Feb 22, 2019 at 02:04:11PM +0800, Hsin-Yi Wang wrote:
> > Thanks for the solution.
> > Previously we were testing if the driver can handle zero-length
> > transfer, but it turns out it will timeout. (Also checked this from
> > mtk's datasheet)
> > Adding original owner qii.wang to verify that. We'll apply this after
> > verification.
>
> I just checked this issue again and concluded that both are reasonable,
> the suggestion from me below with the adapter quirk AND your original
> patch setting the threshold to 1. With my suggestion the core will
> prevent 0-length messages. But still, we should set the threshold to 1
> because 0 is a value the HW is not capable of.
>
I think quirk might be better, since mediatek said they might have some ICs
that can handle zero-length transfer in the future, so flags might be
more clear if they want to restore functionality.
> >
> > On Sat, Feb 16, 2019 at 12:36 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > >
> > >
> > > >> > Ok, I can add a check in another patch. Should we return NULL pointer
> > > >> > if msg->len is 0 or print out some warnings? Thanks.
> > > >>
> > > >> No warning, msg->len == 0 is a valid setting. But interesting question:
> > > >> I was about to say NULL, but your driver would assume ENOMEM there and
> > > >> discard the message which is also not correct since msg->len == 0 is a
> > > >> valid setting. So, should we just return msg->buf then? Will this work
> > > >> with your driver? Can it handle zero-length transfers?
> > > >
> > > > dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> > > > kernel if msgs->len is 0, so I think it doesn't handle zero-length transfer.
> > >
> > > Please don't drop the lists.
> > >
> > > Then, the correct solution is to forbid those transfer with this
> > > controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
> > > like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
> > >
