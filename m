Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34591ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD1521D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n44cT7lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfJKMpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:45:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38154 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfJKMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:45:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id l21so8574641edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THhY/1EGBLynF46Z73peTNxgaGDlKI+6GP0+2FXk1Ng=;
        b=n44cT7lO4rFbJWSui7nkMhtOmcD58/YEEM6gDMqOIGKg6m4xltmk1OmrLg8Ay/C90p
         NT8AxiGcmIzLZqgiK7yhbW/lR36g5QXs9B4NvSOcgTgqcy0eo7CnGqYLCu8fYCqqNp4y
         TSQ4B18sj3LAIW9pJ4A3z4YtcOb2ZsbnmhiA/9fGuKREgPPxUXBeonRmwGjN6g8iBkFN
         rz4npojrDH1SHrDSUBLM/o/bz6usKSFcVwqIzbI51vCem+3CsnJtPoSvUiFUg+VB3vVP
         SBHQj3fnYZQZ054lbAaSb1WSoaaPvtzL6xZooechaqDCYnzOt+tKa0jUxd/7AqxPuGRo
         okmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THhY/1EGBLynF46Z73peTNxgaGDlKI+6GP0+2FXk1Ng=;
        b=CWu0adAz3Nod4SXRhVHzPR2tkkMdJeW3VQJqOb4021Ben3/B/Pjaq7yX5LY0HS1P3R
         L2yd5eItnhHwrVGUZdVA9BzsBqsSNh+/hfLguYvsjYstuN/cXT49ahcEy2tZ1rrBy5xi
         877EKV1wZQoVPJPM1aeWAwLnnFPmEovi6WKWSW1mtX0v4jsJ3e27Cgc5FwsLJacyg3sK
         lHrdvYjlDdZv4NqownainTFW59Wvj575WSf0YoH6YNi9SKsKCi/T4rjd5/kPFz+No2mf
         DfN3lABiAYSJsCob4x07S+eIgfgI94HkrSzSzfrRkO+/nvhUE2qKB+9pDm9BkNR+CEmP
         5CcA==
X-Gm-Message-State: APjAAAXeaE5svvvHDi9+3cIEwj6w+Qt9hxhrhZZas5zf42dAi1SaVMqI
        iucLXaeMZ2jYHhG78RyeMeSpBj8WL1EmsuNAH+Y7pg==
X-Google-Smtp-Source: APXvYqy3nGLibHdKisoYfTTSDKKkcwK6O7yckg02ABEzONB7OV+W/kXsaZilpbqhNZPBbZY2VH1MkCkYrA2kpd2E8t0=
X-Received: by 2002:a17:906:48d4:: with SMTP id d20mr8779018ejt.246.1570797941402;
 Fri, 11 Oct 2019 05:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191010143232.GA13560@harukaze> <20191011060130.GA12357@onstation.org>
 <20191011112245.GA10461@harukaze>
In-Reply-To: <20191011112245.GA10461@harukaze>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 11 Oct 2019 14:47:05 +0200
Message-ID: <CAMZdPi9hTQQcFHMRkj2R9t-P9AiPh01hKGPP5_F8T+MUuckVHA@mail.gmail.com>
Subject: Re: msm8996: sdhci-msm: apq8096-db820c sdhci fails to init - "Timeout
 waiting for hardware interrupt."
To:     Paolo Pisati <p.pisati@gmail.com>
Cc:     Brian Masney <masneyb@onstation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Oct 2019 at 13:22, Paolo Pisati <p.pisati@gmail.com> wrote:
>
> On Fri, Oct 11, 2019 at 02:01:30AM -0400, Brian Masney wrote:
> > I encountered that same error working on the Nexus 5 support upstream.
> > Here's the fix:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03864e57770a9541e7ff3990bacf2d9a2fffcd5d
>
> No dice, same exact problem.
>
> But the patch is present downstream[1]:
>
> commit c26727f853308dc4a6645dad09e9565429f8604f
> Author: Loic Poulain <loic.poulain@linaro.org>
> Date:   Wed Dec 12 17:51:48 2018 +0100
>
> arm64: dts: apq8096-db820c: Increase load on l21 for SDCARD
>
> In the same way as for msm8974-hammerhead, l21 load, used for SDCARD
> VMMC, needs to be increased in order to prevent any voltage drop issues
> (due to limited current) happening with some SDCARDS or during specific
> operations (e.g. write).
>
> Fixes: 660a9763c6a9 (arm64: dts: qcom: db820c: Add pm8994 regulator node)
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>
>
> so it's probably worth carrying it.

I've sent it to LKML, but it has never landed (and I've never followed-up).

Regards,
Loic
