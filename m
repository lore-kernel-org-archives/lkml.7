Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184C0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2521726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z1cP/5ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH2RkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:40:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34274 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfH2RkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:40:01 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so8656757ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fy1EONJYFzvA6a2F757/vnVFBYdEDoPHNwTUWgsvybk=;
        b=Z1cP/5ezzJ90NFU0M1U6zbk+KT4PjiIv172TBGDPGRStchob2kMIXvTBkcXqclue2c
         Pshe76ei8DZxZd/hbugynKc/kZpkF6mSXg2hkUlUffI8nfmY6z5Dzime1bmwMJyrMckU
         dAcjYiSXvN2cFOLrsXI5NPL7Vx0T7FS0VHjQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fy1EONJYFzvA6a2F757/vnVFBYdEDoPHNwTUWgsvybk=;
        b=VRlIZDLS2d4CzJrNozKtg2XLEhL3BabG0+LIa4BvX/V9kZV3ouV5xyrcCtMbXCKq5d
         zRT8KzTSKYwvV88kjsIAyUhkY/QBCtA4HSaHxjuIwfEJt3Wc+EXBobvpGo/cGqnxROcG
         +8fT00ujMCsddU38Nb5K1ynavUhV77MneTLKcivk8AHVUVKskzY4U11JjucVIt/5dHTF
         HXFrQf++xwFDfyRqUwvpu6KYVs55IMlg7dSbrS9XgFXb4WaFxA1FF8BIHvQtdB/XwcVl
         i7NFDcIHhiTNCi0GDkhadHPDgtWMg1Jq9P7skJOmVfvoK4Cv/qdffX6aMtF8KtbKbmrn
         mi/A==
X-Gm-Message-State: APjAAAXH3zYqYs55OrkIrB6o5/inlaEZuQT6VLLCh4GgLHAR0CdQk1Dc
        rNf4aI25TgsNTuxzkFPwDdDvwTuQwBQ=
X-Google-Smtp-Source: APXvYqzPLcuoChK4+ohjzd/bYAAvQoM6vL32z4Rx/578+kqXMnMkP402LjktFYmOmL3Uob0Hq4P1jQ==
X-Received: by 2002:a5d:96cb:: with SMTP id r11mr12952159iol.200.1567100400664;
        Thu, 29 Aug 2019 10:40:00 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id b17sm2698466ioh.6.2019.08.29.10.40.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:40:00 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id s21so8656655ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:40:00 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr12308339iop.58.1567100399775;
 Thu, 29 Aug 2019 10:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
 <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com> <20190829171555.GD70797@google.com>
In-Reply-To: <20190829171555.GD70797@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Aug 2019 10:39:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
Message-ID: <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 29, 2019 at 10:16 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> > In one way, this change makes sense as it adopts the legacy behavior,
> > signaling "cached" SDIO IRQs also for the new SDIO irq work interface.
> >
> > However, there is at least one major concern I see with this approach.
> > That is, in the execution path for sdio_signal_irq() (or calling
> > wake_up_process() for the legacy path), we may end up invoking the
> > SDIO func's ->irq_handler() callback, as to let the SDIO func driver
> > to consume the SDIO IRQ.
> >
> > The problem with this is, that the corresponding SDIO func driver may
> > not have been system resumed, when the ->irq_handler() callback is
> > invoked.
>
> While debugging the the problem with btmrvl I found that this is
> already the case without the patch, just not during resume, but when
> suspending. The func driver suspends before the SDIO bus and
> interrupts can keep coming in. These are processed while the func
> driver is suspended, until the SDIO core starts dropping the
> interrupts.
>
> And I think it is also already true at resume time: mmc_sdio_resume()
> re-enables SDIO IRQs and disables dropping them.

I would also note that this matches the design of the normal system
suspend/resume functions.  Interrupts continue to be enabled even
after the "suspend" call is made for a device.  Presumably this is so
that the suspend function can make use of interrupts even if there is
no other reason.  If it's important for a device to stop getting
interrupts after the "suspend" function is called then it's up to that
device to re-configure the device to stop giving interrupts.

-Doug
