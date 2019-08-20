Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D343C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368BA22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="n+cxQw3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfHTUcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:32:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37066 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbfHTUcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:32:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so6318033otq.4;
        Tue, 20 Aug 2019 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4HEgBYUNMjs7TCGrEWBfpxm+fwdeijgHXxiJ5I4qeg=;
        b=n+cxQw3r9VdoH9z0HdR0eilm17osw9+QEpFNwmZyyZFQyLtKBjk5ogmKv1iVsFoxFs
         UXgLHSU19Xa67oICY4zD7N27i4et6wEO1NrslqYR9VlQ4oq6UFjPSsAWTMUkrCNGjnD/
         0xQYZXJvbb3wgElE6Cb2YXgKtRwBnOX9gLFFEBu2t0ePNg8ysube6AjuGP3wTjq8RPyA
         vUj5AvC4fySAKFJ0gJXAXdZN69OkaMqoj7TAZpVRHsT9/e37iXrJ7NggT1ZknqeYmDUk
         vaIAe4lJcC1bISZQCqGRRH8putI5R60egJIKazx3OjZpsCCgEBBGfwI2YtXcD4JJ6fVd
         UaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4HEgBYUNMjs7TCGrEWBfpxm+fwdeijgHXxiJ5I4qeg=;
        b=ukSx25PHkQtmuCDuzRa686xoxHEtDWGD5FmsUXDKsN3rMbHokqlVWiq+T0w32eGVYb
         XhySEjGUAd+fyT1QW97Mv7J8+EyK7hSfq+K6imbgE1CaSPVCbTs3NBKSk4RvSXzPZkpH
         sRFHJRpv9Kg6t6L5sVtSq7Fl6PSPG90IsnCDz1+CHoU68bp3a81S6EXc9kMSmzmoD2Nd
         UFBK04AoVi3E0Utx7m1jOAI6G4Bc3npUdDRsMJqsB2DTQ7yy1Sej1JexHTjwwpv+kYft
         OCSw2zzj6KtVooWeicKO1sTa1psddjBbz0Ciq9u3R63Q+8pchShWqVWadsLjZvA7hIMc
         6kqw==
X-Gm-Message-State: APjAAAX2YR0N17Cy4VrSyIuXeqql2EUNQERygozNE7NpSCGnFI/u/uQt
        LwSzQVHawMLcRqJufCVoP/2ipopmYf0h2KOW+vQ=
X-Google-Smtp-Source: APXvYqxlvVNpQ+FUnoPDePRzlt/lxOoZg375AfFU3rjHLbAwedqV9QU2sqj3xfsgHWhpAmkjk6c5OkDmuYet9+FYRHE=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr17408901otj.96.1566333151468;
 Tue, 20 Aug 2019 13:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-12-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-12-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:32:20 +0200
Message-ID: <CAFBinCBWFNJNAWdeZ2LfEJA-MVpSf-A5SrLZEx+0z_P+-iBFDg@mail.gmail.com>
Subject: Re: [PATCH 11/14] arm64: dts: meson-g12a-x96-max: fix compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-g12a-x96-max.dt.yaml: /: compatible: ['amediatech,x96-max', 'amlogic,u200', 'amlogic,g12a'] is not valid under any of the given schemas
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> -       compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
> +       compatible = "amediatech,x96-max", "amlogic,g12a";
only partially related: I wonder if we should add a s905x2 compatible
string here and to the .dts filename (just like we separate the GXL
variants s905x, s905d, s905w, ...)
