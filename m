Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B321BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921B227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsuCkfJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLTAtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:49:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39174 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfLTAtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:49:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so6725872qtm.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPmZbtWhwMRbWSbeKM23ptPheqJNw6paBveWF3S8D4s=;
        b=SsuCkfJ6k0jb73fsM9vAJzdTgNA6e2E8j1oY88ulf7ce25QebwOQdaX/iiw+U5L7ye
         kGpEwYw13D8AMm1AF9bhaUKWaJw45fGvtdOCOJDNPa5zw5zoymB4/8GfjLWaocl71nnU
         DXck1mTDh4F/vQi0N8ETMQLaHRUUR66aM8Log=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPmZbtWhwMRbWSbeKM23ptPheqJNw6paBveWF3S8D4s=;
        b=boqLS77HNANrSkGhipzsEFshdxa7ljIvK1V33X6M1y0HQj7VjSr1IdEzjdwrG4TpcP
         sSiDRWDF6r3SGixLV9mLWUNWdj/uttbR1OD9Ee0iFLke6G4JaWlpBwdILlHpqtVNPEVQ
         Unc79UHU/DDVbCLKadW5t6Ma7Ba3NrsZKNmwh32QRfcOWD/+LNVy5Roj1TQIPZtNHcZR
         oIUw9uZw9WdK8AA/AhfK+rrnSzwldjeeOa2dGi7VVSbI3CtY4kXgAc/zPwDDF89Tgc0N
         +W9xwKSOM0vvZoNaRUTB23nlm4OQlMUAi+W8mo8nnG+i/bv+MmWZjIvHbS0IP7uTN4Oi
         Fv1A==
X-Gm-Message-State: APjAAAXOFzj82r6aB6GmKeHD3rXKHhobsr56bNA+rX4QvTcXcqEUXK/r
        EtXjYS7UG2TSlkbdzQxnW0Mx23H3FOV0enUJCNeS5A==
X-Google-Smtp-Source: APXvYqw7BP4Sf9zQh+wqaMsUyXLhsccv1eSLwfvSSDU6taAwYfS+irUHePfv+K8SwObgUD2p7uQKJx/hCRUihq4+/Ew=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr9628686qtj.117.1576802950834;
 Thu, 19 Dec 2019 16:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20191219201340.196259-1-pmalani@chromium.org> <20191219201340.196259-2-pmalani@chromium.org>
 <CANLzEktdkZvdpJusvC67xjyxw5+botWH+TLBmfT8hg6u6P+yPA@mail.gmail.com>
In-Reply-To: <CANLzEktdkZvdpJusvC67xjyxw5+botWH+TLBmfT8hg6u6P+yPA@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 19 Dec 2019 16:48:58 -0800
Message-ID: <CACeCKae3gAjxeDCaGARk_r3T-k6L6OyowbOnYF3mk2sWpVo-fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
To:     Benson Leung <bleung@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 4:14 PM Benson Leung <bleung@chromium.org> wrote:
>
> Hey Prashant,
>
> On Thu, Dec 19, 2019 at 12:14 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> > subdevice on non-ACPI platforms.
> >
> > This driver allows other cros-ec devices to receive PD event
> > notifications from the Chrome OS Embedded Controller (EC) via a
> > notification chain.
> >
> > Change-Id: I4c062d261fa1a504b43b0a0c0a98a661829593b9
>
> Make sure to strip Gerrit's Change-Ids before sending upstream. They
> don't have any meaning outside of chromiumos.
Done. Thanks!
>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/mfd/cros_ec_dev.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index c4b977a5dd966..1dde480f35b93 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
> >  static const struct mfd_cell cros_usbpd_charger_cells[] = {
> >         { .name = "cros-usbpd-charger", },
> >         { .name = "cros-usbpd-logger", },
> > +#ifndef CONFIG_ACPI
> > +       { .name = "cros-usbpd-notify", },
> > +#endif
> >  };
> >
> >  static const struct cros_feature_to_cells cros_subdevices[] = {
> > --
> > 2.24.1.735.g03f4e72817-goog
> >
>
>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
