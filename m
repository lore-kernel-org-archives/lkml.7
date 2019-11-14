Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1485C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77747206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oULrSVWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKNQvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:51:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41353 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfKNQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:51:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id o3so7488485qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jo8xFnYMTbVFfmOh8S5PDP8bAHN29GV6u4PsLZMontU=;
        b=oULrSVWcVDMACO0J599asG80XjhRY6y4we6U9wCoT3EqBCNl1W8BDuxXq+GU5gSiQz
         lbPGqTHymzLwl9rGfb6ec++AUuuDS7OCOyFJEjtBDi6jbubjAV4XUIY0Rl9oWnyief2/
         v7exve6cUUvMBQPFruo52MQD1Tk8YxQsiRU9Yr/Jbs6brMrGfsHqlR2CG+Yt7sHiizHO
         yufuMPm7sNiAR7CYpiR6Cg6nEQTs/8ezGBMj1PMlgpT/eFpy8JZzbKBh6b9SesQqaGJz
         9m6MlmMcFvUNwU5MnWjEne+XZp16XWhDH5o83lTMoGpzqTXej5H1kmabO5/viei5k5zA
         koGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jo8xFnYMTbVFfmOh8S5PDP8bAHN29GV6u4PsLZMontU=;
        b=W2nl3i4XJ31yMAHm8MEjCmxsXfzjzY3VuiPOAXumsqPYJB3/72xrl/zKssZUTM9GTe
         lTstyPK/XxWEnF6WcH5sX30+bWM70bwDnrc2rU9bQxsUJaUjOIvqFoNdyuiOIT3svnOq
         xxgOvVG09h1qHQs5mluNoSfYMa50HvO5kFt0eVhQfIWl4i71xRRnV7fuYSrxsfgY8aGb
         l7wr0hzdSH6OsM+pZKZjYCOgY5HO5U5UGaYzFKhgz9iFIvWnkS93KwZPg+ods1Pj3Pcv
         5SX9mKQFJBwW8D7hB4mnEpEqTwFeW+tzSdnqCwYO8ihrBA2WESFqXRDkdG4iPkLgFn/g
         HmsA==
X-Gm-Message-State: APjAAAVtHv8DXpP3y8TmUMy7SlNKAD+D8We50zKPUSZrb/dQvmUD9O4l
        7w6ciVEqBRzNVlOERj/kJ522xmYT7dQ=
X-Google-Smtp-Source: APXvYqwSkGfDVsDR/za7y8SbICzFRxR4GkAF1AC46sZkOabqTX98nuUDri0HDpUFFINfMeCvetNdQQ==
X-Received: by 2002:ac8:4899:: with SMTP id i25mr9005507qtq.207.1573750268724;
        Thu, 14 Nov 2019 08:51:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c195sm2842066qkg.6.2019.11.14.08.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 08:51:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVIKp-00040W-Sj; Thu, 14 Nov 2019 12:51:07 -0400
Date:   Thu, 14 Nov 2019 12:51:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191114165107.GB26068@ziepe.ca>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <20191114164949.GE9528@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114164949.GE9528@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 06:49:49PM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 12, 2019 at 04:26:23PM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> > > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > > > With power gating moved out of the tpm_transmit code we need
> > > > > to power on the TPM prior to calling tpm_get_timeouts.
> > > > >
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: linux-stable@vger.kernel.org
> > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > > > index 270f43acbb77..cb101cec8f8b 100644
> > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> > > > >                * to make sure it works. May as well use that command to set the
> > > > >                * proper timeouts for the driver.
> > > > >                */
> > > > > +             tpm_chip_start(chip);
> > > > >               if (tpm_get_timeouts(chip)) {
> > > > >                       dev_err(dev, "Could not get TPM timeouts and durations\n");
> > > > >                       rc = -ENODEV;
> > > > > +                     tpm_stop_chip(chip);
> > > > >                       goto out_err;
> > > > >               }
> > > >
> > > > Couldn't this call just be removed?
> > > >
> > > > /Jarkko
> > > >
> > > 
> > > Probably. It will eventually get called when tpm_chip_register
> > > happens. I don't know what the reason was for trying it prior to the
> > > irq probe.
> > 
> > At least tis once needed the timeouts before registration because it
> > was issuing TPM commands to complete its setup.
> > 
> > If timeouts have not been set then no TPM command should be executed.
> 
> Not true since you need a TPM command to set them. That is why they
> have been set initially to maximum possible values.

getting timeouts is the exception

Jason
