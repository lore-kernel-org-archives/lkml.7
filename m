Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9209C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B961821019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfAyIBuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEIHxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:53:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34186 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfEIHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:53:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so858941lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2pnzsjExgiU74Rp+J+FwN2xzCGKrR8arkSJatK/AQ4=;
        b=YfAyIBucDqDPZ8in/ZUpEbAnzAzQ7xF/zpbwhriOvlm+1mE4jIcPZjxSN7GLezV9HW
         a695Xs2OW7+3+g5t0GpZFcuajcY5sQd2vrpuQl5yYx/TK9dXKGMCX0L3d3HBBnXBIwM1
         dRYhWpGajHkOYyORUX4j1YC0lBvDPU744MHwaOqm7plJi7AE9PwiHOnFEJTlULpJjwri
         m2zTZdvOpTcEMwltGD6WYpBpWbDy5B5qa0TKU67zsxBOmsafUBd2de9KDUrh+l61p/Qy
         tU6UzGrh6j0daKxe2iKLGKkSIzloGoIiBk0x9LX4wtFmE6rDq2a8uj+zi9s4hWPAfAK2
         FBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2pnzsjExgiU74Rp+J+FwN2xzCGKrR8arkSJatK/AQ4=;
        b=DleqiO6SQvFf7w1uJYSI+d5OtvGNe83ehzRK7aQPVXdJPGWsnaTXYjJLhi5E0FUWTX
         Pm4WPw2mp6SEclKNZECthCCyrDUFi61QNY8D/ILHsrCI1mPkcJz/XoP515SZMfaMD5S0
         VDGnBVeOmdO3aLW2rRpl2UG4MVDgTz+rr2dxJbgWsLD0Utr6MEKF6zYlAGBpy7qdrgaB
         02qtC2K2tP92nOWhsRBZmorpvosC3AZuZ54yHw+j5npkOL0GPrZoLJMWDdH3+NaQuYPG
         WdkQ2cMuFMSEKgPM3qwZF++M66eQYRM8Q+IKa0Av/2d+58S1SG7PyDv6rwZpwMMLLOKA
         CMLw==
X-Gm-Message-State: APjAAAVp97fcSpAneIRRooL/IJbENf3JIFNXeKrHG7Ze9chvpTjN/lKz
        diaA+N5zBBgZTciy5osCg5wFz29dSp50vfeLWrKodQ==
X-Google-Smtp-Source: APXvYqwq1Im6IYosLNiB+eaRP06VZe08QebvUL+0fbRuxPkX440EK5jc9e1qGqw0+ci0gEoYmzJHQQp+QEp9HuVEJMc=
X-Received: by 2002:a19:f243:: with SMTP id d3mr1477009lfk.168.1557388382722;
 Thu, 09 May 2019 00:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190416083852.126786-1-darekm@google.com> <dcb189af-f67f-ede3-b4fb-de1da7b53ccb@xs4all.nl>
In-Reply-To: <dcb189af-f67f-ede3-b4fb-de1da7b53ccb@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Thu, 9 May 2019 09:52:50 +0200
Message-ID: <CALFZZQEoiikyXmHJyEgEJTRNryTN8ScNK4P3bDCp-9v9GtvU8g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] media: cec: expose HDMI connector to CEC dev mapping
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans.

On Wed, Apr 24, 2019 at 2:09 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Dariusz,
>
> This is getting close, so I think for the next version you can drop
> the RFC tag.
>
> Some comments:
>
...
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> > @@ -261,7 +261,7 @@ static int dw_hdmi_cec_probe(struct platform_device *pdev)
> >       cec->adap = cec_allocate_adapter(&dw_hdmi_cec_ops, cec, "dw_hdmi",
> >                                        CEC_CAP_LOG_ADDRS | CEC_CAP_TRANSMIT |
> >                                        CEC_CAP_RC | CEC_CAP_PASSTHROUGH,
> > -                                      CEC_MAX_LOG_ADDRS);
> > +                                      CEC_MAX_LOG_ADDRS, NULL);
>
> Hmm, the connector information is actually available through cec->hdmi.
>
> I think it would make sense to create a helper function that fills in
> struct cec_connector_info based on a struct drm_connector pointer.
> And add a function to drivers/gpu/drm/bridge/synopsys/dw-hdmi.c that
> dw-hdmi-cec.c can call that does the same.

Looking at the code here, is the connector info guaranteed to be
available at the time cec_allocate_adapter is called here?
drm_connector won't be initialized until dw_hdmi_bridge_attach is
called, which happens after the cec platform device is created.
...
> >       priv->adap = cec_allocate_adapter(&tda9950_cec_ops, priv, "tda9950",
> >                                         CEC_CAP_DEFAULTS,
> > -                                       CEC_MAX_LOG_ADDRS);
> > +                                       CEC_MAX_LOG_ADDRS,
> > +                                       NULL);
>
> Here too the drm_connector can be found via struct tda9950_glue.
> So it is easy to provide proper connector information.

The same concern as with the comment before.
...
> > +/**
> > + * struct cec_event_connector - tells if and which connector is associated
> > + * with the CEC adapter.
> > + * @card_no: drm card number, -1 if no connector
>
> If there is no connector, then type is NO_CONNECTOR. So this
> doesn't make sense. Wouldn't it be better to just use '__u32 card_no'?
>
Yes, removed (leftover from previous revision where there was no
connector type field).
This and remaining comments are (hopefully) resolved in the new
version of the patch, I've just sent.

Will add more docs in subsequent revs.

Thank you!
