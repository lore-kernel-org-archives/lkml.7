Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F94C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296F12087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMcZPKFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfHAJxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:53:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36233 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfHAJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:53:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so68584756edq.3;
        Thu, 01 Aug 2019 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YRN2OUlhSIH5t8le2UO3cRwzUnZ68t+hUODYNupj1qw=;
        b=qMcZPKFUVR2q6PzZuuBNlL9ItDFJllh5h8g018vL9HUQNz9fQBd5UTLJLbxjIdX75k
         Y18iRECfSkDvEx1nMM33SqLzY349VJ+KgKfbAvgBdnp1Vb/07G6EYNiyzsetOrnuDfFu
         JAXYwq64QNF1LZCon55E2L1fhoY6nJb7bP+D6axAVp5nFahfYfust+P96FeyYKeyUkS8
         K9OMj4IxcwIfpsbxSg+/rYOjq+GfrxhxmwC+9woYgZTHD6JQO+opKoB+qweEakMefpv9
         +CixOQdm+6wUCeFirYBn1leSxiPOPKtSAvG0ZAQMZAIC9dBsMqXRPbP4RqOK4DqcNXyo
         h44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YRN2OUlhSIH5t8le2UO3cRwzUnZ68t+hUODYNupj1qw=;
        b=ekeORjxoqGEVDpOxbUSZ25JNxsyFMAjG0HHD4oMy20n4gqf5w4kEYIGiiEkIuj+lkZ
         xrPa5EreUhgcy3Oj1SOKLgqkw1u6ySHGpO3xiLenGDM4uCvrew9Ryr5cfLs7EObwo5YF
         Vz/P0jHy1iy69CBhDXZzDLU2YytW5L1clXXlzAQQ12QwrFZNFcUhwK/T9mDujbQHerNb
         wSuNvqEBkabqBUWHcXjFDSRxfA0WNkammteJHZBq3p8rBbl6TQHRW06a1UQ2DQZQIC+0
         BtzfiLlgybxQeotFpF89es7IHpaYvwcU24Enx/fA3GhLoUbibUt7ww6dC/PVEw23RHJk
         ag/w==
X-Gm-Message-State: APjAAAWZrUXoPfvjkCd/PkqYkL0L+SLph677CvfvkRdLykWo+p8N3xgh
        Tq0JwQYXGcuqI2YNmLTq/vCHMfAed+kn7NemX2E=
X-Google-Smtp-Source: APXvYqyFlIQKAjAyxbHE5Dp5bGqGCqwVaR9Y9OO8nksmdMuB35qihbsw8phI/+ui/ecXqoRPH7DUlr+phrkZ8HSY2c4=
X-Received: by 2002:a50:ad0c:: with SMTP id y12mr110175692edc.25.1564653217261;
 Thu, 01 Aug 2019 02:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 1 Aug 2019 17:53:26 +0800
Message-ID: <CAEUhbmX2LXST-5eDD_UQJP6-XqKPEByVdnQ_KqFM-fR_dH6pyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: msi: Correct
 msi-controller@c's reg
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 5:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> The base address of msi-controller@c should be set to c.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  Documentation/devicetree/bindings/interrupt-controller/msi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi.txt b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
> index c60c034..c20b51d 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/msi.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
> @@ -98,7 +98,7 @@ Example
>         };
>
>         msi_c: msi-controller@c {
> -               reg = <0xb 0xf00>;
> +               reg = <0xc 0xf00>;
>                 compatible = "vendor-b,another-controller";
>                 msi-controller;
>                 /* Each device has some unique ID */
> --

Ping?
