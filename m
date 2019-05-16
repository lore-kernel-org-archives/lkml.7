Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D79BC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8FC20645
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fm2+0aie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEPLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:20:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33862 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:20:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so2775066ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRLI+MRqPWEOi6+o0bitHVCl86C8o1gF6OGgfhSKZS0=;
        b=fm2+0aieraFIzy3CJAw7U/aHEhKeSvaIaVGCGnbl3r8p0fCdl8xR4qJ7SKMk93a3U+
         Mx05fbk1+mevXVRsvcqJWcyNWwoCkWRS6L8BLaSRBAF8lrSvqqO96bUr0JyKAeHPerbt
         hO2aMUcN91gYzMaAlkG4FmDWEI8Ah1TPy6iLuNKgBEpMlKZ9KNpMIo9cB4Djq0nlttJP
         CMBShp8NJrdTlQSYXGoDXgoRLeXqGS16vveCHBpAtS2YJS458XcUeygNvyJbyzBGRoUP
         4jKyZs0gOHomGQS0cD2nSCZuOty7CtU6jsQNe0hFzixUBmPcgqzNEIP5GPr1Uear26xV
         7pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRLI+MRqPWEOi6+o0bitHVCl86C8o1gF6OGgfhSKZS0=;
        b=kTROcp5BbgGw1JHNZGXxZPqm+UyFVurjc/78k2wWDgsEwxCD62Cy3e4YP4MSiNrUli
         qGu/9bdYT1FiJ+0qoAOpKKrYs1CAvXfDzJFgpsVgEarMgP4+aBqeYuxj6NCgcwVz/GgL
         z8IxL2MTP1Z6rQIUWQ+dyVUATDxAtSnvkSYoR4QaZampxq76xRm8TQraO0QKpRJA2DLJ
         ifNsM2EuGg9z79+pvuT6Ez42JzYarOgQATaER06qQxNyBVaSF9Vm97JgfitcomGok4j7
         Wx88NijNZH1tE2QONLLCQQrIs4BdVzPpR1HMwludTPBOaSLPqbLfAcfqjqJWsnbjYMEU
         HuXg==
X-Gm-Message-State: APjAAAXqgex5zphyDtjN7Gfof7VArOKwcCjjLRTQ+Vw5jiNZC9AC6dZt
        pE6MfW3PW6IkdL7eI+cXj4ldTf29OmrbE3k/Pji+8A==
X-Google-Smtp-Source: APXvYqxoArGUQbAGr63yz6qrvWdCjECvzmeE+zyvkueJJAumhxuqD6UH+z3ce8w6hLlTFJ9RXibf6Pkh8utF9aNv1Wg=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr8654844ljw.153.1558005650599;
 Thu, 16 May 2019 04:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <1555309442-16039-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1555309442-16039-1-git-send-email-wen.yang99@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 13:20:39 +0200
Message-ID: <CACRpkdYghGih+oxXwNDMLVZBAd36xJWoJR76JDycycczRPuGHQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: rockchip: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wang.yi59@zte.com.cn, Heiko Stuebner <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 8:23 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/pinctrl/pinctrl-rockchip.c:3221:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3196, but without a corresponding object release within this function.
> ./drivers/pinctrl/pinctrl-rockchip.c:3223:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3196, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Patch applied.

Yours,
Linus Walleij
