Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7CFC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F50C217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="rT1NoDws";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KqTICdni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfJPEcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:32:43 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33700 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389479AbfJPEcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:32:42 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G4WWCC011211;
        Tue, 15 Oct 2019 21:32:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=VqheAkMks9Ap3qqrg0roAPg0oeFiHjDBchJ8x4ZvvF0=;
 b=rT1NoDwsLYgEZE6EuXPAxGEzhh3MkRZkgoJ9JQwVQyLPckFExqksxPfuFscZZFWTYyUl
 UtuscKK4T+hI5i3RVnBsE2B1Fzw7KEUZTAZJUX3Yqk6z+H3lgF0kf0qYcX4/mY5J7xaY
 0hrQhKZ++KUHeaEEB/y/LpLpRhBE4ty/rWNACLE0ldwHArh1haGLiY4vYIGjLI2H8Bsz
 EPMmbna12pEuJg1Kg4riCSoPsjD8whpU6oiYQvNQwBwGx1lT3+DrhARB5zdvhiYnDrdZ
 eH4x3B1xJD88Qo2/J5b7dFuxeodQSdrNo25GuIrUjRXeXTFjUWf7cyJawkv3miJPn0UT /Q== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2vkbd26c91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 21:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cldbUH3Q6MEOsG6jaGh/s8S6eYhcB1u+RvZckxbSc1fUOKC2VfH3ijDgZ5HLsJoGECMYo7fGVaB3r7QSswOVyz576rMH6NPp7PeCYV0xlOXMn39YqlrF2uW15TiEeMGtFfy0rwr+UJ09exyDuQ9xJZQ9HsExuNXyXjo/EfgYW/sjVEkCcBYIsQKIOpM4ifYO8p2UEI/BB7ooQoZdHwkuECW768hXz5pwTAhT97k7BbPBqBfUgmhp12TGkmv25xuMqhJ1IKfxbu2AEkXWzoh+qB3BIwM5s8PGDEjnZBPAkIQdV6A32OLJe4LJ92GfmnuEqpPKZmgdrJi5gNPIJfjpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqheAkMks9Ap3qqrg0roAPg0oeFiHjDBchJ8x4ZvvF0=;
 b=gTxs4oCCRLdc1ygwud8Q4s1GhDRphra7ZvZv1RxS9Pxl+2q2CCPxdS/gQW/aLJxxdQZxEMSVbi6dlyUynAakYR3a2hyqZVv7iANbCjwinj6eWvFg2hq6IJE6/scCOLZqeDbZomnfaG73oMYyDivSXCabczcxm0T+ptukWTlLgjT4d9mjezdWawL0NPzBWBuYBrfY22uCxPetZnTY/2SNGcqC8xgUFd/QohgSAJa4zRswyulMp9e1Re3q3GbGkKyTCUcVMk4q8AUNmvng9f2X4H3JWXbx7QWRmBxKnQ2QFxZJrGjtTnCsIL9qiD5RBHNpDSQgm0zRwi8ICgPsecqrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqheAkMks9Ap3qqrg0roAPg0oeFiHjDBchJ8x4ZvvF0=;
 b=KqTICdnipQstz68UEnTKhPq5Udkjxv1O6/bm+49FnQVw2ynLbBKJXLzBgvReq7IG12sAvJcv2H1jQxcwF9LEM++YWSsx7HD6sHUMw1r7ZAgYXM4pHZRjr+1sRm4iD6s+jPX8Vk/MJZ6D6n7cWTanCGUTzPCB1TxMTuZoKjlFWxU=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4565.namprd07.prod.outlook.com (52.135.224.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 04:32:29 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 04:32:29 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] usb: cdns3: fix cdns3_core_init_role()
Thread-Topic: [PATCH 1/2] usb: cdns3: fix cdns3_core_init_role()
Thread-Index: AQHVfQkEuRq610s5UEaj9CRQS2FO1adctV7A
Date:   Wed, 16 Oct 2019 04:32:29 +0000
Message-ID: <BYAPR07MB470974496C7C59FDE615E5F3DD920@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191007121601.25996-1-rogerq@ti.com>
 <20191007121601.25996-2-rogerq@ti.com>
In-Reply-To: <20191007121601.25996-2-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjQ3YjBjZGMtZWZjZC0xMWU5LTg3NGItYTQ0Y2M4YzMwYmQ0XGFtZS10ZXN0XGY0N2IwY2RkLWVmY2QtMTFlOS04NzRiLWE0NGNjOGMzMGJkNGJvZHkudHh0IiBzej0iMjIyOSIgdD0iMTMyMTU2NzM5NDcwOTU0OTczIiBoPSJFMXR6NDlBNllDNWZZUkZYaDdxSlF6cnlLcWM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb9e288f-72d9-4991-fc10-08d751f1dadf
x-ms-traffictypediagnostic: BYAPR07MB4565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB456538E78DCB06F7641CA21CDD920@BYAPR07MB4565.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(36092001)(189003)(199004)(66476007)(81156014)(476003)(11346002)(99286004)(86362001)(186003)(7696005)(3846002)(6116002)(66946007)(66446008)(446003)(64756008)(76176011)(71200400001)(6506007)(71190400001)(66556008)(52536014)(2201001)(8676002)(8936002)(81166006)(2906002)(4326008)(102836004)(25786009)(486006)(6436002)(7736002)(6246003)(9686003)(305945005)(66066001)(76116006)(14444005)(229853002)(33656002)(74316002)(478600001)(5660300002)(26005)(316002)(110136005)(2501003)(54906003)(55016002)(14454004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4565;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2gT8txK/jCJ8Ao+VbGQBTs7IuGuNg7McEJoEc1ye+3vIesXGPV7RFs/1Ov7g3rWtDH2X3gOpHGDIq49/QUxe3Np3gdGJUA7pmL/lMIDttCvFZnp+8kZgVjN+fpnoh82UF122MXsPZ6jdXoaSEtl7Ge4+NjnWDrnQr3a3Oy8wA4ue7ka9wDxY5iccOcUHwcRCswEzLs/dMaOI4JbJHrhZlkNNdiyaat1pLM1sKV+HQ9t3oHxxzZAyTWBbOp3N452ltkalzATjmtyvgIQn/GqmHOH60dTEUQZ0sEdQzIqAZWDe/IL4AoN0agEp5c9FQTPTn6ySOJKocjOZslTxxvv6nrvZEtm01X6vqcbIJaonbuq5ugzdnLZ7qSQ2hjdbqAjjXytt1iwXFFK9wdgi4s6u4sPk0IeMrL67jnHEusHGVZs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9e288f-72d9-4991-fc10-08d751f1dadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 04:32:29.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4lGeaBBakni/hFevM6Q6bijcvSayzQJl9BkP6UC6Jg1lLBSKXSuza6vf1iHr+SMuHRdVoUjUVvocqCPtVX0JI5CHzE4Bpz8SVPfyF3Fcl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4565
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_01:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910160041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger

>
>At startup we should trigger the HW state machine
>only if it is OTG mode. Otherwise we should just
>start the respective role.
>
>Initialize idle role by default. If we don't do this then
>cdns3_idle_role_stop() is not called when switching to
>host/device role and so lane switch mechanism
>doesn't work. This results to super-speed device not working
>in one orientation if it was plugged before driver probe.
>
>Signed-off-by: Roger Quadros <rogerq@ti.com>
>Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>---
> drivers/usb/cdns3/core.c | 20 +++++++++++++++++++-
> 1 file changed, 19 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>index 06f1e105be4e..1109dc5a4c39 100644
>--- a/drivers/usb/cdns3/core.c
>+++ b/drivers/usb/cdns3/core.c
>@@ -160,10 +160,28 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
> 	if (ret)
> 		goto err;
>
>-	if (cdns->dr_mode !=3D USB_DR_MODE_OTG) {
>+	/* Initialize idle role to start with */
>+	ret =3D cdns3_role_start(cdns, USB_ROLE_NONE);
>+	if (ret)
>+		goto err;
>+
>+	switch (cdns->dr_mode) {
>+	case USB_DR_MODE_UNKNOWN:

One note in this place. USB_DR_MODE_UNKNOWN is not possible in this place.
If cdns->dr_mode will be USB_DR_MODE_UNKNOWN then driver returns -EINVAL
some line before after returning form cdns3_drd_update_mode and in conseque=
nce=20
it jump to err label.=20

Maybe for better readability it this condition should be treated here also =
as error.

>+	case USB_DR_MODE_OTG:
> 		ret =3D cdns3_hw_role_switch(cdns);
> 		if (ret)
> 			goto err;
>+		break;
>+	case USB_DR_MODE_PERIPHERAL:
>+		ret =3D cdns3_role_start(cdns, USB_ROLE_DEVICE);
>+		if (ret)
>+			goto err;
>+		break;
>+	case USB_DR_MODE_HOST:
>+		ret =3D cdns3_role_start(cdns, USB_ROLE_HOST);
>+		if (ret)
>+			goto err;
>+		break;
> 	}
>
> 	return ret;

Reviewed-by: Pawel Laszczak <pawell@cadence.com>
Tested-by: Pawel Laszczak <pawell@cadence.com>

>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
Regards,
Pawel

