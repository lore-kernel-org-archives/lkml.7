Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEEFC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804A1208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VfoU/IfI";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="c/OHnVAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfGaDtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 23:49:46 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:57554 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbfGaDtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 23:49:46 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V3nItM031522;
        Tue, 30 Jul 2019 20:49:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=GSz3ZHW+GB/O7fBi+i82MWdJ9DfCJR08+VxXrj7Il0M=;
 b=VfoU/IfIsMGgaicnp4Jgekxtk166A9ITtELidCq/RnGd/M061uyLUpK9NE7tCqoBcZHI
 7augVa32jOQ8VBlkCEVQhJKr+TdpRpG7W3Ty5i+Yql+5quWIBzPbOvDtqRJCLosFKwNO
 PfdjkpHTpNzaACGWvXS2NeD01chh7RYBFFvatt1vLmddFrNLKzkcTsifpkoFFy24jB4D
 0SC1RCy1endd9RKWvmSMxm92pMhpbup3Dni1FmAJoYHXLkGxJfPJ4HDyYnupU+3tDTji
 mDPZsVX5RkRYdGAXHnItefi1FVAuOMR156qFRyez8b0pCrbubc7vvoetZ44AhFJeIbD6 7w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2u0j711d74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 20:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/JQGQmbXYa1omN6oKVamJSVC1cHdDuzh/6w6tNOI0jGooeDLyq8n22zsYWNsjNvlflavAJvjeCiD+XgIw9jU5XxZX0jugUW6TLVhC/j7AXVb9Dul8Fi+d6L2tHQSHZ03EMyGA486RJWP/QLC2EOBe3AaR5Sl5v+gkDM7U/aa2ettzgA+W0oxk7tpW8PnG9aN0m6vU2wmv+p1YXAlboDaYQbsztPwAn/2LdcUWCiYZcXg5cHW3d2Ei/+MT5A7PqeU4DZ1aVYkN3tsjk4OsRFJ0nxAqyiNEV32XiynNn5aWXG8SpHUaVa4SiQHZNeFHR1ce3QJfP5/nmeebWs8ekjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSz3ZHW+GB/O7fBi+i82MWdJ9DfCJR08+VxXrj7Il0M=;
 b=MFmKcB3EkvmCHtqq+CHbNQ0kYGSznd8JuSrJ9XigSiReqc10t1lnEbZtbLbmOVU6SAgZ3DM/slt7oipNMwQoxf+BmQqet65oKn6nYtpif6KXITEF0QGbNuyaDmEcywY99C9cPQ/xhx4XarwVHeTN0eVyJrsk+zNxkBqd/6KjqEw8jWTuiw/t2jwZc6X0YurrPliccRRH3PsMZrbvmf8j6Qpn1G4QJJdNXa6BoVqoADRTX2HYWPPj7je2OLLrZUptO4dkQV52U7XGJQzmJRfax1NQqB+YOM4woUi+nAGznzQv6k+vNilYejDUKCT9WIe8jbJxTABv349fUpSOQUCk7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSz3ZHW+GB/O7fBi+i82MWdJ9DfCJR08+VxXrj7Il0M=;
 b=c/OHnVAQVWP34KWkbn08IkXKniPQ/jB8//noXWImkDRnbJBuKAkIz2OA5zorfXa8ispSPEzweUolDUrTvbrsEtKV9xqSSjMJJPXR/PP1TtiRqibYrJDdaoCxotXBSlgVBK8y+lGdckJdiEin6voorRXXuVP963UURpUCTA4BOvk=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6088.namprd07.prod.outlook.com (20.179.94.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 03:49:39 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d%3]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 03:49:39 +0000
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
Thread-Index: AQHVNZIWpYuDGK3vWkS+CQXY8vq54abBz0qAgAAB1ECAAAMegIAAAK9ggBNmXgCADvxqMA==
Date:   Wed, 31 Jul 2019 03:49:39 +0000
Message-ID: <BYAPR07MB4709BC53081D0493198FB7A6DDDF0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562592924-17528-1-git-send-email-pawell@cadence.com>
 <87y31768k0.fsf@linux.intel.com>
 <BYAPR07MB4709D1BD29C3E0FA6C5289FBDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87sgrf67qi.fsf@linux.intel.com>
 <BYAPR07MB4709AC9C0BBC8822ACE5409BDDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <BYAPR07MB470944CE1294AC9E5878792CDDC50@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB470944CE1294AC9E5878792CDDC50@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69bfb076-b00c-43d5-b3e5-08d7156a1cff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB6088;
x-ms-traffictypediagnostic: BYAPR07MB6088:
x-microsoft-antispam-prvs: <BYAPR07MB6088B27BFFDD190EC03907E1DDDF0@BYAPR07MB6088.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(51444003)(199004)(36092001)(107886003)(102836004)(186003)(5660300002)(2906002)(11346002)(25786009)(66066001)(4326008)(54906003)(26005)(6506007)(316002)(9686003)(55016002)(8676002)(6116002)(52536014)(486006)(81166006)(76176011)(256004)(478600001)(53936002)(3846002)(99286004)(7696005)(66476007)(76116006)(6916009)(7736002)(68736007)(64756008)(86362001)(33656002)(8936002)(66946007)(66556008)(66446008)(74316002)(305945005)(81156014)(476003)(71190400001)(6436002)(71200400001)(446003)(14454004)(229853002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6088;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: glNjAPqQPV4Vsyl1jjIw+nZBYFdE9gk2pUzwiWPvPgqLtA5HNN6/fKt8/FSQzBcyKedr5oxEcgVfXWj5PrS+37PXPALMcwE/2nXOvJZmTYQXAsSMsDgudUKa7diNBSZVACsQ5qgnSfnjwOza6+Me7azwwNM9KGIf705/4TJYBjq62ZBZekIRUhGr7qx4MJWfNv2GFzNIdlxzGKkS7xIzU2Xt60nlH7yxegYBN7N48h//flLFedOMrh1djdUm1bXxfg5XskdsrslMKjJpiapvOgWAZt6FFfW2JBzYNRGKWyfDpiNFfwkR+Rh3HKkkGE6RAKWrCsbWQ1Ufg6H0NGHY2Rr7eX3yJSXjTjvj9+XIZeRHIErQKgiJ5VSf5Zab19KVyXa6EU5t1SnEs0fZ6HlfShf14qKOYCslusNXv5f4+j8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bfb076-b00c-43d5-b3e5-08d7156a1cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 03:49:39.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6088
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

What about this patch. I just noticed that prefix is incorrect "1/3". Can i=
t stay or should I send it again ?

Cheers,
Pawel=20

>>>Pawel Laszczak <pawell@cadence.com> writes:
>>>>>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>>>>>> index 69f1b6328532..c156817672c4 100644
>>>>>> --- a/include/linux/usb/otg.h
>>>>>> +++ b/include/linux/usb/otg.h
>>>>>> @@ -129,4 +129,20 @@ enum usb_dr_mode {
>>>>>>   */
>>>>>>  extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
>>>>>>
>>>>>> +/**
>>>>>> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
>>>>>> + * @str: Pointer to the given string
>>>>>> + *
>>>>>> + * The function gets string and returns the correspondig enum usb_d=
r_mode.
>>>>>> + */
>>>>>> +extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str=
);
>>>>>> +
>>>>>> +/**
>>>>>> + * usb_dr_mode_to_string - Convert dual role mode to string.
>>>>>> + * @dr_mode: Pointer to the given dual role mode
>>>>>> + *
>>>>>> + * The function gets enum usb_dr_mode, and returns the correspondig=
 string.
>>>>>> + */
>>>>>> +extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_=
mode);
>>>>>> +
>>>>>>  #endif /* __LINUX_USB_OTG_H */
>>>>>
>>>>>Still missing the stubs I mentioned. Did you try compiling with and
>>>>>without common enabled?
>>>>>
>>>> Sorry, I thought that I send answer yesterday but it's look like I pre=
pared the answer but
>>>> I  forgot to send.
>>>>
>>>> In /drivers/usb/Kconfig we have:
>>>>
>>>> config USB
>>>> 	tristate "Support for Host-side USB"
>>>> 	depends on USB_ARCH_HAS_HCD
>>>> 	select USB_COMMON
>>>>
>>>> and in /drivers/usb/gadget/Kconfig we have:
>>>>
>>>> menuconfig USB_GADGET
>>>> 	tristate "USB Gadget Support"
>>>> 	select USB_COMMON
>>>>
>>>> I think that it should cover all cases.
>>>>
>>>> Am I right ?
>>>
>>>Run a few tens of randconfig builds and see if you ever catch any
>>>problem. I think randconfig can produce a defconfig where USB=3Dn
>>>USB_GADGET=3Dn and USB_COMMON=3Dy.
>>
>>Ok, I will test it, but I think that it should work.
>>The same situation we have for example with: usb_otg_state_string or usb_=
ep_type_string.
>>
>
>I've been testing it with USB=3Dn USB_GADGET=3Dn and USB_COMMON=3Dy and al=
so only with CONFIG_USB_COMMON=3Dy.
>Also I've tested this patch with different default configuration together =
with CDNS3 driver which use these functions.
>I've test It mainly with x86 and arm architecture.
>So far I've not found any issue.
>

