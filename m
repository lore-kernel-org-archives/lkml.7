Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43269216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="g3dOWMDk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LOGGViGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfHHDIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:08:18 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34020 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727994AbfHHDIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:08:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7833PG0002216;
        Wed, 7 Aug 2019 20:07:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cPWLHZNscZqE259aaCO2/ORiS7XXI/V4zHP6511fwrk=;
 b=g3dOWMDkt3R4hfoi20vBdiWHeMlq67e45SqywyUlfi4nXGxGSVOJIvdZUuIBsg+FWIDX
 m5tgVK19HY3tKIIglympEM1Z9j1ZTmFzRimRxXuNQNheStJtq/772jLMfCuf7wX05knq
 NXrKJ3eFcIJlkdi4LG6xi8wNi+QUrOMcNRBJ1HKBnbR74ZLTvvLyoaNNNiXGJXEZyKwD
 S+hkzkNxCXcbqo0n3WUAGGxDCGsjSd3CE9ze1izKVu3rsBlgaJ9VPNptNGYQTlblDjRn
 HLnH/nWnHZzbfxAkc9zQSiK/0qDYjur9QeVfHnuy7JLWb+x/+0Vut3tMpojmxN8GbaFK Cw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2054.outbound.protection.outlook.com [104.47.32.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u7t1gm44s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 20:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZvKKmB2SjbilR6hJPnajP/4ucKBMsPR+g45M2/gWM9iachk0CJ/PRObPQiz8HoiVwPZhqfpK0NUMir8nZpi3scFjjZTybTC52Sjo2I+1T8jjOQ3se5NtIgbI7BHTX3cGvA6pO/xzoPq3NuFC0WmqvL8Y2Aj//NhuNx7YCCD83KKGY6K+MlOs4kmVk/3syPcXWV84xjyoj/O7HWNowj30kxsS/8dZ5dK+x5KeLPLi0s7JiOBmDE6timpME1N1gbmyh5dUit3iedU0v/XiezMZhWSvIQ0w8vmlqjNoPnSTUNDynQNEtUJ3KTHUGxQJjruazKTKNhi1IonGqkm3W+cAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPWLHZNscZqE259aaCO2/ORiS7XXI/V4zHP6511fwrk=;
 b=DWRdTYWs3WvJyu9zF9YZ1ajMfIF56BhBP3Ne7qgoj7BzUSmVWHRk1WfRzrrS0wBMJLEZJeCP1Gi6vrc0AsIPqo2doByhEmwVMtvsGM9bHGcZEfw2zohoGfVchV53wANwrjyS89+lAYUAE4CQ24ZM8vYPifwDXz7j8aTQTDuURp6sV5K9PxmJCrb+Ev0NPzVhpLtPsxBUnUp1C/050pbA6kbfyXODhu7tanKfad3oN4pGiO6g5lXkJFEUBdi6TY1FqLt7vPDV/jpx/WdmpR68FCsQ1wo/Up4kFXFMR810LcACi6EeLKrCBYYcG5qOdFTB9vZEGNeHflUDwJuF8iJSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPWLHZNscZqE259aaCO2/ORiS7XXI/V4zHP6511fwrk=;
 b=LOGGViGg8Fy7qQ8Hk0IqKrk3knil4mqvzo9pRQU9etTg6+fSXK5GhZdFpOfFqw2esrO/dLyxAgegaga67x76xsPFLsJiuV6D+6UuFWO6LQ/gOVYc0D14wmznFyY2/yJTmAmgFcv1Hq1s+8hnUZxhaFwm1igd7BcmycSrUC6+jNg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4198.namprd07.prod.outlook.com (52.135.223.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 8 Aug 2019 03:07:54 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.018; Thu, 8 Aug 2019
 03:07:54 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
Thread-Index: AQHVMyB8KL4t/wzfvkK+3nlF+Rqn1Ka75lUAgAABDHCAM8UMgIAAAVWAgAEU3fA=
Date:   Thu, 8 Aug 2019 03:07:54 +0000
Message-ID: <BYAPR07MB470987E1FD7C2ED4ADC0516ADDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-3-git-send-email-pawell@cadence.com>
 <87tvc0lngz.fsf@linux.intel.com>
 <BYAPR07MB4709964C1D0AA2A851BF2F55DDF50@BYAPR07MB4709.namprd07.prod.outlook.com>
 <b66216dd-6fcf-2900-e67b-42fdb81af78a@ti.com> <877e7pnula.fsf@gmail.com>
In-Reply-To: <877e7pnula.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTA0MzY5MTMtYjk4OS0xMWU5LTg3NDQtMWM0ZDcwMWRmYmExXGFtZS10ZXN0XDkwNDM2OTE0LWI5ODktMTFlOS04NzQ0LTFjNGQ3MDFkZmJhMWJvZHkudHh0IiBzej0iMTE2MiIgdD0iMTMyMDk3MDcyMTAzOTU1NTk3IiBoPSIvM3Nobko3VHlLb2Y1N3B0ejdrUDlEeXR2WWM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 403c9bfd-7bbd-4b9d-c9d8-08d71bad9b4d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4198;
x-ms-traffictypediagnostic: BYAPR07MB4198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB419816D7193F47496B1D5E6FDDD70@BYAPR07MB4198.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(36092001)(7696005)(6436002)(76176011)(186003)(316002)(3846002)(26005)(6116002)(99286004)(110136005)(14454004)(81166006)(54906003)(446003)(81156014)(486006)(8936002)(33656002)(11346002)(256004)(2501003)(66946007)(6506007)(2906002)(66446008)(229853002)(66556008)(66476007)(76116006)(64756008)(478600001)(102836004)(71190400001)(5660300002)(6246003)(305945005)(4744005)(7736002)(25786009)(4326008)(7416002)(66066001)(476003)(86362001)(9686003)(107886003)(52536014)(55016002)(8676002)(74316002)(71200400001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4198;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BSH6G/ezoOeZ1lEqBmc7sgx9LuzJZK6kqA/tR5CkI4ISmynRK0XGgmco1dwqgJAm3zH+Rch7dVo1lhKq2pj/D2pXG6jOfEw1C58ts095LfyymIDzhZo2njGD3p9BnvScMJTupvFbCOx5ao4WIV6Om8GJWFsTl9RG77mGYlcMUHFUOUNaZi7dkY5PUF9SMyuKf4bWiF6uwBOmQKSz2o4Leae6JSQq7vWZmWhx3lumIA2ux0W4y7dM2AhBF5GgKQn0MHN2kdY6BhpY5FCRVJzPORi29b0Z4wRn1nWTUZn1PSngHmCmZ4gWmZa8PvxNfbODUpEZC7A88tA017kGTqK56sjUbgSbQ0y0oxGZnFewVu5YbiEPBlWdQkbE6jc4utyDAqIvmo5P2yhkh2lVojPSijh36xnpaU9XAcEPv9I87KM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403c9bfd-7bbd-4b9d-c9d8-08d71bad9b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 03:07:54.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4198
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=681 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>Roger Quadros <rogerq@ti.com> writes:
>>>>> +extern const char *usb_decode_ctrl(char *str, size_t size, __u8 bReq=
uestType,
>>>>> +				   __u8 bRequest, __u16 wValue, __u16 wIndex,
>>>>> +				   __u16 wLength);
>>>>> +
>>>>
>>>> where's the stub when !TRACING?
>>>
>>> Right, I will add
>>> #ifdef	CONFIG_TRACING
>>> 	.....
>>> #endif
>>
>> Can usb_decode_ctrl() be used even when CONFIG_TRACING is not set?
>> If yes then above #ifdefe is not sufficient.
>>
>> You might need to do something like
>>
>> #if defined(CONFIG_TRACING)
>>
>> extern const char *usb_decode_ctrl(..)
>>
>> #else
>>
>> static inline const char *usb_decode_ctrl(..) {
>> 	return NULL;
>> }
>>
>> #endif
>
>This is what I mean. They shouldn't be used outside of TRACING, but it's
>far safer to have the stubs.

usb-common-$(CONFIG_TRACING)      +=3D debug.o
has been added in Makefile so  we don't want to use this if CONFIG_TRACING =
is not set.

I assume that with this approach this part is correct.

Thanks
Pawell

>
>--
>balbi
