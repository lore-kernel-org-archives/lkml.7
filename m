Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958ABC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FF32084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 08:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEDISl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 04:18:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:35814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfEDISl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 04:18:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9109AE41;
        Sat,  4 May 2019 08:18:39 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Sat, 04 May 2019 18:18:31 +1000
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
Subject: Re: [PATCH 4/5] mmc: mtk-sd: enable internal card-detect logic.
In-Reply-To: <1555569583.18628.29.camel@mhfsdcap03>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown> <155539004931.25108.17076624786044710325.stgit@noble.brown> <1555569583.18628.29.camel@mhfsdcap03>
Message-ID: <87o94i3a5k.fsf@notabene.neil.brown.name>
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

On Thu, Apr 18 2019, Chaotian Jing wrote:

> On Tue, 2019-04-16 at 14:47 +1000, NeilBrown wrote:
>> The mtk-sd silicon has integrated card-detect logic that is
>> enabled, at least, on the MT7621 as used in the GNUBEE NAS.
>>=20
>> If the sdhci isn't marked non-removable and doesn't have a
>> cd-gpio configured, assume the internal cd logic should be used.
>>=20
>> Signed-off-by: NeilBrown <neil@brown.name>
...

>> @@ -2206,6 +2247,15 @@ static int msdc_drv_probe(struct platform_device =
*pdev)
>>  		goto host_free;
>>  	}
>>=20=20
>> +	if (!(mmc->caps & MMC_CAP_NONREMOVABLE) &&
>> +	    !mmc_can_gpio_cd(mmc)) {
>
> Should not do this assume!
> better to add "mediatek,internal-cd" in your DTS, then no impact to
> other Soc.

(Sorry for the delay).

Documentation/devicetree/bindings/mmc/mmc.txt

says:
   If no property below is supplied, host native card detect is used.

So this assumption is *exactly* what the documentation said we should
do.

How about I limit this assumption to mt7621 using a flag in the
mtk_mmc_compatible structure?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzNStcACgkQOeye3VZi
gbnPBA//eN9sE9P0TV5+KckYl7NgUH1whziK3Ot5PrCfyuwxOQIqSxuIF7ZRDS+X
6gk6CDYO59Y2DAvCTUJNUWWwEoSrB21EMbKTBmcTLywiaBqTPGn4k8usUQ3xchnh
oZQzfUrwyOM8b0O1jBRh0CJkk345rFMaew30WO1Qvyq4PGUAIEtFpDap1Xd5KWOP
ax8hG1FX/G3mmd2gIxMp8HJmIRvEhnXZOPQ2lI4PRktLO8jG1ltBjF8schg/v8Fh
aIGO+F4bjQRdGrnSPIFbIbu5p5s5oXPW1KDJSzvim7IUFrg9iyBkpgkpnkgT6Id4
oa1x05CG01yNQ5LKtZZGkyiU1XH602964hbzZ9Qvtw7KYV9QqRniDvCx3XxRIIea
MW77EhImTh98jwhjj9hP5R1i/hBUJ3nYs7vVF4AMfSik+dyJyhu1+j26tnD7JQdp
efMeOX1grtDqGrlw1aCWsRBrTA343H/zUMHoRPHnCusOSuSZ7kVDkJ4b/306Gfyi
hGckqJ6+9XTFFWG2r7WfTS+XDVgvZbtcPj0OZhpsg+kWN+/6CfY9zv0ZdK2erPdi
ZTOlse/zGjzTh4vqHV2ajkreK/LRDmR4s4m1iXoynx7SCzR7bjTDcso6bP15ihdc
pHPLL2kBlScb9RZYc3ldl9LFAnQhsMV5uOM0mzrYSR+eb419kkY=
=Q94r
-----END PGP SIGNATURE-----
--=-=-=--
