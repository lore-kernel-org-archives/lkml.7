Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D26C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549CA20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jIlWkdeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCRUC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:02:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41417 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCRUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:02:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id t7so15563100otk.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bXx8Gd7kRQfyDxcGx1GeZllmU8/LjyER2A6kL540eQ=;
        b=jIlWkdePbJhfhKFeSPNNyi5nfcDPDuFQOFpUMECgAIwUKkTY8xI34VLnxYnYRmn8zh
         DeeojmZabNPZBIC9J6rwYIxYgBW7Niqzsdv8SoQhMhFirtGj8k1930KMYPFkowMqUrVY
         ve/2GzO4nF/iHmUoFjcVT2itRn3diCJ0bMbMl5HUAh8z+O1DEAfED4vTtmfFBNsvsYEh
         Vyt0kOLEG7rncKRDwPeSw5IyJjfw0yRy3sFqLcMS7i+eUIOO4pq7gnEsxYRgH/+Ldai1
         Oguq3pcbDObEFHnn5wevz6zPTdKausjkicgTCEljM8V9r3GzCo+inXOAd8/gWwIuMBUN
         4qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bXx8Gd7kRQfyDxcGx1GeZllmU8/LjyER2A6kL540eQ=;
        b=K4KdYZSlQ7pqV5dhBjrzlO8ClTvZCgXGHm/v+AP1Td3Q5uJKF6C9t+o2AH6BNtCfjm
         l4jyxlu7KBIyXB7jJq2MUuyGvFimDbypRleQNTn9fpGxzYCFNDsCphf4PHjl4PkneDLv
         SOeGjASUifm8prysNkfxvO7KFPICn/G8DFT5YY1HJAvrThIcpL6iSYZACHL22Ouw1Rza
         OmfLwsYw5SbZCCHB8PxlRrUPKHUrlAxB62iBcpAQuY9rPEZpBVUF5CqnkuyTQMQ2gN9o
         FMrQcbaoV2qwQ/3fZWFnrdlFTenIkFBueW8tQhs4nbcB/fDFcFK0L/lVgbaiuvqn/cbM
         H3wQ==
X-Gm-Message-State: APjAAAXXg9kCv4HrO5eErJll9/iRCiR5QrB/Frnhlah0jUI9xJLwknMN
        wH7d/1dLWGn3n/Yw7UVbioazh8aPmFpmneCJgDc=
X-Google-Smtp-Source: APXvYqxB4pS1IFH+Pv2u9eodriTgaqFiTQKklidzZ5NBVs5HL+8cEiDJpG7pWhLLA9SdhA66O7ViDoX5cyt7rW9gLSw=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr11298896otk.86.1552939344732;
 Mon, 18 Mar 2019 13:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190318095851.4062-1-narmstrong@baylibre.com> <20190318095851.4062-2-narmstrong@baylibre.com>
In-Reply-To: <20190318095851.4062-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 21:02:13 +0100
Message-ID: <CAFBinCDfOEvmQcE7TgYvXmM1f=pywYbjhbAZWs4AYNXs8y6y7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: meson: g12a: Add AO Clock + Reset
 Controller support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 18, 2019 at 10:59 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add nodes and properties for the AO Clocks and Resets.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 31ddf9444b3e..5c0983edf837 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/g12a-clkc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>
> @@ -122,6 +123,23 @@
>                         #size-cells = <2>;
>                         ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>
> +                       rti: sys-ctrl@0 {
> +                               compatible = "amlogic,meson-gx-ao-sysctrl",
> +                                            "simple-mfd", "syscon";
> +                               reg = <0x0 0x0 0x0 0x100>;
> +                               #address-cells = <2>;
> +                               #size-cells = <2>;
> +                               ranges = <0x0 0x0 0x0 0x0 0x0 0x100>;
sorry for noticing this only very late: I missed the #address-cells,
#size-cells and ranges property in my last review
do you have any change queued which requires this?
my understanding is that the drivers for all RTI children should use
the register offsets relative to the RTI start address. In that case
the child nodes neither have a unit-address nor a reg property, making
the last three properties unnecessary.


Regards
Martin
