Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03CF218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZONdG6+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfJIFUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 01:20:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:51327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfJIFUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 01:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570598393;
        bh=jsvszXWy2fmSnGd+4dEOZil+sNST0DwgpzxtQE9FqVo=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=ZONdG6+OUiPhQN3audB3vLaCF54GOn7Nmo20S4YdoA006FUNb66Nc5lFMwNBYWUA9
         eV44UGw38fPCkCbFI2zWIgvHXx1GZgaOzXoWMqTDHHreoNRCizRVh6ipvjEw01/u1T
         QhGXcuJs82VGWjQvGrlJEdWhSbxYREkYAFoyGHrM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-bq ([37.60.0.182]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1i5zVd2Ry8-01356j; Wed, 09
 Oct 2019 07:19:53 +0200
Date:   Wed, 09 Oct 2019 07:19:49 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20191004152001.GS18429@dell>
References: <20191003185323.24646-1-frank-w@public-files.de> <20191004152001.GS18429@dell>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mfd: mt6397: fix probe after changing mt6397-core
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <8AE93E81-9836-4509-A850-468547569AA4@public-files.de>
X-Provags-ID: V03:K1:rtFiAFFEcwLNTyLU2LbSMAHvQs2xGApRGVsufAMJCqjjXvrOCJr
 GA/cRZW5qlrvHvdKW+JYdAr4TWcFHnDE4iGtTvyZHtuC/Lj7k1W/uugR4FvN6RoFd11XDRa
 b1WYgORNZ8LNb2ZXUXYZf/0TDuSIK+H4MtDoZgW9oxauSx7orEJ+SrXSY1wt91xVv/rgq3Z
 hcV6tX1I9l2mSYvrUIW2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0x7ZW0UPvFc=:Rx1VGnIzUJFQnGK19GM+7Q
 HJOzFrErnP/ISSrz5b2Btxg55q70B7H4cdRn4LuCT5PCfM2XNBdXtyXEZKoha3GHkQRmXJhb4
 HJWayvpBOZG4zvg6nMN0pjvj9oqKTx6eqoKeC5W9mERwT1uzJftPDkTTLRnajcYeHmBPOhEtC
 gqFMMpqdbNqgO3WFDXjSOam6BIeu0nMWOXaSeihaHKwr1wOQh3nVM5NJFLGAP//FmMVV1INp4
 6i7/txhWF0Sr7ufmyDGgCAEMG7u4n4ZStVX99d2nmbAyGU+HyV9Q5e5CSKTEDotS1itIM7zwg
 6BFyLaoeV1N63Udl580VCULw3X4/Sb9enE2yIhK0qZDUOGLOxNx7GEKv0c/yosbL9R7nErRXD
 c02GGMUfA148pZ3aSrdIq1KsMYgWN5TqpAXGZXVoiS1QRZWlqou590MGHx9X689zpLfbX4kmv
 i91O9lGkZFRUW7cipAEzNoxUiqVdFU4Qi0JE2LTqTI+ZlVvOYfn9VVwIVEUuLrWwT4PGAit23
 qnF33mhRg+u/sbg4Heo3007byaJsPtr3s3tX3mvetkM8CTO0Muj5AW0KBP2Xe5pyyIw5MtATa
 jcaIlTO0DI8AIdYGtj5GllIJt0bTvtcjAjndCFvSSmwAOfAWaBi+SVQFOEhzX55T7ObLzVCkH
 GbTG3m8lLG9fkV96kdO6O1TZneh+MvivSik93cevyfENy9xDDkVzN2dw57L5Y2nPE5010+aUU
 dHCwVevh5oHGccoUcc+MMXbJAYc2xvh2it0hnKtwWAELmRh4Zs7JF+Jqi9v/7V2iF54qd/UXo
 GbN+5GxDZ7BWzTreKLUiWNjYsdT2M1mboj/WCeW0pFY92lhEqsa+ev/YS3LujcREOyB+iFiTF
 wk6tuUxHGvojJC9+XjnseHBNsxrCeAQw/9rHX01jDXzfudSnU+iP4TVZubSgMbEECF+YnkHyr
 +TXfiCdf109gEUpBPmBkUoBQBTn59V6k7+7/F5hzKrrCIJwsRs9Uv+BJaoCDJcaCb96ng1Gz+
 o/JG1tIGg+XKvvTb0CVG1NokskDMRs+1PGsn9dT8TrRVjhdp8T7FkHPgelUDFUeI0NCrPGOtA
 2h3PymqtT9PQt/fde5eerYQ0FCyreKmqLqYQ5DNe4eTuIxXxGesH/377sJO+CcKjkO5FdQ2FB
 0Arg7Ki/68ROqit+1+Y2DqDu4MTm6w9FUQCDhoUU90lbSP12n76DATHuHryxY/PWlTrpEc9UT
 ocKiRdMG9PAF/0Pisc2P7eOSCSbUp3BSKfWXcpAW8M3t4a7YpItGZ4eekjoI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should i send patch without the shift (because rest of series gets not merg=
ed in 5=2E4)?

Am 4=2E Oktober 2019 17:20:01 MESZ schrieb Lee Jones <lee=2Ejones@linaro=
=2Eorg>:
>On Thu, 03 Oct 2019, Frank Wunderlich wrote:
>
>> Part 3 from this series [1] was not merged due to wrong splitting
>> and breaks mt6323 pmic on bananapi-r2
>>=20
>> dmesg prints this line and at least switch is not initialized on
>bananapi-r2
>>=20
>> mt6397 1000d000=2Epwrap:mt6323: unsupported chip: 0x0
>>=20
>> this patch contains only the probe-changes and chip_data structs
>> from original part 3 by Hsin-Hsiung Wang
>>=20
>> Fixes: a4872e80ce7d2a1844328176dbf279d0a2b89bdb mfd: mt6397: Extract
>IRQ related code from core driver
>>=20
>> [1]
>https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/list/?series=3D16=
4155
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  drivers/mfd/mt6397-core=2Ec | 64
>++++++++++++++++++++++++---------------
>>  1 file changed, 40 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/drivers/mfd/mt6397-core=2Ec b/drivers/mfd/mt6397-core=2Ec
>> index 310dae26ddff=2E=2Eb2c325ead1c8 100644
>> --- a/drivers/mfd/mt6397-core=2Ec
>> +++ b/drivers/mfd/mt6397-core=2Ec
>> @@ -129,11 +129,27 @@ static int mt6397_irq_resume(struct device
>*dev)
>>  static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
>>  			mt6397_irq_resume);
>> =20
>> +struct chip_data {
>> +	u32 cid_addr;
>> +	u32 cid_shift;
>> +};
>> +
>> +static const struct chip_data mt6323_core =3D {
>> +	=2Ecid_addr =3D MT6323_CID,
>> +	=2Ecid_shift =3D 0,
>> +};
>> +
>> +static const struct chip_data mt6397_core =3D {
>> +	=2Ecid_addr =3D MT6397_CID,
>> +	=2Ecid_shift =3D 0,
>> +};
>
>Will there be other devices which have a !0 CID shift?
>
>--=20
>Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>Linaro Services Technical Lead
>Linaro=2Eorg =E2=94=82 Open source software for ARM SoCs
>Follow Linaro: Facebook | Twitter | Blog
>
>_______________________________________________
>Linux-mediatek mailing list
>Linux-mediatek@lists=2Einfradead=2Eorg
>http://lists=2Einfradead=2Eorg/mailman/listinfo/linux-mediatek
