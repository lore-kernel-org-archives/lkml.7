Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A153CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF1A214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="P3+8TLC9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nEwPdmO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbfJWJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:18:55 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:51302 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390380AbfJWJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:18:54 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N9GwGY002992;
        Wed, 23 Oct 2019 02:17:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=VrgleZRLHCNmrbcsBzy06QI8bvmGkUwAk3dZbPQFwA4=;
 b=P3+8TLC9+UQC74mMoBJk3Xayha5+pD0ERb5O9ZwjNosBs4VrhYhNP4C4SCBg7QXOzEEW
 9J5BA9w7Fw7IVZoy53egBEwIptN7aLfM0RNp8PwvgxflOBv9n1B3hUWrDF0UVTYbFMp0
 mJUFvXWCRnmA+8pmOiOGYvdKpIr6SQ5+N4wCqx25JV5SgDCobVhuyAbhinvH3T5Uy+wM
 DzX2FzCY6ufEkP8abuFRVfib1Y9uZ/yuwG1VsruzX7WkEyhN9mi1HArUekHE4k+VUbmY
 1F4yEQOOWoTHNCrn9d8Hwdpk9IZckd0E5P1DwWWCC/O2PNMWfOFsVoPPc4qY5uozOU6K 5A== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2050.outbound.protection.outlook.com [104.47.42.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2vt9swssrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 02:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKL5vsOrG7uL4i8VhHlEueDy+ZKVVqXvIkhbigQZOamV0cdq4AFBtXdiCk7/MCEFSEeCP7/3wM3oyu20afzWy8y6yThI3TZFGzE3qeETlaalpF69FpSXt3v7I04k1hQ792PUKK3bWM8lYX8/C5GeG8o7Kg8GSBG9uHeFLfg6SvMtSrq4VWnfH5lkx2KvhSdMuFsrznE3Zcm5gietZaGV2MU0gYSfgh19wHvG79rTpYmwWGOeYoOnf4fJ/V/6aaOMK1ONoMuUh8Y9NY0NAd0/T3E/FCN4qZHuqlqviRikR2q4uUiHOM8VbmTC8fbTwj389ygMdLGwO8aR2Grek0JToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrgleZRLHCNmrbcsBzy06QI8bvmGkUwAk3dZbPQFwA4=;
 b=HVExH23ZoFPnJi9zcP27+6SxmGg5EGFqWkPVAKvBtAUTM5vt6IWjzdT85IetlQkzdi/lpxQaI97wJrtFkOJJSVEJY1QKE3hn1h0Zm84xt7iqeavwuoe4yxvQnJthlwG6J05nIjsw8PhTS091n6jsROBqgTT6r+rdsirtqG4aPqRrz4uknQsmCHFilWGGm+FlH1zRjpGOUzbgETYBaKzN1zOgEVYP0e9IoTj6Lk5Phg7uBVfdoposaQPhjRd+ZKd+VJ5jX0GmwZQSE2Vpj04Op5rLHMgwFKQJ5sDZfcQMdPLKlSVETR1iKEjD41pqB4DxQdf6xHF2+MKi/77AdHHyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrgleZRLHCNmrbcsBzy06QI8bvmGkUwAk3dZbPQFwA4=;
 b=nEwPdmO0RzbBJX37SNkdYp60g5TJ4ErUKiNMyb9YsjGBJ04r7TiB2z70R5SP2SiAJTqLLV6uHXcBO1VBQ6ySmBGxM/z/e47x/NM7/qs8wXNoLFlmrYyP3Aux133tKt+AUUNZmXX0tdxuEXxk0R6KvXcMPkSAny2BzSGorWDfhmM=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4213.namprd07.prod.outlook.com (52.135.226.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Wed, 23 Oct 2019 09:17:45 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 09:17:45 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Topic: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Index: AQHViYChp/zP/bBD7UKxK/OPTvIquKdn8heQ
Date:   Wed, 23 Oct 2019 09:17:45 +0000
Message-ID: <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191023090232.27237-1-rogerq@ti.com>
In-Reply-To: <20191023090232.27237-1-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjcwN2Q0ZDItZjU3NS0xMWU5LTg3NGMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGY3MDdkNGQ0LWY1NzUtMTFlOS04NzRjLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTQ4MyIgdD0iMTMyMTYyOTU4NjI2MTQ0NjkxIiBoPSJUYklIcEpUeHpjelZoWndldHZ0T0Y5ZWJBWm89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 028d836c-0653-4712-bcb7-08d75799dd8e
x-ms-traffictypediagnostic: BYAPR07MB4213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB4213EE59AECD37928828A3ADDD6B0@BYAPR07MB4213.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(36092001)(199004)(189003)(81166006)(66574012)(33656002)(7736002)(74316002)(66066001)(316002)(478600001)(2906002)(76116006)(305945005)(4326008)(25786009)(26005)(11346002)(71200400001)(256004)(71190400001)(6506007)(14444005)(7696005)(81156014)(486006)(86362001)(6436002)(2201001)(446003)(55016002)(102836004)(99286004)(66446008)(476003)(5660300002)(2501003)(8936002)(110136005)(66946007)(76176011)(54906003)(3846002)(66476007)(8676002)(9686003)(66556008)(6116002)(52536014)(14454004)(6246003)(64756008)(229853002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4213;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fntJMXJck6N+5Joj18V8poZldwrHkiywM70foiNAcc361CRI7+4QpQuGoJIEU1ix+zcP33CISD/t021Bm8bCQ4/yUpm6r/uJrzLEjk5fn81ARRalQPAlfcBTaVlDVrpSmVkze+2MlRx++KMLWqpgaK71aGPQe7Pjqu70ooGfEbEeatbxTuipRwEJHkMeZu3J8xk7H+XYu9up6YH5F58DuTJgSp3EmMrTz2sZxpZ6dRQtwdrXM71Gy8u3kVQSMMq2TcfwZ7R4geIxRrVSfNEb9yG6GqyJ0be764b8mMLBLjhty7CBVjdhDh6vBdc+APnWXm+iGFyX2b7BsmIS0vDZoHIwuSVXWEd2Vwky2g/plifS6hDBjigsvCT2gyxzUqhp7rigcmBSL5YT1hFkL37e7b+AGcRdCKJWrYpydGgcAHwuYAEct+tlJpNrlI/MGusVgcfheRZIb9NdrJfIFAUGA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028d836c-0653-4712-bcb7-08d75799dd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:17:45.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqBVGQKlCBbvNx8r+uWi53xnNTPpmUMnhoiSSfXTOwX0HhzqHjkbcUqJwHyYLJe2qUeH0zQRuUxHyDEuG1oWyhSElc61zMMkRaKfi5TBqfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_02:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=931 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reviewed-by: Pawel Laszczak <pawell@cadence.com>

Regards,=20
Pawel,=20

>The USB gadget core is supposed to manage pullups
>of the controller. Don't manage pullups from within
>the controller driver. Otherwise, function drivers
>are not able to keep the controller disconnected from
>the bus till they are ready. (e.g. g_webcam)
>
>Signed-off-by: Roger Quadros <rogerq@ti.com>
>---
>Hi Greg/Felipe,
>
>This can be used for -rc as it is a bug fix.
>
>cheers,
>-roger
>
> drivers/usb/cdns3/gadget.c | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>index 2ca280f4c054..714382d96055 100644
>--- a/drivers/usb/cdns3/gadget.c
>+++ b/drivers/usb/cdns3/gadget.c
>@@ -2324,8 +2324,6 @@ static void cdns3_gadget_config(struct cdns3_device =
*priv_dev)
> 	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
>
> 	cdns3_configure_dmult(priv_dev, NULL);
>-
>-	cdns3_gadget_pullup(&priv_dev->gadget, 1);
> }
>
> /**
>@@ -2708,8 +2706,6 @@ static int cdns3_gadget_suspend(struct cdns3 *cdns, =
bool do_wakeup)
> 	/* disable interrupt for device */
> 	writel(0, &priv_dev->regs->usb_ien);
>
>-	cdns3_gadget_pullup(&priv_dev->gadget, 0);
>-
> 	return 0;
> }
>
>--
>Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

