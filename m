Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00142C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C783E22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQoYmM1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404181AbfHWIN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:13:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41252 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbfHWIN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:13:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id i4so10401678qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iEZzmAuZ9VlWo1rY1HoUVRqOc3pQbx/jL7+3U6XUrE=;
        b=KQoYmM1kiPcUeWePSRh/MATRSKtGHbDYwmscEnDEJex+ScfK8GC0Pn565Cm8BTQ7fS
         TN0P76B44uAatP3B3BZ61Hp3/1ZaAhV2sP1r/Qzr+VQI42UarAvsX6fIFMwnvDohlRBM
         i/SnM/kjB9KyiVRKnmaBnb4WhhIpto3GuckqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iEZzmAuZ9VlWo1rY1HoUVRqOc3pQbx/jL7+3U6XUrE=;
        b=Nxab5CVWFJEHb8Wmo/UQ1PmwkVBtsrLn3T79Dk/8wvEU/t9ImajK2n92nyD8GnyjNt
         36X5oqvzeQaTaTKiOw49VAEY9hqiWtlDW4F69u/5FaK86p239shz6++pGaj24QRJN/9M
         s8BXlZ/dLF+DDuiPxb9uXm67LjF0AjgScyF8nWR+h98BnT8TDmZHjqKaF1pAIsnIwxka
         BtSivMljP5yWscYpEHUz3ispk+EBZkxIv9QdtayLmDlXvMyjB6n9nBCK0hgOPwOMwUZB
         p/3uGGdCzgyraEjx0pS/2YQq9gjUsyupGMXn8py8fMv7iyzW0GVH3dTs/WYJ0GctM8di
         X6Zw==
X-Gm-Message-State: APjAAAVPC5zIxPrRxBLJpZhpKhbIlliWlRm/oBdaguuMtYyu07/ptczb
        SQNrtzeLbZRljtqUwcEuurzMJQFWeys+1aAXWKsfLQ==
X-Google-Smtp-Source: APXvYqxNnLStOk4ZXp11RN7jSj7XJVMznct6ojLcGz5Yls6xfN9NE4mhgE85LSRowXYs50aMoWOgyWYV7b4IKr4cJAE=
X-Received: by 2002:ac8:1e1c:: with SMTP id n28mr3591243qtl.78.1566548035657;
 Fri, 23 Aug 2019 01:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190822094516.55130-1-hsinyi@chromium.org> <1566547772.19935.2.camel@mhfsdcap03>
In-Reply-To: <1566547772.19935.2.camel@mhfsdcap03>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 23 Aug 2019 16:13:29 +0800
Message-ID: <CAJMQK-gb+A9dwyMqMcA5yaaXak9no8_=urwK0XbLnNAEGyZ_hg@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: mediatek: disable zero-length transfers for mt8183
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jun Gao <jun.gao@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-i2c@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 4:09 PM Qii Wang <qii.wang@mediatek.com> wrote:

> >
> >  static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
> >  {
> > -     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> > +     if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
> > +             return I2C_FUNC_I2C |
> > +                     (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
> > +     else
> > +             return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>
> It can be removed?
See previous discussion: https://patchwork.kernel.org/patch/10814391/#22484435
but not all SoC's quirks has I2C_AQ_NO_ZERO_LEN.
