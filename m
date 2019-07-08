Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C45C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6776721530
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="V2GQD+cs";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YrnJcoVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfGHMkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:40:22 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59074 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727544AbfGHMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:40:21 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68CbhTA008199;
        Mon, 8 Jul 2019 05:39:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=OWtTzM5NEKkAhBuHJ6CEEIzwpiU215SMMQ0HlfyVEro=;
 b=V2GQD+csq3Jpga4hmpDUfZBjXr29HAbqHVVpjcTS9kmeM3RZzgMqeRvMBV2iG74KjBCw
 zT0/GjPHb72opNiVJblO6zEjlUycPCMS2/wNC4NaVQ5UvWeTWU0F7DbGrVdNQcRgWw7y
 zrn+hi3/pPgSebwWEXsWa/5Wrf2N7rOKOdPYr7Khoc2zAPEcJfsw00lIt0X9c5aUbYHT
 Qr5+irkr8kMDHmZj3kRyO8wHeDv//Q/IXpEmwy8z3qne2NfIOuv9TmxlGwx//T36retW
 VUM1G5n47F5nHW7NjKwZbietprEcHF55VNRFcB2PRRAiBf8DKgnXqRF21jyyuThaEEaZ Ag== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tjr6vf109-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 05:39:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWtTzM5NEKkAhBuHJ6CEEIzwpiU215SMMQ0HlfyVEro=;
 b=YrnJcoVdjlPfCaRjrN6elr9XQ5dlYl7i6cD+uL4TxLtUDgbAVDqBtbVnMA0AOE7cMd3dRUVQrFMd0VDn+v07hQnUtHSj7c01OXzFNom1T1WXZCrdKrksogp2fL+pDzvvt4m+31X2B/3wsvqWOOK5f1rfFvNZ0tK/rXzN3mUkSZU=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5957.namprd07.prod.outlook.com (20.179.92.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 12:39:07 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 12:39:07 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6a76sKAgAN7ISCAAOC4gIAAKa7ggAAmawCAAAZysIAABbSAgAAINMA=
Date:   Mon, 8 Jul 2019 12:39:07 +0000
Message-ID: <BYAPR07MB470932E0BC5FA1B1753C2C47DDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <87r274lmqk.fsf@linux.intel.com>
 <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7dpm442.fsf@linux.intel.com>
 <BYAPR07MB4709E5BA041BBDDB70E69F62DDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <874l3wn5ep.fsf@linux.intel.com>
 <BYAPR07MB47097C3C2A2BBA2AA63C65DEDDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <874l3whh4g.fsf@linux.intel.com>
In-Reply-To: <874l3whh4g.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWQ2OGNmNmUtYTE3ZC0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDVkNjhjZjZmLWExN2QtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjM5NiIgdD0iMTMyMDcwNjMxNDMyMDc4MzA5IiBoPSJQcmYyaUZtREprQU5xZVp0YlhCSEs5NU9CQzA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09e880fd-e6f4-4231-d943-08d703a144cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5957;
x-ms-traffictypediagnostic: BYAPR07MB5957:
x-microsoft-antispam-prvs: <BYAPR07MB5957CA195133A11352E1C352DDF60@BYAPR07MB5957.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(36092001)(199004)(189003)(76116006)(73956011)(5660300002)(52536014)(14454004)(186003)(6246003)(86362001)(66946007)(476003)(64756008)(66556008)(478600001)(107886003)(81166006)(66446008)(66476007)(81156014)(8676002)(26005)(76176011)(71200400001)(2906002)(4326008)(25786009)(7696005)(9686003)(55016002)(71190400001)(66066001)(6506007)(486006)(3846002)(7416002)(6116002)(33656002)(99286004)(68736007)(229853002)(54906003)(305945005)(2501003)(316002)(446003)(53936002)(74316002)(102836004)(110136005)(7736002)(256004)(14444005)(8936002)(11346002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5957;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qtKswqepjimBkTueMiuLuawiw4FFibSoo/TL4/DBb5xWWlON2dMklIHz9JMZvz+lMh8P1036wCHCzi3Q4FE0ErgwihBA4BfhK20FHYK8Z+Pj7wBRF5O7d78lSWdkuhew8o71fM7ZhdLPXRf/zsmeQQeS0PhuGgx/D1V3we6QVRFIEOUl7ph3MncVfgKy592/X2KxBlG10qe3IyHgFyuP+eoPnZ1cho/yOqxh8UJ5MlAzOLSTNSSzwRn6jftj0OeJ0oSEs191iSoT+usBOgA5xjF3Te0MFRy4r78gJEey98rwxNAKHYQCoXBnbqImr9Z5aVGA4IPwg5sAXGTpTG1cURvGLfYKRy5kczbyRguDm7/47LAdSpts4htwSC1NpT+96R7v1uL9kl/AN7ujFnWe/lnbXv+S/tM1TW6KFewhcvg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e880fd-e6f4-4231-d943-08d703a144cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 12:39:07.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5957
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>(please send it as a formal patch from now on)
I will send it. I think even today.=20

>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>> The prototype was added , but not all text was past. Sorry for that.
>>
>> Fixed version:  with your changes.
>>
>> ///// v2 corrected
>> commit 4553d48dd0500085d90c8280e28714072279c3dd (HEAD)
>> Author: Pawel Laszczak <pawell@cadence.com>
>> Date:   Mon Jul 8 12:53:47 2019 +0200
>>
>>     usb: common: Add usb_get_dr_mode_from_string and usb_dr_mode_to_stri=
ng.
>>
>>     Patch introduces new function usb_dr_mode_to_string for converting d=
ual role
>>     mod to string and removes static from usb_dr_mode_to_string definiti=
on.
>>
>>     Both changes have made to avoid duplication of code by cdns3 driver.
>
>missing Signed-off-by
>
>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>> index 69f1b6328532..c156817672c4 100644
>> --- a/include/linux/usb/otg.h
>> +++ b/include/linux/usb/otg.h
>> @@ -129,4 +129,20 @@ enum usb_dr_mode {
>>   */
>>  extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
>>
>> +/**
>> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
>> + * @str: Pointer to the given string
>> + *
>> + * The function gets string and returns the correspondig enum usb_dr_mo=
de.
>> + */
>
>why duplicate the documentation? Perhaps put it only in the header,
>otherwise we will need to update two locations whenever these functions
>change.

Ok, I've removed it from drviers/usb/common/common.c.

>
>> +extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str);
>> +
>> +/**
>> + * usb_dr_mode_to_string - Convert dual role mode to string.
>> + * @dr_mode: Pointer to the given dual role mode
>> + *
>> + * The function gets enum usb_dr_mode, and returns the correspondig str=
ing.
>> + */
>> +extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mode=
);
>
>Don't you need a stub for builds when CONFIG_USB_COMMON=3Dn?
>
We don't need it. It will be enabled when USB_GADGET or USB is enabled.
It should cover all cases. =20

menuconfig USB_GADGET
	tristate "USB Gadget Support"
	select USB_COMMON

config USB
	tristate "Support for Host-side USB"
	depends on USB_ARCH_HAS_HCD
	select USB_COMMON

Pawel

>--
>balbi
