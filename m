Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB9C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBD9206E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JnC5PSzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfFEP1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:27:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39950 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfFEP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:27:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so15036478pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=bL2F5Kk1z37B/CBGiBHXHDAe9BGsJSubIxd5oJ6N+xU=;
        b=JnC5PSzF0dpVQw69G+2XoZLocnP6x7N9rI2cPtusWE/fddvUWozGnzbtsHQ2aa8sEc
         7+0hwpN5WyoALO0EsgvzKntrblkMdk0/sW12SHCR7LZ8K8nWV6dXF4D04VcDXdFkiaEs
         DeDPXmnOTqWiBMwAIc5QHaf1qxJWZKPOd4klLL55TrsDgbNPdpDgHZZNeykfn2x4qRM4
         fFYSAEoqNusLd1hI7+7/sni8dz8hIFVhCU3trmdSIRGDT0w/lgpjvchYlnqu1xp+VC80
         pSuouA8DqO+cclu+xPvSvbXH0tpMoihTHKnJPE6KzV0ls3lrGQjY7BBh6vCNP4V9Asce
         9Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bL2F5Kk1z37B/CBGiBHXHDAe9BGsJSubIxd5oJ6N+xU=;
        b=q/umv6ui9K1oKCVE/zmxYN2abgjk4honLrNq8gd5bovjj3OqWwiEr6kuF5I2qaRRJ4
         ZaGM+H8/336dbVyL28txxfpJpZdpxw1GsTsBs50ymHeJlxGe2c6ehePXneLg8DJhSxc4
         UhKZeHBc1Mn3NpezIVJhDc4UHc6dH5ZHd+0nyfxJR+BfLxmGFD3GhPjk2whgt97psUkc
         y7q7ogWrj1Dev3Y6Cie9ADlgsc95P6v9KkoTcsbG+OB6b4+nTMkNLBt1acqJBKyJJ2D1
         Sfw7v4I4xYiG4J3+9jH6KggBG0xLLdH4iVyIg2dOmBq5KA1uawQHriNbQ+TzqMKVAoFJ
         NqKA==
X-Gm-Message-State: APjAAAXHk8vBnJTlW0iiv5UgPgKbx4tl7Puoe8CT/EbXPFRvn63/7WXu
        S8vf1LW5OFn6uE6dsRFkPwWPsw==
X-Google-Smtp-Source: APXvYqz2e4+YAz3gMkVuEi5gyTiboR8jSeUJlxflVDvvuuaQofZK4swW8J85VuYxCm33g15kXEUd8w==
X-Received: by 2002:a65:484d:: with SMTP id i13mr5108450pgs.27.1559748448854;
        Wed, 05 Jun 2019 08:27:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id y10sm23446768pfm.68.2019.06.05.08.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 08:27:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/3] arm64: dts: meson: Add minimal support for Odroid-N2
In-Reply-To: <f1013078-5964-640e-de7a-4ad8b91ed005@baylibre.com>
References: <20190603091008.2382-1-narmstrong@baylibre.com> <20190603091008.2382-4-narmstrong@baylibre.com> <CANAwSgT964PY6OMkS-hoqBf39Np99-tzfGbpXGdLtxF600eDtQ@mail.gmail.com> <f1013078-5964-640e-de7a-4ad8b91ed005@baylibre.com>
Date:   Wed, 05 Jun 2019 08:27:27 -0700
Message-ID: <7hr288gihs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 03/06/2019 14:00, Anand Moon wrote:
>> Hi Niel,
>> 
>> On Mon, 3 Jun 2019 at 14:41, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>> This patch adds basic support for :
>>> - Amlogic G12B, which is very similar to G12A
>>> - The HardKernel Odroid-N2 based on the S922X SoC
>>>
>>> The Amlogic G12B SoC is very similar with the G12A SoC, sharing
>>> most of the features and architecture, but with these differences :
>>> - The first CPU cluster only has 2xCortex-A53 instead of 4
>>> - G12B has a second cluster of 4xCortex-A73
>>> - Both cluster can achieve 2GHz instead of 1,8GHz for G12A
>>> - CPU Clock architecture is difference, thus needing a different
>>>   compatible to handle this slight difference
>>> - Supports a MIPI CSI input
>>> - Embeds a Mali-G52 instead of a Mali-G31, but integration is the same
>>>
>>> Actual support is done in the same way as for the GXM support, including
>>> the G12A dtsi and redefining the CPU clusters.
>>> Unlike GXM, the first cluster is different, thus needing to remove
>>> the last 2 cpu nodes of the first cluster.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>>>  .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 289 ++++++++++++++++++
>>>  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 +++++
>>>  3 files changed, 372 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index e129c03ced14..07b861fe5fa5 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
>>> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>> new file mode 100644
>>> index 000000000000..161d8f0ff4f3
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>>> @@ -0,0 +1,289 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2019 BayLibre, SAS
>>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "meson-g12b.dtsi"
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
>>> +
>>> +/ {
>>> +       compatible = "hardkernel,odroid-n2", "amlogic,g12b";
>>> +       model = "Hardkernel ODROID-N2";
>>> +
>>> +       aliases {
>>> +               serial0 = &uart_AO;
>>> +               ethernet0 = &ethmac;
>>> +       };
>>> +
>
> [...]
>
>>> +
>>> +       main_12v: regulator-main_12v {
>>> +               compatible = "regulator-fixed";
>>> +               regulator-name = "12V";
>>> +               regulator-min-microvolt = <12000000>;
>>> +               regulator-max-microvolt = <12000000>;
>>> +               regulator-always-on;
>>> +       };
>>> +
>>> +       vcc_5v: regulator-vcc_5v {
>>> +               compatible = "regulator-fixed";
>>> +               regulator-name = "5V";
>>> +               regulator-min-microvolt = <5000000>;
>>> +               regulator-max-microvolt = <5000000>;
>>> +               regulator-always-on;
>> 
>> As per odroid-n2_rev0.4_20190307 schematic its missing.
>>                   vin-supply =  <&main_12v>;
>> 
>> With this please add my.
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>
> Good catch, thanks Anand.
>
> @Kevin, should I resend ?

No need, I've fixed it up locally,

Thanks,

Kevin
