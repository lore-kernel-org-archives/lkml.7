Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A17C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781DD20838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPZJ48LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfCBJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:36:28 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38403 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCBJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:36:28 -0500
Received: by mail-ua1-f67.google.com with SMTP id d4so181012uap.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzcIXt1A98hziKuoJoTOypTfa9JZQFVS/+pT/mj2GO4=;
        b=nPZJ48LXbfWYuCQki8bfQB/cobttZrsS/7FZtJschLWRaTvkE6C3zD3j9uawkZL5WO
         5O2OCAwA0wGaftVGgJdICL/JdUp3yQv1Ke1Iqi6wraNFGJeCM0ye2dl9HFhK7n/dqqmO
         6jjgyi+yc7C4Lux4zTGa1we3gWVNVXjSEuGUvSNY6z5BA1VPH8wI8M2tybO0BQz2GsoE
         Wm2Tn/ms0iH45Ruiaev94ARkjTtyklKiURBwVxREPb+iwEaC0o2JMF8X3ILKf11nf4YD
         O7x5rouF1Cni3pyQJxMtRfu4tzfVDzZfMSYbyBAH6RmJkpM50RGEtOFuYE1VrlYzy7d5
         jsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzcIXt1A98hziKuoJoTOypTfa9JZQFVS/+pT/mj2GO4=;
        b=W32bzvMlNnQNBFAqQ8yCM7P84/9wlgvw9XSIaS/5LQ3N1bgqDm4xFKkxS3PZfeQc0d
         RRXLV9yptNyon9jUcgP6zWneumrJMoJkp7JOma4X1K6L5BxljMQ7U5stTpYP1sno4unU
         XL6E75ONqLxDOTfehr91221/ngGgAN0c1zEj4GIoJR2miO1yJYbh/XMSXz/+1tdSCgfe
         PX9GYKCpEBtc4L+WuKsASn3XmRkTdjjzUt1LK8VrqY2/o3xWUTRr2lNwpWbVqhmVdDzO
         Q70FgRcngq2IqjpBjIKnUXqHoEc3BEu/g4nXAabSE5itXmYz3xBfu9qY51+k14ESkF7r
         tRig==
X-Gm-Message-State: APjAAAWl1V+lrFtH5wkbx/YeRgwoBhMAUP80KdOcDeOqd1cWO22M5ArS
        FnRo4C7GO0xw9k5xcdoOraKP9lS0MnKLEYFHv9c=
X-Google-Smtp-Source: APXvYqyL8cNmQIgRfZLYTExMvbZs4m3xDWySrMjDvitkUgV+Qt+0B7biZXh58+jOT7M/f7F87oPSe4b3Ka0sMs3Enf4=
X-Received: by 2002:ab0:69d9:: with SMTP id u25mr5090211uaq.8.1551519387283;
 Sat, 02 Mar 2019 01:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20190228095545.30842-1-oded.gabbay@gmail.com> <20190228095545.30842-2-oded.gabbay@gmail.com>
 <91b9cfc4a87bfd7a220f558f514e322f4864b13e.camel@perches.com>
In-Reply-To: <91b9cfc4a87bfd7a220f558f514e322f4864b13e.camel@perches.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 2 Mar 2019 11:36:01 +0200
Message-ID: <CAFCwf13EYVhZmzQSwh0==Omr9mkJksCW0aFrqOsPRZxWkGCU=Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] habanalabs: print pointer using %p
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 3:00 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-02-28 at 11:55 +0200, Oded Gabbay wrote:
> > Don't cast pointer to u64 to print it. Instead, print the pointer using
> > %p.
>
> You might want to use %px here if you _really_
> want the actual address and not the hashed output
> %p normally produces.
Yes, you are correct. Thanks for pointing it out, I'll fix that.
Oded


>
> > diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> []
> > @@ -4276,9 +4276,8 @@ static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
> >                       return 0;
> >
> >               dev_err(hdev->dev,
> > -                     "Internal CB address 0x%llx + 0x%x is not in SRAM nor in DRAM\n",
> > -                     (u64) (uintptr_t) parser->user_cb,
> > -                     parser->user_cb_size);
> > +                     "Internal CB address %p + 0x%x is not in SRAM nor in DRAM\n",
> > +                     parser->user_cb, parser->user_cb_size);
>
>
