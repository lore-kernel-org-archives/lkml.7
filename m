Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812BE214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JGhZbQDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDDBuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:50:24 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55096 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:50:24 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 54CCB886BF;
        Thu,  4 Apr 2019 14:50:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1554342621;
        bh=3GmtZ4RdryulcpU69QBeS9k4ZUOi8Znu7cTy9MsiWCM=;
        h=From:To:CC:Subject:Date;
        b=JGhZbQDVq+MuOv3WOcV/V3UJMtUL+Qe7f+cDdrwCa2AD/yAnlzkawOSrdAKseo9Oz
         /kXIARAegcRm2ajyEDIzMlnrSs7rtEnn9Vzi5VSJrtPxYru1v/WgMNu8S7xbkIw7GO
         y6L8BlXCzI/g+W0Pa7uKmpb1KIm3hnAi0pu9fhdi/ruD+owAaVTDswmmPxuEe30IHR
         b7BQmSIDSzk64p89voywECyKqsfs7WRl5M01ATGxRjzMkivDotnnaA0k0MWm35RZD+
         sPHha1IGbTNEPNRO7n4T7ybHHlt+fWJsy7MhR2fuA9s/Y8aWbkIJblWzwdm+2NNeVq
         /WoAqpH5AS+Ow==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ca562dd0001>; Thu, 04 Apr 2019 14:50:21 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 4 Apr 2019 14:50:21 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 4 Apr 2019 14:50:21 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Using device tree overlays in Linux
Thread-Topic: Using device tree overlays in Linux
Thread-Index: AQHU6ojCpZF8ouBfMkagL4RUBC6Q3g==
Date:   Thu, 4 Apr 2019 01:50:20 +0000
Message-ID: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
I'm implementing support for some modular Linux based systems using =0A=
device tree overlays. The code is working but it seems a little more =0A=
fiddly that than it should be so I'm wondering if I'm doing it right.=0A=
=0A=
An example of what I'm doing is=0A=
=0A=
=0A=
arch/arm/boot/dts/Makefile:=0A=
DTC_FLAGS_myboard +=3D -@=0A=
=0A=
drivers/foo/Makefile:=0A=
obj-y +=3D myplugin.dtb.o=0A=
obj-y +=3D mydriver.o=0A=
=0A=
drivers/foo/myplugin.dts:=0A=
/dts-v1/;=0A=
/plugin/;=0A=
/{=0A=
	fragment@0 {=0A=
		target =3D <&i2c0>;=0A=
		__overlay__ {=0A=
			gpio@74 {=0A=
				compatible =3D "nxp,pca9539";=0A=
				reg =3D <0x74>=0A=
			};=0A=
		};=0A=
	};=0A=
};=0A=
=0A=
drivers/foo/mydriver.c:=0A=
extern uint8_t __dtb_myplugin_begin[];=0A=
extern uint8_t __dtb_myplugin_end[];=0A=
=0A=
int mydriver_probe(struct platform_device *pdev)=0A=
{=0A=
	u32 size =3D __dtb_myplugin_end - __dtb_myplugin_begin;=0A=
	int overlay_id;=0A=
	int ret;=0A=
	=0A=
	ret =3D of_overlay_fdt_apply(__dtb_myplugin_begin,=0A=
				   size, &overlay_id);=0A=
	return ret;=0A=
}=0A=
=0A=
=0A=
The first issue is that I need to add -@ to the DTC_FLAGS for my board =0A=
dtb. I kind of understand that I only need -@ if my overlay targets =0A=
something symbolic so I might not need it but I was surprised that there =
=0A=
wasn't a Kconfig option that makes this happen automatically.=0A=
=0A=
externing things in C files makes checkpatch.pl complain. I see the =0A=
of/unittests.c and rcar_du_of.c hide this with a macro. I was again =0A=
surprised that there wasn't a common macro to declare these.=0A=
=0A=
=0A=
