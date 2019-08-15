Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583FC41514
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB18420644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Jut1zz1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfHOTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:08:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40849 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfHOTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:08:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so2356830lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtoUQYFY0uJJ3wOUCkGhLyCOVfAV5E4kawG+f5hhH90=;
        b=Jut1zz1ynCHITNpZDyG7heTK6Oosdj3wHGtuk4iLdGlssew6Ncow55oVkSL3D0XCHQ
         QfC/wG6bIEvbC/Ig/BH5Qad/zewyYYD8MyjXYqDA9Q61BJqL8/viXT2Ux7XegrQxbceb
         ttOmE+FpoKCUbpe9133QnM0k4r11hbWd+wUjoFzmpe5gyjdo6yJpVl6LvUJM91Foem89
         2QBvNnE4D7b4jzkJJZJabtRZtK7yA3FKZ560skQDXrFddcT4A0jzPtmCDDgdh9AZSV/U
         XdVAnY/Lc0FlNxFrAEmXU1ZrpUOcdpXqiwr4KiwdJiVJk4ynZQkWcG65tEnyLP/qrqYz
         No7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtoUQYFY0uJJ3wOUCkGhLyCOVfAV5E4kawG+f5hhH90=;
        b=SxmGCrFM6R9wH8FKF3cNllqp23QUf24QEFCYlZstYuurAicfKAnN8csWeZlxb384qG
         op+f0lfYkbUWY9i5HYXJbaAAOHilHhrgs7WfrX7M0nT0RqcJBVL2K+rcSQCH9JRI7WPJ
         gvaUMx5EjN7Sgh2TkSglvhgEndyuoeC00DUWbV55UMyPGu6uq5Gf8p7bc40BlblqawMM
         nMbjDs+gf2yQ3H4heFc+57DEueJDmeVjQAhAUbmDf8IZOUZ4fFOTvt5ZyaKSEJATfkLg
         qUCSv3BK4gEigKYO/C1+6lnWay4gnQy5+lqTN8d0Sh8rul2GChKFrCX7+Do39ffnjJqd
         Fwkg==
X-Gm-Message-State: APjAAAXY+M/TpdKyHiP8/utgUu7cyzeILwOUPSf3+6T3yU3CkvQRErE/
        xm2fh/87sGMBAwRiN3ez4XYm/MXzCso7WDPIyQvX7A==
X-Google-Smtp-Source: APXvYqwsZVdr/o1b7op1uwOOb4KPrSFVcPJXTgPSI/9f3jGISy0c+hLJ/pF5DDu2LIuUDxp6R+/7CZLmBMIWn8EY1HE=
X-Received: by 2002:ac2:4ac4:: with SMTP id m4mr3109014lfp.172.1565896127099;
 Thu, 15 Aug 2019 12:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
 <CAB0TPYHdaOTUKf5ix-oU7cXsV12ZW6YDYBsG+VKr6zk=RCW2NA@mail.gmail.com>
 <20190814114646.GA14561@ming.t460p> <CAB0TPYGc8H1pJZrDX1r5wO1gyYV9rzgi3acT9mp-vxxrdA-pyA@mail.gmail.com>
 <CACVXFVP0JrpUgterqHs5bvCQn7L9a-XrjDCD3BmQOLe+rgC1KQ@mail.gmail.com>
In-Reply-To: <CACVXFVP0JrpUgterqHs5bvCQn7L9a-XrjDCD3BmQOLe+rgC1KQ@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 15 Aug 2019 21:08:36 +0200
Message-ID: <CAB0TPYEbHeTqd2ZrOyMSMbV+g7r0HMTt2GSpUrRZxM8XsNPi3Q@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 6:34 PM Ming Lei <tom.leiming@gmail.com> wrote:
> If nothing will change, why does the userspace bother to send
> SET_STATUS?

We don't change transfer, but we do change the offset and sizelimit.
In our specific case, we know there won't be any I/O from userspace at
this point; so from that point of view the freeze wouldn't be
necessary. But I'm not sure how we can make loop aware of that in a
safe way. Ideally we'd just have a way of completely configuring a
loop device before starting the block request queue, but that seems
like a pretty big change.

Martijn

>
>
> Thanks,
> Ming Lei
