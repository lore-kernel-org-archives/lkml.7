Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22146C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E655827751
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNKo1PJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFARlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:41:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46630 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFARlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:41:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id m15so4244676ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHjJzagrI2w6CxzEMyI3YS1Fy3fUOHjBVJQpvV06gF4=;
        b=kNKo1PJp5JY8FyKD7JkhadL2uuwGlRwXyBzur6y5fdsxiydbyEgL0yjSnj/Ex6vBKV
         m91afAFfI15VdDMK9Zfn7vRNKG2F0OlQhgZcdfwH1WdJS/+fB//hckYTGPJAbO1ERb4K
         HyAxPI2RKz2bVOmVcIHmnjJRBJ7zha/dHpZkNggiMM6m0cGW79yQVu5hgFKOmcog6a/X
         hQs3OUaUJOD+266aTLeyUt6aplfIXQOZtfyQz94Xlt0MZhseWtud2aHTOzF2cCpB5s4s
         80eAyy08uKq1gEL3GyhM5xQ4EG9xJyOOnryKvPiD/uGps9VmxiPapZa7RSqZOrdEj4sK
         Y6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHjJzagrI2w6CxzEMyI3YS1Fy3fUOHjBVJQpvV06gF4=;
        b=n2iBnwqHxUrJhY9yVZhKWysu5Tws31VMSTDY6rFYJ1EUouloVeA4Ze9vYq5LfUPpNI
         SlAoHm/+rZXSuUS2BI0CcRtip3Iz5+MSW/Sm9Oetx+Hz0EvzAbVzVFsPvZcb4Lftx0AB
         YCL+4p57YOBYFM3Sb99iYs4ZcE9a6mm+U53i61Hpzhw6FmJ6Erm3IiGRbs4hhSonLN08
         Bcc7JR78MvxVrk1uKW9nGUciQ4RrQHj97nNadpNUpJx86O2u6eXJmbQ6eNBnsgaB2Tfc
         zBKaMNTQsVwg7ASyRncm1JIxlUNQ9hrKyxJX+kupaIqC2La4bcmx+wEETZ/VAmf0JPvz
         jp5w==
X-Gm-Message-State: APjAAAXVtjlXifuH/exOLhGZVBCxbaSdSs+rvrMcPwjcsAtc+e5KZGvo
        /NcD8PtgXxVgg05vsvd+OEpjUpv1snS7BanYjK8bzg==
X-Google-Smtp-Source: APXvYqyMs3a2CNuuQZwXewGMpnWnrvA5Em5qjXrSELyADIL3SbiyiL6hwwGk0M0RbgN9+6Gp3Y2EroKx7Y7np874/U4=
X-Received: by 2002:a2e:9018:: with SMTP id h24mr2448110ljg.165.1559410889721;
 Sat, 01 Jun 2019 10:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190508073331.27475-1-drinkcat@chromium.org>
In-Reply-To: <20190508073331.27475-1-drinkcat@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:41:18 +0200
Message-ID: <CACRpkdb1cfQts-CshwgoSXDv5JM8=miy4=2FhKpOi-jZL6OTxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: mediatek: mt8183: Add support for wake sources
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 9:33 AM Nicolas Boichat <drinkcat@chromium.org> wrote:

> This adds support for wake sources in pinctrl-mtk-common-v2, and
> pinctrl-mt8183. Without this patch, all interrupts that are left
> enabled on suspend act as wake sources (and wake sources without
> interrupt enabled do not).
>
> Changes since v1:
>  - Move changes from mtk-common-v2 to mtk-pinctrl-paris, as
>    recommended by Sean, to keep better separation between eint
>    and pinctrl-common features.

Both patches applied with Sean's ACK!

Yours,
Linus Walleij
