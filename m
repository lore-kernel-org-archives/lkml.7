Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA5E22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZXrBT73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbfHWHuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:50:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33858 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732840AbfHWHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:50:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id b29so6473105lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AROq8DpxBavGw3rOZlBsIIIgdgdRJheHWzoZIaKAbGU=;
        b=eZXrBT737nM6L8Pa5XlEQuC0rQBRrzfTsrl7Tw0vIf6llspePcFP3Z99vwe48Xo+q+
         xOKOeB2kfRG07WTIk/J/GStBuxjjfJKMkzmaTv+HZxcu+unxdyhXqKmAcj8A6lXg4nll
         Wh5bMJd1ogfOrPxcDidGKUBQ9eIYg8/0B5MHQGTrHe/GPKG/Ds+nI4dND4hFOoU+Mdgs
         nuA64AWazxNszt2zSzknLq2Go1nWPLVQW2G+zpe8aY/JKdzYSFUXNP4Zweqq/FTXRHef
         Gx6CccrR4hrMSojSHJjv1mmNtPTOQ5L/PyeCjpMZX9KG+V+MXVOELXgnFpiPNT0xvQjA
         UKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AROq8DpxBavGw3rOZlBsIIIgdgdRJheHWzoZIaKAbGU=;
        b=Xu1ESmRaJI2hyxiAX+72vLULWymUDA5QRtoIOXdLkIfup7S9b9CKXs6zbPN0GRr1QN
         GBswQZSTzSd7achKi2OIrHHesQoHkFwiZbznEWiP36Mzgvdbes4NX+KmE4aSsG7khTY9
         +HdkPBJFDRbKtYFSUrsUj3FWuqQ5OVKKe87WN/Pu+DdQgbZo8FsSM+MLFhYce6KlHycR
         lrdOmVA768dfLuxNbHq4u/Ei8i4efrUVn52UvJ66FUoJ1Ctd2H43YeviDKsNlYmjZMiD
         E7WoCuxWJB572c7yn417XG1jiLvGqma7peQV8z2QCajsvdHmU1pnS+vDajAtKLOpAsXw
         1MbA==
X-Gm-Message-State: APjAAAWTdPjQsjPOLOA9ffBZRWmwahkwhR8Ysv903jdV4gGG6GqQRj/3
        OjklaDRQb7aS0uW+43fghW+kJ4WVmjoHd1LCyoTsNw==
X-Google-Smtp-Source: APXvYqy4LEAB6weVbikWw4omf6hTp96l46dy0piklsM9lAxP3u3RWDVFhgst2bdXR83kAe94+v5z+0MY4UWyNN2QLmo=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr1990286lfp.61.1566546650115;
 Fri, 23 Aug 2019 00:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <1565686400-5711-1-git-send-email-light.hsieh@mediatek.com>
In-Reply-To: <1565686400-5711-1-git-send-email-light.hsieh@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 09:50:38 +0200
Message-ID: <CACRpkdY0+eQXknPPj2vz9-Zo9cQHJQafbUC97mOQvEuzbX-qtw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Improve MediaTek pinctrl v2 and make backward
 compatible to smartphone mass production usage
To:     Light Hsieh <light.hsieh@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:53 AM Light Hsieh <light.hsieh@mediatek.com> wrote:

> This patch improves MediaTek pinctrl v2 and makes backward compatible to
> current smartphone mass production usage by:
> 1.Check gpio pin number and use binary search in control address lookup
> 2.Supporting driving setting without mapping current to register value
> 3.Correct usage of PIN_CONFIG get/set implementation

I rely on Sean to review and get this in shape.

> 4.Backward compatible to previous Mediatek's bias-pull usage

This is fine as long as the new style of using explicit pull
setting also works. It's nice to be compatible.

> 5.Add support for pin configuration dump via sysfs

Do you mean debugfs? You should use debugfs for debug.
sysfs is subject to ABI rules.

Yours,
Linus Walleij
