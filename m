Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D0A2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567107035;
	bh=P8Okz1ioDyQ5iQhhZdadmnrkWaz9o8uYiuS0d0WDRvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u5pM80hD9XWTtr2+Q+VWAc0ADvVn784dS4ufirK8MJocBNFQWzDQ3a+XrzWlWzCf0
	 NvknwB4vdYA2KNPlq7edP64IO0FZu0alw61Uj58VioQliH1K9h8Z5ESQVP8aFz9SRb
	 BJ9zW82fauDmUKyUG24xSgx0CxRilTzzymlWGqrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfH2Tae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfH2Tae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:30:34 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9062922CF5;
        Thu, 29 Aug 2019 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567107032;
        bh=P8Okz1ioDyQ5iQhhZdadmnrkWaz9o8uYiuS0d0WDRvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KCEFp0U6rFSC8fIUYAgYeOAPSqvJeCAi1y4HpyDJjcC/XELXgJd3q28f97XeSRotf
         Em3O6VdjKFphBdvLxx3GLXXZNZpPYp4m0Z7KIPGkz+TYVqOVaWAZ2Fp82r0uZfPa+g
         tciw54shUTMXr6RuyRkAt88LL65IrR7IyWGV+GuE=
Received: by mail-qk1-f180.google.com with SMTP id c189so2471341qkg.2;
        Thu, 29 Aug 2019 12:30:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXzHHdhLk/WuawXfnXLuqY/PWDL5c/rGa80PwxKKGnKJ+TlIt4Y
        jdnTWOdqH10B33wj5PNI4d6iBMUh6V0WVbN87g==
X-Google-Smtp-Source: APXvYqzkIC+v5aIBr2WVnHist8Ob0TXXTVPct/ifT/ce+i4zRLnYa43TF25d7xt3ZDfB1IBglTWwTXNJUva+39sy1q0=
X-Received: by 2002:ae9:e212:: with SMTP id c18mr5379641qkc.254.1567107031751;
 Thu, 29 Aug 2019 12:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
 <20190829144442.6210-4-srinivas.kandagatla@linaro.org> <CAL_JsqLOHA+r9UCTwyvj+_BzWSrsVDZw5vp-1XhYYvQxncx0sw@mail.gmail.com>
 <ef01465e-25d6-059c-1f5d-8e8ebd6b887d@linaro.org>
In-Reply-To: <ef01465e-25d6-059c-1f5d-8e8ebd6b887d@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Aug 2019 14:30:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL9p9fF4KZ4DSfhC0+XTDe0OaR8CZ0mmDNPTxaoi38FFA@mail.gmail.com>
Message-ID: <CAL_JsqL9p9fF4KZ4DSfhC0+XTDe0OaR8CZ0mmDNPTxaoi38FFA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: ASoC: Add WSA881x bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:52 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks for the review!
>
> On 29/08/2019 16:46, Rob Herring wrote:
> > On Thu, Aug 29, 2019 at 9:45 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
> >> Amplifier. This Amplifier also has a simple thermal sensor for
> >> over temperature and speaker protection.
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   .../bindings/sound/qcom,wsa881x.yaml          | 41 +++++++++++++++++++
> >>   1 file changed, 41 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> >> new file mode 100644
> >> index 000000000000..7a486c024732
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> >> @@ -0,0 +1,41 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >
> > Dual license please.
> >
> Will do that!
>
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
> >> +
> >> +maintainers:
> >> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> +
> >> +description: |
> >> +  WSA8810 is a class-D smart speaker amplifier and WSA8815
> >> +  is a high-output power class-D smart speaker amplifier.
> >> +  Their primary operating mode uses a SoundWire digital audio
> >> +  interface. This binding is for SoundWire interface.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: "sdw10217201000"
> >
> > No need for quotes.
>
> Did not knew that! Still getting used to yaml stuff :-)
>
> >
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >
> >> +  powerdown-gpios:
> >> +    description: GPIO spec for Powerdown/Shutdown line to use
> >> +    maxItems: 1
> >> +
> >> +  '#thermal-sensor-cells':
> >> +    const: 0
> >
> > Either of these required?
> >
>
> "make dt_binding_check" was complaining when I added this! Let me retry it!

Because the example in soundwire-controller.yaml will no longer be valid... :)
