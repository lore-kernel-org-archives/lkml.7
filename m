Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292402054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyVmCwkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCLPYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:24:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35675 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:24:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so2388955lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aOasrWNGGRnQLgjjfq8vqZ5DNneGLyU7YgbK8bEx3o=;
        b=nyVmCwkneRU76Jw2nxR/uogPBzDfFFt1f9Lg89ui3QFVK/2lXLogSlUoHBi9M7zsoz
         0UAhUxGyoeJaMCN4oQV5TLUkfqa/kO/qtW82gDmMkLycWGk0TvaxOtrm8rbwaL7CBEsl
         /bFGlHzNOvE5XXz5IAbrf+VGBLRIVTVn877N7g/kpwjtCWWaASnWjwADZZvaHA9in8dE
         jpthrPUMRgg8YUO0aAqIqvlcY9xexzvaHOkU6l/2GiVl0UnWvV56s8xoCFqJKRDp+WD0
         hkofzbtSase4r0k4yr4MlQOuz/vZhnTT4bSe1de9WozFWgke6RveQoGpZ1QH3LHmXy2u
         0Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aOasrWNGGRnQLgjjfq8vqZ5DNneGLyU7YgbK8bEx3o=;
        b=cmXmv+kI+f4kI+B92vE+Lo4C8ZfyHDJSH8/juxHdn8LKVx38PXJmlG9c6sIzu1S+2N
         bP0pNI3SiK19/Vmer88+3FLR4uPE1RlDyMpmnIAKjKVhoWHGODTM03v7X1Ik5bnsgORa
         2SapKATbxn1zKwEZ/GVF/oiZ1X5ZPKhOS+SNX7Wqom6n49ACLBnX8iLbdUFlXFQS4u5h
         cxUvXp+uRJQp4OEXOzqgNXeU0YL6rWLz93go/bdtR4vyLyYkM8IZ+4eTZwsKisPJ7Xyj
         ZfgYhqowPqC7wTJr212sT4nxlcM8TL2gBwdzdT1d4bkyxkay3Gja6vXW4qHFoco3wlhy
         VD7A==
X-Gm-Message-State: APjAAAXjrES8Tbg8kgJVyFZ5J7whLAFbH0XFVGeyXDrZug4tPOqJOivp
        dVeLlil0Vwe4Ae/mOyIhDG67kLDR00wo7ihcU9KuYrHf
X-Google-Smtp-Source: APXvYqyQh7cISe/E1Wru9LwvbnYi2RUGIqkXCgYsYex4X3y3tfWd6+CyPbmzPEgK4tdkTjmmZc9p7tiFZNpBTIH8/OY=
X-Received: by 2002:ac2:5386:: with SMTP id g6mr12717577lfh.88.1552404289710;
 Tue, 12 Mar 2019 08:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <1552310346-7629-1-git-send-email-info@metux.net> <1552310346-7629-86-git-send-email-info@metux.net>
In-Reply-To: <1552310346-7629-86-git-send-email-info@metux.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 12 Mar 2019 16:24:35 +0100
Message-ID: <CANiq72mQKKcE+dr4ajOULmR-Y-1OdxaQ8tmAyAFJ_ZadCkD5wg@mail.gmail.com>
Subject: Re: [PATCH 085/114] drivers: auxdisplay: Kconfig: pedantic formatting
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Mon, Mar 11, 2019 at 2:21 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.

I am all for humor in the right places, but this does not even explain
why this is being done nor what is being done. :) Also, "pretty" is
not really a good description.

Instead, please simply state that you are replacing spaces with tabs,
or whatever you feel it is best, and if possible, what triggered this
change (e.g. a reference to some discussion, or at least the
motivation).

> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

That Signed-off-by line looks wrong. It should only be your legal name.

Thanks,
Miguel
