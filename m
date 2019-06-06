Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA292C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C69B206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M425AF5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfFFTrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:47:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfFFTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:47:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so3099010oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcIBWNKq7rsOKiEN1ZaEM6TKSTC1rUDAvceROHJkKnU=;
        b=M425AF5Q27k8jkeaKLy3GpcG3/THjW3EKKvWd5BFOXOfwvojEUqtEhRXM41XGdkHMb
         h8LU8MGpp5JRP5f/g32xGqlzlKxtbJ1u9xwjgu4Nto8zWLvviGXaKB00286n9L/T4Kox
         EiouMsmFQFmfoT7f64GMWqXE03Ohqvy/QfKEic7ODdh1rUmOXcoGOopizF9CwVrvNn0c
         0z8zEtBu4+9BjYPIlxOhnc63GmhLiXaMMGfu+gGPXSnf9R3XUBVQggmIhg0atpJM6WBB
         /R8fvLI5n11mZVCwWrM53Urn6/S8fYaWeKPZj+Vw4WQklRnIhDwsLMdo+hY6Ym/lt8HY
         LkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcIBWNKq7rsOKiEN1ZaEM6TKSTC1rUDAvceROHJkKnU=;
        b=eiV9vcgN3VRDMDk2wgA0H/L9otsixx22/SFmepJz7hhhUFijv2ATU0BjDhi3+IXgE0
         ZN51IGBi9kl3OZx+xIIOrz4A+tkhj97mFgz008GSVXPpZChoXgq9NM7YdCfNPxJIx4hX
         lwBJuVknrLM/GSsak/wb3bXs+JS1eWZeW009bdq6C+t56dDFqQsgc7dJ3as94bKlpwFx
         smNm7+JziDVG4F7t/nRFnCIKsfJbh7IhRjoi9FX1ceU/EipxQ5YGiCvTldr5vFpyZbKB
         WPtukjzEprmaUbLjmU+CKaHsp2ipdjdllsBcVHu8wBrUJmbksqMo1KiD/XY1ShB+EgGR
         9iCA==
X-Gm-Message-State: APjAAAX2cKQcXDnZKU9zv9D9DzxVkXMQUbyEJiscOE9jX+PjvwRKYHDp
        s4fGkoY4xF3S0u1tc7FPIjtF8yog38eWogUN9vs=
X-Google-Smtp-Source: APXvYqzFpAzVe5kdyBif3vrS3V+GMrD8alJ36+ksEaUmNq0YqsSf3K6qGWZQCFu9O/Xa8RCVUUMMwVMVwimx9IQZ9h4=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr16549424otb.81.1559850425739;
 Thu, 06 Jun 2019 12:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190603094740.12255-1-narmstrong@baylibre.com> <20190603094740.12255-2-narmstrong@baylibre.com>
In-Reply-To: <20190603094740.12255-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:46:54 +0200
Message-ID: <CAFBinCDS6wovEfU+z3bxYq6Kyw-Br+EuBGTdG6sNx4oBW=NBzA@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: meson-g12a-sei510: add 32k clock to
 bluetooth node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:48 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The 32k low power clock is necessary for the bluetooth part of the
> combo module to initialize correctly, simply add the same clock we
> use for the sdio pwrseq.
>
> Fixes: d1c023af1988 ("arm64: dts: meson-g12a-sei510: Add ADC Key and BT support")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the correct fixes tag:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
