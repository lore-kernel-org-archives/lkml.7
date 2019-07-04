Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A6EC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE6C21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1zYiDtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfGDOHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:07:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43054 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfGDOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:07:14 -0400
Received: by mail-vs1-f67.google.com with SMTP id j26so2026076vsn.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P90kgH7q9sXvK86t1MZ4NbDsLn806eYSQE5PzlGAARc=;
        b=j1zYiDtki+YMl3ZvtZfvAuXTVlnDEStPBOtdkF9p0fPM6M7w/NBp1I1IRhHkSlnwyV
         GNTq9Em5g0gy+EkPxBhdvgbjqiI8YanKTJQqDEHlcKzUkIAUIiHyFJmSJNhES7QrQRX1
         j+5NDsgt/HY91cb34ryr7d1jgY3YDBZ+d1HElKoIikbOhI4KXWXVdlgP718Ig/4ROk9t
         iK/9AZib5cCpism8EIWqxizf4z6obLgGkbMtipU8ltVCVXU++1jDeGcvTBBAd7vNF9xm
         yQGRZsX2IXTLUilJe40E2WELAq4UufVd32hJH5tlAkMWNJGRuS3qM2Xg8ZaRCxL9PYIL
         oiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P90kgH7q9sXvK86t1MZ4NbDsLn806eYSQE5PzlGAARc=;
        b=Cs8dm8fysttLGb7bRBsDoLYvq7sMx3nAQAR+Oz7c30sHOYCb23UVDskpf6YJdINAPo
         15dg0/JtIXkj/rdbVS2l4sQqFA013BfpYlK45qBMZO/wwE8STcTgfxCItpsHjgm5bIB2
         biiNCZxpBYCNH2CnWBWL/P5I9VbGigHbwuEtp3l7lg1fLNA2ZFXUM/IJVLfeIvUZ42a4
         CbfOdaoOyp7Jzg1/2465HOi2MevRtAjDJm0R6CM30hrN0nxef3Q9mZfeb1fovuIIvcYS
         tBWGf5D6Gjea+orKiNP6AFaIMQzR5dBqn0LQJbcKwsRikGiOcgXDzRTjlzqVKE4FG7iO
         OEkw==
X-Gm-Message-State: APjAAAXHToMoHiku3eZWKq3uXEBsGmMWDts0EaQjf7JUXYPofDGvZc2w
        VbmcAk/NCaCJokj3UT/N/2deVpLo5ighdI00AxiUmQ==
X-Google-Smtp-Source: APXvYqxEoMd69cp5VHkgPtoEdfoRftzObUi4NGy1EBTWFUhvcqSK1+G87cS5PjbAiMBLFILHt22+c+yDiA4fc0F9Iao=
X-Received: by 2002:a67:7fd8:: with SMTP id a207mr21712067vsd.85.1562249233840;
 Thu, 04 Jul 2019 07:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190703170150.32548-1-efremov@linux.com>
In-Reply-To: <20190703170150.32548-1-efremov@linux.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Jul 2019 15:07:22 +0100
Message-ID: <CACvgo52N5v07qA_afJfw7vo1X6_Gt4cGqBZn3eBzQtokndjWxA@mail.gmail.com>
Subject: Re: [PATCH] drm/client: remove the exporting of drm_client_close
To:     Denis Efremov <efremov@linux.com>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 at 08:27, Denis Efremov <efremov@linux.com> wrote:
>
> The function drm_client_close is declared as static and marked as
> EXPORT_SYMBOL. It's a bit confusing for an internal function to be
> exported. The area of visibility for such function is its .c file
> and all other modules. Other *.c files of the same module can't use it,
> despite all other modules can. Relying on the fact that this is the
> internal function and it's not a crucial part of the API, the patch
> removes the EXPORT_SYMBOL marking of drm_client_close.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Nice one:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Out of curiosity: Did you use some tool to spot this?

-Emil
