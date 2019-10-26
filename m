Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D1CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7136421D7B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfxksKUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfJZCLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 22:11:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43326 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfJZCLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 22:11:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so4298447wrr.10;
        Fri, 25 Oct 2019 19:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ALQdhB5h3cKalAoVvOYU2qpe569Ks5R2FX4vQ5KEM0=;
        b=LfxksKUJvXxznvcTIid8C09TRv1SJkXLT6K706LJCbwK/TUbqfTzijG0vqZ4Bx4Buc
         qE0kRJT37SvRiWvnx6tw1TafGfA9AZXMHj4u44Hy3XwsRxo/TQuOCrSvbeOsLMutt4vw
         HIfhktuA02JuxlizIP01M5kIXRNoo3kjbOZ6g3JkEE+WFVWT9179q0LXW8ykKc+u1sXD
         iaZdHVrqDjqODrJE0m0KY9h0wwx9xy3l/xs8Zn1vMFhgjJ8EnDBNLUOmDb6Ph7cH1YtH
         MS2Mb/T33eDeRGCGp7mQCALzFLOWPqp4mUm7RVsgQtH3gPCsTXVCFupKyZulzLfHm2WV
         u9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ALQdhB5h3cKalAoVvOYU2qpe569Ks5R2FX4vQ5KEM0=;
        b=lYvQL49eUhpcKr1F56EsjTcqphBxg021ZezNVHMTaaT3snNu+y66N17XWW5UzjRVBK
         xql2bB82iiP8/8bs5c03tqtgCksrf1lmWuwNNGvLO1xhPk5OnCVWknFYqtZZ7rSxHhg3
         7qjaVU/oTOXX67tmNMnAQ8+TMaNGuE6Q2ngEverEwV+JbtjRGCvmv7yH0z5Aj+y4R4gc
         tgyZwO4+4+Jcs+1065K8DWZL/aaEk6lAQHJWYBw2Yn9G2IChUP8OsmLfJy6DxH/fZDsF
         iHWH61MPLPS05DyIlvyID5YgpW4ZX2QyOFctB0EzqwE5qbmyoYLbP0TBgvvRbFEI0XcW
         k2nw==
X-Gm-Message-State: APjAAAXXYFvDXs8Wtby1fJvtHY/nUvUSqVUU7e0BcmBm10SbCYuUl6OE
        fpeoDgOFnit3Fn8PEmikyGbs2WlPPqo8xmu6Qujmcw==
X-Google-Smtp-Source: APXvYqy9WIvJ8mlOEnf1bsTVAEZqNwjann/RSa9Iiqk+fNe+gqyRdq1x/PwGQ7DH0ZwB9Oy00XC30ELcQR3QqRApCzg=
X-Received: by 2002:adf:e403:: with SMTP id g3mr4931960wrm.128.1572055888508;
 Fri, 25 Oct 2019 19:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com> <20191025102915.23677-2-chunyan.zhang@unisoc.com>
In-Reply-To: <20191025102915.23677-2-chunyan.zhang@unisoc.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sat, 26 Oct 2019 10:11:17 +0800
Message-ID: <CA+H2tpHkYwQLEO7ftLebErsEXBQnRS37gFOoKoG+_jnt5+0r-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: Add a new compatible string for SC9863A
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On Fri, Oct 25, 2019 at 6:30 PM Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
>
> SC9863A use the same serial device which SC9836 uses.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> index 9607dc616205..0a9f8a7809e1 100644
> --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible: must be one of:
>    * "sprd,sc9836-uart"
>    * "sprd,sc9860-uart", "sprd,sc9836-uart"
> +  * "sprd,sc9863-uart", "sprd,sc9836-uart"

Duplicated 9836 with above line?

-Orson

>
>  - reg: offset and length of the register set for the device
>  - interrupts: exactly one interrupt specifier
> --
> 2.20.1
>
>
