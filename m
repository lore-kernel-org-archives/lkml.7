Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60109C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E7420872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="X2obqZx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfDPPdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:33:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46210 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbfDPPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:33:11 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GFDFHZ019039;
        Tue, 16 Apr 2019 17:32:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=61MvAHL/EPzyX/edUQQ7IU72jytbHArLxrUanjOictU=;
 b=X2obqZx/dvmQWr7TNSs+MXgob6avjxXr59JCDfEKb03tdk+Z8TUg88ifhDMMgxMtn3Kn
 pgnfDAZb5F/9IJHulDJyrD/s1ydetoKBiFZNQB175zE+G76X+Chj/Htt9EafCRQzF10j
 xIwp/5SsHmMTMuGgE20tHmyb3smor9b9YojC33Ojgaf0s+xJft+YaaGDWI1n4bYatB2K
 hFjIBXrXuQwzGPWsJVN5DEa6j4HZyBoWJNQ8szQbylxYdc9bFfoW67UVx1CnG0kmHAl/
 ZALROHPzc3JJsSbxK7meuTbat83mKZVEoWlMvKzVZZttZdu9GgdG4ASJkcNiMUKoPEuA dQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru6ngskya-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 16 Apr 2019 17:32:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C30F31;
        Tue, 16 Apr 2019 15:32:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CEE71272A;
        Tue, 16 Apr 2019 15:32:46 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 16 Apr
 2019 17:32:47 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 16 Apr 2019 17:32:46 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
Subject: Re: [RFC PATCH regulator] regulator: ready_mask_table[] can be static
Thread-Topic: [RFC PATCH regulator] regulator: ready_mask_table[] can be
 static
Thread-Index: AQHU9GmkqboxS7KZ10S8loxUEkpQ/w==
Date:   Tue, 16 Apr 2019 15:32:46 +0000
Message-ID: <5CB5F59E.6050905@st.com>
References: <201904160046.ggavw2OV%lkp@intel.com>
 <20190415165238.GA71613@lkp-sb05>
In-Reply-To: <20190415165238.GA71613@lkp-sb05>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <32DB909AE251DE4A918397290CA9C124@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same patch was proposed by YueHaibing

Acked-by: Pascal Paillet <p.paillet@st.com>

thank you,
pascal


Le 04/15/2019 06:52 PM, kbuild test robot a =E9crit :
> Fixes: 6cdae8173f67 ("regulator: Add support for stm32 power regulators")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>   stm32-pwr.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.=
c
> index e434b26..222d593 100644
> --- a/drivers/regulator/stm32-pwr.c
> +++ b/drivers/regulator/stm32-pwr.c
> @@ -32,7 +32,7 @@ enum {
>   	STM32PWR_REG_NUM_REGS
>   };
>  =20
> -u32 ready_mask_table[STM32PWR_REG_NUM_REGS] =3D {
> +static u32 ready_mask_table[STM32PWR_REG_NUM_REGS] =3D {
>   	[PWR_REG11] =3D REG_1_1_RDY,
>   	[PWR_REG18] =3D REG_1_8_RDY,
>   	[PWR_USB33] =3D USB_3_3_RDY,
> @@ -44,7 +44,7 @@ struct stm32_pwr_reg {
>   	u32 ready_mask;
>   };
>  =20
> -int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
> +static int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
>   {
>   	struct stm32_pwr_reg *priv =3D rdev_get_drvdata(rdev);
>   	u32 val;
> @@ -54,7 +54,7 @@ int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
>   	return (val & priv->ready_mask);
>   }
>  =20
> -int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
> +static int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
>   {
>   	struct stm32_pwr_reg *priv =3D rdev_get_drvdata(rdev);
>   	u32 val;
>
