Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DAEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499B621881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amJeN7bN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfH0Qhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:37:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45381 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0Qhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:37:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so19445737wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Go1kHMAm0UaQCiCBE+PzgIHLVN7K4hpTWgZuaxb+3YE=;
        b=amJeN7bNoXZDGClSUsmTOJ1zxFmTNK0cihb26QdIApZKWXDvBppGc9PTzojK6xG0ti
         pjOcg4Xmkc99SLTfWZRfD6EWuh38f/Ej/q8agMnk4pO0Jmx8fHSUeGxXa3Zu3oukaAKA
         MPslJbDOyMoUIxEbKhrs4Mn5Ku82fwBmfREGyMH6tdRSKKeKP+7o25mFvsGcFyjSQAiG
         c9zbw8rUuj7dbzUk4xZ5E2ED7QjUtTR3W2q+zb4IsoC+xTHTNNiNIDuVOCekrK5IR0mO
         X7hB48pTtSyXxd9Xo96mTMH7icm8ch4q1UrFyEnZpMQUf/5cwN6r6XFBYxi2nTjELXii
         P6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Go1kHMAm0UaQCiCBE+PzgIHLVN7K4hpTWgZuaxb+3YE=;
        b=isyr0ca8O6fsKvqkV9TSdyfJua4YssKMjDuSqhJQa2pTtbdiz3zcGrVu4VQ+pPkdM5
         zLhUzdDTu+swInqxNOL9DX4B7XlAMTgpqks8rEbym/SIHnNMFuLHzbmRhrUz4CrAVlBQ
         lXwWk6of5FgTj3zYdS6ui5KEwNymCc9aKKTA01KCtDhDL10W2gNYosG1xtCg33n2C0rf
         JyUDJrkQKPS2zWpP3SOPa9rtv6W5gDpYR+fCuunhSpwzn/IAQJmUzFY3eDKzd0kF5+DX
         SujUjmEh/cQ/rMjpfHzsUuMc2u5wWL3LBQDR8nkvII/xnMCkQNiNWB83E5u9XDvfycEQ
         OhJA==
X-Gm-Message-State: APjAAAWhXODQi5ehbKpLl7cb+WYcxMD7cMN27lugZrgOttzDTlasp+zY
        OfdLqK0dSsEPVa+mnsAZf+zMBw==
X-Google-Smtp-Source: APXvYqxX15uDp/xlM+yhu2D78R4Tujo7F6qafdGAIfSfB8gUL84JRxMQAeIjUkR0erQQEBrRXfqfWw==
X-Received: by 2002:adf:c594:: with SMTP id m20mr32545270wrg.126.1566923853579;
        Tue, 27 Aug 2019 09:37:33 -0700 (PDT)
Received: from dell ([2.27.35.174])
        by smtp.gmail.com with ESMTPSA id z2sm3863063wmi.2.2019.08.27.09.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 09:37:33 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:37:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 11/11] arm/arm64: defconfig: Update configs to use the
 new CROS_EC options
Message-ID: <20190827163731.GG4804@dell>
References: <20190823125331.5070-1-enric.balletbo@collabora.com>
 <20190823125331.5070-12-enric.balletbo@collabora.com>
 <910312bc-d4f1-b587-b6f2-e832b13d7237@collabora.com>
 <CAK8P3a1ScpJCVEPWiVo+Kc=Ec=c_uhidAt44i==RH+YN5Y+U=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1ScpJCVEPWiVo+Kc=Ec=c_uhidAt44i==RH+YN5Y+U=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019, Arnd Bergmann wrote:

> On Tue, Aug 27, 2019 at 4:52 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi,
> >
> > On 23/8/19 14:53, Enric Balletbo i Serra wrote:
> > > Recently we refactored the CrOS EC drivers moving part of the code from
> > > the MFD subsystem to the platform chrome subsystem. During this change
> > > we needed to rename some config options, so, update the defconfigs
> > > accordingly.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> >
> >
> > For some reason I reduced too much the recipients from the get_maintainers
> > script and I missed the defconfig maintainers. Sorry about that, so cc'ing Arnd,
> > Olof, Will and Catalin
> >
> > To give you some context the full series can be found here [1].
> >
> > All the patches in the series are acked and will go through the MFD tree (Lee
> > Jones). This specific patch is still missing some acks from arm/arm64 defconfigs
> > and if you are agree can go through the Lee's tree with your acks, otherwise can
> > go through another tree.
> 
> Defconfig changes often cause merge conflicts, so I'd prefer to have
> this merged through the arm-soc tree. Can you resend the latest patch
> with the Acks to 'soc@kernel.org' to get it into our patchwork?

How do you plan to keep this change-set bisectable?

Ideally the defconfg changes should really be paired with the re-work.
I was planning on creating an immutable branch for each of the
stakeholders to pull from.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
