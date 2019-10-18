Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C20CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A47222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhnfsjBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503819AbfJRFDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:03:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33035 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503780AbfJRFDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:03:55 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so5963318ior.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kXqnAV3BvDQ/yTcBOlg44rzpqzO4grBXIpdUaNHFpQ=;
        b=PhnfsjBnStwgloirkfrQMlV2aEsZgdjJJYMMe4A4IQ4IOi7S5uTcWFfa32j3iBFQ/c
         WKP0QCImurjrSkiceZZAukElEIbY5ETTtk/r3+2bTga5P5okeD6N2xDfVzOSJ26jZrZb
         djreQpXMmnivyvDKN4QHv4ghUZa8p1i1TwL34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kXqnAV3BvDQ/yTcBOlg44rzpqzO4grBXIpdUaNHFpQ=;
        b=d4YP7Cbqb2EwJmCFZdXiKX/QTMLZytUG1Fk7794r/aSYAtnaFcUYxVT0WsW5yHQIKA
         f4C2bbmE0rp+L3SjN+f52MV47kr07kJty033ul475n5N1/WbDftIKoC+cTFXBWcpi9Xi
         Bh9whN6lY2Mye6QjBJJs8mJplLBIacmQye1tBEmw59F9AQ3hmR0TVeXj71tlGGbeigtI
         w0TU71rRPCC8Bghi6T+C7r3f8BVirJ99s+1a3eLHJ+Ts1xwGRzp+wMKup75gUhE7YD0u
         fPses2/41pFWvo8LFpVIG44hie1cSSwbFtpYRcW3dTy5pJJZ3jEXSI6c6zvAQnQWrQdl
         T9pA==
X-Gm-Message-State: APjAAAV0s5LFrALZwSJzxp6ZC6w5KB315MDZjMNkTybYHmYvZpbTDwQ/
        xdDCliPFqrKcyGu+mceT4wbkzgrN5FAO1lcV4j64xYwVq74=
X-Google-Smtp-Source: APXvYqwRxgKDLPgCCYZeE7qFw9W3nfXIYvw2H5isnZMGpt16134pjaIMVP22T7ZwatWVHujSSxBd+jnA+/zRmW39ymg=
X-Received: by 2002:a63:d415:: with SMTP id a21mr7371460pgh.299.1571368242911;
 Thu, 17 Oct 2019 20:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191005101345.146460-1-ikjn@chromium.org>
In-Reply-To: <20191005101345.146460-1-ikjn@chromium.org>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 18 Oct 2019 11:10:32 +0800
Message-ID: <CAATdQgBQiFnP3+Dtz8EGCRNiCOWRoJ+zK25iESNLPmVJ+exPmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: input: Add DT bindings for Whiskers switch
To:     jikos@kernel.org, Dmitry Torokhov <dtor@chromium.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping on adding DT binding for Hammer (1/2).

On Sat, Oct 5, 2019 at 6:14 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Add the DT binding document for Hammer's TABLET_MODE switch.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  .../devicetree/bindings/input/cros-cbas.yaml  | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/cros-cbas.yaml b/Documentation/devicetree/bindings/input/cros-cbas.yaml
> new file mode 100644
> index 000000000000..3bc989c6a295
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cros-cbas.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/cros-cbas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS Hammer's Base Attached Switch
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
> +
> +description:
> +  This device is used to signal when a detachable base is attached to a
> +  Chrome OS tablet. The node for this device must be under a cros-ec node
> +  like google,cros-ec-spi or google,cros-ec-i2c.
> +
> +properties:
> +  compatible:
> +    const: google,cros-cbas
> +
> +required:
> +  - compatible
> --
> 2.23.0.581.g78d2f28ef7-goog
>
