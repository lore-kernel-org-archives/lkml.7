Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF13C761A8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70B120679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQ5H57KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbfG2Vm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:42:59 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36249 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388374AbfG2Vm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:42:59 -0400
Received: by mail-lf1-f52.google.com with SMTP id q26so43153530lfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nCAhqsVRTUbfSc3zueaP6/rAmu54qp6S7qtfkPndZw=;
        b=XQ5H57KC2m9zzV1YUZO2/UWUGFWXuv+sLFLOwg3sjsZ6WLSFSMgjzgd3Or7LhL54M2
         bYe1qUnhOKBgSiDnPFf6lV8dAf84PqVI4ee6Xpy83AkPlQDtVFSemPu+rRyjXmwAty+E
         3LFTUHJcG2rDwKZTufp1Mup/u3IMlCyDSlo6szx2MlgadTZzuNsXgb0JEiB1z4kLZh56
         1vyyRdPUD7f25dKVqz7jJrjHA4KWNZm6Wx7lYNaXU+pJbStQRT2i9rI+cRUHGORPQkY7
         83n6/YiPNSQpL+03K9Juot7d6QLspBvmI1FgIZDAf8bwBTMJ6H1NVGCxwYkPu3ivASn7
         pNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nCAhqsVRTUbfSc3zueaP6/rAmu54qp6S7qtfkPndZw=;
        b=uArKVixk4VD3s3r0JdHWmzR8XitLz/qSQfkt1GbwM5pPnxr2NcyYjAsIchS5S1oeM3
         D2BKm3LA9wM8GZleLvB29vIc4nlsYUBz0ONbZfsZcH11r/eVKIglRW8dXgmZUSAaKWwR
         HhSCWvStkqhXWrwqaudSycOoGx7sY9ANJFjQ8zAuaW4f+DRh1fK9ju247b3OzgG5imz0
         1Bg3Ltpk4TeLYg5yt2lxury5uK3fR4vyjiBShrCKLC6tAXUKqk7xxUG/c3WQiQtnuUMq
         K/ihBIzw5zpq5ZQ6MVVPTXFP2SMuUFCufCzVHoFL/0rtrJaTF5/QQHXV6nriNJKKxIA2
         FMnA==
X-Gm-Message-State: APjAAAUcyaNrWUxjw7lct3MvQSzfWYBQsMTGatXKM0YeXbkFl8eabyhJ
        3iP1E7GCMSzza2zd0oWAnrRDvATz7XlGYVvHll9WCw==
X-Google-Smtp-Source: APXvYqwPPJD/EfvWSQiiprO7ycqY+wqwRXmEiafD8nOfeRaXHuKlzj+ngqiBVCA5U0tcxLAepJhz+O+oI8uWKeXtDz0=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr54417470lfc.60.1564436577047;
 Mon, 29 Jul 2019 14:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <1563076436-5338-1-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1563076436-5338-1-git-send-email-zhouyanjie@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 23:42:46 +0200
Message-ID: <CACRpkdb630mbyV8n+6meo6ooEe_Lg+p66CX3PBTm5P78Lc5qJw@mail.gmail.com>
Subject: Re: Ingenic pinctrl patchs.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 8:55 AM Zhou Yanjie <zhouyanjie@zoho.com> wrote:

> Add support for Ingenic JZ4760, JZ4760B, X1000, X1000E and X1500.

All 6 patches applied. Seems very straight-forward thanks for fixing this!

Yours,
Linus Walleij
