Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DA4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E7320674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7sE7Sz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfDWJCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:02:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40178 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:02:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so12764770ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9N7UGhQON+gI/ng6qZFxfvVySNzQpvfR8FPw13NHic=;
        b=r7sE7Sz1rL6BxTyln/k6U8+Iyv05Of1hQeD2psM1A/HRVlJLhfuv66Ag33tOrLEebT
         Z896v/cQCby49422KYIqJExzffv5des+dthVJLhxOP6s6Li3DGgB2svSzvhhmrSWkduc
         oY3POUUkjkl1wtuN6zLBgt40lgKZe9dit5XeCznjDHm8GwXdbzCGDNsDCQHv6WbFg0VO
         eY47GmzEpyHSShlwRzs/j5J6d92LuP83BK1OlPIxuaaWlPqbCxVoiB37B9L/uxymrhq/
         rHGmReQwf67N1993884WcKGAAnZDmOA582kL+KHNwLePJwnBFxfYect201SuqzZgq2dl
         IAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9N7UGhQON+gI/ng6qZFxfvVySNzQpvfR8FPw13NHic=;
        b=WOsTqI41quZ3+BbHgduEhoJ0M0ogNvJGXplXoLrcFu1b0xUkR5e2vJgFOogpJ/vSHw
         iOsVblSdACeOl7XjsZ5+eNMZfTe6g0MEeHpIXp0qaF2F8XyJ6N0SPkEn5ZJeAs3OUbCG
         TI37Tw+OY17zKwDzMMrXkNfp7rpmVv6G0be5tNf2MKJ7Tpju4aCWsy31UXmds7Y0Hi5G
         P8VQ9FCk3sA5UdPQcjBoA8yE9ws9UT3xGdVpwUIozIHCb0clxHvVyvtUlNiIwJ+f+hoG
         29yw4xkPCPOLQ4UjiEws+fEb/GNPgFuJM7vBrusmwmVeTfqJHZC3x/4NmaPBeYYBJs8F
         hYag==
X-Gm-Message-State: APjAAAWuwqkjcs2dgDiBkKrDpMShGwKrnbGb7a4FwNRCcYpMKNE4byhp
        Gwb+EhASLOw1EyNVDgBxmqdHZgDOMRE2VBz6yFaF9Q==
X-Google-Smtp-Source: APXvYqzkmNB5nal0MNbHFzCH0XLgE+MtICgH4oU8aB9EsPs0vW+c3zIdDRTKwE0XuR9Uq1UWt7oxtqRlppi/HYEDRFQ=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr12784869ljh.135.1556010135246;
 Tue, 23 Apr 2019 02:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn> <1555048943-39589-4-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1555048943-39589-4-git-send-email-wen.yang99@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 11:02:03 +0200
Message-ID: <CACRpkdY1Mjg8aL0i5rgrUBpnbhc5sMSsumgogRmSMgSWDvEkoA@mail.gmail.com>
Subject: Re: [PATCH 3/5] pinctrl: st: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wang.yi59@zte.com.cn, Patrice Chotard <patrice.chotard@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:01 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_get_child_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/pinctrl/pinctrl-st.c:1188:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.
> ./drivers/pinctrl/pinctrl-st.c:1188:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.
> ./drivers/pinctrl/pinctrl-st.c:1199:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.
> ./drivers/pinctrl/pinctrl-st.c:1199:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1175, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)

Patch applied with Patrice's review tag.

Yours,
Linus Walleij
