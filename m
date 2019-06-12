Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4A9C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0B62177E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560355337;
	bh=metd6bfdlEBpzQ+ceKHY3yudA9GwzpuxQi/0AJYZuR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rE9UjpoR85A6U/gPelcbUQA1jmOWqd0xyDLOBekbT/R+XjZZizp15nB4iqTdeJX+R
	 65z3PcQvEXyXfO0AOp68JLoPycpkbqz/GkzUIRzfby08tr1wLprlD0aBTC3qrN35BP
	 BQM1Y+WpcLp6gG/fC2U+xvYcGL70rUCXwnyD3P9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440182AbfFLQCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406982AbfFLQCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:02:16 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2E621734;
        Wed, 12 Jun 2019 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560355335;
        bh=metd6bfdlEBpzQ+ceKHY3yudA9GwzpuxQi/0AJYZuR8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oM3YEkg5JFAtr+dxqlSmKGC5DoRVFr9YH8llHwQvbj05188iWTHOHyZTwGZTihjdy
         RUNponKwURuc7jhnmsN26O1yJsqqQcx79O4t7KN6p4MD6sap6D2o60q/3o2le1RtJp
         keYYthQbmm5nwIkUSPxFQCOA3VGMLOOB8nQdAgas=
Received: by mail-qk1-f180.google.com with SMTP id w187so10614100qkb.11;
        Wed, 12 Jun 2019 09:02:15 -0700 (PDT)
X-Gm-Message-State: APjAAAX/JPwcOIn5gPDkwYemvK+dhwYMnIysM0kwzAutoXwX31L6rfJl
        4m5mlZJ2sae85wB2jd4uCxZ7rIEHhOQ6OLIelA==
X-Google-Smtp-Source: APXvYqybvPsqmqFny7a/JtFlhcTlJvlaZutyfLURiANi3yYx5Ws3TiRMG/YwRYEOIfUSRlyBWiQ9Ld6YtcnmxxUqqK4=
X-Received: by 2002:a37:a6c9:: with SMTP id p192mr68957195qke.184.1560355333838;
 Wed, 12 Jun 2019 09:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org> <20190612075451.8643-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190612075451.8643-3-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Jun 2019 10:02:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLRTK=7Ch7V-WA07_zxWMNGXmRH7=1TRR9m-zY7h_-YYQ@mail.gmail.com>
Message-ID: <CAL_JsqLRTK=7Ch7V-WA07_zxWMNGXmRH7=1TRR9m-zY7h_-YYQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: stm32: Convert STM32 SoC
 bindings to DT schema
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        loic pallardy <loic.pallardy@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 1:55 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> This commit converts STM32 SoC bindings to DT schema using jsonschema.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/arm/stm32/stm32.txt   | 10 -------
>  .../devicetree/bindings/arm/stm32/stm32.yaml  | 29 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
