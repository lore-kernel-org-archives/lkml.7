Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E30C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BD421872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RGusDddQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKLU0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:26:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41312 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:26:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id o3so21235858qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WAHHo3eYG/GlHJEoP+Cppnso1TeHYAoN/ZX4SH504bY=;
        b=RGusDddQfS3B9UAv0zCdjipMrsC5BcvYhv4a5HuXnreJeUQV7JYI9AXkF+iTNPfA6O
         mfNZ3aFbbmzZPc4gLTj0bMpDHKLs7ou7Y4mrJV7KqYg6T/8v3GBxNbJki1pTlQfP1RhP
         vL6yy2SgOmBCVWqt4oae4acbzVSIH3XhBnVQrj+VLEXD9KeqgJFJsPGCuKujM8zxFyW7
         P+VJYNyeVrPPgxfE0ONH61jM12DoFvzwDTndIOKZHKqShdO12L5VsRvEeZjmkW5nv/RM
         nRifeoYAdtjIps4uQw0DXbQGIs6yK5YO4yrjSh+JELD9gnUemiPpFEo1LPehwJRN3jdL
         TRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WAHHo3eYG/GlHJEoP+Cppnso1TeHYAoN/ZX4SH504bY=;
        b=YnwoQsGPBBJjzq4pCGVaoui2n2uoA0C+HYtq/BWK3QkRImOm7W8rLEA01NrqkCZ8YJ
         TD1BpcmTcHF7CvjtPTAcCoeRndAPHZ9OysLvNBINbrpGNysepgonwJ5YJFyqgm6pvMvm
         wUYXvoUOU24mq0tXAGko4nvkupeCjjI0w2Oy2VTPciqHgIOLVax3OoA5HUeeBPj1alOo
         ezV45tq+ZLhpBkC7iUR9lKLqS2p3ZtYXFmF/wGgeA/ytdLhvc3G7hdLmJ8pWhxDEA47K
         Do50EvbvVA06vxbBsatEx0DKXPqnWhQhAUUmpzxyBZ8uZ8vtF4ATShnhfzi8IAOIpVBk
         5i3g==
X-Gm-Message-State: APjAAAXmBT/dWn4sWgfiNtMWxHaZ0rHCLuMEf4WT9T89yhtabgX3wl58
        bapNR/eKBumwbrttKL/HhXp/EA==
X-Google-Smtp-Source: APXvYqxEXOzL0XqlH0Yt6OoI2swlKz89LpzD+J2fHHgpoaiFOE3utI9fW8vLljz1XfxUubAnDMiwaw==
X-Received: by 2002:ac8:6f3a:: with SMTP id i26mr5541601qtv.344.1573590384226;
        Tue, 12 Nov 2019 12:26:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id n185sm9341472qkd.32.2019.11.12.12.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:26:23 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUck3-0003nR-76; Tue, 12 Nov 2019 16:26:23 -0400
Date:   Tue, 12 Nov 2019 16:26:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191112202623.GB5584@ziepe.ca>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > With power gating moved out of the tpm_transmit code we need
> > > to power on the TPM prior to calling tpm_get_timeouts.
> > >
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-stable@vger.kernel.org
> > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index 270f43acbb77..cb101cec8f8b 100644
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> > >                * to make sure it works. May as well use that command to set the
> > >                * proper timeouts for the driver.
> > >                */
> > > +             tpm_chip_start(chip);
> > >               if (tpm_get_timeouts(chip)) {
> > >                       dev_err(dev, "Could not get TPM timeouts and durations\n");
> > >                       rc = -ENODEV;
> > > +                     tpm_stop_chip(chip);
> > >                       goto out_err;
> > >               }
> >
> > Couldn't this call just be removed?
> >
> > /Jarkko
> >
> 
> Probably. It will eventually get called when tpm_chip_register
> happens. I don't know what the reason was for trying it prior to the
> irq probe.

At least tis once needed the timeouts before registration because it
was issuing TPM commands to complete its setup.

If timeouts have not been set then no TPM command should be executed.

Jason
