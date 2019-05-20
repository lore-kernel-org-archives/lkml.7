Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2A4C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9864F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Gw5ZFVvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfETSHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:07:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41994 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfETSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:07:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id w9so8895662oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/mkNRaloYm4q4e81CZAIxtva6CYlEwPt4YAYYrKrHM=;
        b=Gw5ZFVvWbGzpmF8y+hSk7oez1jyyFwu8IUGwPSJyfDu1oSbl8A71FC/8MM5seTbyYc
         nuo3bsJir7/6msWzaYixA3kZWV+qQRscTDPO7wgQ1CigsRRWt+jUNbq92qvrhKCNLMeN
         ltU4TB02W3YKesBRXKCtic0kTRChVtV7wDkcuKnh/V+kLWdK9BBhhow2r1cRmq/JfMOr
         mc1uK3tVodISTIUqEwTRx8kK/C6CHFcsxf3tkmQmWLHHxGGq8VtFmgVA3FM/ARqwe+Ph
         DtLGQC3ZEOGqKIhmSsPZBDRVeucSx2J7tmH2B5dM3nOfZQ1OoSgWgAxOkYD0mbrMLz5o
         jG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/mkNRaloYm4q4e81CZAIxtva6CYlEwPt4YAYYrKrHM=;
        b=MA78ZhKYfPXRsopZlrf82NFtVI+uyWa71Q9LXUyUAD8nYURhHk4hEN3jYBqyhWiH+U
         b1Y3mv6eOu8UBPsXRCnmzvPqSQAOl0ecIMc1xKXyj1J6msmL/oJ9AVe7jdjH4m7Vh2db
         gDyYtXyM8QsuS/4OLHlRfb61PRlEDY09bwZvh050j++yqbgaHFx+QU7oWutbVxidgSwY
         56b94t1Puifze3XhojInLHifspSuB9INGwW2Ed8yVRyB/RNS6oCYNHK9xcqPRsxdx7BR
         2WpDaS0sNgCF5FAxTEct636v+YMgft4sajnW7ntcE+28MDhs+a8KYPS3y7t3FiecJAn9
         4cyg==
X-Gm-Message-State: APjAAAVCOheN52EJrSVm82jzfiPjteyw29NB52uhJOgOrlpgw+j+Ldmt
        4gaTmoa74ygqHPRQYleptAkvkEZ/VCDEU6eBwtE=
X-Google-Smtp-Source: APXvYqxbuQHL22U8lHijHjitJPXnnx300LA4EOUxMrBsIl4UhxogFbmLJxCUA3WXmBC1dAmeI82mdcOhr+suIYh5+YE=
X-Received: by 2002:aca:4341:: with SMTP id q62mr358048oia.140.1558375620395;
 Mon, 20 May 2019 11:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143812.2801-1-narmstrong@baylibre.com>
In-Reply-To: <20190520143812.2801-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 20:06:49 +0200
Message-ID: <CAFBinCCEi8OjeDaWxfhyfoQOu3GVsw=U9jBLQ2LEkPn7Ataf7w@mail.gmail.com>
Subject: Re: [PATCH 00/10] ARM: meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 20, 2019 at 4:38 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the SPDX Licence identifier for the Amlogic DT and mach-meson
> files.
>
> Neil Armstrong (10):
>   ARM: dts: meson: update with SPDX Licence identifier
>   ARM: dts: meson6-atv1200: update with SPDX Licence identifier
>   ARM: dts: meson6: update with SPDX Licence identifier
>   ARM: dts: meson8-minix-neo-x8: update with SPDX Licence identifier
>   ARM: dts: meson8: update with SPDX Licence identifier
>   ARM: dts: meson8b-mxq: update with SPDX Licence identifier
>   ARM: dts: meson8b-odroidc1: update with SPDX Licence identifier
>   ARM: dts: meson8b: update with SPDX Licence identifier
please check the .dts updates with my comment on the meson8b patch
because I believe there are two typos (which managed to sneak into the
rest of the patches)


Martin
