Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DAAC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7192320828
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CmwQHPsl";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Kjv2sQi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfGUOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 10:54:57 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:64580 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbfGUOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:54:57 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6LEregA002379;
        Sun, 21 Jul 2019 07:54:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=wDg4QsqJKoutl2naKK8IxLfQKox09JeWfvEjgv9wI9A=;
 b=CmwQHPslOQdov4qdzWc30kwbLhvJ+ZjGNmVQo4LWO+UmC0GB4RnLtXhIYLIdWa449xef
 ZcHpPUBzcFly4aDJTqpJuwjJ/1Jt5xNR0qPkivcMb/lvyFG9faZ0Wb4jUYDmaziqDWcl
 i7DE+c3eMMRPFDCWWbz3gTySykmQnmBauF+zcQNgkCdju4cmBZq1YFg6iqrsqbw7LDG5
 enOYSXlHEAxiMjll4TFvZUchGh3N4Go46gZTHrVMcoNuBLgTM/ipBlZxpUotUnE7lCi2
 8p9KKUFnFc3+7nbsrJ0AS6YDFaCyp4HeDibmgO/hyQ8QDP2q8vbz1/5pkJPtXgOK35Hs tA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tuxhwbk5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 07:54:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGC/yimFglNXSBOfhRoYp1SbIuf7zjGlnDJ+Lx/ejdPDUZx8fnY4+9YVaEu/2kb4WvUoCK6fgw8aNOS5tUi9a8udhdXmyAe8vhbyf60UXO208Z3LnfMkZWMYSe2USO7IyfuaTRJP1pttAJZJTQB7G1koyNSiYvTmDJeJyY/JQu3AIop+MVMGR0Pe0im6yKnk1zxUFmW3gs8Hj1Gg46ABCmLmIt7/Nlz2eFPhXZqQrdubIz+cILxxjeGSAxmS+9/ch2VnP0+DmirhzNABJp2pQ4BOisIk4MfA9BGhNV8wGEZdYVz9N+AeVdJgdIV0q8GcPp5OEVeBqtfCrANawUTUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDg4QsqJKoutl2naKK8IxLfQKox09JeWfvEjgv9wI9A=;
 b=hIvT42heB2Z4dTI23uMiDpRWs0T3PEscJ1tVycYpyQTEJZjZwxIz3/FMX5y89jNQjilWCjJKoOCnPdhE4r4yZiQqArP97cZAflWsaRlmnB51x8mrnknxrqjk+YIha97wdVXle0hg1u9w88krMngfR4g1Xhd+SHgggTkdudFK8cwVnXFjd95yzG+RBvAnN7E/r6g52Y5EEQmVqrqgYMy6vhf4b7Y8mQiZ7eCfXVrrKWS2EV6YEwQBqk0eBUetPejAk7pXwf8CDrrArdJ/VIZs49hIyZ3bdIL3vqgVUmMm3uVdZGm9DHonxFvmW5yGOGxLtWA72DgmTtg8ax7kfekDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDg4QsqJKoutl2naKK8IxLfQKox09JeWfvEjgv9wI9A=;
 b=Kjv2sQi3dksx5CY4yBmLGwn6EZlPfZRgKhkKl6cy1zGGJeBQunppjZVKUr0EjUrycdio9bLMLAfaXNzzX9h/cifBcjif9FvibukJ6T0TiAXc8lIwCS/AzCZS/OscEmT3GFckolTbnq4WLZZg3vdoGo6R9HBFoQwfO92At96Filc=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5304.namprd07.prod.outlook.com (20.177.124.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.15; Sun, 21 Jul 2019 14:54:47 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d%3]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019
 14:54:46 +0000
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
Thread-Index: AQHVNZIWpYuDGK3vWkS+CQXY8vq54abBz0qAgAAB1ECAAAMegIAAAK9ggBNmXgA=
Date:   Sun, 21 Jul 2019 14:54:46 +0000
Message-ID: <BYAPR07MB470944CE1294AC9E5878792CDDC50@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562592924-17528-1-git-send-email-pawell@cadence.com>
 <87y31768k0.fsf@linux.intel.com>
 <BYAPR07MB4709D1BD29C3E0FA6C5289FBDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87sgrf67qi.fsf@linux.intel.com>
 <BYAPR07MB4709AC9C0BBC8822ACE5409BDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709AC9C0BBC8822ACE5409BDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzhlMWNiMTctYWJjNy0xMWU5LTg3NDMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDc4ZTFjYjE5LWFiYzctMTFlOS04NzQzLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjQ3NyIgdD0iMTMyMDgxOTQ0ODM2NTc1NDY3IiBoPSJGVTNqUE5hc0Vubmg2YXpTaDUvRisxc0xxbGM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70c15124-34a2-428d-634f-08d70deb5fae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5304;
x-ms-traffictypediagnostic: BYAPR07MB5304:
x-microsoft-antispam-prvs: <BYAPR07MB530419DFF6C34A73F3719824DDC50@BYAPR07MB5304.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0105DAA385
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(199004)(189003)(36092001)(51444003)(68736007)(11346002)(71190400001)(71200400001)(446003)(8676002)(6916009)(14454004)(86362001)(9686003)(55016002)(4326008)(6246003)(107886003)(53936002)(6436002)(3846002)(256004)(6116002)(81166006)(26005)(186003)(7736002)(305945005)(81156014)(478600001)(8936002)(66066001)(74316002)(33656002)(7696005)(6506007)(54906003)(76176011)(102836004)(25786009)(316002)(5660300002)(66446008)(52536014)(2906002)(66946007)(229853002)(64756008)(66556008)(66476007)(476003)(76116006)(486006)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5304;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z3i82AZm7liZiCNNgs7yq/3o5SKB+WQchQCUEG8WAmi7CuRrIqcQY1sYHvVdNbGQa4Z92IRhcbY/n5e5JCB9Uifio9Be6yv6qSFFwpxAbrDVwe2A/fsu81pMIlyjp/Z4J0Mr1qbPJ9MZjxcEp7RibWpn0bNYricqIKFpvot28KD4pnWEqGz4dXtT82ebMvZKb2dAMPNSJCMgu6vPOLIK1RyGlBcV80tO0TOJoP+ATdAHHlmAym+fjCRJT0itWoM/BqbhkmHgygbONjUEctLnYQw/NevXXu7YynZ3nRMomSShxwAQbp6JYEHjL7gEg8p881x2ogKlJv5Rtiv5G+7n7BUWUZGKpd2VKuoWYKZ7Ix3M3IC+UlowhHQtbhYgtZcN8rm5OmBopqqgbTVHBiKnlPQJXH15GFUHaK269lDmvHM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c15124-34a2-428d-634f-08d70deb5fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2019 14:54:46.6716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5304
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907210179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>Pawel Laszczak <pawell@cadence.com> writes:
>>>>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>>>>> index 69f1b6328532..c156817672c4 100644
>>>>> --- a/include/linux/usb/otg.h
>>>>> +++ b/include/linux/usb/otg.h
>>>>> @@ -129,4 +129,20 @@ enum usb_dr_mode {
>>>>>   */
>>>>>  extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
>>>>>
>>>>> +/**
>>>>> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
>>>>> + * @str: Pointer to the given string
>>>>> + *
>>>>> + * The function gets string and returns the correspondig enum usb_dr=
_mode.
>>>>> + */
>>>>> +extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)=
;
>>>>> +
>>>>> +/**
>>>>> + * usb_dr_mode_to_string - Convert dual role mode to string.
>>>>> + * @dr_mode: Pointer to the given dual role mode
>>>>> + *
>>>>> + * The function gets enum usb_dr_mode, and returns the correspondig =
string.
>>>>> + */
>>>>> +extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_m=
ode);
>>>>> +
>>>>>  #endif /* __LINUX_USB_OTG_H */
>>>>
>>>>Still missing the stubs I mentioned. Did you try compiling with and
>>>>without common enabled?
>>>>
>>> Sorry, I thought that I send answer yesterday but it's look like I prep=
ared the answer but
>>> I  forgot to send.
>>>
>>> In /drivers/usb/Kconfig we have:
>>>
>>> config USB
>>> 	tristate "Support for Host-side USB"
>>> 	depends on USB_ARCH_HAS_HCD
>>> 	select USB_COMMON
>>>
>>> and in /drivers/usb/gadget/Kconfig we have:
>>>
>>> menuconfig USB_GADGET
>>> 	tristate "USB Gadget Support"
>>> 	select USB_COMMON
>>>
>>> I think that it should cover all cases.
>>>
>>> Am I right ?
>>
>>Run a few tens of randconfig builds and see if you ever catch any
>>problem. I think randconfig can produce a defconfig where USB=3Dn
>>USB_GADGET=3Dn and USB_COMMON=3Dy.
>
>Ok, I will test it, but I think that it should work.
>The same situation we have for example with: usb_otg_state_string or usb_e=
p_type_string.
>

I've been testing it with USB=3Dn USB_GADGET=3Dn and USB_COMMON=3Dy and als=
o only with CONFIG_USB_COMMON=3Dy.=20
Also I've tested this patch with different default configuration together w=
ith CDNS3 driver which use these functions.=20
I've test It mainly with x86 and arm architecture.=20
So far I've not found any issue.=20

Cheers,
Pawell

