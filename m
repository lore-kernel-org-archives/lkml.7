Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1F0C468C2
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94F420859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tLkuf9ro";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lgTqaKEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbfFJGaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:30:01 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:53732 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387464AbfFJGaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:30:00 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5A6ShFR011487;
        Sun, 9 Jun 2019 23:29:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=P0vnocFvZxBwfdYhEL9DulKQijsgEH2BMGtmsMJz/is=;
 b=tLkuf9ro45s7PISzjl1fgIsCZowTkfovCZi7JKMlk3f1Ru5xkAkA7ucPHHaA+F/Jb721
 AnvphOmix09JmS4g7vdqg8o9DZUupVep5q/qM0S3kfxVaNa8/L6XVUdRdWKZBZqixLcs
 dtMmYDWSCsPT7v9d4NXS+btZyh1UaqaEvqLo0dZFVtrp1lTlRn0rf1Lgw9gY+1TfvVkA
 7/NNfxLoe75b06P5PvWwHNjBv/uBwH4dkSVReuUHWSeIBG3ogfUkDrBqWj4QK0Qjs4BM
 0rGVH9kAeBdrwWCZg6dXYmAxX3W49sbyaSOsHCpRo2zANMJFNe8VAOkDoprNCtW7E9gI 3Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2057.outbound.protection.outlook.com [104.47.50.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2t08kxd887-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 09 Jun 2019 23:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0vnocFvZxBwfdYhEL9DulKQijsgEH2BMGtmsMJz/is=;
 b=lgTqaKECIAYEUtTdeYuWnxKAwwXdyYPgM1+cvaIjInhTBrvJ30YZRGAM/bU2biPKfm+/K8U2hQJUj8htsMPue6/6LArsSp5xe7MzYgiPzwQZZsIgT+1TXOrnsFEBh70kqBrKJvWlEy50zvVzNOl+gaMGm9ecsrbLtqf6EbLwTIg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5063.namprd07.prod.outlook.com (52.135.239.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Mon, 10 Jun 2019 06:29:24 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::594a:4a73:3ead:457d%3]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 06:29:24 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v7 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Index: AQHVG4YSgPl5e1M+1Ue5XKtVVDFb6qaRyFMAgAKop2A=
Date:   Mon, 10 Jun 2019 06:29:24 +0000
Message-ID: <BYAPR07MB4709C42303D60ABF917E22D0DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-3-git-send-email-pawell@cadence.com>
 <20190608134008.GB11489@kroah.com>
In-Reply-To: <20190608134008.GB11489@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTUxYWJmZDctOGI0OS0xMWU5LTg3NDEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDE1MWFiZmQ4LThiNDktMTFlOS04NzQxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzU1OSIgdD0iMTMyMDQ2MjE3NjI0ODQ3Nzg4IiBoPSI0V2VkLzJvNHh0MDRkd1Z2NVZVdGc5ZnJxQjA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6218fb84-de09-4a52-9241-08d6ed6cfb21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5063;
x-ms-traffictypediagnostic: BYAPR07MB5063:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR07MB50630234FB4CD052AD945906DD130@BYAPR07MB5063.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(36092001)(3846002)(6116002)(52536014)(478600001)(2906002)(186003)(229853002)(7736002)(305945005)(102836004)(7416002)(6436002)(107886003)(6246003)(11346002)(25786009)(4326008)(74316002)(53936002)(66556008)(54906003)(486006)(86362001)(6306002)(66476007)(81166006)(64756008)(66446008)(9686003)(99286004)(33656002)(55016002)(8936002)(5660300002)(81156014)(6506007)(76116006)(7696005)(8676002)(966005)(76176011)(66066001)(14454004)(316002)(73956011)(71200400001)(6916009)(26005)(446003)(71190400001)(66946007)(476003)(256004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5063;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Qps1QiRtDoCEStSFCHAbmFBGSAHncSmufABqHi18un+JCeomLvZZmNyDQt5IyY8oiCYjWtvPTZxu8J0u87294qRn+GTDnzFElvV/osGlYDK6ygVtTLe36bUZRid/eL2/DEtbDonLPdrzZSmO/q8Uh20bZce78v7s+dD+VHVnRRpVyjqMU+esTdo+JaDthgkP9flszk3H6mQbvmQ8V8xSivOA9RELb+3IcxteX/gs8e+l5tDZabeo2NBt1ZqB1VJrWaTfpuFsauBXZYq4Oq2sVf6YUezUcBHyil4zAfQ6qo3gvBf5TZKvrHeX2JBy7ROSzVGAeEbAP+XrR9wxLtBvI59xf4Q6k/5DxEo7NKoztfc0+OGCi+Isxb3WGTmO/C0uCxjrF3YQIWMkpSJhr78QqiZQokFQPN6bt34u5QIlSQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6218fb84-de09-4a52-9241-08d6ed6cfb21
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 06:29:24.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5063
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, Jun 05, 2019 at 11:03:46AM +0100, Pawel Laszczak wrote:
>
>> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
>
>> to driver/usb/common/debug.c file. These moved functions include:
>
>>     dwc3_decode_get_status
>
>>     dwc3_decode_set_clear_feature
>
>>     dwc3_decode_set_address
>
>>     dwc3_decode_get_set_descriptor
>
>>     dwc3_decode_get_configuration
>
>>     dwc3_decode_set_configuration
>
>>     dwc3_decode_get_intf
>
>>     dwc3_decode_set_intf
>
>>     dwc3_decode_synch_frame
>
>>     dwc3_decode_set_sel
>
>>     dwc3_decode_set_isoch_delay
>
>>     dwc3_decode_ctrl
>
>>
>
>> These functions are used also in inroduced cdns3 driver.
>
>>
>
>> All functions prefixes were changed from dwc3 to usb.
>
>> Also, function's parameters has been extended according to the name
>
>> of fields in standard SETUP packet.
>
>> Additionally, patch adds usb_decode_ctrl function to
>
>> include/linux/usb/ch9.h file.i
>
>>
>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>
>> ---
>
>>  drivers/usb/common/Makefile |   2 +-
>
>>  drivers/usb/common/debug.c  | 273 ++++++++++++++++++++++++++++++++++++
>
>>  drivers/usb/dwc3/debug.h    | 252 ---------------------------------
>
>>  drivers/usb/dwc3/trace.h    |   2 +-
>
>>  include/linux/usb/ch9.h     |  25 ++++
>
>>  5 files changed, 300 insertions(+), 254 deletions(-)
>
>>  create mode 100644 drivers/usb/common/debug.c
>
>>
>
>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>
>> index 0a7c45e85481..02eb01666289 100644
>
>> --- a/drivers/usb/common/Makefile
>
>> +++ b/drivers/usb/common/Makefile
>
>> @@ -4,7 +4,7 @@
>
>>  #
>
>>
>
>>  obj-$(CONFIG_USB_COMMON)	  +=3D usb-common.o
>
>> -usb-common-y			  +=3D common.o
>
>> +usb-common-y			  +=3D common.o debug.o
>
>>  usb-common-$(CONFIG_USB_LED_TRIG) +=3D led.o
>
>>
>
>>  obj-$(CONFIG_USB_OTG_FSM) +=3D usb-otg-fsm.o
>
>> diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
>
>> new file mode 100644
>
>> index 000000000000..f7218d794aa6
>
>> --- /dev/null
>
>> +++ b/drivers/usb/common/debug.c
>
>> @@ -0,0 +1,273 @@
>
>> +// SPDX-License-Identifier: GPL-2.0
>
>> +/**
>
>> + * Common USB debugging functions
>
>> + *
>
>> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://url=
defense.proofpoint.com/v2/url?u=3Dhttp-
>3A__www.ti.com&d=3DDwIBAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&=
r=3De1OgxfvkL0qo9XO6fX1gscva-
>w03uSYC1nIyxl89-rI&m=3DhCAftKt20FnC6KiCwNbVrg7WoY-WnCtUjVuast3iJSw&s=3DQ4q=
hFXl4s1P2u0s65WgkulIRgV4KZtGphj7Xjr4t6yA&e=3D
>
>> + *
>
>> + * Authors: Felipe Balbi <balbi@ti.com>,
>
>> + *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
>> + */
>
>> +
>
>> +#ifndef __LINUX_USB_COMMON_DEBUG
>
>> +#define __LINUX_USB_COMMON_DEBUG
>
>
>
>Why are you doing thsi in a .c file?
>
Good question, I don't know :).=20
Was removed=20

Also I remember that you complained about placing it in=20
drivers/usb/common.=20
Currently this file is used only by two drivers dwc3 and cdns3.
Both are USB controller drivers. Maybe it could be better to move it to:
drivers/gadget/udc/debug.c
drivers/gadget/debug.c=20
drivers/gadget/common/debug.c
or
drivers/gadget/debug/debug.c=20

What do you think Roger?=20

Felipe it's also question for you.=20
=20

Thanks,
Pawel

>
>
>thanks,
>
>
>
>greg k-h

