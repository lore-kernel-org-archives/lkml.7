Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E2BC606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7147216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="f6MYWtFL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HYaGD4aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIGij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:38:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8104 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfGIGii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:38:38 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x696bH8F029936;
        Mon, 8 Jul 2019 23:37:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=L7WSnH2N+ZINwdY9aWGa4IxArxDebBqpV88ULLKa4qE=;
 b=f6MYWtFL91RhOuiS9McCyw39V9b2Crw91Wi9WAYq+vRr3CXpuE7S/oh9bSxMKZYOq2oz
 lG/uM/xXsnHr3J76eHLllXZd4haXw5fNODTlgBfqagG40FjNNdqag5RctYnzWTcRhB7O
 7w4GxpUqJ6gpVrSi3k3sGY6dwhxHO+6YW44K1k5g1VLaIQLd6o1+dGqvSJ5+GjxYbrVY
 NGSQHEO6qQLiHABH33IojqR6foQVfteH8P4QVCRaFw4qM0SX49oEP/XQH6kP0QhyIDIx
 xhO5ZBWqrAvxAcWpBDZVVhV1iYrdxXH2HBtfIGMV0kLYvdXMqwIZ9HUWirlHCzUCGn1p ZQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tjr6vjef4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 23:37:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7WSnH2N+ZINwdY9aWGa4IxArxDebBqpV88ULLKa4qE=;
 b=HYaGD4aSaBLGwiC5k4vpPGfrpytvjPJVJm1TQwR/q0166ZgRgQ7IUbrROJZVfPIvLz/f4J6I7ZC6iwUgHIKRwZIE5PaeoYmcLevYTx4n5ecpQscqbaaZpNsuvYOuM+S7jE4RVLfUa+ObI0XxX7xyJDkONFpCXuJbmLd9C8CyFU0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4885.namprd07.prod.outlook.com (52.135.205.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 06:37:29 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 06:37:29 +0000
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
Thread-Index: AQHVNZIWpYuDGK3vWkS+CQXY8vq54abBz0qAgAAB1ECAAAMegIAAAK9g
Date:   Tue, 9 Jul 2019 06:37:29 +0000
Message-ID: <BYAPR07MB4709AC9C0BBC8822ACE5409BDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562592924-17528-1-git-send-email-pawell@cadence.com>
 <87y31768k0.fsf@linux.intel.com>
 <BYAPR07MB4709D1BD29C3E0FA6C5289FBDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87sgrf67qi.fsf@linux.intel.com>
In-Reply-To: <87sgrf67qi.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDMzODVkZGMtYTIxNC0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDAzMzg1ZGRkLWEyMTQtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjcxMCIgdD0iMTMyMDcxMjc4NDU5MDQyNjc2IiBoPSI5UHpBZkgrQzI0SUF0dWhMbkhYYTNZTlNMc289IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7083844b-cf66-4d6c-6a19-08d70437ea2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4885;
x-ms-traffictypediagnostic: BYAPR07MB4885:
x-microsoft-antispam-prvs: <BYAPR07MB488510BA6A85C6A19BD1D58CDDF10@BYAPR07MB4885.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(36092001)(199004)(51444003)(13464003)(102836004)(316002)(9686003)(6506007)(26005)(54906003)(6436002)(25786009)(33656002)(476003)(256004)(186003)(55016002)(6916009)(11346002)(446003)(8676002)(486006)(66556008)(52536014)(81156014)(4326008)(81166006)(6246003)(107886003)(7736002)(74316002)(76116006)(71200400001)(68736007)(6116002)(76176011)(53936002)(7696005)(305945005)(99286004)(3846002)(2906002)(8936002)(66446008)(478600001)(66476007)(229853002)(66946007)(71190400001)(14454004)(5660300002)(73956011)(66066001)(86362001)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4885;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RBd06yOk5XUsbTVcV9Qe+neOItW9mM7RfQ7doRka/XpElwjN6v9exwGSxBjkCnxw1vV6QTv2ASPVb3cyDxciLLBvjC7MMQJO4X41CxyTaHufqVD8zrmUCJ9oJoDjtMT6eexF2J+T7BxkQagjOU5Sxw+6eWzHtmIHrzhN8ooKgtA0rR4JaOno3dgOqlKuHqFZGFKwDzK50BEpY4Xjem2ZOvCE1gdvCLqv81MA3ugW/c5VpQxn8bKpjH9/ytI6C13leVuExtdsmLs6g66h5OIA9gqB4b9Ltzx1mRs6IDWp0v5tK29R3tSsxWIBmKQlfTQ201GILyUssxu7XCT6EGDXSC9jI+GxTQ/4cJm1OEfNDLcZfVx1v0vLmsuXE+9CXNTWCEyI9pTECYB5XIXZ1cHmYTS3yNyrYjicyR6vTBN4lII=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7083844b-cf66-4d6c-6a19-08d70437ea2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 06:37:29.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4885
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Felipe Balbi <felipe.balbi@linux.intel.com>
>Sent: Tuesday, July 9, 2019 8:30 AM
>To: Pawel Laszczak <pawell@cadence.com>
>Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; rogerq@ti.com; =
linux-kernel@vger.kernel.org; jbergsagel@ti.com;
>nsekhar@ti.com; nm@ti.com; Suresh Punnoose <sureshp@cadence.com>; Jayshri =
Dajiram Pawar <jpawar@cadence.com>; Rahul Kumar
><kurahul@cadence.com>; Anil Joy Varughese <aniljoy@cadence.com>
>Subject: RE: [PATCH 1/3] usb: common: Add usb_get_dr_mode_from_string and =
usb_dr_mode_to_string.
>
>EXTERNAL MAIL
>
>
>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>>>> index 69f1b6328532..c156817672c4 100644
>>>> --- a/include/linux/usb/otg.h
>>>> +++ b/include/linux/usb/otg.h
>>>> @@ -129,4 +129,20 @@ enum usb_dr_mode {
>>>>   */
>>>>  extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
>>>>
>>>> +/**
>>>> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
>>>> + * @str: Pointer to the given string
>>>> + *
>>>> + * The function gets string and returns the correspondig enum usb_dr_=
mode.
>>>> + */
>>>> +extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str);
>>>> +
>>>> +/**
>>>> + * usb_dr_mode_to_string - Convert dual role mode to string.
>>>> + * @dr_mode: Pointer to the given dual role mode
>>>> + *
>>>> + * The function gets enum usb_dr_mode, and returns the correspondig s=
tring.
>>>> + */
>>>> +extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mo=
de);
>>>> +
>>>>  #endif /* __LINUX_USB_OTG_H */
>>>
>>>Still missing the stubs I mentioned. Did you try compiling with and
>>>without common enabled?
>>>
>> Sorry, I thought that I send answer yesterday but it's look like I prepa=
red the answer but
>> I  forgot to send.
>>
>> In /drivers/usb/Kconfig we have:
>>
>> config USB
>> 	tristate "Support for Host-side USB"
>> 	depends on USB_ARCH_HAS_HCD
>> 	select USB_COMMON
>>
>> and in /drivers/usb/gadget/Kconfig we have:
>>
>> menuconfig USB_GADGET
>> 	tristate "USB Gadget Support"
>> 	select USB_COMMON
>>
>> I think that it should cover all cases.
>>
>> Am I right ?
>
>Run a few tens of randconfig builds and see if you ever catch any
>problem. I think randconfig can produce a defconfig where USB=3Dn
>USB_GADGET=3Dn and USB_COMMON=3Dy.

Ok, I will test it, but I think that it should work.=20
The same situation we have for example with: usb_otg_state_string or usb_ep=
_type_string.

>
>--
>balbi
