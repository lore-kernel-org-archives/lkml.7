Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD76FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6507621655
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="C+pZmMBk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YoPdP2wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfGVKHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:07:47 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53902 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbfGVKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:07:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MA2c1V000937;
        Mon, 22 Jul 2019 03:06:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ZhFSq4fb9ySxDzp9SAG1tBuiFKzeth0//wSgjFVcM38=;
 b=C+pZmMBkfQje4PFAqQeQeULyKpYlSQkTkxOpGw/subqcxtLtBIlx6ZrHFR9tGb+/rUf/
 cw8XnAI6LUS+ATfH1Bc8QXRFTVNzwtVESUwiWsf1rGGspclbsEjMD/ToQF1bivOb8zzT
 sZfH3x+ypMbFIYHjKtFKtj4YjCJ9i3a7PgOTMphh0oahyjx4IZvUvjUz6XRkBBzxJC/3
 0LTPXBAuAroVSZeVna8IwfOLlAI9P5UfrIkrdcP2CpMyK0cRm6c4a0vfOFCYAKanj2u0
 jZHfeVY0PNQ6xv/eHwisT+8fgaGjsRF0kKYRD652oSdfLC5r2k6zqqe/jI5lcD7kFfLX tw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2053.outbound.protection.outlook.com [104.47.34.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tuygwp1g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 03:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrczULX3W39iupoCgvGO76bsEOWYxTujB8Cf//yQ2XbWAXX0Fj7QEE4/Ouv81ceiekQuz6DSB0umlccG79wr+Aig442Mhy+qsz5wkbYPhF1LejP5HKDlsGD10lBWbvT7coW8sq6ty7TqPCd3k+adVDB6gqKWzZ//cBqjW4JsZvIx1upMyBFwoezU0SqyeKWJXMRGHgGPkehZa7Ouj0vPxRm4euqzmRqLFHnV3fb/8Sfy6r19GWnhEFsBAH+4fx6cAG5FnsqgIZPT3Q2F/S+QUa/H8xxjtik3k+CaLc9o1G02bSwA2Raw01iboF2fH9JcgAaYr+/w/3iPDKswjZzh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhFSq4fb9ySxDzp9SAG1tBuiFKzeth0//wSgjFVcM38=;
 b=S2T5MWhx6b/XxrbanA62fJMWIA6SCKEVvF1jZpKuJEOJTl1/GLrP2F2rjU5p1sSdVOu8l+NCHLr6F25jv6Ary64+9nCzqpoi7WUaJR7DYi9T7eYAVJily6ghiQagFpezXsCl7+OLaSgzQuTE2lw020IQFyDJSYX8mxoex1eGLk8Fy80arioXlY2/3/jHbJp/CYaMV8fijyHKdUrN3m6id5pOWFgFkTfDu0c50Z678xFTlVxoMJetXcde3dBDGX3HnyYHFrMByGC9ZpR2rin0fWO6vuo7bX9vIinXqTchW5s6V5Q6MJs/9zizNFwLY26z83B1XHpPu+5RwKxlgjV0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhFSq4fb9ySxDzp9SAG1tBuiFKzeth0//wSgjFVcM38=;
 b=YoPdP2wUmd2uvwwzkLBkgJEPyCS8cV3PGk2JMXtFQwGx4LYRILhpWQTp4OuDtfbnsnN29fztIMhYoUfqWozrY/z8m6JfOxj8t1dXcsept6DsxjX6vxQHbaK4y5qRkcKJDWgLZ0oYNb1322h1HIp2wwqyMGLAKEQ/W3tMxKNRoi8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5847.namprd07.prod.outlook.com (20.179.91.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 10:06:38 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 10:06:38 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Joe Perches <joe@perches.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
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
Subject: RE: [PATCH v10 2/6] usb:common Separated decoding functions from dwc3
 driver.
Thread-Topic: [PATCH v10 2/6] usb:common Separated decoding functions from
 dwc3 driver.
Thread-Index: AQHVP/K7nMB7vDlJp0yjBpKWwoKwDqbVbqmAgAD5p1A=
Date:   Mon, 22 Jul 2019 10:06:38 +0000
Message-ID: <BYAPR07MB4709115020BE99B5EB34D232DDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
         <1563733939-21214-3-git-send-email-pawell@cadence.com>
 <4d4a8a02e4ec7fad9213302d17a6acd17851d8da.camel@perches.com>
In-Reply-To: <4d4a8a02e4ec7fad9213302d17a6acd17851d8da.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjMxOTQ1ZjAtYWM2OC0xMWU5LTg3NDMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDYzMTk0NWYxLWFjNjgtMTFlOS04NzQzLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzA5MyIgdD0iMTMyMDgyNjM1OTYxMTA2MjIxIiBoPSJvZVNkenc5VnhPQ0FJT05uTk1GM2JUQkZKTXM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a59314f-e046-45d6-89cc-08d70e8c4950
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5847;
x-ms-traffictypediagnostic: BYAPR07MB5847:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR07MB58474B7CE8D22732897C9B81DDC40@BYAPR07MB5847.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(36092001)(66066001)(66446008)(64756008)(66946007)(66476007)(66556008)(81166006)(81156014)(76116006)(8936002)(256004)(25786009)(4326008)(107886003)(86362001)(966005)(478600001)(99286004)(14454004)(110136005)(54906003)(316002)(486006)(76176011)(5660300002)(476003)(26005)(6246003)(305945005)(7696005)(2906002)(6436002)(229853002)(53936002)(102836004)(6506007)(52536014)(33656002)(186003)(74316002)(2501003)(71190400001)(71200400001)(8676002)(3846002)(55016002)(6306002)(9686003)(7736002)(6116002)(11346002)(446003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5847;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7AGIGuH9GGOva8YOoo6lLLTNbhO/f0j6px0pgN0Q6madriE1uuS6KWaHE3hCqb7TtWPDa4mOYeT1KOYHyN1MI1xjID9wIozDh6epR6JodK1tOwO7EBFsDUe13/PRVjNK8FrpVShQx/LIE5UprftU1bEVhUwrJHQYEFgTGKdwpRqngCOeG2VR/HOQPXY53UneyG56nrLwybR2GQzdEn8DpEQFP+4pMIwhzS+jlYB+eD1bHss+B0sVNyHBoYGI/4pfR/BS5pFLsJxkyheZ6oLp14quq5CClnUS2rTL4E/Z3nE5/PW3VwMZG23mnEsLTrAwSYCUSUqIlw9h1fGFeRff/QUxJ3WLAWq3p+W4y6xXCVVebYCAabCcQvHjEy+6lO8oWFWUo7GYPHwde5gEYgQdCm5IQiyB0UuHwjADqIkG30I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a59314f-e046-45d6-89cc-08d70e8c4950
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 10:06:38.2560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5847
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>On Sun, 2019-07-21 at 19:32 +0100, Pawel Laszczak wrote:
>> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
>> to driver/usb/common/debug.c file. These moved functions include:
>[]
>> diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
>[]
>> +static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bReque=
st,
>> +					 __u16 wValue, __u16 wIndex,
>> +					 char *str, size_t size)
>
>It's probably not necessary to use Hungarian
>when moving these functions into generic code.

In my opinion it's ok in this place. It's consistence with USB specificatio=
n ch9 and with
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/usb/ch9.h=
. (look at usb_ctrlrequest).=20

>
>> +{
>> +	switch (bRequestType & USB_RECIP_MASK) {
>> +	case USB_RECIP_DEVICE:
>> +		snprintf(str, size, "%s Device Feature(%s%s)",
>> +			 bRequest =3D=3D USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
>> +			 ({char *s;
>> +				switch (wValue) {
>> +				case USB_DEVICE_SELF_POWERED:
>> +					s =3D "Self Powered";
>> +					break;
>> +				case USB_DEVICE_REMOTE_WAKEUP:
>> +					s =3D "Remote Wakeup";
>> +					break;
>> +				case USB_DEVICE_TEST_MODE:
>> +					s =3D "Test Mode";
>> +					break;
>> +				case USB_DEVICE_U1_ENABLE:
>> +					s =3D "U1 Enable";
>> +					break;
>> +				case USB_DEVICE_U2_ENABLE:
>> +					s =3D "U2 Enable";
>> +					break;
>> +				case USB_DEVICE_LTM_ENABLE:
>> +					s =3D "LTM Enable";
>> +					break;
>> +				default:
>> +					s =3D "UNKNOWN";
>> +				} s; }),
>> +			 wValue =3D=3D USB_DEVICE_TEST_MODE ?
>> +			 ({ char *s;
>> +				switch (wIndex) {
>> +				case TEST_J:
>> +					s =3D ": TEST_J";
>> +					break;
>> +				case TEST_K:
>> +					s =3D ": TEST_K";
>> +					break;
>> +				case TEST_SE0_NAK:
>> +					s =3D ": TEST_SE0_NAK";
>> +					break;
>> +				case TEST_PACKET:
>> +					s =3D ": TEST_PACKET";
>> +					break;
>> +				case TEST_FORCE_EN:
>> +					s =3D ": TEST_FORCE_EN";
>> +					break;
>> +				default:
>> +					s =3D ": UNKNOWN";
>> +				} s; }) : "");
>
>I always find this sort of embedded switch/case char *
>statement expressions difficult to read and think it's
>better to use separate lookup functions.
>

It has been changed in next patch in the series.

>I would much prefer something like:
>
>static const char *usb_device_mode_desc(u16 mode)
>{
>	switch (mode) {
>	case USB_DEVICE_SELF_POWERED:
>		return "Self Powered";
>	case USB_DEVICE_REMOTE_WAKEUP:
>		return "Remote Wakeup";
>	case USB_DEVICE_TEST_MODE:
>		return "Test Mode";
>	case USB_DEVICE_U1_ENABLE:
>		return "U1 Enable";
>	case USB_DEVICE_U2_ENABLE:
>		return "U2 Enable";
>	case USB_DEVICE_LTM_ENABLE:
>		return "LTM Enable";
>	}
>	return "UNKNOWN";
>}
>
>		snprintf(str, size, "%s Device Feature(%s%s)",
>> 			 bRequest =3D=3D USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
>			 usb_device_mode_desc(wValue),
>			 etc...);
>
>
>etc...
>
Cheers,
Pawell


