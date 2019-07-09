Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85D6C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AE220861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PsSDG74J";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="T8Fvvj7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGIGZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:25:07 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7310 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfGIGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:25:06 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x696Mv98016935;
        Mon, 8 Jul 2019 23:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9V7evLTCmtHLaGxlGxig+MxgXlmsKXm/BnZCpzc5iG0=;
 b=PsSDG74JL8+buaxXbTdGtiM2kN1mpECRXYfGBRiDMT4/TzYPdE+1Zp5185TtjccO53Cs
 cizgTw7z+EZwudLSHaILN7AkrIT7h+ZITsBCtoQYGWNKkEClGtgoVv0Z+ntTtyxKhOAl
 Rthtkn91/K44UzE25n3r45He+q7N+P2zr3/P/zV12KeYkei8vWny2iCC/NcBUXLHDoxy
 lTAry+cQJPYV7/4j6FF/Pn9u6E0syKWh5nr9v7yT2P4WuZn7jFZYkuMkopabsufNWDK+
 fV23WCfl74PleGL2jVAmcD/ahKHhzcYEAuqO0VBKy/dyVLZIZOp5T113YVRK8Wiw5i+F Ng== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tjr6vjcyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 23:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V7evLTCmtHLaGxlGxig+MxgXlmsKXm/BnZCpzc5iG0=;
 b=T8Fvvj7RlXiIxQC0XL9kKKraVZUEIt54UxN0Hz6KTsRUwFQ00QjvFObeYi1iFun/w3JOslGsCtHz10ReVsqkRZCkwDorrHkk6LyJbA+Fcqie7HCVYk1FrasHdqt9MbV7eqpeX229EvBiTCKXlQSwXaEvCWIl9ZU8JsCcwa2Rhy0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5109.namprd07.prod.outlook.com (20.176.254.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 06:24:00 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 06:24:00 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: RE: [PATCH 1/3] usb: common: Add usb_get_dr_mode_from_string and
 usb_dr_mode_to_string.
Thread-Topic: [PATCH 1/3] usb: common: Add usb_get_dr_mode_from_string and
 usb_dr_mode_to_string.
Thread-Index: AQHVNZIWpYuDGK3vWkS+CQXY8vq54abBz0qAgAAB1EA=
Date:   Tue, 9 Jul 2019 06:23:59 +0000
Message-ID: <BYAPR07MB4709D1BD29C3E0FA6C5289FBDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562592924-17528-1-git-send-email-pawell@cadence.com>
 <87y31768k0.fsf@linux.intel.com>
In-Reply-To: <87y31768k0.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMWZjZjkxZDYtYTIxMi0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDFmY2Y5MWQ4LWEyMTItMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTY5NSIgdD0iMTMyMDcxMjcwMzQ4NjE2MTg5IiBoPSJNRWRDdk0wK0FTN2Zqb3RPVThXdUhLT3hFY289IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91e3adfb-f94c-4d79-7675-08d7043607c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5109;
x-ms-traffictypediagnostic: BYAPR07MB5109:
x-microsoft-antispam-prvs: <BYAPR07MB5109F39836F712EA8543E2BFDDF10@BYAPR07MB5109.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(51444003)(36092001)(9686003)(4326008)(64756008)(66556008)(66476007)(71200400001)(66946007)(55016002)(73956011)(71190400001)(478600001)(66446008)(76116006)(256004)(25786009)(2906002)(3846002)(229853002)(6436002)(52536014)(5660300002)(7736002)(7696005)(102836004)(476003)(76176011)(66066001)(99286004)(33656002)(81156014)(81166006)(186003)(11346002)(54906003)(446003)(316002)(486006)(6116002)(8936002)(6916009)(6246003)(26005)(305945005)(8676002)(14454004)(74316002)(107886003)(6506007)(68736007)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5109;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ruHgVqpGTOKmwcfSekI2CzO+7xx9SGsrFhlggMX3IbNQjzJB2j5DZutFulxUBlNUmD7xSzOAP009m5+rbaHZaS7Nva3NFFLCxjVhKfmYEjhI9LB2hjgIRpOhYpMSuBZSKa154rmkZYbFJmBUCrL8aIwNz3K3yp7+0iHswkUj25wCW5P28pO8ntcfbjCU/kwHrimyq5PKYSY/va15rNO8QCY9jokHlXEPUTgAsRCkmOsvDN1+R+VuQPoiXNSvAagKhOGujAO7VlFCfqU5rMn8MtT15uxx/AfAeayY9wxrXyUsMdB3G79LXVh2l2lLgSRSEOnRnAytCwfZc1Sjte/IJtB0eiD9vHI87uwbAoJ0x82RVsxia0LFgNWzP3gfrRp3D3MNlLqzmER0MArc8qCY1XBFO8J1WC/c41FsoSbhjk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3adfb-f94c-4d79-7675-08d7043607c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 06:23:59.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5109
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
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
>> +
>>  #endif /* __LINUX_USB_OTG_H */
>
>Still missing the stubs I mentioned. Did you try compiling with and
>without common enabled?
>
Sorry, I thought that I send answer yesterday but it's look like I prepared=
 the answer but=20
I  forgot to send.=20

In /drivers/usb/Kconfig we have:=20

config USB
	tristate "Support for Host-side USB"
	depends on USB_ARCH_HAS_HCD
	select USB_COMMON

and in /drivers/usb/gadget/Kconfig we have:

menuconfig USB_GADGET
	tristate "USB Gadget Support"
	select USB_COMMON

I think that it should cover all cases.=20

Am I right ?

Pawel

>--
>balbi
