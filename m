Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17C7C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8053D21743
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KAadwpkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbfHFH7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:59:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42073 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfHFH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:59:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so36975029wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0jpzu7N7BsP1VTKn6SaBBYfX2bOHc+E6EaagQmvrJ2k=;
        b=KAadwpkUrbOoQ989pzgCF1/nXwbP1IkkDAvvTWWre3gmn14ax4AV49Qh3mM5+jlPCz
         h3jS4Fxe7KmKNs+iD3OXXJtVuffqMC6EIuUBaFoZWJplXceKwfNPa0wWujuN5ffHNYE4
         gEg8+8WYN2QtioyIV6XHFaeI72dfhYIY880gohnHkHknVY88i7EHTsO+Xv96duNaL25n
         TgX7Qm0wsO2zvogAnT2s8/JOGNLKxzjFVyi95udEtPrg1W3ZCH2hX437onnaBvysF/T+
         Aj/nzLRKjgcc9EgCeSTvkCswUrNc64y93/9dEXZM6KFTpIgW54JOrSMqxnWuzNODtbX1
         ET1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0jpzu7N7BsP1VTKn6SaBBYfX2bOHc+E6EaagQmvrJ2k=;
        b=RxZRzz59/p3qmIiL8xtdt//Pg+uyPhLDghKF9aw8IA6UnEUtRF4xTknelES5FH81SD
         2iepgHjGpvO8x51uSSoIGLSmi6cQ+ywGBuNKCPgisOOGKbpWV1GtiQROHCdMEbBEluCV
         /9J75t9pQq8ONZEGFgUmqEE491G/t69SFzpVTeK+p/eYG8nUrqwuHmOGh9ioDy2RLVPt
         qixsYlcapLyxeLj4xyk2/ugTTmMgyO9UwgXFQHJzxmEEjelXl18k+CfXtw7+H4UIC8wY
         RN30QvU0c52+sj1/QJklF7MSTOHxLjm/BRbutEuIA1INevW3AWr7XXHrwMmiJHi2g+jh
         SaZQ==
X-Gm-Message-State: APjAAAWQRz+hGJZamhkJ6yDa7C/QYrZ4PgzByfe8E178ylGQb+fKmzG2
        HUPIxijZaMIx//EIm/sfJ5NfY2mDOffJWg==
X-Google-Smtp-Source: APXvYqx0S78akU8v6+0QvhaK+gQ+SteoV/oBIwE21MV/EkelU53v84DKHkisQiYQus5RFh31GiMdng==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr3152392wrt.295.1565078355350;
        Tue, 06 Aug 2019 00:59:15 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p10sm15591437wmk.2.2019.08.06.00.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 00:59:14 -0700 (PDT)
Subject: Re: [PATCH 2/3] dt-bindings: display: amlogic,meson-vpu: convert to
 yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190805134319.737-1-narmstrong@baylibre.com>
 <20190805134319.737-3-narmstrong@baylibre.com>
 <CAL_JsqLMS2y5ZR4SH6TVwnaTDhnGwk2_C_81DTz9J=ypDdBd4w@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <a887183e-01d5-f4fc-7d12-eeda9c7e278f@baylibre.com>
Date:   Tue, 6 Aug 2019 09:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLMS2y5ZR4SH6TVwnaTDhnGwk2_C_81DTz9J=ypDdBd4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2019 00:19, Rob Herring wrote:
> On Mon, Aug 5, 2019 at 7:43 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Now that we have the DT validation in place, let's convert the device tree
>> bindings for the Amlogic Display Controller over to YAML schemas.
>>
>> The original example has a leftover "dmc" memory cell, that has been
>> removed in the yaml rewrite.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../bindings/display/amlogic,meson-vpu.txt    | 121 --------------
>>  .../bindings/display/amlogic,meson-vpu.yaml   | 153 ++++++++++++++++++
>>  2 files changed, 153 insertions(+), 121 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
>>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> 
> 
>> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
>> new file mode 100644
>> index 000000000000..9eba13031998
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
>> @@ -0,0 +1,153 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2019 BayLibre, SAS
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/display/amlogic,meson-vpu.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Amlogic Meson Display Controller
>> +
>> +maintainers:
>> +  - Neil Armstrong <narmstrong@baylibre.com>
>> +
>> +description: |
>> +  The Amlogic Meson Display controller is composed of several components
>> +  that are going to be documented below
>> +
>> +  DMC|---------------VPU (Video Processing Unit)----------------|------HHI------|
>> +     | vd1   _______     _____________    _________________     |               |
>> +  D  |-------|      |----|            |   |                |    |   HDMI PLL    |
>> +  D  | vd2   | VIU  |    | Video Post |   | Video Encoders |<---|-----VCLK      |
>> +  R  |-------|      |----| Processing |   |                |    |               |
>> +     | osd2  |      |    |            |---| Enci ----------|----|-----VDAC------|
>> +  R  |-------| CSC  |----| Scalers    |   | Encp ----------|----|----HDMI-TX----|
>> +  A  | osd1  |      |    | Blenders   |   | Encl ----------|----|---------------|
>> +  M  |-------|______|----|____________|   |________________|    |               |
>> +  ___|__________________________________________________________|_______________|
>> +
>> +
>> +  VIU: Video Input Unit
>> +  ---------------------
>> +
>> +  The Video Input Unit is in charge of the pixel scanout from the DDR memory.
>> +  It fetches the frames addresses, stride and parameters from the "Canvas" memory.
>> +  This part is also in charge of the CSC (Colorspace Conversion).
>> +  It can handle 2 OSD Planes and 2 Video Planes.
>> +
>> +  VPP: Video Post Processing
>> +  --------------------------
>> +
>> +  The Video Post Processing is in charge of the scaling and blending of the
>> +  various planes into a single pixel stream.
>> +  There is a special "pre-blending" used by the video planes with a dedicated
>> +  scaler and a "post-blending" to merge with the OSD Planes.
>> +  The OSD planes also have a dedicated scaler for one of the OSD.
>> +
>> +  VENC: Video Encoders
>> +  --------------------
>> +
>> +  The VENC is composed of the multiple pixel encoders
>> +   - ENCI : Interlace Video encoder for CVBS and Interlace HDMI
>> +   - ENCP : Progressive Video Encoder for HDMI
>> +   - ENCL : LCD LVDS Encoder
>> +  The VENC Unit gets a Pixel Clocks (VCLK) from a dedicated HDMI PLL and clock
>> +  tree and provides the scanout clock to the VPP and VIU.
>> +  The ENCI is connected to a single VDAC for Composite Output.
>> +  The ENCI and ENCP are connected to an on-chip HDMI Transceiver.
>> +
>> +  The following table lists for each supported model the port number
>> +  corresponding to each VPU output.
>> +
>> +                  Port 0       Port 1
>> +  -----------------------------------------
>> +   S905 (GXBB)   CVBS VDAC        HDMI-TX
>> +   S905X (GXL)   CVBS VDAC        HDMI-TX
>> +   S905D (GXL)   CVBS VDAC        HDMI-TX
>> +   S912 (GXM)      CVBS VDAC      HDMI-TX
>> +   S905X2 (G12A)       CVBS VDAC          HDMI-TX
>> +   S905Y2 (G12A)       CVBS VDAC          HDMI-TX
>> +   S905D2 (G12A)       CVBS VDAC          HDMI-TX
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - amlogic,meson-gxbb-vpu # GXBB (S905)
>> +              - amlogic,meson-gxl-vpu # GXL (S905X, S905D)
>> +              - amlogic,meson-gxm-vpu # GXM (S912)
>> +          - const: amlogic,meson-gx-vpu
>> +      - enum:
>> +          - amlogic,meson-g12a-vpu # G12A (S905X2, S905Y2, S905D2)
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +   items:
>> +     - const: vpu
>> +     - const: hhi
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    description: phandle to the associated power domain
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
> 
> Common properties don't need a type definition. As this can be an
> array, you just need 'maxItems: 1'.

Ok

> 
> Same comments on patch 1 apply here too.

OK

> 
> Rob
> 

