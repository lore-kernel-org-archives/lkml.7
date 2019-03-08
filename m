Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A18C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B3720851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5mMG1EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCHNMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:12:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34866 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCHNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:12:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id t13so17373874lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8sYND1AGWfalwOf9o0H91NFx6rsn1GeKQgu/s71ZbIo=;
        b=f5mMG1EUEDKVhpoTBMFZWRwjoHnEBsYvtOTtkhNq1Q8257CUdhdd+b/FPI0ZoPAfk9
         lu58UwSNidrsuEppad6SaFjAmTcJIlJpmi6atFeewBPwWRdqJ8ZZTNvzR14c6byhyCZW
         RxhEdMAg+GFNT/iYGM7j91xLPw9Jd1kU5fwYhnN6zVhYEKK2FEMdYpPywfLG4xW6qPk7
         N5T1abp+tJA/ZbP4GUGP69A32tw76X8iybq115pSBSbrmYrt4PnirrlbCJMx1LMg0BU3
         bsBY0tWh/wFPO4HJXJfzx32nS28tViBHHk+3P0rEuWauXf/DkmuvFEKpDVRKVm1OuLsc
         IKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8sYND1AGWfalwOf9o0H91NFx6rsn1GeKQgu/s71ZbIo=;
        b=KEP66X8tpK5oOmhAIWdX/zUHNvbuenVx5zEKkvh0bGrTQLkVuOt9ZjVzKc9831Nj6M
         konbvMHfaXHBORGo3GUQus30mkbIaTnuRfEHWnn73dwaUyU+r3GaF1Nzs64/BIeZl+ql
         6zz/f4ISQsXDR62ioa7/ygFwYwoCxUF/hImh5GfkTflNQbC5Wb9LPnLg2DCsEYaCL/up
         TLEXeeM7T3FLx9Fbs1xl5PkBeuqSoCbYhmh1pvg81i5qBjypbVhCAuZEdYwQexBN21lK
         ZS3OzpSxceWzVmYZh2To+5T4FKtc/Syz/ZlBSMgr0VfQc1VVTU6Em/kIVIeB5JuWu5Au
         0a/g==
X-Gm-Message-State: APjAAAWRaCu6Lep/KPfIG9k7NTxnSsKvQ8XghxbDnYN074qNARp9WD1z
        xM7D94ARSIpWTZDIDgyh1Tyqv07VGakvWi72+Izt6A==
X-Google-Smtp-Source: APXvYqyTd31Y7HpDq8Zd+pM2gRWTdk37zArNbMIJ+8UmrDZcBA7M/ow263Fmz8FlzyTRkz/I2fBgZl2ELAvWNmjzzO0=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr9672049ljk.105.1552050769336;
 Fri, 08 Mar 2019 05:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20190307125251.724-1-marek.behun@nic.cz> <20190307125251.724-6-marek.behun@nic.cz>
In-Reply-To: <20190307125251.724-6-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 14:12:37 +0100
Message-ID: <CACRpkda2S0sR-kydVXGLmvh9_FOjT-1-xiYgrOOuxnnyu51r5Q@mail.gmail.com>
Subject: Re: [PATCH v4 armsoc/drivers/bus+gpio 5/5] dt-bindings: gpio:
 Document GPIOs via Moxtet bus
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:53 PM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> This patch adds documentation of the device tree bindings for GPIOs
> on the devices connected via Moxtet bus.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
