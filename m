Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C621D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia8HRhn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfJDVf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:35:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43977 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:35:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so5420101lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYthbBkktNxFNhA79P5qBlET/NRolFGJmUsKm1pDpdU=;
        b=ia8HRhn9/1Kb63Pb1AAPb/dgwBMU5zFZ/1YLS7IUAE9m0YIQWEO2j/RrZdK3RxeSD3
         TtHn7kbGsN7lGIORGHe0PYGozFS6gfKxBMW+UDACqZ7EUlIQIzSIXchUtcZU6uHJcZaz
         3cgHGwnkSZjHnecmmiGhql926ZgQbOIo9K2f/DOZuljvPTdYuNlEV91+UpJOY1IsNaPJ
         mjkuLx7dgkvxGiI6+h4lVXWgsv20J/KWizv0ZPcWW9Hc8BxfYLUvBFDSbYt2VjozwvmW
         X92sfwjd0K+/H3d0P+kHqRwGSJP4UaLdS1MMPfwFy2Fu7iCnWuHc2XOk0zK9OXRfe735
         WXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYthbBkktNxFNhA79P5qBlET/NRolFGJmUsKm1pDpdU=;
        b=ASQn4C43zK3LS/9m3OEIWZ48bwAIIMCytNL/9kI/n4XLW6BVjOWM8Umg/AcSmm6/qb
         2F0OM98+9jLX/52vcXE3T/Jzh7YIpDh2/7sp3NH1SBz2+AYKwZh8yHSLC4vZt1Q7gD7d
         Hai5LloRp00dz7yjRuUqi9+Tednx1Fh9arLmwNT0WDFLJKXUzb93KXzkjrrb607ySWhE
         /8Vzk9wxF55Uv86RrwlgDoXVhQrFrprLeG5YTys0XAzsEy/0BFFsMWZbWFBDR+NzWT4y
         mFZqLcJVtxNoBny4HcaLFfH4RGzz0XV7kjSPwWahgCiq6STkEM8U5pj2cDBwfaLxIQXx
         juRQ==
X-Gm-Message-State: APjAAAV/IQ45nbnKrOUc7um3wyQAAlAb0de8FIm2SWNCjtFbdGmRPgKE
        y5MCHMvOPInuQ6uV6uLAwY5qExvlV0+4FR4NSevbEw==
X-Google-Smtp-Source: APXvYqze4xi7TbiTueWqhSS4nrOSZaQhkR1K84HJxk9c9uMTj1SYrkWkL0PxrWyDOmIY4NQ2Sl8HEDV0XpI2eV2MksE=
X-Received: by 2002:ac2:46ee:: with SMTP id q14mr9407136lfo.152.1570224954613;
 Fri, 04 Oct 2019 14:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569572448.git.baolin.wang@linaro.org> <e991666ead56cac30a7ef9cec85e802b57d47458.1569572448.git.baolin.wang@linaro.org>
In-Reply-To: <e991666ead56cac30a7ef9cec85e802b57d47458.1569572448.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:35:43 +0200
Message-ID: <CACRpkdbVP9MsNZGJNEw3gYvg4bhf75gh6WKDPFcbKK2eQuc_5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwspinlock: u8500_hsem: Change to use devm_platform_ioremap_resource()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 10:28 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together, which can simpify the code.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
