Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF4A21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kxy8Dz6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCTR2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:28:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36392 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfCTR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:28:19 -0400
Received: by mail-it1-f194.google.com with SMTP id h9so72054itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Sy/loxk9uhnrLnMhnuT+3tkOvukk3oNzVzGpJ9cgV4=;
        b=Kxy8Dz6stwyxwLbrKwLEkhDP7+JX1vBCSelQBj3IiTgMbYFq0ttLkr133eQHDAygkP
         rRBWvyGcJujJHP/Ek+DWxb2176AlvrVqSC4ti/lui3i/ebPC+Hg5zCz4n9ZcqhemHugX
         9T7MUyL57bFqrhTLfQ4oouOiMXMjjQRexb3c8V2K6GeCbcOj6pdOUApOyTneqt8CIx5j
         wP4NBNGsR2HBILeZdh3z6tJNszVh5jVw177mEIZ0KrWth6vpeE1AugafULfkibR4jhxX
         6bKEN5jgoFdEfSPOWNDsjIL9iTVwrVMyAi3QtDxMYkNHuMugtzxHWuBuMadeDeuer2GT
         tBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Sy/loxk9uhnrLnMhnuT+3tkOvukk3oNzVzGpJ9cgV4=;
        b=KL4skoocrPYw7qJwFACyHEQeviLXXa8x93q62zmqZfC3kaVTOmtRiuTRw2RJs48RFx
         7UytabJtkSkGxMoHQ8tjmyr8YMqMTyxGcoyuQ7tuih0qOn+3eyuzkwCYw+c+LDhEcQgv
         omAXOtPSQhABfbreAV1oTVS5ev2UvvMUJuBHAM9y9JDBcFH9lFLfemmVMeRvDgwxXj21
         C4QlUseUZ8FDm7oaFeNT0OEQNUQL+J48aIqvJ4SigLFRmOC+AkaFgUYxI0gAo2Mk5/S6
         CM+mvh8m8KQJ8kslic+Yxe1KrzU34a2G985xBlDen+BiFQuNJSzSg+kPUJEtAcShPPst
         YrcQ==
X-Gm-Message-State: APjAAAVnqzifs/agmVxymOS4rdXiOYY//h80yLb0IRVGEK4EJ8kO3zzG
        Pnr+vboGhB7wTc9RQ4+xt176YMiyhcj4t7sTmd+Ohg==
X-Google-Smtp-Source: APXvYqwKiY9GzxGkF9bDw/N3iNl6361G48bq0qjXeJx75IRx5XjIFsj0np1Gt5z3KyIAvnzg68DQE9sFCeyQHsxMjrU=
X-Received: by 2002:a24:5208:: with SMTP id d8mr5926514itb.137.1553102898386;
 Wed, 20 Mar 2019 10:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <1553085490-42870-1-git-send-email-shiwanglai@hisilicon.com> <1553085490-42870-2-git-send-email-shiwanglai@hisilicon.com>
In-Reply-To: <1553085490-42870-2-git-send-email-shiwanglai@hisilicon.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 20 Mar 2019 11:28:07 -0600
Message-ID: <CANLsYkyooCaEjRtq0OnNkSKPhe6MPKVbL14Fao=pQ1j3Riw5Pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: coresight: Support
 non-configurable funnel
To:     Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        xuwei <xuwei5@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wanglai,

On Wed, 20 Mar 2019 at 06:53, Wanglai Shi <shiwanglai@hisilicon.com> wrote:
>
> From: Leo Yan <leo.yan@linaro.org>
>
> Document DT binding for non-configurable funnel and give an example
> for it.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

This patch needs to be sent on its own.


> ---
>  .../devicetree/bindings/arm/coresight.txt     | 45 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index f8aff65ab921..e63ec3362af8 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -8,7 +8,8 @@ through the intermediate links connecting the source to the currently selected
>  sink. Each CoreSight component device should use these properties to describe
>  its hardware characteristcs.
>
> -* Required properties for all components *except* non-configurable replicators:
> +* Required properties for all components *except* non-configurable replicators
> +  and non-configurable funnels:
>
>         * compatible: These have to be supplemented with "arm,primecell" as
>           drivers are using the AMBA bus interface.  Possible values include:
> @@ -24,7 +25,7 @@ its hardware characteristcs.
>                   discovered at boot time when the device is probed.
>                         "arm,coresight-tmc", "arm,primecell";
>
> -               - Trace Funnel:
> +               - Trace Programmable Funnel:
>                         "arm,coresight-funnel", "arm,primecell";
>
>                 - Embedded Trace Macrocell (version 3.x) and
> @@ -65,11 +66,12 @@ its hardware characteristcs.
>           "stm-stimulus-base", each corresponding to the areas defined in "reg".
>
>  * Required properties for devices that don't show up on the AMBA bus, such as
> -  non-configurable replicators:
> +  non-configurable replicators and non-configurable funnels:
>
>         * compatible: Currently supported value is (note the absence of the
>           AMBA markee):
>                 - "arm,coresight-replicator"
> +               - "arm,coresight-funnel"
>
>         * port or ports: see "Graph bindings for Coresight" below.
>
> @@ -200,6 +202,43 @@ Example:
>                 };
>         };
>
> +       funnel {
> +               /*
> +                * non-configurable funnel don't show up on the AMBA
> +                * bus.  As such no need to add "arm,primecell".
> +                */
> +               compatible = "arm,coresight-funnel";
> +               clocks = <&crg_ctrl HI3660_PCLK>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               combo_funnel_out: endpoint {
> +                                       remote-endpoint = <&top_funnel_in>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               combo_funnel_in0: endpoint {
> +                                       remote-endpoint = <&cluster0_etf_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +                               combo_funnel_in1: endpoint {
> +                                       remote-endpoint = <&cluster1_etf_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
>         funnel@20040000 {
>                 compatible = "arm,coresight-funnel", "arm,primecell";
>                 reg = <0 0x20040000 0 0x1000>;
> --
> 2.17.1
>
