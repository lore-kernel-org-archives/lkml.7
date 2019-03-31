Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF10C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C32086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 20:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bN/9a2Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfCaUkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 16:40:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34083 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaUkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 16:40:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id k21so6802635otf.1;
        Sun, 31 Mar 2019 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuOXAbv3J8MIItCcPhrIAhsPpVIiIOHz9DlA2MhFrvU=;
        b=bN/9a2Icb8kTa8BTFjyJnjT9+QkuhDJiyZkwUBEI41Yf6Cp46OzTZ6Rqmty+cSrWF3
         LCy6O5Gk71eM5tiZ6QFstzXEgRHu6TdpyYU3uwBP7LHsjlZEsNIBssNuaW8wHyHVbA13
         Swcng2LUtQ17AyJp3W4o2CaFKCk+ESnTQpVim7S8NXilOFPFNdyPTsjro9g/ExNtuPFk
         UBFLA1AaTlLdQYWuyoBN1kxX/j7XllEP9tI7V9fccIr5B24xm/aippHzdoMY1nC7NeCk
         Pcte0gapIm5tyq2Iz8SSKcUWt16qeI4RoONTgRGuNuvDnGolbMTB4FYcQaf0Ly+3qsTV
         J2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuOXAbv3J8MIItCcPhrIAhsPpVIiIOHz9DlA2MhFrvU=;
        b=X9lrRABmeRXrkUbiagb/RWewslC+7BsJl7ZSv4g9dwv4jEBD49reV+WhN+3kooqlez
         F3FknP2jEap34T23cxnmQgF99boerjT3ljvknELOkjL5+Rx2Dx77ZxILO8g78sm5er18
         SPErQb2l/N6SkR+qw0x88cSK3Q6B3nBrIt0bLQu04UjuMVPuClbIBq+FLy3x2/sXVHGd
         bl6w/eBdlkFLSY0YPrzJDS6oLVsGGdQA1HESfIMBlZVXA3HCZqVGkQzq+mkxeJNXqE60
         U1XhKpioabdHQJ0ppQ0gy3a1Rv8G8imvYqsdH1yJAsABY4JF+OvdU49tUD8lEob3WD3Q
         ffiw==
X-Gm-Message-State: APjAAAU0YDDCwFDAT4OttJLZrxltR4JhntOyf4IgIoZYeH7/wFacFMjn
        wp96icOTW3z7iUD/ujRH69iIKYTYWeTIKLkXQO8=
X-Google-Smtp-Source: APXvYqz7vwnAicuK0j8AB+0BTgjMdFbNCYY1OyUChZCo3VH210NS3/ytS9lexvsbiOvNTToenmiS3lo48nCo67UWJ0g=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr41923482oth.308.1554064806858;
 Sun, 31 Mar 2019 13:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <a8539bcf66065380069676fbea99a51254309803.1553914418.git.chunfeng.yun@mediatek.com>
 <c0d6e2a75efc26eb1af49506e6c2cead394abecb.1553914418.git.chunfeng.yun@mediatek.com>
In-Reply-To: <c0d6e2a75efc26eb1af49506e6c2cead394abecb.1553914418.git.chunfeng.yun@mediatek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 31 Mar 2019 22:39:56 +0200
Message-ID: <CAFBinCA3L650-9s0-y_hAP=pS2n=E_YTxn3LnRL_CTs76u2H9A@mail.gmail.com>
Subject: Re: [PATCH 4/4] phy: phy-meson-gxl-usb2: get optional clock by devm_clk_get_optional()
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:12 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use devm_clk_get_optional() to get optional clock
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

thank you for this cleanup!

if you also want a Tested-by then please give me a few days (until I
have time to boot with this patch applied on my Khadas VIM or VIM2)


Regards

Martin
