Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32BBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD39217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxRmyWhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKNiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:38:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46683 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKNiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:38:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so5519651ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guwFbviI2kgOJWrleQr6pPYHSI18jLv9R8pRD3jVt3A=;
        b=AxRmyWhco4rYLE3gM+8AcSny/EGR52StLf9nTVCCtVZU9j0aOJiYz4EdwZpwNGoAic
         2WLO+fOLmdbwySJ3sR4AJ6fgAo34rn6CmNf9uGqdbZJtihkF13Q1I2RVSymKMPwqgm2X
         38yXMwSt2PcIBrkX4ggWbH29ax5UcnXIULDC5XEGw3cRNTdJY4dGU9TeJTlor2AXQ1x0
         e0tkr33XvVdnk8SEvBgueSRDTywEq4tLmNbpaTOeA8o3cugA/3jEOHllwDQP2EoFek4M
         xK4jbyGLxqptz6Yk3uAFLFnwnyx3VA4OpVLnSw8YTM65fDaaxdByJc0otCfUieXE84XH
         lIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guwFbviI2kgOJWrleQr6pPYHSI18jLv9R8pRD3jVt3A=;
        b=HTRWbo+r2KZlr7POaErJmaEr3Rbvq7BeF79YsRsP1s6yoPOeTfY5id83c5wnfutvgy
         Fd02epFCo94OpMzKQ7RiXvisV2PbflLVYaA5CgfoVnfipEixf59hDrxKxu5tDSev0Umz
         I8cpfwa2V/THRMpjdXa6mLxosieNkm3P5O+w8A5Zc16XkSDYNA3uwq77n/RYxqbUZdOv
         IcwIhGJ/vH4dJ6DufFZXTPsQ2NhoPTV1vxF+YFx26xz1lJydCYwGLBPSNmvRZad5ERQB
         NuVu+VKTx95xUn1BoXvXYE3loSjI+1EVhdfnQCyD8zf81n14Bwbv+PvZj6dZk3VtM+VQ
         p7CQ==
X-Gm-Message-State: APjAAAU5oBhYX0ZHrlpOVLeBbNA1LrBiWy54pIx1RbF6d+kvnMwICwxW
        q8GFGPsTwgar4LZxUyfdKTK9tQAlNk/nl9bmO3sK9A==
X-Google-Smtp-Source: APXvYqw7+pz//IS1LwqWgHRPmiDxjce+6Nw4t6NTkBQVijAU5nXCugCITtGbiRQ1vzy06IVZVjOKt2ewjkEU+JdRep0=
X-Received: by 2002:a2e:9a46:: with SMTP id k6mr26275139ljj.119.1554989896082;
 Thu, 11 Apr 2019 06:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190409195945.20725-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190409195945.20725-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:38:04 +0200
Message-ID: <CACRpkdYCBZ66nvsO5r0w45WaS8ggyuY8PG5v6RgqRXKYGKWQvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: ab3100: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 9:59 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The ab3100 has a 48bit counter running at 65536 Hz (despite one of the
> comment). The max value is then (2^48 - 1)/2^16 == 2^32 - 1.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Ah, sweet.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
