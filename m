Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA1AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B90321955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm8hR45y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfGVSvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:51:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37590 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfGVSvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:51:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so41324438otp.4;
        Mon, 22 Jul 2019 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjJupYIc6xWc8gLFfPCwhmNtFxBF1s29Cj+SrhBx5Is=;
        b=bm8hR45ywmygZ8NW0eNp6YDk/NoCpAjuyMaoMf5JVUbHHpaC7V+k2GEyK/Sxbub2Io
         10P9Eqp7mwTpApV9roRtHUIppuq9fRxcVehIInvSLpuWNk3JdidqKDG7RO5zsMfYiz04
         M2CRABNHRuqfxifSuEgV7kO5xBzUcuv5s0n3ma/hI9X3iO+XsAlF6LZjgFeAQMq1mlNZ
         q7C/CD1aTbdIdyP0ZkBhU+q765+neevpRfJfRG/X7YJSC3P2MuuwZ/Ulup6VUHuwLSEi
         JMn8Jt2ACGXiSOJ6H/2giqHKf7zjFeZtRoF1Fw7MhYblXHt0DLaYrP42uXq1SO9Rz01j
         qpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjJupYIc6xWc8gLFfPCwhmNtFxBF1s29Cj+SrhBx5Is=;
        b=ndYDKpWaZYgPZgF97g5OS5u6K5Lnb1QQilFfIqzw7ivYggGrHEcByDIkeQhH2p3BSE
         Y1L8Mm6Uqm77VijwhpFoIZPkFlbXmRynQAbBAnli8d8KhgJmYoWpMOVStyy1Pic3kT8j
         3q6haUt5QShBX0ndva/LaHxUZZ08C3Flg4UNmvcRBDbBchjCPisYWTi6gYaaSN58lOu3
         Aw53r/JgLPuDN+gJ+X8PwSdwQXL6me2mhOipRvoGsw54Gh9xSUbLGRScmMWEmoA1VKSG
         cTkTI3pn9oafVt5VYs/b8lALGLqHH8brx22uDaHfF8Gz7XkesN+bqIZgl51Pgp+9wg49
         CEHQ==
X-Gm-Message-State: APjAAAV54ibBel9qpp8BQXmf+x2tVU+9Otwry3WsgUoQeR8uc1S5On+k
        lrDoTR3UfEJnzZ8VmLueqaLL83mwF/2rAorBG4M=
X-Google-Smtp-Source: APXvYqxJ1cmuAUD5O0KF/ePYZbRJdJ5aTWAG9K+yO/+94qQbz28EEpCc4OtsYtwRR4vQw7JKfy3sOGJoQP+tXdUEhp8=
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr16501766otf.312.1563821505561;
 Mon, 22 Jul 2019 11:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190722151202.5506768B20@verein.lst.de>
In-Reply-To: <20190722151202.5506768B20@verein.lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 22 Jul 2019 11:51:36 -0700
Message-ID: <CA+E=qVdu3Hf7ufst-t_CiWkquximGFX8B2RcoQ1x0m++cc8n8Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: Add ANX6345 DP/eDP transmitter binding
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 8:12 AM Torsten Duwe <duwe@lst.de> wrote:
>
> The anx6345 is an ultra-low power DisplayPort/eDP transmitter designed
> for portable devices.
>
> Add a binding document for it.

I believe you'll have to convert it to yaml format.

>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../devicetree/bindings/display/bridge/anx6345.txt | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.txt b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> new file mode 100644
> index 000000000000..0af092d101c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> @@ -0,0 +1,57 @@
> +Analogix ANX6345 eDP Transmitter
> +--------------------------------
> +
> +The ANX6345 is an ultra-low power Full-HD eDP transmitter designed for
> +portable devices.
> +
> +Required properties:
> +
> + - compatible          : "analogix,anx6345"
> + - reg                 : I2C address of the device
> + - reset-gpios         : Which GPIO to use for reset (active low)
> + - dvdd12-supply       : Regulator for 1.2V digital core power.
> + - dvdd25-supply       : Regulator for 2.5V digital core power.
> + - Video port 0 for LVTTL input, using the DT bindings defined in [1].
> +
> +Optional properties:
> +
> + - Video port 1 for eDP output (panel or connector) using the DT bindings
> +   defined in [1].
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +
> +anx6345: anx6345@38 {
> +       compatible = "analogix,anx6345";
> +       reg = <0x38>;
> +       reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
> +       dvdd25-supply = <&reg_dldo2>;
> +       dvdd12-supply = <&reg_fldo1>;
> +
> +       ports {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               anx6345_in: port@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +                       anx6345_in_tcon0: endpoint@0 {
> +                               reg = <0>;
> +                               remote-endpoint = <&tcon0_out_anx6345>;
> +                       };
> +               };
> +
> +               anx6345_out: port@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +
> +                       anx6345_out_panel: endpoint@0 {
> +                               reg = <0>;
> +                               remote-endpoint = <&panel_in_edp>;
> +                       };
> +               };
> +       };
> +};
> --
> 2.16.4
>
