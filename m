Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90D224650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx/eixMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLRVuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:50:20 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41939 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLRVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:50:20 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so3005591ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u3kw0VgsPg2+lbAD3lYb1Tu6UkJzbJQBjdYncZ9VVns=;
        b=Bx/eixMrPPRB3FCITwtCnQ2zOFSDbda6eoPiWzmtPM0z+v3puPPLk38Nt2gbllbD6Z
         L0Em2btnbec25cgM1uU2PuswGV/EinZFxDiSNRa10ZnUsK2B8BYzvOmXKUMi/y3urSVh
         T3HP3VdbnV5I0/Uu5M7innavycoNqutChZDoRurEzUMe3VmzAGmhag0yJ17+Vkjpcv9b
         VLoQuJphjG3wpVzGpsAOStHmei3ArvbKqM2VlPPhv/2te+z6YbrS71ROzTimZ0PXS7OI
         hsdNy+5KwAh/ch0E8p4E+p42yznA11qr9yuMaOa2tSlXrYOKzJyB3PrcdIy2bge/1a1A
         drRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u3kw0VgsPg2+lbAD3lYb1Tu6UkJzbJQBjdYncZ9VVns=;
        b=gbWgP2famvBEYBccXPnMr9FHPT9MVkPoHck0rkHkq1Xznutll56KJYX7kn5cpotcbc
         n3PMk3XSueLeeFz/6rF2a1G4rYEElePFWf0l6DSvRJ2aAgrj/ihkrLZBDAy2+A5uepcl
         cX/Ml/lmHwA5cYruEG33mBMEHYXnLd9wBH1uKM2eSjmAoC3VqiuauQJKl74jC3h5SHMV
         saV7e57ZnxABNNfC6OgMIdV7o8sYXA/34Wgdosh9MF9gyQfqY88OsleHbPl/Y3ZByvF5
         eLXl2ZdPipdvf1J+8FbDii4AcCLBWQJHEgXBah4BNUUq5bbMN3tZgc4L6q/dk20ksoyL
         uXQQ==
X-Gm-Message-State: APjAAAV+3gYb74Qog35BvpxHyys//hu4KWi39VrMH4h9g7CQxDfQi2Xs
        +5u7uIR17GWiMt2cRmRIhnzPnhhS8YqsQy5JeVnfip0DiwPfZw==
X-Google-Smtp-Source: APXvYqzj5/v1uXB2CRbiywbQlhECUQPIUhMuBJQ5qrD4Y9/6F82gQBxjReq4F+bPSCqukeB2OAcIWH+ImYIXIDCgDqw=
X-Received: by 2002:a92:465c:: with SMTP id t89mr4159865ila.263.1576705819957;
 Wed, 18 Dec 2019 13:50:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Wed, 18 Dec 2019 13:50:19
 -0800 (PST)
In-Reply-To: <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com> <20191217064254.GB3247@light.dominikbrodowski.net>
 <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com> <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 19 Dec 2019 05:50:19 +0800
Message-ID: <CAOzgRdaRDnd3gi0QO-b_2Nm4RXf_+UJ+Ec1Ne0=cx00fKpZN8g@mail.gmail.com>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-12-18 5:14 GMT+08:00, Linus Torvalds <torvalds@linux-foundation.org>:
> This should be fixed by 2d3145f8d280 ("early init: fix error handling
> when opening /dev/console")

this fix no help for me.

> I'm not sure what you did to trigger that bug, but it was a bug.

alt+f1, type bash command,
bash: cannot set terminal process group (-1): Inappropriate ioctl for device
bash: no job control in this shell
