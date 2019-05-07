Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D2BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D4720656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeeclIpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfEGV0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:26:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEGV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:26:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so425227wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpS0acp3uuHexCCxmfsBcp2LVHuqUmGr+AfC8n1/nG8=;
        b=LeeclIpSD2O+PfBGCoM+AsjKIueYP8u5J7Mh2a3qOtWoBkv9uMFrZ9g62I5pKh5ZvB
         f7UQJ/g7mzm6UqS/+zBGs6H1CK+HLlO8U6el1hOzltMHIlUOHo4f1xM3fPvAum4D5J5i
         6q8toThV1tjYHsb0Tb3P3jCrftHIuN9Kj7+Jq8IVTjv4efgoxhHdvGOsgbLkqa+Jl8YK
         P6olw2AF91FiaKGxzHpMdwSJzBNChaEFUnKAcPQagIZrkATn4rVAqwIlea7wjq7l1/WJ
         4/3YqmZW16fTi5J+PaDqIk3XiHmIe4X6Ba/zSkGGv+o7QcFoYjZmWxhb3moGMO5GmjSZ
         44bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpS0acp3uuHexCCxmfsBcp2LVHuqUmGr+AfC8n1/nG8=;
        b=JMZhUdrMEJoNnoxQxaCzdltqV8OoNJHiTA3yBNXfB0WHVhGv+PBREeTnYeHag3x1Jy
         OP55asMjXIhBlxiubjFA3S1mss+hl4DlAUK4hZn7KxCA3tOuU5pnhC3pLrY3kxo6+2Qd
         SeG8elhkfiBzANSPoJQ6mmk3GPuh8HsIb2VAnSWp0F2m0TEau5gtek4ihtis54YZ1c61
         MGuHQZQRLVIP4vZCOQwjN4decEGw0k9zOBdypckSrzde/6ljnOiIYBDetfhwupDD8eUq
         sRw99sJ3akqLtfMfDkSITX6c487JdaI1jQhqYT9OgRZS5Z2XTIpV0mbOhhyPJK7pmWOX
         JbtQ==
X-Gm-Message-State: APjAAAVn+sgKRDu3Mkoob5UnVwY6qy1WBDaBMeVWC0y2A+UW51vFlQA9
        0bPVemCyHcSDzfSVF9aAKOWGdZNnvJ3GYNyoBgAMeL6KkzU=
X-Google-Smtp-Source: APXvYqybBltjIktuaOWmGdahqcOnGayFyfWkyFiOAnKhh4NUIe41ZYMKvyCKjLJoxum3IrCr+iks53pYmOrWFbj/oEo=
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr381826wmt.10.1557264409469;
 Tue, 07 May 2019 14:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl>
In-Reply-To: <20190411094944.12245-5-brgl@bgdev.pl>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 7 May 2019 23:26:38 +0200
Message-ID: <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Setting a chip for an interrupt marks it as allocated. Since UM doesn't
> support dynamic interrupt numbers (yet), it means we cannot simply
> increase NR_IRQS and then use the free irqs between LAST_IRQ and NR_IRQS
> with gpio-mockup or iio testing drivers as irq_alloc_descs() will fail
> after not being able to neither find an unallocated range of interrupts
> nor expand the range.
>
> Only call irq_set_chip_and_handler() for irqs until LAST_IRQ.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Just noticed that this triggers the following errors while bootup:
Trying to reregister IRQ 11 FD 8 TYPE 0 ID           (null)
write_sigio_irq : um_request_irq failed, err = -16
Trying to reregister IRQ 11 FD 8 TYPE 0 ID           (null)
write_sigio_irq : um_request_irq failed, err = -16
VFS: Mounted root (hostfs filesystem) readonly on

Can you please check?
This patch is already queued in -next. So we need to decide whether to
revert or fix it now.
