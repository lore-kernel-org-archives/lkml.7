Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3223A22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="etrBidu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfHUKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:47:59 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38820 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfHUKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1566384475; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCAftt3lJ09+T5g6O8rgBlvklX6m4wsgkMOQe1tylGQ=;
        b=etrBidu99dqcPni2DzX+1LekMpTbWLg2CzthJsiYXn5GFm0I9aILx7OGWMnWHW7FJFmVFU
        s666lbabp6Q709Lxw4JvMVyeLtuFPnYNxhGOPayz1UhuvaCQkMAy7XSZPpWCG3S1DZtWbB
        VPyMOdqq8827JcgFK5dPmMpdV0xicEQ=
Date:   Wed, 21 Aug 2019 12:47:39 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] dt-bindings: Document JZ47xx VPU auxiliary
 processor
To:     Rob Herring <robh@kernel.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1566384459.1884.0@crapouillou.net>
In-Reply-To: <20190820205044.GA1223@bogus>
References: <20190729183109.18283-1-paul@crapouillou.net>
        <20190820205044.GA1223@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


Le mar. 20 ao=FBt 2019 =E0 22:50, Rob Herring <robh@kernel.org> a =E9crit :
> On Mon, Jul 29, 2019 at 02:31:07PM -0400, Paul Cercueil wrote:
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
>>=20
>>   .../bindings/remoteproc/ingenic,vpu.txt       | 36=20
>> +++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt=20
>> b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
>>  new file mode 100644
>>  index 000000000000..576f9e582780
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
>>  @@ -0,0 +1,36 @@
>>  +* Ingenic JZ47xx auxiliary processor
>>  +
>>  +Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs=20
>> from Ingenic
>>  +is a second Xburst MIPS CPU very similar to the main core.
>>  +This document describes the devicetree bindings for this auxiliary=20
>> processor.
>>  +
>>  +Required properties:
>>  +- compatible: Should be "ingenic,jz4770-vpu-rproc"
>>  +- reg: Must contain the registers location and length for:
>>  +  * the auxiliary processor,
>>  +  * the Tightly Coupled Shared Memory 0 (TCSM0),
>>  +  * the Tightly Coupled Shared Memory 1 (TCSM1),
>>  +  * the shared SRAM.
>>  +- reg-names: Must contain "aux", "tcsm0", "tcsm1", "sram".
>>  +- clocks: Clock specifier for the AUX and VPU clocks.
>>  +- clock-names: Must contain "aux", "vpu".
>>  +- interrupts: Interrupt specifier for the VPU hardware block.
>>  +
>>  +Example:
>>  +
>>  +vpu: cpu@132a0000 {
>=20
> cpu is reserved for CPUs under /cpus/. Use video-codec or=20
> video-decoder
> or ?? It's not clear what type of video processing this does.

Hardware decode and encode of mpeg-2 and h264. I guess I'll use=20
'video-decoder' then.


>=20
>>  +	compatible =3D "ingenic,jz4770-vpu-rproc";
>>  +
>>  +	reg =3D <0x132a0000 0x20 /* AUX */
>>  +		   0x132b0000 0x4000 /* TCSM0 */
>>  +		   0x132c0000 0xc000 /* TCSM1 */
>>  +		   0x132f0000 0x7000 /* SRAM */
>>  +	>;
>>  +	reg-names =3D "aux", "tcsm0", "tcsm1", "sram";
>>  +
>>  +	clocks =3D <&cgu JZ4770_CLK_AUX>, <&cgu JZ4770_CLK_VPU>;
>>  +	clock-names =3D "aux", "vpu";
>>  +
>>  +	interrupt-parent =3D <&cpuintc>;
>>  +	interrupts =3D <3>;
>>  +};
>>  --
>>  2.21.0.593.g511ec345e18
>>=20

=

