Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32048C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF0620868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALaN4p5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfDPUUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:20:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46204 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfDPUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:20:23 -0400
Received: by mail-io1-f66.google.com with SMTP id p23so18702710iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CIgmZ2upaRsiIQCqoA+tYgvZr/881F4E+c+VKRZINg=;
        b=ALaN4p5wRrWFjjuo/5omDtOPBN1jLfEWp2iMEaBBUFHNpF/8JCjBxAf7QKvIrrxcw+
         MaxQiccXoahOEfMdrPS7W+proe5at6UZ9SgOkLo2z8pD9um/zuMOL6boNMcMHCLQwyFz
         x9n1hJCU+w4njWJOXiGzwg4ZmbFeXwn1d2N8JkFI352eHWdvhxcyNio3uSkL5qrEVjbB
         NTnOhuP0qdBSU9mnNnTWhVPmlziR5FcW1QVPOwn5pmXcV6cg6suKWhy5XQyNX8ZIfeBZ
         G7dy/SewjkN/g/cuiIJVwqlj7ZhLrynrFhyyKZa/ZGm++yKgIybhwJ3ylOC+Q0G/35lX
         YBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CIgmZ2upaRsiIQCqoA+tYgvZr/881F4E+c+VKRZINg=;
        b=aAi0xyABiZvHir9buB5ysSwr4+ov14Rzc02ctxsIFcwCj8nTv2UwgZje7lbxY9LDir
         0CBj/A7T/WzbMZ88bc+7Io7h4WyGmJ1T369TUHXG6QXEoCqOc82O3UgSu1FLYi8600fK
         EtvYOioB6ICOW683ht3ts4waO3AtuwrcAKGnFFA7iJDwNHJqqwxY+tkQUD8nMVKW+Vrm
         7Ht9a/4UGnmqwg4XVCyVzDvPU/Dgnc5VIArj5+6jll+oIuZvrtai+z68ZmHGg9e3+Pfg
         743WB21LUwJxek06XV7ays/jqFdFCWgCxMi8Sa8JCSPn8HMiS2HWjs+27cIMpwbncoj+
         0nyQ==
X-Gm-Message-State: APjAAAW3GcRtbwmFRcRJdaZwE7zaUMJwt25nfulRfkz2DZ4to8fJcCce
        JOd/Qi92kP0bRwG/g6adAL8Cm3ln4dfM3fMZ/YH34w==
X-Google-Smtp-Source: APXvYqwFvRf80rk7q03sQzE537m4AChTVlA95CZEnLYg643EUVRpgRZoa1aIwg7O938QmNYrTZaruErMsQAqUCpU1nE=
X-Received: by 2002:a6b:7401:: with SMTP id s1mr54113923iog.55.1555446021769;
 Tue, 16 Apr 2019 13:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190412102738.12679-1-leo.yan@linaro.org> <20190412102738.12679-4-leo.yan@linaro.org>
In-Reply-To: <20190412102738.12679-4-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 16 Apr 2019 14:20:10 -0600
Message-ID: <CANLsYkwr=bZLodHbbRiDiV1m6mwscJoYbx00MoqPf4ttXytD=Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: coresight: Unify funnel DT binding
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wanglai Shi <shiwanglai@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 04:28, Leo Yan <leo.yan@linaro.org> wrote:
>
> Following the same fashion with replicator DT binding, this patch is to
> unify the DT binding for funnel to support static and dynamic modes;
> finally we get the funnel DT binding as below:
>
> Before patch:
>
>   Static funnel, aka. non-configurable funnel:
>     Not supported;
>
>   Dynamic funnel, aka. configurable funnel:
>     "arm,coresight-funnel", "arm,primecell";
>
> After patch:
>
>   Static funnel:
>     "arm,coresight-static-funnel";
>
>   Dynamic funnel:
>     "arm,coresight-dynamic-funnel", "arm,primecell";
>     "arm,coresight-funnel", "arm,primecell"; (obsolete)
>
> At the end of this patch, it gives an example for static funnel DT
> binding, and updates the dynamic funnel example.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../devicetree/bindings/arm/coresight.txt     | 53 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index d02d160fa8ac..8a88ddebc1a2 100644
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
> @@ -24,8 +25,10 @@ its hardware characteristcs.
>                   discovered at boot time when the device is probed.
>                         "arm,coresight-tmc", "arm,primecell";
>
> -               - Trace Funnel:
> -                       "arm,coresight-funnel", "arm,primecell";
> +               - Trace Programmable Funnel:
> +                       "arm,coresight-dynamic-funnel", "arm,primecell";
> +                       "arm,coresight-funnel", "arm,primecell"; (OBSOLETE. For
> +                               backward compatibility and will be removed)
>
>                 - Embedded Trace Macrocell (version 3.x) and
>                                         Program Flow Trace Macrocell:
> @@ -65,7 +68,7 @@ its hardware characteristcs.
>           "stm-stimulus-base", each corresponding to the areas defined in "reg".
>
>  * Required properties for devices that don't show up on the AMBA bus, such as
> -  non-configurable replicators:
> +  non-configurable replicators and non-configurable funnels:
>
>         * compatible: Currently supported value is (note the absence of the
>           AMBA markee):
> @@ -74,6 +77,9 @@ its hardware characteristcs.
>                         "arm,coresight-replicator"; (OBSOLETE. For backward
>                                 compatibility and will be removed)
>
> +               - Coresight Non-configurable Funnel:
> +                       "arm,coresight-static-funnel";
> +
>         * port or ports: see "Graph bindings for Coresight" below.
>
>  * Optional properties for ETM/PTMs:
> @@ -203,8 +209,45 @@ Example:
>                 };
>         };
>
> +       funnel {
> +               /*
> +                * non-configurable funnel don't show up on the AMBA
> +                * bus.  As such no need to add "arm,primecell".
> +                */
> +               compatible = "arm,coresight-static-funnel";
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
> -               compatible = "arm,coresight-funnel", "arm,primecell";
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>                 reg = <0 0x20040000 0 0x1000>;
>
>                 clocks = <&oscclk6a>;
> --
> 2.17.1

Same thing for this one.

>
