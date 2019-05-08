Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51208C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA55216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hYD5u5tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfEHQn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:43:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41121 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfEHQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:43:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so18059407lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bE2g2/J7jcovpzbNiK1OGJndwPVuuKcWH0XZQkXZprw=;
        b=hYD5u5tQEgcbqVOlPqx5/nEt9O9Z7X8BAv20e+5EZiUy0lly8gA/9guE6y3GL4x5IN
         MKvJN9psUkKmanEK1Mlx6WZVYiUAmPH+IGPBi1JRJJvDrhmxEnfDqKM48VxCQn7z4Uys
         0N3+G87YR9b37t+d5zCumoc7eM4h6PG6bIb+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bE2g2/J7jcovpzbNiK1OGJndwPVuuKcWH0XZQkXZprw=;
        b=XGcgrwH54eYzMxapLQCinDPMpjf91uK6NADUSftPlDW+JhfPPdusvuvmN/Ig7HKG/d
         zJSm4np3OrT5lRyJZ9AKeBQrbxUdXXtXukwzwAkeEEOoQ5d2+iOCVDJFodjX7GoLK6Wm
         dCQnW8BFfMGtlJnFpUfaXFSEQhOjiyr9H4fZZDh6bGfWaw8zkBPGeIpyfrs8avM6X4wd
         v9qrpdsMDFppXdc4GE/ycUbGmMyHB66nSJZ7fom+z3C4P1VcHeMwQgrCekAVpviaiZt8
         TTGkGn+g71+T36oi8EVva3DpqePQRH2nYk3ukbN+ZypmJnM3+I7BjR6DtBWJTU1IEyTn
         x5MA==
X-Gm-Message-State: APjAAAX6PKJKne7aor9BaURmZHOOddAHSpQU1xoCweNmcDHqVTLTm2uN
        uirMtlBWYfUKDtH430Qi3OZoZ+yiR1w=
X-Google-Smtp-Source: APXvYqxE7V+ROvcUZ+wlEuqV4zSJXLm3wi88sCYqiieDQBKJJLOOg1/YH9OIe5o8NK97m9RqAYuQzA==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr3173801ljg.182.1557333804820;
        Wed, 08 May 2019 09:43:24 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id b15sm4073258ljj.1.2019.05.08.09.43.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:43:22 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id y19so7462699lfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:43:22 -0700 (PDT)
X-Received: by 2002:a19:1dc3:: with SMTP id d186mr20179267lfd.101.1557333801942;
 Wed, 08 May 2019 09:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190507215359.113378-1-evgreen@chromium.org> <20190507215359.113378-2-evgreen@chromium.org>
 <cb0accd5-6b0d-065a-9b54-321252862d88@linux.intel.com>
In-Reply-To: <cb0accd5-6b0d-065a-9b54-321252862d88@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 8 May 2019 09:42:45 -0700
X-Gmail-Original-Message-ID: <CAE=gft7PtNWzH1QYigbQvDcJwZSb7ZLWoKzurPGBnh72DYcZrw@mail.gmail.com>
Message-ID: <CAE=gft7PtNWzH1QYigbQvDcJwZSb7ZLWoKzurPGBnh72DYcZrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: Add Comet Lake PCI IDs
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 3:14 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> Minor nit-picks below. The Kconfig would work but select CANNONLAKE even
> if you don't want it.
>
> >
> > +config SND_SOC_SOF_COMETLAKE_LP
> > +     tristate
> > +     select SND_SOC_SOF_CANNONLAKE
>
> This should be
> select SND_SOF_SOF_HDA_COMMON

You mean SND_SOC_SOF_HDA_COMMON I assume.
Except that I also need &cnl_desc, so I need CANNONLAKE to be on as
well. Should I select them both?
-Evan
