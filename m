Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBE620848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="gLCodwqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCAWlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:41:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:60514 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCAWlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551480058; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZOCv1w4NpvFoFLPRHBg18/Ij6Qbf5c21dh3PnLMa+k=;
        b=gLCodwqDPk5pDeaYvFBR5R2YeU6bA/m5Yk9SWLmMfqA2CaVBlosdjGd4pI2whfPYG6bjN3
        fpucZ57Ss73jieXJ0G+zIkqxBq7/nHecn8/uPLzE+mwS8OLtpwcFZ263InzXM4P0ue4HTr
        6lUzRdS2liQ4aOMyi849smqwYzFZmKw=
Date:   Fri, 01 Mar 2019 19:40:42 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] dt-bindings: Add doc for the ingenic-drm driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <1551480042.1526.0@crapouillou.net>
In-Reply-To: <20190301201624.GA22317@ravnborg.org>
References: <20190228220756.20262-1-paul@crapouillou.net>
        <20190228220756.20262-2-paul@crapouillou.net>
        <20190301201624.GA22317@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, thanks for the feedback.

Le ven. 1 mars 2019 =E0 17:16, Sam Ravnborg <sam@ravnborg.org> a =E9crit :
> Hi Paul.
>=20
> Good to see work migrating fbdev =3D> drm.
>=20
> Following comments is based on experience while working on migrating
> another driver from fbdev =3D> drm.
>=20
> On Thu, Feb 28, 2019 at 07:07:54PM -0300, Paul Cercueil wrote:
>>  Add documentation for the devicetree bindings of the DRM driver for=20
>> the
>>  JZ47xx family of SoCs from Ingenic.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>   .../devicetree/bindings/display/ingenic,drm.txt    | 30=20
>> ++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/display/ingenic,drm.txt
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/display/ingenic,drm.txt=20
>> b/Documentation/devicetree/bindings/display/ingenic,drm.txt
>>  new file mode 100644
>>  index 000000000000..52a368ec35cd
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
>>  @@ -0,0 +1,30 @@
>>  +Ingenic JZ47xx DRM driver
>>  +
>>  +Required properties:
>>  +- compatible: one of:
>>  +  * ingenic,jz4740-drm
>>  +  * ingenic,jz4725b-drm
>>  +- reg: LCD registers location and length
> The fbdev way of doing this was to hardcode register setttings.
> In the drm world we read the configuration of the panel and let
> this decide the actual configuration.
>=20
> Note that no drm drivers supports stn displays and that there
> is really no use for this these days. So you can skip the STN parts.

STN panels aren't really my problem; but I have a board with a Sharp
LS020B1DD01D panel, which requires the LCD IP to be configured for a
"special 2" panel. I also have a board with a "smart" panel (ili9331)
that needs a special configuration in the IP. There is nothing in
the drm_panel interface that tells me what mode I should use for what
panel...

> Also the modern way to specify a panel in the DT is using OF graph=20
> bindings.
> You can find many examples how to do this.

Ok, I was looking at the Tegra driver, which uses a "nvidia,panel" DT
property. I will change it to use the graph thing.

> I was there with the atmel LCDC driver (not in the kernel yet),
> and had some challenges with this.
>=20
> 	Sam

Thanks,
-Paul
=

