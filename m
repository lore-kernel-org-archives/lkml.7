Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20213C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29C3206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGW6I8SL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfDWKxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:53:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34092 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfDWKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:53:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id h5so11387781lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dm0VsNuXtWaNq7ax6YiLsGrK/V6ALwGWhvC/p/yldeQ=;
        b=xGW6I8SLppPprtIGaTLcbEV+AlP6ePI7QoAYOg1ibgPujKzem3fZ+yRyt7gcgyxZnF
         2yRxJawQZaK68b1LVsWRSxlE3JWN3FUHSIE3w5mYSTZjRy3aCECeZznKnv1ZYyA3c6pO
         HWjwv+DBO48MZ8qaGoS9C9cc4BplA7XW4k3Ivfxwy5guyBwTSb5v7as5d3qyB20YOGuu
         xKF+2w9fXa6QLZnz18cxW+bbSkCHAxs8f86zrqJzELOrLuzBIrjO3NcNOwLex6wvMYc4
         1aDzysiGATSij7NQNZvjACho1ewOiIlbb1ZSjWhLidzF0XNL38Ok8QePO0j7VJMwPalt
         gBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dm0VsNuXtWaNq7ax6YiLsGrK/V6ALwGWhvC/p/yldeQ=;
        b=S/i6YmBi8zhwcl3lGdz04xbyxPF+JAVXPxHRJom1oPvZAlVau9frZhkPYI+7F4KCdS
         rHUSHqrQl9q/H8jgjvzh6Ro7XVBrErPub/VeRDhpopDAcsQwk8njPbqE9xfMUK5BdVtS
         Xzjojb4CyarZJh3/KVn0RrxqVxsUJKr2XAGe6sLfi3tT939Mn2bRyyfseJKG7OPpSkWp
         60ZdjG1yDEEncJ5e+1QnD1VYKhD3COX9+3LB99zkGJ92wfPKqpWCPavISKQfg8bO/8DE
         IxXm3FbfvCozsyoldvX1AOls4Z854THLuGrutRJNNOb+gPVGxe8mCQJH49VZJpTikk8q
         sCBg==
X-Gm-Message-State: APjAAAWto8C2lro+v08IUCKaUP19in+gbddmOJkzh20N4xPKpk41bkTS
        U/Zi9dMkaT+pwvKZdDrkxqsvb+Xlc2QWPWIqFnCtgEOu
X-Google-Smtp-Source: APXvYqy5TWCfEQM/8ZLFBA7gOvgdpENo9ofonlBC3ai6xxUKsFVLEXuLaW9+5dQtQOJODZYUBMNc21H4p8k5YVqbTuQ=
X-Received: by 2002:a19:f001:: with SMTP id p1mr14368867lfc.27.1556016830067;
 Tue, 23 Apr 2019 03:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn> <1555048943-39589-6-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1555048943-39589-6-git-send-email-wen.yang99@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:53:38 +0200
Message-ID: <CACRpkdZiaTq_uo7=qKkwXy+yuahJjUxs4wVP=UJwOGQ=jHPe=Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: zte: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wang.yi59@zte.com.cn, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:01 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/pinctrl/zte/pinctrl-zx.c:415:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:422:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:436:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:444:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:448:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
