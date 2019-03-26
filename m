Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B74CC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6993C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfCZIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:12:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47004 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbfCZIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:12:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id s81so7011016qke.13;
        Tue, 26 Mar 2019 01:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnNw3x3uIVonMYaNm1hCRelod2otCjxy0BvB7UUxoXg=;
        b=Se1M+F2UAILNvSZIyLKHYc9cA1powSeRu1cetMo9ZBhH42FnMnCXc5v03yBHPoZ48P
         KkKROVErNg5Z9Ad2ixv50O4LfLmdbKKiieb0FSB3l+oqZ5OzcmiR2eSk5N4+uYOjfRSZ
         BxsYmtPf2WcUcdUQdA/ifpzIAPgJoDRCdGyorw4dY3nN2sm5wZLq+SXedjxk8kd7MG9P
         /lPQ/yl2bnGYREKIU4NrMOg04Vvt2EK4AhP012GRt6Ha9BmR4+jR+haQO4aLgbm0ig9D
         5M8NKVsSqxCNk984d9XbsMoemr28tjf8BmnZlFCb92rwmHg6vIiE6CYo5lp7IQ4QmXjW
         OxSw==
X-Gm-Message-State: APjAAAUlqodffwA3suLWtM47H8jQ52wyrKfY1sZYzK2/5cz8BXhQOEoA
        vJkSIo8Zlp5PwYymY1wOQGKp9Ss/4uVSAiNhqkM=
X-Google-Smtp-Source: APXvYqxZ+c/jntGU+pgMl/SFyKRH+410Kr0HEFSVIQcOaLWxFnMtheUzi/p/upgCqt54KpSp1OmwYrOZbK7Gl4WXBNY=
X-Received: by 2002:a37:aa58:: with SMTP id t85mr23438691qke.291.1553587920707;
 Tue, 26 Mar 2019 01:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190322154425.3852517-1-arnd@arndb.de> <20190322154425.3852517-2-arnd@arndb.de>
 <20190326010831.GA29420@kroah.com>
In-Reply-To: <20190326010831.GA29420@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 09:11:44 +0100
Message-ID: <CAK8P3a1zF7VMoLQfby4W=TzB0btN82gMn2FNvkc3te5Ey97=+A@mail.gmail.com>
Subject: Re: [BACKPORT 4.4.y 01/25] mmc: pwrseq: constify mmc_pwrseq_ops structures
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 2:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Mar 22, 2019 at 04:43:52PM +0100, Arnd Bergmann wrote:

> >  }
> >
> > -static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> > +static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> >       .pre_power_on = mmc_pwrseq_simple_pre_power_on,
> >       .post_power_on = mmc_pwrseq_simple_post_power_on,
> >       .power_off = mmc_pwrseq_simple_power_off,
>
> Why is this needed for a stable patch?  It doesn't fix a bug, it just
> looks like it is a "nice thing" to have, right?  I don't think any later
> patch in this series relies it it, or am I missing something?

Right, the benefit here is rather small. In theory, any structure of
function pointers is a place into which an exploit can be placed
in case someone finds a way to modify a few bytes of kernel
memory. Placing the structures in read-only memory make this
a little harder (it doesn't prevent rowhammer attacks though).

Dropping this patch is certainly fine with me, as we have a large
supply of other structure definitions like this, and we wont' get close to
plugging enough of them in stable kernels.

       Arnd
