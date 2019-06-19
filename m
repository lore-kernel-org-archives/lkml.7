Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1347FC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7E22084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvvJ6rQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfFSLeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:34:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33865 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSLet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:34:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so18961001otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRJsEYMCxjB/gQmt8AuT+dGCwVbVNWbR34Uqa5PFHNc=;
        b=uvvJ6rQGY+is/2WOoc+TaiQfocmKFXSueUKUbErRcEGulHR9krcQw2bU6UimtemwP8
         zVc8MPxJe5j39eMsjRfY2XzY0d0+FAYlaltFpmQ5nDLp+MUsGlGJuKOMbWaGpDwnQOz1
         tei2q28xx1Reh4dudfFm6a+llFMQMOOY6gqboPKeAthSJ9U6lrYi0wVt2p4/dK8oBBbb
         dWyuNdumCx+X0lLEwfKl/FzTB22lWjc9+iUabFgS8jKrReTDHcZ7OH0Y7QVXCHIwe76i
         ISpiF2709549xZDgbq7l5lrPKPYUDlIyA7o2rFtBnZG/+a3xNtm17Vf4NxDvC1GHwdoK
         gleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRJsEYMCxjB/gQmt8AuT+dGCwVbVNWbR34Uqa5PFHNc=;
        b=J0G+47j2Uby9bs75ejHtb4RprLSWtO6khYshlvpMD9wi1pqMoSDUnSS5UXzOrXOqSu
         ol5vMLJrsrQITodDAf2eapdkJ0MM8btucJgc5b5yx6eSHaxJ4EiUXKiVY0g/exfv/lHQ
         +KjdWkZ5RY+uzl6nqoATmMDItL+baJZtP+AxnbpHO54djndpmd4QjcdhSMwUFFlrO5++
         LpnBZYgpHcEBodGKvDY+Ulmrply8iZwSqkHHK6OluTTAu67iTlfP6v6b4ZTt4i1KFGQW
         s2GtD0x6geEu/IIha70PXRXq46rcyi0DBwKLiQe2XYgDshFeGD9J1LX29oONWhG5/NTJ
         OdEw==
X-Gm-Message-State: APjAAAV6brLG7KPlCz4/3HDwfpfDdBTRi2nUuvQKUVQ5DrNnVPECGSh3
        VoKGIfdpY91hZaAlskLzldOm8R05MkBLsNrrm3RInQ==
X-Google-Smtp-Source: APXvYqxoNAySE1fcoRZVkDaS2fHorMGb2u+HB0o+Gefw2u3xcm9sT8x6X/jnWHGXb08ZdcR4xMdOeQSCmvU8ioo8sdE=
X-Received: by 2002:a9d:1718:: with SMTP id i24mr50671024ota.269.1560944088861;
 Wed, 19 Jun 2019 04:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net> <1560790160-3372-3-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-3-git-send-email-info@metux.net>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 19 Jun 2019 19:34:37 +0800
Message-ID: <CAMz4ku+3A=fcYpp++owPv8N5dbatHYTKNRtUiOrHqbXVONRn+w@mail.gmail.com>
Subject: Re: [PATCH 3/7] drivers: gpio: eic-sprd: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Jun 2019 at 00:49, Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Thanks.

Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
