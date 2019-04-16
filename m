Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492DEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B7220684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cx2UYLU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfDPUSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:18:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39567 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:18:52 -0400
Received: by mail-io1-f65.google.com with SMTP id e13so18735272ioq.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqFZk5qgav69xi0SuJyDMEr2clOQqYVnHTLXC004odA=;
        b=cx2UYLU4/7EyL9BPoWnm8AMOGxWyxhufzLPZhGFAMivgm7kIaJrO4qWgiQpL0JJspf
         cPaxQovh6ml1F6iYL5l4W7ayfjPrRsWfzQuu22yv+qYtZqjp3cCEq3nAcwWT8v9qribR
         u+APyqyZFmjsB4AAlMQMzwPHE+RX67a6pDKprEtj03AEmMwK5HmXcj78C5T5312JvkHq
         +SVUCKtfs9uGfjGbUW1SaUBT6KbY2H6jH4Nvsfmt/nb4q1AMiOldsTPNiVaGmHG3PCCx
         Rwo10jwNUpNMc8SJ9Z6AOaOjRFb48S42MvhNr6X9lGMOb+/vLbR4Gu2GmGzR7OT+nw/v
         WYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqFZk5qgav69xi0SuJyDMEr2clOQqYVnHTLXC004odA=;
        b=Q97WRwlmZfsRZnc3AVlDSTGZq9tZD+AtSvBJ7e9hCFCImdDEbz0yS834bWwozXTcK3
         KuZyXZKIeIrZVZvrl3tR8DsyAF20EHxaZr8ESX1IhQ4zbEuQ8dRgFfaGhdIxLLV8c74d
         NjZ5U9f4rCDevXy1w63Xn1aFU7zmPA0W1SSLT/5fM1v3f8MhOyZIoebhQLD5vMPF052x
         8jMSlPObKlZK8YAkVehcQ5tPjTLEIbp3gKr2LWGKaiy4Jx4KMjBpaQ5qZ6UPJ6+LEis2
         umz1GUupaq3pP/tjoXrNY2i3tLTJRRHPCHnH2HEhjH6hVZGhsM7w3SEHIwij3PPER9O1
         ZLyA==
X-Gm-Message-State: APjAAAXOWfMoGDckc9rqtSf7bc7cC8jS0VkxXxv+C+OO40nXj8mH9xLx
        taL1jxkL7CXxjg9Hqd2Ho/QRRjFUZSemmzirVhT/dQ==
X-Google-Smtp-Source: APXvYqwV2WIII5nr7bauB4HuZ2PK1ZqbKcpz++HkaHYXomE9T3f2NzXd2zuFcyuG4BeCKJ2GrIqJKtt+akK6/C87e4I=
X-Received: by 2002:a5d:984a:: with SMTP id p10mr38323902ios.217.1555445931606;
 Tue, 16 Apr 2019 13:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190412102738.12679-1-leo.yan@linaro.org> <20190412102738.12679-2-leo.yan@linaro.org>
In-Reply-To: <20190412102738.12679-2-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 16 Apr 2019 14:18:40 -0600
Message-ID: <CANLsYkw1vaevcJZfjQfF9BeUvi1THGNtu+SH+LR008LjZOc7fA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Fri, 12 Apr 2019 at 04:28, Leo Yan <leo.yan@linaro.org> wrote:
>
> CoreSight uses below bindings for replicator:
>
>   Dynamic replicator, aka. configurable replicator:
>     "arm,coresight-dynamic-replicator", "arm,primecell";
>
>   Static replicator, aka. non-configurable replicator:
>     "arm,coresight-replicator";
>
> The compatible string "arm,coresight-replicator" is not an explicit
> naming to express the replicator is 'static'.  To unify the naming
> convention, this patch introduces a new compatible string
> "arm,coresight-static-replicator" for the static replicator; the
> compatible string "arm,coresight-replicator" is kept for backward
> compatibility, but tag it as obsolete and suggest to use the new
> compatible string.
>
> As result CoreSight replicator have below bindings:
>
>   Dynamic replicator:
>     "arm,coresight-dynamic-replicator", "arm,primecell";
>
>   Static replicator:
>     "arm,coresight-static-replicator";
>     "arm,coresight-replicator"; (obsolete)
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index f8aff65ab921..d02d160fa8ac 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -69,7 +69,10 @@ its hardware characteristcs.
>
>         * compatible: Currently supported value is (note the absence of the
>           AMBA markee):
> -               - "arm,coresight-replicator"
> +               - Coresight Non-configurable Replicator:
> +                       "arm,coresight-static-replicator";
> +                       "arm,coresight-replicator"; (OBSOLETE. For backward
> +                               compatibility and will be removed)
>
>         * port or ports: see "Graph bindings for Coresight" below.
>
> @@ -169,7 +172,7 @@ Example:
>                 /* non-configurable replicators don't show up on the
>                  * AMBA bus.  As such no need to add "arm,primecell".
>                  */
> -               compatible = "arm,coresight-replicator";
> +               compatible = "arm,coresight-static-replicator";
>
>                 out-ports {
>                         #address-cells = <1>;
> --
> 2.17.1

Since this is a binding patch it needs to be sent on its own.

>
