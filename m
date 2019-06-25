Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0826C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B966D2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdLfNuRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFYNvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:51:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33520 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFYNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:51:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so12714443lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFgue3oKymAnPLqWEpKiFYxZqxdbMA1mAsgv3rYLpoE=;
        b=PdLfNuRX8o0MT8u/xnGoKn1MWuT+NeXfGGOEg8LQPuO8qtlaH+6/U/Se7HOmQPGW/t
         nhuOnnNj/Ur1cPp9pkrCWbCm946AeCXnyEcwO8F6uGppaYNGrImtYwVg4eqyZuYx4nw4
         VzpiyXCGGe1cmSCebquOcabusXBnFKLKt/BvnEHk5Iq9Ksp049DCVXNqpV90gE4KpAF6
         jIdbmoHFwr2O+yKyF5xOQ6KSyCo6vEP2VXoqEQKBLLqYGiyMWASrpQRYV9T68FD2svRX
         SLceTYFCOde44PwxP8DvJvoE815KPjsYOzE1qmOXi23IUTqltqJQloZd9osx4M9Eh944
         IQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFgue3oKymAnPLqWEpKiFYxZqxdbMA1mAsgv3rYLpoE=;
        b=BK87E4ugL5354K5n0q0U95Rgo6B51kI/gHkzDIs6BAcv46pABe92wIvTvUBU3NpfiI
         O4Vj4L4MsywJKla9p/p37Ae9DemiKa/qJTv2tXpCFLDvRZrfS5cikrDCIUnnvOO1AHpq
         W9kEZnlessn1viHrYtaRYFNAgAzneacJ59o1jM4RH+fMAyMZbw9HgCyGASPXBk3NjiOZ
         U5vCkEaT+xlv6l7oRJ18tjes6pQTyKPQuFipSkJfKEMX3Hxyh3C489gicOES18ALaVmM
         N/GB8z9cp8nTdih8eigLc2XIO+MrJOPN+p+4BYbV9zRsMrfyzZcd5+tl5almJz1o9/0P
         KG5A==
X-Gm-Message-State: APjAAAUkRmodTOKUkmxJi2NX116vqMOJRyaLa+UzuhTpnl14GWVC9kGR
        8w01X1Q6QV2YOQ4zP1kpZQ4xAzTJ9GVNgZzHejz5lQ==
X-Google-Smtp-Source: APXvYqweuybTOeTfqTGsuOJxjLKJ6DVhGG8Um8M//OczH8cF/Z2EL92nk9R9z1tbGk4bZ7C0ouYVRfKXJe75pfgJjXU=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr25254433lfm.61.1561470662286;
 Tue, 25 Jun 2019 06:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190429035515.73611-1-drinkcat@chromium.org> <20190429035515.73611-2-drinkcat@chromium.org>
In-Reply-To: <20190429035515.73611-2-drinkcat@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:50:50 +0200
Message-ID: <CACRpkdZd+0_7xqaa05mqNzNxDC1kKmEv9LLRoSVYqTmO=+3iGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mediatek: Ignore interrupts that are wake
 only during resume
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 5:55 AM Nicolas Boichat <drinkcat@chromium.org> wrote:

> Before suspending, mtk-eint would set the interrupt mask to the
> one in wake_mask. However, some of these interrupts may not have a
> corresponding interrupt handler, or the interrupt may be disabled.
>
> On resume, the eint irq handler would trigger nevertheless,
> and irq/pm.c:irq_pm_check_wakeup would be called, which would
> try to call irq_disable. However, if the interrupt is not enabled
> (irqd_irq_disabled(&desc->irq_data) is true), the call does nothing,
> and the interrupt is left enabled in the eint driver.
>
> Especially for level-sensitive interrupts, this will lead to an
> interrupt storm on resume.
>
> If we detect that an interrupt is only in wake_mask, but not in
> cur_mask, we can just mask it out immediately (as mtk_eint_resume
> would do anyway at a later stage in the resume sequence, when
> restoring cur_mask).
>
> Fixes: bf22ff45bed ("genirq: Avoid unnecessary low level irq function calls")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Patch applied for fixes.
Hm a late ACK made me miss this, sorry.

Yours,
Linus Walleij
