Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5584CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211CE216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WRo9sqKK";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KnvXngV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfGVKMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:12:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57368 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbfGVKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:12:15 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MA2aNO000923;
        Mon, 22 Jul 2019 03:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=hEgSFvxVDR+q4SpLniVKvCdgRFswCGRu/spcfMhvbKc=;
 b=WRo9sqKKP6HC2j/awSsAr01NfvtHwzJr22dfrIttb0+ftdTxnOl3BO/ZTgXahapwchbx
 5uhQLzxNfCeryScm2sIScnaqi6oVMKkSmKdLSiX4i25qGDC5ANhR2hBG+ZVyZfP4B096
 1W77KbT3MoHfhCPYdWuVzqiNDqh9yXLVTTVjpfvjx9ovxB3rwJAEgoUjRaQyZ4LjILOS
 5qjbKT3mdG0h2cbW/48e5grLsFZ/knFdlSEKsxUBjwKXGgKAv7WAbRctsV43XGj6bdg9
 iWyFyzq2g8SoUIMTJZfMXM0tfFcCc5HApgasSJJA8ARJpD2VTSvkZtJ7svFPRsX7rmGR 5A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2059.outbound.protection.outlook.com [104.47.40.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tuygwp1wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 03:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfnLfByAJf04eMEhYey3ySOPOMXzGYGbYDlsdPfzAYEiQz8O4lu/BHL3DDjReWBV6Aer0ysRuOxsHOxUsYm55sZipzR+KbIID4f3SG15aPp9kgmkp2x+4VBO9ZAm+sHhwXP8RmG7tAcdAHW/KKqMCKvtFuSU8qtd27O0eJuCrsgl3PuAGLuS4eWlg7gbQmYg5E2zyXu9P0z+7Ef0QUEicLC9YtpNbhs+3EgbFZHs8WT3vyDSMD3y61oqRQCBTFrAiWWtlYMj6r02qd/6iE4Dc6u4MNSMRhvi3Uy2s3Op1XReIaeBa6Pj6+ig+09KCLB7N9mtLzdKmZDb3ghPa8M/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEgSFvxVDR+q4SpLniVKvCdgRFswCGRu/spcfMhvbKc=;
 b=TN1uKGRgCo/mxojTRNxqRyL2IT7630ioiE9QRwQHQA7JMBWSf/3ESI58igegGEkM0gvqTnfgbF7CwZmt5u06SP0N37l+X1S9caE66UrgqycuaZGg45VVoNYVQOjiIlSaxqyvyxBigIJc2l8DVQvW99BAd4V5vd7XXXo0xjKoaXF0zr1OaG8fY6NesEVB0iTL5xpBR9Pdk6kdId+9ZIsTw5Cf7O3nFagwh4il1F9JrJ0DM46a8jw7yE8Alcp24LZsCgblPodPG5B6mlqK6nH93ogmannQ6NOImPDPaqR4OCK9CLg8qBVeyMUmQeK7NvQ40/8Tk9Gtwwh8005T54lkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEgSFvxVDR+q4SpLniVKvCdgRFswCGRu/spcfMhvbKc=;
 b=KnvXngV1X6rytnhEopYp/9bJL9Wq11ubSfdJFKXJLUDyOVPdwu8Fmps+HnfwLQTIr6WVk+SxGA6S9Wva+lEI6WYXQDiFkHrOdHftNq6TsfzmTL4VrhOkFAJ2ePCkJRdNX8lY4VDi36RXwmBOg7QKVjDwdPtnHQ818sNzUqwLB0U=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5847.namprd07.prod.outlook.com (20.179.91.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 10:12:06 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 10:12:05 +0000
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
Subject: RE: [PATCH v10 3/6] usb:common Patch simplify
 usb_decode_set_clear_feature function.
Thread-Topic: [PATCH v10 3/6] usb:common Patch simplify
 usb_decode_set_clear_feature function.
Thread-Index: AQHVP/LEmwzWOkQQukWtTsoPuSeSmabVb08AgAD7cTA=
Date:   Mon, 22 Jul 2019 10:12:05 +0000
Message-ID: <BYAPR07MB4709DD50CB0EA4950EB42656DDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
         <1563733939-21214-4-git-send-email-pawell@cadence.com>
 <300d3c06763883bc4af2d25d5466b7188d20e8f3.camel@perches.com>
In-Reply-To: <300d3c06763883bc4af2d25d5466b7188d20e8f3.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjVhNzMxZmYtYWM2OS0xMWU5LTg3NDMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDI1YTczMjAxLWFjNjktMTFlOS04NzQzLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTQyNSIgdD0iMTMyMDgyNjM5MjI0OTM5NzMwIiBoPSJ4K2hHRVFaQmtaRlVQODJKNkloRHlUaEZNSEU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5910e04d-d239-47e6-2f23-08d70e8d0c34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5847;
x-ms-traffictypediagnostic: BYAPR07MB5847:
x-microsoft-antispam-prvs: <BYAPR07MB584719C81D178661A07ADCF9DDC40@BYAPR07MB5847.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(36092001)(102836004)(6506007)(229853002)(53936002)(33656002)(74316002)(186003)(52536014)(26005)(6246003)(76176011)(476003)(5660300002)(7696005)(6436002)(2906002)(305945005)(9686003)(55016002)(3846002)(6116002)(7736002)(11346002)(68736007)(446003)(8676002)(71200400001)(71190400001)(2501003)(8936002)(64756008)(66446008)(66066001)(66556008)(66476007)(66946007)(76116006)(81156014)(81166006)(14454004)(99286004)(54906003)(110136005)(316002)(486006)(86362001)(25786009)(256004)(107886003)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5847;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5UfM574jbM7tMNgwbhsZRi6vdgkNL2FX3zxd/+MBFr679DLUaXsAcJfmFm86oV6duO0BzgYEtUqv23AGenVqDtEfr7dMSIETiqq3VKd/kV7dLNhRyOrpGnuYjHCfiKccatRdrE32J7hNK46+iZHI+7l2P8rPsxPMZDT821YSQGXJbc5WNry5nElK9EaGt5WVg2iHoQfa4zwRvgxhoq4vlb5o2UFwA+OGGpXhA5HI7nqlFeLwCQH9x9Zkwz22rdLVyBxpSWeIzAATRNA8SLbz/cPn+n8D8o4qKhzBgsRbgYJAJcX1nkA6I1oj8xabY0ES7nPlVFmfbtmeLpVc4x3wIKTdypgMooGKDO7VieueTVCqIIE8l2KfNXwzm7YFhTV9VG9h09FU5hTMgOulHuU0LbwRHULeH9Qakj8Gqm/N25E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5910e04d-d239-47e6-2f23-08d70e8d0c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 10:12:05.3229
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
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=476 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Sun, 2019-07-21 at 19:32 +0100, Pawel Laszczak wrote:
>> Patch adds usb_decode_test_mode and usb_decode_device_feature functions,
>> which allow to make more readable and simplify the
>> usb_decode_set_clear_feature function.
>
><chuckle>  I need to read entire patch series before
>commenting more I guess...
>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/common/debug.c | 89 ++++++++++++++++++--------------------
>>  1 file changed, 43 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
>[]
>> +static const char *usb_decode_device_feature(u16 wValue)
>
>I believe this is still unnecessary hungarian.

it's common in usb subsystem if driver refers to descriptors fields.
>
>> +{
>> +	switch (wValue) {
>> +	case USB_DEVICE_SELF_POWERED:
>> +		return "Self Powered";
>> +	case USB_DEVICE_REMOTE_WAKEUP:
>> +		return "Remote Wakeup";
>> +	case USB_DEVICE_TEST_MODE:
>> +		return "Test Mode";
>> +	case USB_DEVICE_U1_ENABLE:
>> +		return "U1 Enable";
>> +	case USB_DEVICE_U2_ENABLE:
>> +		return "U2 Enable";
>> +	case USB_DEVICE_LTM_ENABLE:
>> +		return "LTM Enable";
>> +	default:
>> +		return "UNKNOWN";
>> +	}
>> +}
>
>
But yeah, exactly like this... ;)
>

Pawell
