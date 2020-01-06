Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF7C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCB9207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d35htZm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAFWvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:51:47 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44497 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgAFWvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:51:43 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so19736587qvg.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcDJpyHhT/zuHt9L/g76CdYSvylHBQA1EbFEZdNVtEg=;
        b=d35htZm0gVCK/o7dbN8yxRvxzIEDYFhUfHYTtCUanbQlAQUMbA7D9fJQ7sI+7YkUYI
         fpuj36oPW2PXPysY4rVwdiRH0I2zfeUYPpyYdP1pGpAM2VHM60s2z5fmvIrfO0S+4CcN
         lOApLOvozrkfiXp8w2ciqEbwqOGsPZ9cKipyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcDJpyHhT/zuHt9L/g76CdYSvylHBQA1EbFEZdNVtEg=;
        b=eYyAHRRGy5Jl0DZ17bSQDvyl8ao7n5Kz8JyWqspNgflf6D2HAXkhjXR0QwnlOpm1X9
         /fQmQnaJZeHkjqS53g0u4E/Am2b78NN1oy3wGYhgkWZmxP7Om4JTi29nAapcyG+NXWW4
         1S0eqUHDBJ6kKAmXnoNcTJXlBJBuhcMsM8sgRjQhXWu8Xg18ttNbEJAbpYF1H16fowXD
         nCerVJBTcxs1GwDxiyzu/Mf/H4LHMNgHuEXvOKIYhMByNrD+nuCaqS+dykbYUf2tt0EV
         GxUeyTBFOUG3N9qiB60Ne+ftl6pSma/PZcmA7vV5II/EyaJ0OuxJ5XLxzDqC96pSJlzw
         3ibw==
X-Gm-Message-State: APjAAAWz6NGEWgkhAZ3vbmDxeojLiFrr/qeg/qVdPM/Fdww0QKtljsF9
        FRt++KmFn9xAjDXoATSdg7RSSnW7ZBU=
X-Google-Smtp-Source: APXvYqzXjgaQhMpJT6GTGSt3gOMtQVr/EPOjUs/oll1CScKeXlv7FSOKyEcQr3vhAJVswdPt0Lvmqg==
X-Received: by 2002:ad4:580e:: with SMTP id dd14mr82023902qvb.84.1578351101282;
        Mon, 06 Jan 2020 14:51:41 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id i5sm23949143qtv.80.2020.01.06.14.51.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 14:51:40 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id w47so43824710qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:51:40 -0800 (PST)
X-Received: by 2002:ac8:678d:: with SMTP id b13mr67296866qtp.213.1578351099829;
 Mon, 06 Jan 2020 14:51:39 -0800 (PST)
MIME-Version: 1.0
References: <20191227174055.4923-1-sashal@kernel.org> <20191227174055.4923-8-sashal@kernel.org>
In-Reply-To: <20191227174055.4923-8-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 6 Jan 2020 14:51:28 -0800
X-Gmail-Original-Message-ID: <CA+ASDXM6UvVCDYGq7gMEai_v3d79Pi_ZH=UFs1gfw_pL_BLMJg@mail.gmail.com>
Message-ID: <CA+ASDXM6UvVCDYGq7gMEai_v3d79Pi_ZH=UFs1gfw_pL_BLMJg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 008/187] mwifiex: fix possible heap overflow
 in mwifiex_process_country_ie()
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        huangwen <huangwenabc@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 9:59 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Ganapathi Bhat <gbhat@marvell.com>
>
> [ Upstream commit 3d94a4a8373bf5f45cf5f939e88b8354dbf2311b ]

FYI, this upstream commit has unbalanced locking. I've submitted a
followup here:

[PATCH] mwifiex: fix unbalanced locking in mwifiex_process_country_ie()
https://lkml.kernel.org/linux-wireless/20200106224212.189763-1-briannorris@chromium.org/T/#u
https://patchwork.kernel.org/patch/11320227/

I'd recommend holding off until that gets landed somewhere. (Same for
the AUTOSEL patches sent to other kernel branches.)

Regards,
Brian
