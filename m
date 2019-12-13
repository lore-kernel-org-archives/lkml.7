Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF295C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52EE206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rieWzSbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLMKFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:05:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36478 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLMKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:05:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so2000833ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oghGxm/Txk0ydLM4nCCqz7DnsmQdDf+yHTL2M4IdnQ4=;
        b=rieWzSbFKmC8n8c1EKomfpWiGNBNZOamuuF/BIH9a6QstQiu6xHzKvkOPMGxW2R5xk
         /DerBZzH/XnbtYU1ke2XupRADC/0Vsoqo37GYn+Gj0MPr/vK7UOcFrM97kDvIjSH2LVi
         dUALb7ggGS0+mIOsIp3GELyzxEbUMwcsRtaQjFGEm2UPfFhH54QNN3mldjStaUanzGZi
         AvZ9ygknSfvCrhEMaU7ntTNie9HXRapIWOYtCsbNFDXuFRM7H425lV+w5GJ0BhNo3NEU
         qVYteKoU86vXvsm5P/6GB4RclQrKXt2vTTXN0H1j7N9jm1BDBjB97IFkbwzW98F65ErX
         YmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oghGxm/Txk0ydLM4nCCqz7DnsmQdDf+yHTL2M4IdnQ4=;
        b=PZY1ypNtVhAmMNAxMMokXAmdNWhVeKX4Fzu2DzoEqAd/YLJtqFd6Ab3ke735vizmVz
         W7GTM50qcX2eYuRNVjeYEe0cgrSh1wSdUYEpYI16Dj9ovDwXHpcuZf9TDkZ53ejwzVAv
         wZ1fsNoMgmBFIL1FQNQUSelw5XvmG2NjUMoeGksL5vZGy1NDUdRQyMSBI1/JyGN1Am6W
         b4MEI0cwJLMJ48G4yx+u71UzYQ7Dnl+ACbgMe7XZxmk9pVQyQH5lrZmjR9M8Ao8dyM/c
         E0VqXNvqoASRE/0r2WPFgFaSPN00/q3/Y+B9iW/h4Pp8fA3N+xQx3s+yK4jU00F32MgT
         lm+A==
X-Gm-Message-State: APjAAAXamMjyQ6QMMQWsuAVY1/C9dyUpLkTHpvJkMKwHVUDtlJxMdoEL
        d4u0z/azn+rgThi8If3h5UTM6RjwucR5NnDIW2o2DQ==
X-Google-Smtp-Source: APXvYqwRqbc5Uv+MaUhx8941W65wH+aMUFGZmpuTY3+LqoZli2TemQ+jVAOAjbDZ41EX0OqkMjz9VnJj/mMWpj88iLE=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr8822965ljm.233.1576231538948;
 Fri, 13 Dec 2019 02:05:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575514110.git.rahul.tanwar@linux.intel.com> <ba937f271d1a2173828a2325990d62cb36d61595.1575514110.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <ba937f271d1a2173828a2325990d62cb36d61595.1575514110.git.rahul.tanwar@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 11:05:27 +0100
Message-ID: <CACRpkdZnr7JfqTKksOnpTdLq=3g8nfPbeqidJrLu9+cG9ry7Xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: Modify Kconfig to fix linker error
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 4:01 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:

> Fix below linker error
>
>     ld: drivers/pinctrl/pinctrl-equilibrium.o: in function
>     `pinconf_generic_dt_node_to_map_all':
>     pinctrl-equilibrium.c:(.text+0xb): undefined reference
>     to `pinconf_generic_dt_node_to_map'
>
> Caused by below commit
>
>     1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC")
>
> by adding 'depends on OF' in Kconfig driver entry.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>

Patch applied for fixes, thanks!

Linus Walleij
