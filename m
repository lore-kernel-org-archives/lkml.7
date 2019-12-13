Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A921C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C244E21655
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="S/u7q0cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLMV1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:27:51 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50664 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576272468; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B87WmKoBPFu2Odj1rZgXnJF/hh74OP8To16AjhM4gEs=;
        b=S/u7q0cZey8t0mX3IWoQ6L1CNL9zSiXDJyUiXBOI0DV8iQC/G1125BRG2SoAqYgAPH1HQ0
        fXQngvZwyZciGJYiLdDaJDiE87ftc1ZHip/uI/nPVKGMPiqWMjLLBuXKP5ObbufH3Fem7Y
        QKiLN9O8+xeDT23IiKmCBR30+GmFytE=
Date:   Fri, 13 Dec 2019 22:27:38 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/5] dt-bindings: Document JZ47xx VPU auxiliary
 processor
To:     Rob Herring <robh@kernel.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1576272458.3.4@crapouillou.net>
In-Reply-To: <20191213190200.GA11267@bogus>
References: <20191210164014.50739-1-paul@crapouillou.net>
        <20191213190200.GA11267@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


Le ven., d=E9c. 13, 2019 at 13:02, Rob Herring <robh@kernel.org> a=20
=E9crit :
> On Tue, Dec 10, 2019 at 05:40:10PM +0100, Paul Cercueil wrote:
>>  Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs=20
>> from
>>  Ingenic is a second Xburst MIPS CPU very similar to the main core.
>>  This document describes the devicetree bindings for this auxiliary
>>  processor.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: Update TCSM0 address in example
>>      v3: Change node name to 'video-decoder'
>>      v4: Convert to YAML. I didn't add Rob's Ack on v3 because of=20
>> that (sorry Rob)
>>=20
>>   .../bindings/remoteproc/ingenic,vpu.yaml      | 76=20
>> +++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml=20
>> b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
>>  new file mode 100644
>>  index 000000000000..9f876d16a5a6
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
>>  @@ -0,0 +1,76 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: "http://devicetree.org/schemas/remoteproc/ingenic,vpu.yaml#"
>>  +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>  +
>>  +title: Ingenic Video Processing Unit bindings
>>  +
>>  +description:
>>  +  Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs=20
>> from
>>  +  Ingenic is a second Xburst MIPS CPU very similar to the main=20
>> core.
>>  +  This document describes the devicetree bindings for this=20
>> auxiliary
>>  +  processor.
>>  +
>>  +maintainers:
>>  +  - Paul Cercueil <paul@crapouillou.net>
>>  +
>>  +properties:
>>  +  compatible:
>>  +    const: ingenic,jz4770-vpu-rproc
>>  +
>>  +  reg:
>>  +    items:
>>  +      - description: aux registers
>>  +      - description: tcsm0 registers
>>  +      - description: tcsm1 registers
>>  +      - description: sram registers
>>  +
>>  +  reg-names:
>>  +    items:
>>  +      - const: aux
>>  +      - const: tcsm0
>>  +      - const: tcsm1
>>  +      - const: sram
>>  +
>>  +  clocks:
>>  +    items:
>>  +      - description: aux clock
>>  +      - description: vpu clock
>>  +
>>  +  clock-names:
>>  +    items:
>>  +      - const: aux
>>  +      - const: vpu
>>  +
>>  +  interrupts:
>>  +    description: VPU hardware interrupt
>>  +
>>  +required:
>>  +  - compatible
>>  +  - reg
>>  +  - reg-names
>>  +  - clocks
>>  +  - clock-names
>>  +  - interrupts
>>  +
>>  +additionalProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    vpu: video-decoder@132a0000 {
>>  +      compatible =3D "ingenic,jz4770-vpu-rproc";
>>  +
>>  +      reg =3D <0x132a0000 0x20 /* AUX */
>>  +           0x132b0000 0x4000 /* TCSM0 */
>>  +           0x132c0000 0xc000 /* TCSM1 */
>>  +           0x132f0000 0x7000 /* SRAM */
>>  +      >;
>>  +      reg-names =3D "aux", "tcsm0", "tcsm1", "sram";
>>  +
>>  +      clocks =3D <&cgu JZ4770_CLK_AUX>, <&cgu JZ4770_CLK_VPU>;
>=20
> Examples are built now by 'make dt_binding_check' and this fails. You
> need to add the include for these defines.

Strange, "make dt_binding_check" does not complain here about this file=20
with your latest dt-schema tool and Linux 5.5-rc1.

>=20
> Also, the schema should complain after that on 'reg'. You need to <>
> each entry (addr and size).

Ok.

-Paul

>=20
>>  +      clock-names =3D "aux", "vpu";
>>  +
>>  +      interrupt-parent =3D <&cpuintc>;
>>  +      interrupts =3D <3>;
>>  +    };
>>  --
>>  2.24.0
>>=20

=

