Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E173CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EB520883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HUmc6rir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfE0SGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:06:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38253 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:06:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id u199so12419266oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snK6jJsPt2cSi+KLqPDOwYhYAz49h47RS/7FICnk118=;
        b=HUmc6rirKmR1hS/gQsUVm0RGGqPT4N9PmeqPlzvBsEmT/AclV6qMqetS2k+ZqseZt1
         O+Vonuz3IKhAeIac/8ALVXzw3wyEX0O0KXVQr/aS+HZJZcBcA17jb2xhJETkOllXc+Wz
         lzNv6hMZa5n3nvVMipKtUhA6sEdtCOqtcfP9W1yPgc40bJsoseywMbjinhqauVzZzYDe
         2DdtFuaMlbN4WS4utWCYQDwCF20MxmO6klYN0kIEqQldYJlwfqFroerA+UJZGPTxW9d4
         5CVNp7lh14MpD36j0VFTNVHkO/i61eb1Tqq7GSTXPIU2pjympknGZG9RbML3wfZSQsAV
         a4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snK6jJsPt2cSi+KLqPDOwYhYAz49h47RS/7FICnk118=;
        b=XCYW/SoSXixrN8ekAhArGTSGdAr8WQeuV+wKqGMYDRY3MHmqDLosd7TUeDJdvKdVg0
         RQXNYnD/9hm0yiyhPQwdD97JdATstlebuOD866AFB5ZWnoFI/a7rr0QlrA+JffZkjpxK
         I1Gbq2xTKXal2TPnUKDeHbhjxh74J2ToTOgcLhRMWHmdb8aKnIF8bOi0mA8KJb5fBX1n
         zn2o//o5eqMg634FOcFQktWjHJh52Dh5IokIX5wyddfod2dCsAILD82aMt4kmY3IZUyH
         pGTJSHhNwr/dJU9mvNOO9UwJbParGMZdOi/oFJCUv4BvBDRuiggqNdE+CWtOyeEmGm90
         sRPw==
X-Gm-Message-State: APjAAAXd0eA2CdrICVwrTH5YIsCQ6JVj4dnYeE+vgg5t7pFQTRHthBRi
        WjQxYuMFkbRlVG4krNVMZsJcXLSJCLq0tVhwesI=
X-Google-Smtp-Source: APXvYqx9KJ2jcVtyv9sJYJEyKAm3S24vaMJ0KK9SArvolrcTJopXP7wsbVLGJgnh9WHreFlM6dw6JEOu0onvKFlRxFE=
X-Received: by 2002:aca:f144:: with SMTP id p65mr141486oih.47.1558980376467;
 Mon, 27 May 2019 11:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-3-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:06:05 +0200
Message-ID: <CAFBinCArHofRSpA+2Ti1gWzBPeOV8R9H-=gxkm9xFiiBt+4Vbg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ARM: dts: meson6-atv1200: update with SPDX
 Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
