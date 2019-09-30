Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A85C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE3B21927
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxeBRvzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbfI3V5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:57:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40408 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3V5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:57:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so11113884ljw.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4G8UhfmOAU+vf176VW3ixtgHtt4omHWSmMUKQqJYu4I=;
        b=zxeBRvzt144Q4MDycJBV/iY/2eVJfo8OGtkSJ0SJijBO2SEblZzrVzwlMUbAM+75SS
         LNt8hYAXph/R13Qlfc4X4Ugg10gDi9uZoyrf3aIEGtHaARdlCMS8W6Hv/Gyg1aA7NhRg
         +5YcShk/mkdFeO4SABR6+AehSLtFVMI9hV0IZvm+xNaDRU5ri2jxn8wN8+R2531bip9n
         HWBEiqrzP+T1djmmDaowqv+2jDvWaaqtPXvH9ttR19WAiFNmZfzReUc6pUSYmzdCWlCo
         SGlbCAYv2DyxRTmvQ2x85hx7Fhc++TSYqMt/xumnFrYkYOJyZ42kIwDm0UDHbqZFiWeX
         mCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4G8UhfmOAU+vf176VW3ixtgHtt4omHWSmMUKQqJYu4I=;
        b=q9W4Cn/p2hyspDYbPt6piTkfpw0yUSL+nr8OaTl1iMy5kSx4atYapcCRXbsl5EDdiJ
         bEFXrZXMWPSsuMPtLznXTXB3sGhaFqn3adK2Jz8MHji7adFk0HS5VR5xEXWjdTuQs3Io
         HT93Efti6rOTGLX+WNcaSGqLT0mFAtqQaqveSS4p5tTJDWl8sEZzOPckEUAyRl9J1kSW
         O/5O5I4S64qVgDgv3RWBrQqt0fFulHgVeK++3fCwdwbDNehcPbkCfxK36FsPeviYS6U0
         pbhVAK++r0/GJsUy7KlJTUApFxJdCtBs2boDnT5tKRRJ/HYSO98i8lgab8gFVnjVbDAX
         4j0A==
X-Gm-Message-State: APjAAAVKTbjTU5W1yaqzezCaz3a7mqV1N8XOn2EMPOBC/rPLpUPbLaDS
        UjiH/jvdoFxKDPmIAtAqgcwn+23q/w5UrQgPkdxghQ==
X-Google-Smtp-Source: APXvYqxTMPGQmp2QxQwSjPnSlD2DfIy461Be7tP5jcA0wNeXj15OTh6X0ZFBtVo8y+wCLVjDeIruFT+9xcgMQuaamL4=
X-Received: by 2002:a2e:b4c4:: with SMTP id r4mr13939072ljm.69.1569880621961;
 Mon, 30 Sep 2019 14:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190929070047.2515-1-wenyang@linux.alibaba.com>
In-Reply-To: <20190929070047.2515-1-wenyang@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Sep 2019 23:56:50 +0200
Message-ID: <CACRpkdY-SnPjocWzoujah6c=Tnj8G7XqBgULXYNwnt6FvED37g@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: rtl8366rb: add missing of_node_put after
 calling of_get_child_by_name
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     xlpang@linux.alibaba.com, zhiche.yy@alibaba-inc.com,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 9:01 AM Wen Yang <wenyang@linux.alibaba.com> wrote:

It's nice to see some Alibaba kernel contributions!

> of_node_put needs to be called when the device node which is got
> from of_get_child_by_name finished using.
> irq_domain_add_linear() also calls of_node_get() to increase refcount,
> so irq_domain will not be affected when it is released.
>
> fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Vivien Didelot <vivien.didelot@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
