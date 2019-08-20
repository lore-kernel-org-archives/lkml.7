Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A8EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159A622DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF96vaXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfHTPy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:54:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45625 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfHTPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:54:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so3475845pgp.12;
        Tue, 20 Aug 2019 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oKRxdUPEqx182AGsFYC1FZNnJTIkLhG2zitRB8VXskY=;
        b=EF96vaXIKSJqXkEQ+iKjKVxtUoKoMAu+x4HM+r2PftVEkhJ0IX1sPAboufpFgvzhvZ
         Lx+vxJ3MlNqgsYplkTfIzRKqr0YW321a3A0bPHWCbwPxhqjZ14R6LD2Dlgg3FZ2J9C+G
         45dyKwseoRQuhJZQSMtqwyCqJJYy7LzKCPsci7rrVprv5SaUNrQ+UXGwHFAFXU0kccLM
         mOX2CuMyDgvMoOrd6bEvJ6U+leMuAbd4VHTc7rXLqx9xa8TmMuH64nxeg8BBtUVO/DIt
         xd+ghgEDijtJYXvCeTA87FYY9I6VjXFELZ1fVrRib1vmJB9IiNbpemnww78rxMPJThMm
         vY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oKRxdUPEqx182AGsFYC1FZNnJTIkLhG2zitRB8VXskY=;
        b=ne+8HeDHYZ+CSU7LnCHCCux8xXEoZR2Ywe37jz9SSSoxRq+hLNLV8VqkDNEKMjM3Rr
         zBii428wRoDIoGrb8GUDGIG1fkKdr1op0zKUcMLGCRxcPIyQu4GhuI2890uHUKYo4q+n
         h5oEs/JMZxOLzV7OOslJsunysI3hvvNgQ8K9xtZNEROuLydKywNtRvZulOfh1OW9VbHv
         QIQjRZxRtUGTjjjEe2P9GtQjJ6yVYk//TE+TP+CsT+Nngd3CoAZUlo+1RAZ0bCIJZmyD
         HMsTYqMSPBGb68782OF8oYG+LQ3s0Urv+Qpc00MKy1XRKslcunJAOnaqTGhoCN/qlcpa
         pfQg==
X-Gm-Message-State: APjAAAUmt9xVooL6q6eXvz9w1aOSpl4rK2vB8zfYC7vjQzCzQeZoFNzC
        u/bqmLLNUQd1EGlNWWNVfcQ=
X-Google-Smtp-Source: APXvYqwT6p/B3nVNF9dkl92avzPLIXO+NgzJ9fT0X+D8I222afrN3om41gfv7AR8PrYHKtWYHCgUwQ==
X-Received: by 2002:a63:31c1:: with SMTP id x184mr26182258pgx.128.1566316495255;
        Tue, 20 Aug 2019 08:54:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7sm21147062pfn.72.2019.08.20.08.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:54:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] dt-bindings: watchdog: Add YAML schemas for the
 generic watchdog bindings
To:     Maxime Ripard <mripard@kernel.org>, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <20190819182039.24892-1-mripard@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ada53037-898f-7b8c-8a96-b80414563fa7@roeck-us.net>
Date:   Tue, 20 Aug 2019 08:54:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819182039.24892-1-mripard@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/19 11:20 AM, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> The watchdogs have a bunch of generic properties that are needed in a
> device tree. Add a YAML schemas for those.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

What is the target subsystem for this series ? You didn't copy the watchdog
mailing list, so I assume it won't be the watchdog subsystem.

Thanks,
Guenter

> 
> ---
> 
> Changes from v1:
>    - New patch
> ---
>   .../bindings/watchdog/watchdog.yaml           | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> new file mode 100644
> index 000000000000..187bf6cb62bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/watchdog.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Watchdog Generic Bindings
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +  - Wim Van Sebroeck <wim@linux-watchdog.org>
> +
> +description: |
> +  This document describes generic bindings which can be used to
> +  describe watchdog devices in a device tree.
> +
> +properties:
> +  $nodename:
> +    pattern: "^watchdog(@.*|-[0-9a-f])?$"
> +
> +  timeout-sec:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Contains the watchdog timeout in seconds.
> +
> +...
> 

