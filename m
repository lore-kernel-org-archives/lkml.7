Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003EFCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B3C2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572799553;
	bh=DMaNjRVWAYnvr8ic3Grl+yVkjaBXpaltz8Sf2gsuMqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x0FnxPWr8Af89cYPkY6baD4HyyGhfD0c6PXAL6a7IqeGtBCSYa2KeWg/Gm+9Kml4L
	 RPdyg3F48mY56W63TJ34EjJ3BekU6kHIJl/YAD/Vd3WQNTOvzUU/+y8LBIxh4R39+e
	 IeQMM1GxnCspCW+rv4v3rEHIdvLbTz0rDyGcTTRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfKCQpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:45:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43109 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfKCQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:45:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so4128014ljh.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksEu0A0KjLwy1M0pwU6CUlXpOlz1Dc+D61V1TG3xX/c=;
        b=Puv7vmSp8hqtr7dTSpIERhXWbuCG6m92q8NpW8kfcLLCpTj2WmtgknmsiAhxP7lWV6
         7+Vkeqs7gpDvpz9+OB1fTJzaOGKN3uQHkO587f1Z9kaGu38OIBzIX2T6wxkdCPz+6XAO
         iIYgAnhZTNw8f+CmIl6V01mf3+EqjV1hHwUwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksEu0A0KjLwy1M0pwU6CUlXpOlz1Dc+D61V1TG3xX/c=;
        b=BGZYcplok6kTjtjNCgtzAqjMk5Zt5XFuZh0mR79sfvrvu3tDdlTXeWb4nkh7xSAsVu
         3cPPa+UQG2Mzlfq9SItvhdNj6j+LUyP0YFWc9+epnVdk6Ou7jxaAWuF3xaaxxer1V6gW
         u+v0Tt7x0m9ejQoU0cqzzz1TWeOzXjZGO0Yo71zl09WPN5AM70vFK7qLA+gthMAickPz
         NIuIIGo7f+L5/9NMZ6gJDg10TL+Fve7UvoWe2LR6L4zyBAH2ycXbRwHxOnbXq8cgPwi1
         3JDsoO7cWwLnT4RcKt/Gtkz+A5RGcyKPsYlA8fD7B4BliCGHxJTPIP64mcfV6+0L3Uju
         mk1g==
X-Gm-Message-State: APjAAAWWHqNiHSd0cEXXXxpoL43N04+Oz9h5AfIXwcc1hEXRirac7sOe
        tmBm2L1s5byZHrMYtyYwgltjow2lufo=
X-Google-Smtp-Source: APXvYqy/OyHs8CB4WErTbADp/vNx7Ksq5Ic2faoeo5eF3JJPBqDw3dGrT3jNPGidc1CNh5xU4TQAeg==
X-Received: by 2002:a05:651c:305:: with SMTP id a5mr16010610ljp.144.1572799543255;
        Sun, 03 Nov 2019 08:45:43 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y189sm9284556lfc.9.2019.11.03.08.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2019 08:45:42 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id v4so10463339lfd.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 08:45:41 -0800 (PST)
X-Received: by 2002:ac2:4c86:: with SMTP id d6mr13812625lfl.106.1572799541430;
 Sun, 03 Nov 2019 08:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20191102190327.24903-1-alex.popov@linux.com>
In-Reply-To: <20191102190327.24903-1-alex.popov@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Nov 2019 08:45:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgE-veRb7+mw9oMmsD97BLnL+q8Gxu0QRrK65S2yQfMdQ@mail.gmail.com>
Message-ID: <CAHk-=wgE-veRb7+mw9oMmsD97BLnL+q8Gxu0QRrK65S2yQfMdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] media: vivid: Fix wrong locking that causes race
 conditions on streaming stop
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Security Officers <security@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 2, 2019 at 12:03 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> -               mutex_lock(&dev->mutex);
> +               if (!mutex_trylock(&dev->mutex)) {
> +                       schedule_timeout(1);
> +                       continue;
> +               }
> +

I just realized that this too is wrong. It _works_, but because it
doesn't actually set the task state to anything particular before
scheduling, it's basically pointless. It calls the scheduler, but it
won't delay anything, because the task stays runnable.

So what you presumably want to use is either "cond_resched()" (to make
sure others get to run with no delay) or
"schedule_timeout_uninterruptible(1)" which actually sets the process
state to TASK_UNINTERRUPTIBLE.

The above works, but it's basically nonsensical. My bad for not
noticing earlier.

               Linus
