Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29193C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012CA20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfDPWMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:12:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfDPWMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:12:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15AE2AF56;
        Tue, 16 Apr 2019 22:12:38 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Wed, 17 Apr 2019 08:12:28 +1000
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
Subject: Re: [PATCH 2/5] mmc: mtk-sd: don't hard-code interrupt trigger type
In-Reply-To: <1555402302.18628.17.camel@mhfsdcap03>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown> <155539004923.25108.12499096383277776864.stgit@noble.brown> <1555402302.18628.17.camel@mhfsdcap03>
Message-ID: <878sw97g6r.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16 2019, Chaotian Jing wrote:

> On Tue, 2019-04-16 at 14:47 +1000, NeilBrown wrote:
>> When using devicetree for configuration, interrupt trigger type
>> should be described in the dts file, not hard-coded in the C code.
>>=20
>> The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
>> and so cannot be used with the current code.
>>=20
>> So remove the trigger and leave it to be set from devicetree.
>>=20
>> Signed-off-by: NeilBrown <neil@brown.name>
>> ---
>>  drivers/mmc/host/mtk-sd.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>> index 4492a4465c0e..14e048239143 100644
>> --- a/drivers/mmc/host/mtk-sd.c
>> +++ b/drivers/mmc/host/mtk-sd.c
>> @@ -2243,7 +2243,7 @@ static int msdc_drv_probe(struct platform_device *=
pdev)
>>  	msdc_init_hw(host);
>>=20=20
>>  	ret =3D devm_request_irq(&pdev->dev, host->irq, msdc_irq,
>> -		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
>> +
> change it to IRQF_TRIGGER_NONE | IRQF_ONESHOT

Why do we need IRQF_ONESHOT.  That is for threaded interrupted
handlers...
msdc_irq() clears the interrupts, so ONESHOT isn't needed.

???

NeilBrown


>> 			       0, pdev->name, host);
>>  	if (ret)
>>  		goto release;
>>=20=20
>>=20
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAly2U0wACgkQOeye3VZi
gbljERAAtkbTW3fr0lNdKM5Qsh7w1WZVpv7b7n0OUcL6menI0j1novdyKfV83FJz
IljS2rbbngDCe0COqfZGLlCSmHSatVRvUWZzYrLQENPnmuecu72VCRyrJbWLyMHQ
HQJyozpLN3y/DD6bmuReUrBv4MS6OfTdYNtFE+gTLAvmnVDzSuugKHMBtoh6XCXm
k6hgFrGAwV6YBtzJIYxBxb2R06WVgT1ciT65g+uEdv9FWeTqilS/foTRo/baw6VR
EHxnvoL6TTYzr1RX2jBp5zjERB/gWtyFDw6zinuIBswLt+8p21/k9ZY4fLKNPqdF
hJUgpuq0I0Fsbh4ru/z2tZj3Uki522JYATHFcyzPxQgXTD9bnV4KlMHPxNkIWMzm
8AJXE8G2f9R55lzEH7VCEBPsi3Xmb9bTFPiEcqI01Fc6qx9axwSqDTTqAGlhKYs6
a/1Y0UsG9rmP7FPcanw4VJQl4BTnXdFVS9NqlZq6Z6TWTbw0d3r2Mj717YXYWKLm
cvCsEO0oZTReDs3WvEuwMZVCJcozaeZlnp1WyFs/2VHTQ+dOQduKI0IjbfyZOi2M
j9fjQXa9lWg1FZhR1OajQeWkL3DyqTLldiFPc++l5Q6Xpt4D0Qy0/aw9tL13B1q9
U3zbB4iU85APZBbYstR7JC+pNjsRaFuSRHD5M+4QLTJ32KdInHo=
=7WTR
-----END PGP SIGNATURE-----
--=-=-=--
