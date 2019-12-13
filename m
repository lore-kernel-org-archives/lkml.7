Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B48C35244
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D730A246C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUFdr87b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLMMGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:06:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46119 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfLMMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:06:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id z17so2326284ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 04:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vy2WG4RuHa5f2z6LjbeaeW56JXxALVqQpIH2hCQzJo=;
        b=MUFdr87bdfxATCI3TuO5k2GqC/HU8Dsml0uQw9V53Jd/55Qbe3TvFTuiiwhLJvYgw5
         zfDgBf6GFZ4jSjt5tZVAQnxttYhw1lPR5WOrhifw5AkqsmSyFoHL++kCK4j/FeeRJ3do
         4g2t1TYCAu0OCa6zVUR67UF+ejkN1IJ+hDkrM2SJbHadqHPABW5tDrg6QrhGpFz7Rr8L
         F8Nf1nMaB4Ufr0urTRFjUd+WPj740mF3iCcP2SUsZIToizfiuaRXfW+oOjeyYYdcINk8
         eMPSdHWD6uWpfVbvr/3r0xpjNZqG1QHnDfpxc0eFB3Noq77MyEHZUOgyuDflLkOk8Ri3
         B5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vy2WG4RuHa5f2z6LjbeaeW56JXxALVqQpIH2hCQzJo=;
        b=POdbsCCDL/PR86qmRdvn8BUA5R5YLnttkt1GWdGqjwQnhnPOh5SteAT1N7cTCaCKVv
         DFDUHOijUi8LBBaykvLCgWuZovimgZriAKRkQOguAjyDXzQ8fZKEDeiaA7zmMUVRJ56p
         kxthWdI7Xu/70CoaPSPvmWtVhieJ5RdSlwJbCqAFvPmZNUw8kOIjucHY8uExuIW0hJN6
         rFQrO967B5F8ZFxseXS3Npf9r55HqnGZtC3qniUOjBTau3ETGBf2hbDOJYS943Ws6H/v
         CT+xmVV4qn4/Otj7HVRZgo3ySUxU0HzaRWE0UJ2rVMbbYKKiGZLpQuq8HNiU2xpNPlcd
         kQxA==
X-Gm-Message-State: APjAAAVUAj9c92yzKXahvXjAohyB65/jNOZ7Zdv6QM4ssp2vcMZ9Pqz2
        TBHPGMXrxx6bw+ebY+e6P+AmhDyBUCJ23/d9Lck=
X-Google-Smtp-Source: APXvYqwBfVKH9QpfEnk02Am4ccGlNAh6cevgsF9QJIkcB8wjW9gjMc2o7+gzwuf/6YRf3nWwcpblq5xp3R3uXjjTd9I=
X-Received: by 2002:a2e:b4b5:: with SMTP id q21mr9269515ljm.17.1576238759501;
 Fri, 13 Dec 2019 04:05:59 -0800 (PST)
MIME-Version: 1.0
References: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
 <20191212164835.GD10451@ediswmail.ad.cirrus.com> <20191212165311.GK4310@sirena.org.uk>
 <CAA+D8AP4XNNmQ72xG6gNevtu8i8TJ7AaQMMgXJMCPmv2VO0_HA@mail.gmail.com>
In-Reply-To: <CAA+D8AP4XNNmQ72xG6gNevtu8i8TJ7AaQMMgXJMCPmv2VO0_HA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Dec 2019 09:05:49 -0300
Message-ID: <CAOMZO5AHRWbgn0U=FsF7a1Ux1vu2_zhga5j6Z5p=6K86PSm1Xw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: fix lambda value
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        guennadi.liakhovetski@linux.intel.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        Thomas Gleixner <tglx@linutronix.de>, allison@lohutok.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Fri, Dec 13, 2019 at 12:10 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:

> We encounter an issue that when Integer mode, the lambda=theta=0,
> the output sound is slower than expected. After change lambda=1
> the issue is gone.

This is important information and it would be nice to have it included
in the commit log.

Thanks
