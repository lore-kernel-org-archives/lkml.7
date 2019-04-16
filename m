Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF56C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8E4206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wgu1oUuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfDPVym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:54:42 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45229 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfDPVyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:54:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id c13so7233019uao.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZn+GdxcQLNV9rNNFIxxXnN5hhRchD8i4/I2eKH3M5o=;
        b=Wgu1oUuGb5Fpsidxj26k8qFo6rzH1n1b1eWU2o50/BkvYcHj0padMXcgaAcgJ6XWlw
         HrTvc/nDDk3jB2mugPjbTL6QSLS850ndb7DFWNSIYjUkfhsHi056qRJwDt7xMiQTjKtR
         B+zfxmpov+s+VNAPC+Pp16v6b7SZOVYPAkBcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZn+GdxcQLNV9rNNFIxxXnN5hhRchD8i4/I2eKH3M5o=;
        b=aXaqZK8YfYSs+suUztyQikuDmFMOUdOXucpYHqzDhmcG2Hy3W1VPyiiucy/k4iFi3m
         Be7XIaYFbB0pRmLoHDwTiatQEeV/eZOQb3M5PPr9ZEcc5aIDCyYmyZhgrwS0GxzfTw+q
         jXNjzsK6NoAiReveJrPOlR4SqnoDwDWdol7ojlqt+0HVwjRD1ehANxyYI4ATzBM6lN+F
         Mse4TrebbBg7Zz7J//Ah0aMkTNf2rMuvUnrtBacD0Gi0KuEl3Z+j4ibHcSSbsoLe+ErT
         uuqn7mNGlk7ZZyHrQdJb0qpVT7Q21KN3rQpy210812GWv4VKS3K1wRzSGfWMw890BmsX
         8rkg==
X-Gm-Message-State: APjAAAUceILQ1T/UnRcHpwq80HycSwpbX9c8qM7w/LxxMEM4Liic7NRL
        whqWO6qvTRPyV+J03UTEt2fzJ6i7g+M=
X-Google-Smtp-Source: APXvYqzxko0pPQXqMThzE/d0ozM1m3E4oyyk5i1TqH8jdFEl1WhrlAwtkBsG0S0pIzHLQ1UZcREvkQ==
X-Received: by 2002:ab0:26c1:: with SMTP id b1mr43952232uap.92.1555451678590;
        Tue, 16 Apr 2019 14:54:38 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id h125sm8344038vke.49.2019.04.16.14.54.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:54:37 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id f15so12460560vsk.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:54:36 -0700 (PDT)
X-Received: by 2002:a67:1603:: with SMTP id 3mr43643535vsw.13.1555451676483;
 Tue, 16 Apr 2019 14:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190412224149.106971-1-dianders@chromium.org>
 <20190412224149.106971-3-dianders@chromium.org> <20190412235633.GY112750@google.com>
In-Reply-To: <20190412235633.GY112750@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 16 Apr 2019 14:54:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vy8A2PE+EeYJi7n7O8c2_JuCpvHLiMXL_Ad-kqW208QA@mail.gmail.com>
Message-ID: <CAD=FV=Vy8A2PE+EeYJi7n7O8c2_JuCpvHLiMXL_Ad-kqW208QA@mail.gmail.com>
Subject: Re: [PATCH 2/4] usb: dwc2: optionally assert phy reset when waking up
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        Ryan Case <ryandcase@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Yunzhi Li <lyz@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 12, 2019 at 4:56 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > @@ -5271,11 +5282,10 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
> >               hsotg->hc_ptr_array[i] = channel;
> >       }
> >
> > -     /* Initialize hsotg start work */
> > +     /* Initialize work */
> >       INIT_DELAYED_WORK(&hsotg->start_work, dwc2_hcd_start_func);
> > -
> > -     /* Initialize port reset work */
> >       INIT_DELAYED_WORK(&hsotg->reset_work, dwc2_hcd_reset_func);
> > +     INIT_WORK(&hsotg->phy_reset_work, dwc2_hcd_phy_reset_func);
>
> You also want to make sure that the work is cancelled when the
> controller is stopped/removed. It seems dwc2_hcd_stop() would be a
> suitable place for that.

Good point.  dwc2_hcd_stop() doesn't work though because it's called
with interrupts disabled (because it's holding the hsotg->lock
spinlock).  I put it in dwc2_hcd_free() where there's another similar
cancel.

-Doug
