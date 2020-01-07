Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E6C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5723207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzsDCX30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgAGMBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:01:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42793 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:01:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so40083297ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLtNFMYZWtPhEKvur4VjuvVAPi0N1wL36Q6jCtiHfeE=;
        b=kzsDCX30f0Ec0JSPVS+j5bCMaV1MEdQdwUvAhfFWwLBYywuqsohIZB/CwqFxo2+Wpd
         xgSPZNnspuxr1JNmr9CTelVTIWd2tj//1wDsUbLSuMFvQWHW+kpfp5MTO0mKFK+Nd6xc
         N+mQPHlQDj8xdAFTBbpJS5dX0nRK5WuOqwauMc8zuJ+Q0Lkik9401WV07qylSSehTbb3
         53EkNPcDR6UzG8NwsunjUL2rrhSUvGL8fofUa1O0ZNw3nApGoUDzETIl+1ohMWhrsR0W
         4mXZE5hT/InAifSSYrra61Lm6c2GabDFSl+9stC08onKuQA5NEiaK+iOYtzd80/5Z9r4
         T0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLtNFMYZWtPhEKvur4VjuvVAPi0N1wL36Q6jCtiHfeE=;
        b=oenER8NMIPZC8hfZqP+nVywcgU6OciDVAWzzK1XLN7bDvaJATJO9nv0LwvymAHjxUQ
         /rrwLtRGHwgH8aICHq+EbkC19bYPMtJbq9wIkOZNnsc673XG7w2RVkijimOyAfugJb62
         SBLsORRu5adSJbOOCjEVeTo6WLTf1SffXGx3rOXTBVfCU30CYxMuPLI7Kn8cmJqGUwU+
         O+3UkFIx/fm+9MxthdzUIGZ7HvCHpad2AKauAFqdUssRBy+ZFtSm79fzKpTP6BC2C2RD
         iPZp/hV4Sdg6n9jgALDWdFpXkbUst/JKz/Ft+gEAI6BYrR+XN33ekwanghQPE+7YZw6b
         SD+g==
X-Gm-Message-State: APjAAAXuRl3cD+SDHeO1HQOEumY115AczJInyG2uWLS58Hh5gRXql9V9
        tIB5hDMrKEUseB1D9Y71+AoPUUZctN75plQZ5kbnrQ==
X-Google-Smtp-Source: APXvYqxYVYIleP/nRgbENo3Yfgwk8OenCerefUQZlVEJcsgDGSH/BBARur4Ym4DwvHBVMCf6Xow3cwPKUVUV93X9mVk=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr61458408ljj.191.1578398500619;
 Tue, 07 Jan 2020 04:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20191226191425.3797490-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20191226191425.3797490-1-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 13:01:29 +0100
Message-ID: <CACRpkdZ3uc30Efwe_2YtNJBK4FTt+dWLbY3pnh1uWSPwGu_-SQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: meson8b: add the GPIOH pinmux settings
 for ETH_RXD{2,3}
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 8:14 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> GPIOH_5 and GPIOH_6 can have two Ethernet related functions:
> - GPIOH_5 can be ETH_TXD1 or ETH_RXD3
> - GPIOH_6 can be ETH_TXD0 or ETH_RXD2
>
> Add the bits for eth_rxd3_h and eth_rxd2_h so the ETH_RXD function can
> be disabled when using the ETH_TXD function of GPIOH_{5,6}. No problem
> was observed so far, but in theory this could lead to two different
> signals being routed to the same pad (which could break Ethernet).
>
> These settings were found in the public "Amlogic Ethernet controller
> user guide":
> http://openlinux.amlogic.com/@api/deki/files/75/=Amlogic_Ethenet_controller_user_Guide.pdf
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied with Neil's review tag.

Yours,
Linus Walleij
