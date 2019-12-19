Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62178C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3570A2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C7UCqqJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLSDvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:51:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47060 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfLSDvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:51:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id r14so3497898qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAOzy6HGq+TFs1xtj7/74tezRjxUw60c5rVBr7oLwZ0=;
        b=C7UCqqJzkPx1B9MwYq5LMFwPNwZyG+0Lu2c/yVQdV8kq5zN+wo1e0ltwHagA5u4va4
         Z2Dj9d4LjBn5WuzmdYZAHL+yKhKZAJkCRvaQLFfiNOU+N3UqRrdkJMgyUMANVigeTFaC
         dZb3Lcrvzgp9DkVgJEDfMwhF7RLdt6+uVAhHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAOzy6HGq+TFs1xtj7/74tezRjxUw60c5rVBr7oLwZ0=;
        b=ucDnMfvgoXwbd/2Jn0IyBuw85U6LwIullK/7VZTE4XtoiCiknsPpsVS+1glgPVYwij
         eRZ7iMhkiBiH1eroE9iQuG87iB6HDOLtTFGryR/yrPOnWNHQBHpkmCOrfT9JFOkzZX+F
         fOQKkZ21lqv+S92jyEB58dYj2cDjBE+SpjjHUkh/yn58gE5H2c4VcunNhtvk3sENWQcp
         nzxIk60kVf6P4MQi/sg2wmJVOQER73WuQKNztK07MrilEhFTB2o/qsfDecy6b48KHmbn
         XQENVHmNeXeXs7Uks99UXrsgNIcO2J/Rs9v48tlhrysIJxiO5eup2X3Di+QmYqYZBkp5
         iTkQ==
X-Gm-Message-State: APjAAAUHqfIrJcQD9lyzwTyS5sOwbgNUDC9OuO8NGY7fq5kBFW+a/cK4
        FeSSV0pyDOjA9bJ6Fz3e/m9Zh8c8P8MIiUtl6gmNMA==
X-Google-Smtp-Source: APXvYqxVQR1zDsHVfDiovLQ82mdUU+RrdR4Ro/PJNLrRoTgjjNYA4g4hdU30loYBDdj3qwoVrHU40Q9ZvwTk5Kt3wBI=
X-Received: by 2002:a37:4bc6:: with SMTP id y189mr6213311qka.18.1576727490722;
 Wed, 18 Dec 2019 19:51:30 -0800 (PST)
MIME-Version: 1.0
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com> <1576657848-14711-6-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1576657848-14711-6-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 19 Dec 2019 11:51:19 +0800
Message-ID: <CANMq1KAB9vTDY+d1ktmAtxCGMYqc_C9-SzLzOkLyBmgLz39KYQ@mail.gmail.com>
Subject: Re: [PATCH v10 05/12] soc: mediatek: Add multiple step bus protection control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:31 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Both MT8183 & MT6765 have more control steps of bus protection
> than previous project. And there add more bus protection registers
> reside at infracfg & smi-common. Also add new APIs for multiple
> step bus protection control with more customized arguments.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
...
> diff --git a/include/linux/soc/mediatek/scpsys-ext.h b/include/linux/soc/mediatek/scpsys-ext.h

Will this include file be used by anything other than
drivers/soc/mediatek/scpsys*.c? If so I think you should keep it in
drivers/soc/mediatek/ instead.

I also still had a comment in v9 about clr_mask, otherwise this looks ok.
