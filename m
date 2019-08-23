Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA735C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70C4233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnqmvTiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbfHWI01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:26:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42499 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfHWI01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:26:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so8065629ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAjMP4xmuyulOMV5YHvxWXlnTiDG+r9Si9f0jb+2WDc=;
        b=wnqmvTiQ4ZhkeUMMGa8l+1/vKLWR57cpy51RNA8D86BswIXgpaC66WZNEnz+gaAtEd
         yaF5lSTARq14IcDa5Pb7Im1swP5IFnrdkL+zBM8oXP3mSJ0sjyWSOc5tP5EUjnjIUqvE
         yXIIsrDNXL/poNk6ChLnNmVn3TZxuhlh/UgCm/+Z0A5ASVSF9fyBygW85hnKhlRIOy7L
         yDSegJk+yU5y+DmcU3onPXtkgt0fieVYFJMNJyBTNSKmhjVeghLmDd1/CPqCOWIlbXnI
         VYie58F4+bV8/Alw7sqLSe/Bhl2Zrg08cX9CK0YNfr1hMdI6fYIJWa3/6HSN4vqfu6He
         pkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAjMP4xmuyulOMV5YHvxWXlnTiDG+r9Si9f0jb+2WDc=;
        b=ejo2f0gF8C9E/rynkGdU2WL/u3g2+Rdbdw07ywFIw5+yokQJ+mb2P66Oe6Bhdig/j8
         a8b+szee8Xo2G828WK+F11aGsfYy3OCiLn3jmmsB6lUkbU7yOIscg40NY04QFg3+F98r
         A2d16QdOvdQYy+/kDkVXbd85gexIjhEoixe8vTLW0JDzjGpTzFeEf5UolMvFzOF/sa66
         0J7GEFYFxIpiJtPZCr15cCw9ROZrJVBPQapJi5ayBSgwyJ75K7RTN3GFhiAcpGqj+K0P
         VU2hjQAVfym5UhEqvtzkU4gHZFzSsvbw9HM8PUEuGs1u7hfiAggz9f0yRLrM+S2/dpR0
         a9cQ==
X-Gm-Message-State: APjAAAWSbG47N597Kz1NzLIrINCChaYPmg98WYDuIIZ8CR6rZCmMsOy0
        I/1+KRddnNmlWwg+/bXKQhN7JFKSaexjpBoLPWWBhA==
X-Google-Smtp-Source: APXvYqyhTMDzE6GdzWuXk5RzTjGHl0wxLPmcdtUjxeFGV4fqNcsMAPshNok8qNzvW4m2O1CDv3ny2IJQx10PdbaavvE=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr2217761ljm.108.1566548785065;
 Fri, 23 Aug 2019 01:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190819080028.13091-1-geert@linux-m68k.org>
In-Reply-To: <20190819080028.13091-1-geert@linux-m68k.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 10:26:13 +0200
Message-ID: <CACRpkdb66GWnW6j=G==vAP_79ePyVCL=dHwcM2ui-GRC58eCjg@mail.gmail.com>
Subject: Re: [PATCH] soc: ixp4xx: Protect IXP4xx SoC drivers by ARCH_IXP4XX || COMPILE_TEST
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 10:46 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> The move of the IXP4xx SoC drivers exposed their config options on all
> platforms.
>
> Fix this by wrapping them inside an ARCH_IXP4XX or COMPILE_TEST block.
>
> Fixes: fcf2d8978cd538a5 ("ARM: ixp4xx: Move NPE and QMGR to drivers/soc")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Rebased on top of commit ec8f24b7faaf3d47 ("treewide: Add SPDX
>     license identifier - Makefile/Kconfig").

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Do you want me to also take care of sending this into the ARM SoC tree?

Yours,
Linus Walleij
