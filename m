Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD16C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AF621844
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="inz6BKPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:19:32 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44385 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfKRQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:19:32 -0500
Received: by mail-il1-f196.google.com with SMTP id i6so7117475ilr.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9E85CtL9td3M11CPpft7JLYpTsiRw80DDYN+NBSTjo=;
        b=inz6BKPqZnuPFIBOaggS5p7Eq85z3j336Z6TV07+Al4rjRDU6kXtvyQ+UbLZ+grkc7
         F9IoCrhDHv9E0jbh24OtIzDmmwE+a0DYcrXe6lMlciR7KxmFm0bRRidgAu/DP2Y6bS0M
         eryoP6eftPzMcIOhTmUSN+/UFMaYfEBxLPQPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9E85CtL9td3M11CPpft7JLYpTsiRw80DDYN+NBSTjo=;
        b=ge8Jt4xIfg7NCf6//UxGXHptHd3Y9Lso7+joO2/S+ZwA2RXLFklOHwS7rQ3SFhmwhp
         wz0DR26AaQkzagGG9+d6oCgMwz3ZID241U6r0IWIEmXiTiNo2zrW/8RkWo3wIv7tP5i+
         fuJtN0X1fhMjLKyBDt2jk5/gBMKP4iGkergwtd6lXY/9GnRTf03UIEXz0jg4sO+p6Ajg
         iRF+qr9ELG/86bNy92ihKsSHfLwsvFdopCuu2VNRxHDv/CVHeDItyBwS1oru1jFasHnn
         xKuYhgnSFOYI1mI7IiwrjqMorhM2I3Mu08b26JUhu5TJIs4JM1g6UGxZeFw/a85iJU9v
         ciqw==
X-Gm-Message-State: APjAAAV7Icby5Pv8HJeP3hxJW0T5fwFBl55jFd+iW90WNdXZ/EtM47wv
        oAqHhxywah0Js3LY93ItP1v+XjMY8bw=
X-Google-Smtp-Source: APXvYqzh1VKGsXvpgGv1qEG+Fa1DCpDreQ59tMk/NbRqaSSeuW7KmHAuoMM4kKHyp2UJwaLEdpFbHw==
X-Received: by 2002:a92:8108:: with SMTP id e8mr16348963ild.209.1574093971501;
        Mon, 18 Nov 2019 08:19:31 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id e25sm3567879iol.36.2019.11.18.08.19.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 08:19:30 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id a7so16517256ild.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:19:30 -0800 (PST)
X-Received: by 2002:a92:109c:: with SMTP id 28mr16767271ilq.142.1574093970462;
 Mon, 18 Nov 2019 08:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20190214173633.211000-1-dianders@chromium.org>
In-Reply-To: <20190214173633.211000-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Nov 2019 08:19:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WD4r-GAM6mnTg9qB04aaX7JJzHajhtb+N8Yq9UR1WZAA@mail.gmail.com>
Message-ID: <CAD=FV=WD4r-GAM6mnTg9qB04aaX7JJzHajhtb+N8Yq9UR1WZAA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmhpd: Set 'active_only' for active only
 power domains
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn / Andy,

On Thu, Feb 14, 2019 at 9:36 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The 'active_only' attribute was accidentally never set to true for any
> power domains meaning that all the code handling this attribute was
> dead.
>
> NOTE that the RPM power domain code (as opposed to the RPMh one) gets
> this right.
>
> Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/soc/qcom/rpmhpd.c | 2 ++
>  1 file changed, 2 insertions(+)

Somehow this fell through the cracks and was never applied.  Can you
pick it up?  Given that it's been a year and nobody has noticed this
it seems like 5.5 is fine, but maybe you could add Cc: stable since it
seems like something that stable trees would want...

Thanks!

-Doug
