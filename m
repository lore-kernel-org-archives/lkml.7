Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2190BC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA89F212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vegyCWko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfFGVIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:08:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45952 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbfFGVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:08:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so2886575lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6jL7ejK1vdoksS3xLayzljNzEjieCxBcJeb5tUZgYI=;
        b=vegyCWkoFq7IWHKgGIIU7ajpXmTFnt5PpMQ9WCQO4zF3Q/P2g/7GacC2aZLGSPk7+k
         bwnKT4BjE4rsV0FAHf9xG/aEDLvBOW+z+MciDjGAJnnRQTaNamB/IA7WdfJeNgPuY5VL
         l69vSI2aMGChyzbeGI9JtyDF+xnfqxqznHF5qxCwD1n4/FJaZGuR38MdzlOoNiqnR4+D
         lOx0xMbHlCKYL1nYd151G75AOt9/cgRis88Her1XSNeTwqKZJGwxGK3xCG7hInDN+zoG
         +/PsDxfzby9IDLyGazyfoIU2PDdufTCb8/oXvvsP0ynVXnqs+pyfxXYNdkyYvxFqslBV
         /lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6jL7ejK1vdoksS3xLayzljNzEjieCxBcJeb5tUZgYI=;
        b=Ogf0e67HKbicqO6IfCGvKctpxcf++68HgfV9Kr49jzQFRKj5ARkyYK7tt9IEUdZBbZ
         vP8QbEExri7gQJ0Nt1RwV2VLQFci7s4OM638K49vFnfUFdlada/R1nb0sbqy60GT0mk5
         daeU3GHskN49pzDJHYU7tCLduUZxn20wywrei8JmprquHvxjZnxboCtUTiO1fAABHAJk
         /lxSvVDID/jODDME/Wl6lT/vYIQQq9CAcqtYLZLcEG7dq1AuynVP5wG/sxiaypFm2WX/
         gIfPoXFnVgVBeOwAQGYIsWaCeB1Q6t5EocCePGCLmd+ItSlcXz95IMalKQzsWU4Bv6XB
         sb9A==
X-Gm-Message-State: APjAAAXy9cWjuyyd+6qqIBQrgMCFNqa0+g1DN6VcCSl8ODyoh7IG/Uzu
        lNMKwX9eQMad6jk+g34gwONjP2nWgJ6u8JOk4jC66Q==
X-Google-Smtp-Source: APXvYqwPTQVLwavT2qXQKKLz8bFfoqAyN+lJI4vElZiZLHJbP2BQZYrz/3pv5Uyw1qDhaFDWje1vP/YBI4KFNgDVDhs=
X-Received: by 2002:a2e:8902:: with SMTP id d2mr29169874lji.94.1559941698057;
 Fri, 07 Jun 2019 14:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <1559285512-27784-1-git-send-email-tengfeif@codeaurora.org>
In-Reply-To: <1559285512-27784-1-git-send-email-tengfeif@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:08:10 +0200
Message-ID: <CACRpkdbdkbSofrvJ0hSV66DX+DcwWXp0ONDjx0265Pz50yE8TA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Clear status bit on irq_unmask
To:     Tengfei Fan <tengfeif@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 8:52 AM Tengfei Fan <tengfeif@codeaurora.org> wrote:

> The gpio interrupt status bit is getting set after the
> irq is disabled and causing an immediate interrupt after
> enablling the irq, so clear status bit on irq_unmask.
>
> Signed-off-by: Tengfei Fan <tengfeif@codeaurora.org>

This looks pretty serious, can one of the Qcom maintainers ACK
this?

Should it be sent to fixes and even stable?

Fixes: tag?

Yours,
Linus Walleij
