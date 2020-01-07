Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905AAC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611972080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0GsPYhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgAGKn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:43:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46894 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgAGKn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:43:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id f15so38493912lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ij45+y4tQbjswuhc/ASM64hxiBChi1v4xQfYvXcYB6s=;
        b=H0GsPYhVqTjf0ta9+KsTEWOsl8hYTozJg22rau4LHG6gVZDFkftjFg6m6ivAvrew9+
         w6SQ9vWlurV7I7uMUGuJ2MFZWAvwEjc0g9tesLRrgHOIueQ89kWtwxkX2EMeuyhEm4Bc
         ev6hfj2CYGkr6rEZvPPxaufcm3fKBink56/CEXq2AFrAGsbf5O6MxZeWQe8+9iwLYMHv
         8W9MebwA3kDNbKrwIt8wcDAg913dOlEX1+9Mxk0ZSY5pFwl3vy0tECVjQvWSQruqxgWT
         C/TKRJ7priMWYWtbANZnP1AkjqGSZvydwd87XQ9ucfwBtsxPtmJD1GQtgnp+iAJCDd4z
         EqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ij45+y4tQbjswuhc/ASM64hxiBChi1v4xQfYvXcYB6s=;
        b=RRFJY5Qxzp6LnO67FxdOg2qzCeZ3lxj0HNeIHlB3EjjX0Ur3ei9VEMGbJgJCu1HJTG
         eqtjxAYOewi6v+lgNCvzovTxHhQYDUy3S0u7Vq5+YjcFpGVnMw9wLeCfbUy9QgVXo0eI
         3MThl7RKVCfIVu41nJUgZB+05dtrRbz/Qd3Y0fOGJtstPp+kWb7LqGDj4d7PxwmAlYST
         vLe/NsEaWLBfxmGC6a/HirEvv5kl0B6jsCLyekWt3qLwIzE0/NspDE9y7XQmHB+5Kvz6
         6JHf8cEdFwBxj5pbldlSXdX93g/5+QD4ijFIoyaMPSiSlzr5Ax8dOYOyD/ZtmNjmmB1u
         nVCg==
X-Gm-Message-State: APjAAAU3k+QL72wE67xOtG1q9dT1srOYiGRmKSV/iJknxVR1kVafmHgY
        mNJ9jC6r2Ey1RTL5GFFOClDlTOPNGOlNmr+1wWdIUA==
X-Google-Smtp-Source: APXvYqz+jQpx/la/O2K0/budtRMX6KFmWmOMeG9QERQ6JtTLWAO+vG67nfJvEFSWtJY427WX0m7HLcUZUjplSCki6YQ=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr58271999lfi.93.1578393835746;
 Tue, 07 Jan 2020 02:43:55 -0800 (PST)
MIME-Version: 1.0
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr> <1577864614-5543-9-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1577864614-5543-9-git-send-email-Julia.Lawall@inria.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:43:44 +0100
Message-ID: <CACRpkdYQfiuziMyu+oCyh-8wmgpzVY7V5+CPNqoSLm3+ZEFmVA@mail.gmail.com>
Subject: Re: [PATCH 08/16] pinctrl: ssbi-mpp: constify copied structure
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Andy Gross <agross@kernel.org>, kernel-janitors@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 1, 2020 at 9:20 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:

> The pm8xxx_pinctrl_desc structure is only copied into another structure,
> so make it const.
>
> The opportunity for this change was found using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

That's a pretty cool semantic check finding things like this!

Patch applied.

Yours,
Linus Walleij
