Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453BBC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD4B2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dafqzq5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKLUq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:46:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41782 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfKLUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:46:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id o3so21300758qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rzHHOT8VNkB3teikkpEIDHOWIVsD71DDKshVr+6Wg6Y=;
        b=dafqzq5ZAhwpdHpgdCsK7uyR2oEr6i+jGOh0QYY/fg3j5I1eKWfvsetqQZmYecttLb
         SO6xKy1ezGdTWeA2R5G4nbaMICzxMDGXrTL6ivBIU7uygDRNtWYZmyXHDslA4jI0RejP
         q+ekouZqwL2ldOHsxtzydpyr5iUkbwTFp+dnXHlQ4xrw3oPHJdmyvDNQW/W7xIGs2nhE
         3gd0y/fviYykTVNq1u9szcSPiUBVsg9wBai5pJFT1oDUWgm4Vfe2WFZ2V7+TSEW80JxU
         Pk3v+OR021ZkdvUcMJPCiL71ZI+8t61hl+kjPI2koa/xQZhrsWyOUJ6ihtHVI9dL4dXM
         G/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rzHHOT8VNkB3teikkpEIDHOWIVsD71DDKshVr+6Wg6Y=;
        b=gi5lWGb9w6qpsBbPuzaAsS+eJ4ZeKYiruf2TdMw7ppEEOlfRu9cCy1d0l5zeVE+dCW
         9PYnpYKOjibRQV1eBiiyxnf2gUGLBDWSI9g1QKfntZbaO5/gfsUkYWAfE3ohLg2BrkxN
         qev0xA6yBy+8A46QljMQkftY44QQfdIokwSFyLTBiPjB92lSpbmyjCb6MmofOpVre8uh
         w5N22A10b8GR5U+WdjatjDI5kWloJ5OyPPBwAHLiuR9+5xJCRGLe+4pwimTMNjQinm94
         Ka38BwUAOR1iGWov18eaMJwu1UDhA/79df4NBl1VmAhFYWbAx3g/qiaHgKfCP+/PBOFD
         8Z9A==
X-Gm-Message-State: APjAAAXWlQPwGaCgQPYDUFHg6rCy4kmw11oAI9anV4BWgjmwqLkqBduk
        +EHRjh3fdWnhkxbB3gJCDnxccA==
X-Google-Smtp-Source: APXvYqxJ4zofVo5QYIjS0X6ILaCLyuOOmnF5Nu7jixF+DGJmyqXvFP+nw8QkdUWNcDPYpXYUXqGs6w==
X-Received: by 2002:ac8:f35:: with SMTP id e50mr33743966qtk.39.1573591584583;
        Tue, 12 Nov 2019 12:46:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a18sm10271505qkc.2.2019.11.12.12.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:46:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUd3P-00048C-Md; Tue, 12 Nov 2019 16:46:23 -0400
Date:   Tue, 12 Nov 2019 16:46:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191112204623.GG5584@ziepe.ca>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
 <CALzcddv2aLQ1krYFeNtWNOxyF3aSD0-p3j_p3CgS2Vx-__sQPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzcddv2aLQ1krYFeNtWNOxyF3aSD0-p3j_p3CgS2Vx-__sQPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 01:31:09PM -0700, Jerry Snitselaar wrote:
> On Tue, Nov 12, 2019 at 1:28 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >
> > On Tue, Nov 12, 2019 at 1:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> > > > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> > > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > > > > With power gating moved out of the tpm_transmit code we need
> > > > > > to power on the TPM prior to calling tpm_get_timeouts.
> > > > > >
> > > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: linux-stable@vger.kernel.org
> > > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > > > > index 270f43acbb77..cb101cec8f8b 100644
> > > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> > > > > >                * to make sure it works. May as well use that command to set the
> > > > > >                * proper timeouts for the driver.
> > > > > >                */
> > > > > > +             tpm_chip_start(chip);
> > > > > >               if (tpm_get_timeouts(chip)) {
> > > > > >                       dev_err(dev, "Could not get TPM timeouts and durations\n");
> > > > > >                       rc = -ENODEV;
> > > > > > +                     tpm_stop_chip(chip);
> > > > > >                       goto out_err;
> > > > > >               }
> > > > >
> > > > > Couldn't this call just be removed?
> > > > >
> > > > > /Jarkko
> > > > >
> > > >
> > > > Probably. It will eventually get called when tpm_chip_register
> > > > happens. I don't know what the reason was for trying it prior to the
> > > > irq probe.
> > >
> > > At least tis once needed the timeouts before registration because it
> > > was issuing TPM commands to complete its setup.
> > >
> > > If timeouts have not been set then no TPM command should be executed.
> >
> > Would it function with the timeout values set at the beginning of
> > tpm_tis_core_init (max values)?
> 
> I guess that doesn't set the duration values though

There is no reason to use anything but the correct timeouts, as read
from the device.

Jason 
