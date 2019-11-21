Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B40C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E782067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw0tGGpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKUTB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:01:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38152 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:01:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id s10so3754379edi.5;
        Thu, 21 Nov 2019 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGlv9N7emzPPMkGFW2suWUAOKKS+im2D/mbhQrUjPOw=;
        b=hw0tGGpydIclVWzvfKyqExS+ky3mFe5zVFYzo8L/vE9QIsquY7DLXT3bxgRHCc913E
         QPYswTjKLbcK2rh16yudPur9Safmg77tW/A/pa8QnF37XhIQ5u2H6l5XQnrqZ0aSXohF
         y6vPt6lysOVpBO2kR2FnrJoNlGusPUTt7c8MvEYo4Ow7Xs5zpbwdCctguSfnT+blVgEB
         Q4i301/C0VgEKQcp8OXyj0B4DEMiIH+KW8S+llH6hOmRla4aO4RRVQjT1xyHulgZf1VE
         +VPAp76Wx4D/VNMQcC/VxE3KHRvxo2QJLj9rf50nPHnZVipfoaeoJSPhd6ml6WK1/f/3
         nZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGlv9N7emzPPMkGFW2suWUAOKKS+im2D/mbhQrUjPOw=;
        b=geFjy27muvt1MM06Qe8Pm0+7EIjbkjcgAY3n8YcKQkKrVV67OdF5EeHB1JhrgigUjU
         7L+9duCpy1YYkV8Iy+5AvUi+1KhF+LHR4j3KpDnkgNYPIMRfwFrdpmhksBmOGMLtrudw
         24yfbuZ/KCIfbEmYZvs5EUQo4GPmUQJlcrRqiuk3ka+UHu57EDUYSEeNQwjHoVuzRRwc
         /+/MFI6RbHZ+VSHeJfGfj/8r+27iPpo1SbVkrHIIJ2G1xj91mqt/9f9ZlUq+Qm8HRJtr
         s87sQneT52NZy40ecmTs0DkEl8ZWc2q9GLOaKEHYYLtQN0tH+/Gh977LGxHJrQWp/1XQ
         8ACQ==
X-Gm-Message-State: APjAAAWwTnSo7PqxS1SMTMD8DMlYFf41ToHJ9ICqf8ElvKSk0OPmEubn
        nd2qvgr5wU/tAGgOByZCZeY+7B+lx38dcjzr+7fkAoFI
X-Google-Smtp-Source: APXvYqw7XM4/ilKVdiKymLyfmxi48lasfzIxyiJ681Tf/Q+giqd2n8es7XgsJNBR5MISNx52NIpdSQew5FnTSv5teuU=
X-Received: by 2002:a17:906:11cf:: with SMTP id o15mr16093149eja.208.1574362887584;
 Thu, 21 Nov 2019 11:01:27 -0800 (PST)
MIME-Version: 1.0
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com> <1574232449-13570-5-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1574232449-13570-5-git-send-email-manish.narani@xilinx.com>
From:   Rob Herring <rob.e.herring@gmail.com>
Date:   Thu, 21 Nov 2019 13:01:16 -0600
Message-ID: <CAC=3edbHWA7gv-mTFVXXcMzN6hyzO4LPqkbcRZ-zDp5BAm8_Vw@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, adrian.hunter@intel.com,
        michal.simek@xilinx.com, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        linux-mmc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:49 AM Manish Narani <manish.narani@xilinx.com> wrote:
>
> Add optional properties for mmc hosts which are used to set clk delays
> for different speed modes in the controller.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 080754e0ef35..305b2016bc17 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -333,6 +333,18 @@ patternProperties:
>      required:
>        - reg
>
> +  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
> +    minItems: 2
> +    maxItems: 2
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 359

This is wrong. It can't be both minItems of 2 and a single uint32.
What's needed is:

allOf:
  - $ref: /schemas/types.yaml#/definitions/uint32-array
minItems: 2
maxItems: 2
items:
  minimum: 0
  maximum: 359
