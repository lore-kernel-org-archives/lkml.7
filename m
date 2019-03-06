Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B69C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69276206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OSBbmCxR";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="G8MsBP+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfCFR3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:29:44 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51488 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726409AbfCFR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:29:44 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26HOgxu023925;
        Wed, 6 Mar 2019 09:29:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=4lOO4VaB0vX3DOAGx5sgSY96XDS0OmWRpmOV5vlqb3w=;
 b=OSBbmCxRBSUE0vx8cLWPkbM/PbFk5CWVKF+bIORRlkk4tpI9PD2GPSs+lXHB44hDSd9V
 PC3Pcq/CMBXoXAbZI0ageYV9K8XOcVR8Cbl47WTfBR9VKVXiFmYwkgE0JEQ/Gy8GdOmi
 X2C6LD0W/9sNXWa6SyNiehHi+yPQyam8lUJ4gkMRhExcnvtXHH06+X7HrJovV1Rimxe4
 IH1zDCZjW6wVG0MwOdR6C3Zogj0xJ4OvtXKevqEztlkhc30sHs/+kQG+Enhpp9hzv070
 cxUZvXwbid5WfDikgLmcVt/lXaEdHPxTpQPzXlj0DKSoF+MnvAXllI/skGTAWf02/0cV PQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2r2gum0grs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Mar 2019 09:29:37 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Mar
 2019 09:29:36 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Mar 2019 09:29:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lOO4VaB0vX3DOAGx5sgSY96XDS0OmWRpmOV5vlqb3w=;
 b=G8MsBP+YT7pbczrXWS/pvQEJtNI+V6iRS4MV1dsqQtW8/jWAVnH430iMsywvSOmrqEB+D5S8yW1g3AG/8KvaTjhGpRl4o28apQTHxUfeFtwd8yzJbJJGbkuwCsA3/fZopxU46yEKe7TlwUJCropmkPi8MitH6pghNzUAeZmplkI=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2606.namprd18.prod.outlook.com (20.179.83.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Wed, 6 Mar 2019 17:29:31 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::5aa:fd80:a3fd:9971]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::5aa:fd80:a3fd:9971%6]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 17:29:31 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quoc Tran <qtran@marvell.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] scsi: qla2xxx: avoid printf format warning
Thread-Topic: [PATCH 3/4] scsi: qla2xxx: avoid printf format warning
Thread-Index: AQHU0sIJGMxOOF6KLEyJvjfJnncKUKX+WLCA
Date:   Wed, 6 Mar 2019 17:29:31 +0000
Message-ID: <2FB12FC2-6B14-4AD4-BFAC-548720D676A6@marvell.com>
References: <20190304193917.702601-1-arnd@arndb.de>
 <20190304193917.702601-3-arnd@arndb.de>
In-Reply-To: <20190304193917.702601-3-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d9a9115-1f22-4eca-2a3f-08d6a2594b4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR18MB2606;
x-ms-traffictypediagnostic: MN2PR18MB2606:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNTjJQUjE4TUIyNjA2OzIzOmQ3YjZRSGo2MjlJaU54RWVQalVFb3ppOE54?=
 =?utf-8?B?OHhoUHVjZUMwaVpDUWFRVEtWcVFXaUJmNlRXWE9kam9tUzZnWmhCVnhiSEFi?=
 =?utf-8?B?akhUZGJYdnh3b2JiZnA4MEx3WlhIbHhXdTFvU0lnYlJ5bTRVSklZOTVWYUtX?=
 =?utf-8?B?RFc3OS9UMGxaVUozVlVGVjNDT3N1b2NkL0o1QTl6bGxFN3Y4TjZPV21JbVZa?=
 =?utf-8?B?VHladnV4SURsMHFOdFZPSGZlekxOWDYwR01ZUEVseFFvdVZrUzJkamc2SDB4?=
 =?utf-8?B?RUh3OU0xa21rRXl4S3E2N1cvSDhQRGs3M0kvV0VubXpXRVBlK1RTd3oxY1l1?=
 =?utf-8?B?eXpGRzZMY1UxN2R3MVB1ZUpldXRGYjViYTE4YUM0dmhjNythV3B1cUF5QUNO?=
 =?utf-8?B?NFZXbTlQZDNRdnIybU5qSGEyS1JHN3B6RzdiSkJMU2xGWFVielo1MTgrMUty?=
 =?utf-8?B?T1h4UVh1VExKcERVYWdmWm4vUlFBVU4wT1A1dGlCby9YR2xXamJjQ0QxOGVU?=
 =?utf-8?B?NVBaZnEwTVlzZXJSSkRvY0pZOW90NjAreVFDMFhnbEdMSUQ4eDNxZkpENVM4?=
 =?utf-8?B?T3ZOQ0QwK0Nsd01zVXN2WnA2MngrSUE4UGNiSnRnNFRuaFgrYnlNeFYvK01a?=
 =?utf-8?B?aCs2d0dXbHd6OVNEc0k2bnNWMFVXYjIvVWZTR2ZsWWpYS3VDaS82T1pkWEt6?=
 =?utf-8?B?bml0cGRGWE5jZUtKOFNBTWIvRDNNUytXcW93bVhjd29tdGdUZndyYzlSaWRJ?=
 =?utf-8?B?aThkVzRxN2IzNG1ZWVJpWkk1c3hrejJIWWlrSllGMFZrYWpxSU85NGxURVBu?=
 =?utf-8?B?MzhIMWpTL0VnbExzOTFlSUR6NXNZT2VlSXkvU2hiY2JUb0t1TURma0I5M0Ir?=
 =?utf-8?B?U2d1TWdLcU1weTg4S3dVeXUxNGt2Zm5lVGc2OTdLSTR6bCtJQ2lKa2R4T0pY?=
 =?utf-8?B?Sng5L28xRnAzTlNkL054NW9HQjR1cW92d1VSUkFuckM5Sm9HVGxDYi9NMWgz?=
 =?utf-8?B?SG9PNkt0RnRtMVg3cmdkTENRSHdnWXlJM1ZNV3dGaTdrOUJXYWt5ei9mejJP?=
 =?utf-8?B?KzdqZ2FVRjdwdjNlUit2ZlA4amNCeFVCQ1JKc0c1QSs1azZwNDFjeG1DOEhT?=
 =?utf-8?B?NktpMmtGMGZKdjI5ZCtSSVdGaFJZZmxycVA2Rk9RNlhvcm5HN3pRai9pbkJo?=
 =?utf-8?B?NTdrcExWNHFzMCtWRDM2NzdEWUpMSmY1bkk5clRObXRjMGU0dGtDR2FSMDIy?=
 =?utf-8?B?UHRxWDlvckFsQXJua1F0T0J2WmliNGtTU0N6STVJNm5ZTUEveU8va0p0V3d5?=
 =?utf-8?B?U2FuRUw2TnhMMEtNTDhJSm9JRGNuZ1lQTFJvUVMwb1NOMmtFUHEzNG5ZbzZk?=
 =?utf-8?B?aDdsOG5CdTJOcjB4REx0MzNIOEt5bDhYRFJkMHNEWUk3dUlJY3BmWUJZVnMy?=
 =?utf-8?B?WnlSbDFUTDJBRUV6eXY0VFVjZ0xvaUZhU1ZvZ3QyaTFQcmFOWW9rL2VqZWRM?=
 =?utf-8?B?Q2tQUEl0QUdJSXJzN1VVUmpmaS9wTDhrdGpNSVA3SmhHSHd1R0pGWmNJWmE3?=
 =?utf-8?B?Z0g1VG5BUEFhVC9IdWNOQTJQZllQbzV3MTlXV2pnUGNDSmcyL01PZDdmbFBI?=
 =?utf-8?B?NVoweFFqOHhLcjB0d3hnYXF1aTU5Z0wyb0hTV0Y5d0h4REZKYXN4T1FoUVBO?=
 =?utf-8?B?WG9pdWo0OFRPaTVJSU45S0tkcU9YWjJXSXpCWGE1NUkvdERNeVJGbGwzb244?=
 =?utf-8?B?OVVwRmtNd0VaL1FySVZYQTUrNVFSQkdra3o4MHhoYWkvVms5Qkd0MU42am9Y?=
 =?utf-8?B?aWhxSEQ0Y3ZIaUtHdUw0MjREQXIwa0E1UEJzSUpUUmcwTVF5MW1oVGowcmJL?=
 =?utf-8?Q?GFHPxBegWaA=3D?=
x-microsoft-antispam-prvs: <MN2PR18MB2606DA97099D7708282D4EB4D6730@MN2PR18MB2606.namprd18.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(346002)(136003)(366004)(39850400004)(199004)(189003)(256004)(68736007)(6116002)(5660300002)(33656002)(316002)(6246003)(110136005)(83716004)(229853002)(186003)(2616005)(476003)(3846002)(54906003)(4326008)(446003)(97736004)(26005)(6486002)(486006)(2906002)(102836004)(36756003)(82746002)(76176011)(14454004)(6512007)(6436002)(53936002)(7736002)(11346002)(305945005)(86362001)(2501003)(6506007)(8676002)(66066001)(8936002)(14444005)(71200400001)(106356001)(105586002)(25786009)(71190400001)(81166006)(478600001)(81156014)(99286004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2606;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k2rnj3lJvdA5Spq+3wnVweELnn0xcCDc56Q0pHRAWINOdF9TyN8XSV1jwztsF5/b1Ih/NITRXobOkWY7lPVY05LgBui/0I67OHEDynfRhvkj8Msu2KZSwXVG7bT17hJQ2V+9XuEwJaaLgFMIjUv5zkiKIa9RO3JHMETEfqZTkV2z5dozsDKz3/7N8pZnuXQBKfv1EQ5XRJw2Df6Y63UsYObAP40X2puHoOnbmJcSPeb7r3bk8P9m+omOk80pin9p8zVKWtII20Arygy1Y2Q7Ps2veXc8U2ylcZNmfZ6iKyoPKKZ24witcl9W8aCH10/88SFcj4nsuJ7z9VQw+WRHAVJeQvf1VDUYF28EsFN1OkOSA9v2JqkbWoU69/qSta26QggruTxsDFUHBYDWn97XWnq0j75LsOfE103nb4fTZ9E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <157354F546D00242807DAC87661DC53A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9a9115-1f22-4eca-2a3f-08d6a2594b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 17:29:31.7211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2606
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDMvNC8xOSwgMTE6MzkgQU0sICJBcm5kIEJlcmdtYW5uIiA8YXJuZEBhcm5kYi5k
ZT4gd3JvdGU6DQoNCiAgICBEZXBlbmRpbmcgb24gdGhlIHRhcmdldCBhcmNoaXRlY3R1cmUgYW5k
IGNvbmZpZ3VyYXRpb24sIGJvdGggcGh5c19hZGRyX3QNCiAgICBhbmQgZG1hX2FkZHJfdCBtYXkg
YmUgc21hbGxlciB0aGFuICdsb25nIGxvbmcnLCBzbyB3ZSBnZXQgYSB3YXJuaW5nIHdoZW4NCiAg
ICBwcmludGluZyBlaXRoZXIgb2YgdGhlbSB1c2luZyB0aGUgJWxseCBmb3JtYXQgc3RyaW5nOg0K
ICAgIA0KICAgIGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9pb2NiLmM6IEluIGZ1bmN0aW9uICdx
bGEyNHh4X3dhbGtfYW5kX2J1aWxkX3Byb3Rfc2dsaXN0JzoNCiAgICBkcml2ZXJzL3Njc2kvcWxh
Mnh4eC9xbGFfaW9jYi5jOjExNDA6NDY6IGVycm9yOiBmb3JtYXQgJyVsbHgnIGV4cGVjdHMgYXJn
dW1lbnQgb2YgdHlwZSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCcsIGJ1dCBhcmd1bWVudCA2IGhh
cyB0eXBlICdkbWFfYWRkcl90JyB7YWthICd1bnNpZ25lZCBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9
XQ0KICAgICAgICAgICAgICIlczogcGFnZSBib3VuZGFyeSBjcm9zc2luZyAocGh5cz0lbGx4IGxl
bj0leClcbiIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH5+fl4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJXgN
CiAgICAgICAgICAgICBfX2Z1bmNfXywgc2xlX3BoeXMsIHNnLT5sZW5ndGgpOw0KICAgICAgICAg
ICAgICAgICAgICAgICB+fn5+fn5+fg0KICAgIGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9pb2Ni
LmM6MTE4MDoyOTogZXJyb3I6IGZvcm1hdCAnJWxseCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBl
ICdsb25nIGxvbmcgdW5zaWduZWQgaW50JywgYnV0IGFyZ3VtZW50IDcgaGFzIHR5cGUgJ2RtYV9h
ZGRyX3QnIHtha2EgJ3Vuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1dDQogICAgICAgICAg
ICAiJXM6IHNnWyV4XSAocGh5cz0lbGx4IHNnbGVuPSV4KSBsZG1hX3NnX2xlbjogJXggZGlmX2J1
bmRsX2xlbjogJXggbGRtYV9uZWVkZWQ6ICV4XG4iLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfn5+Xg0KICAgIA0KICAgIFRoZXJlIGFyZSBzcGVjaWFsICVwYWQgYW5kICVwYXAgZm9y
bWF0IHN0cmluZ3MgaW4gTGludXggdGhhdCB3ZSBjb3VsZCB1c2UgaGVyZSwNCiAgICBidXQgc2lu
Y2UgdGhlIGRyaXZlciBhbHJlYWR5IGRvZXMgNjQtYml0IGFyaXRobWV0aWMgb24gdGhlIHZhbHVl
cywgdXNpbmcgYQ0KICAgIHBsYWluICd1NjQnIHNlZW1zIG1vcmUgY29uc2lzdGVudCBoZXJlLg0K
ICAgIA0KICAgIE5vdGU6IEEgcG9zc2libGUgcmVsYXRlZCBpc3N1ZSBtYXkgYmUgdGhhdCB0aGUg
ZHJpdmVyIHBvc3NpYmx5IGNoZWNrcyB0aGUNCiAgICB3cm9uZyBraW5kIG9mIG92ZXJmbG93OiB3
aGVuIGFuIElPTU1VIGlzIGluIHVzZSwgYnVmZmVycyB0aGF0IGNyb3NzIGEgMzItYml0DQogICAg
Ym91bmRhcnkgaW4gcGh5c2ljYWwgYWRkcmVzc2VzIHdvdWxkIHN0aWxsIGJlIG1hcHBlZCBpbnRv
IGRtYSBhZGRyZXNzZXMNCiAgICB3aXRoaW4gdGhlIGxvdyA0R0Igc3BhY2UsIHNvIEkgc3VzcGVj
dCB0aGF0IHdlIGFjdHVhbGx5IHdhbnQgdG8gY2hlY2sNCiAgICBzZ19kbWFfYWRkcmVzcygpIGlu
c3RlYWQgb2Ygc2dfcGh5cygpIGhlcmUuDQogICAgDQogICAgRml4ZXM6IDUwYjgxMjc1NWU5NyAo
InNjc2k6IHFsYTJ4eHg6IEZpeCBETUEgZXJyb3Igd2hlbiB0aGUgRElGIHNnIGJ1ZmZlciBjcm9z
c2VzIDRHQiBib3VuZGFyeSIpDQogICAgU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2lvY2Iu
YyB8IDQgKystLQ0KICAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KICAgIA0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFf
aW9jYi5jIGIvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2lvY2IuYw0KICAgIGluZGV4IDYzZjhl
M2MxOTg0MS4uNDU2YTQxZDJlMmM2IDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvc2NzaS9xbGEy
eHh4L3FsYV9pb2NiLmMNCiAgICArKysgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfaW9jYi5j
DQogICAgQEAgLTExMzIsNyArMTEzMiw3IEBAIHFsYTI0eHhfd2Fsa19hbmRfYnVpbGRfcHJvdF9z
Z2xpc3Qoc3RydWN0IHFsYV9od19kYXRhICpoYSwgc3JiX3QgKnNwLA0KICAgICAJLyogaWYgaW5p
dGlhdG9yIGRvaW5nIHdyaXRlIG9yIHRhcmdldCBkb2luZyByZWFkICovDQogICAgIAlpZiAoZGly
ZWN0aW9uX3RvX2RldmljZSkgew0KICAgICAJCWZvcl9lYWNoX3NnKHNnbCwgc2csIHRvdF9kc2Rz
LCBpKSB7DQogICAgLQkJCWRtYV9hZGRyX3Qgc2xlX3BoeXMgPSBzZ19waHlzKHNnKTsNCiAgICAr
CQkJdTY0IHNsZV9waHlzID0gc2dfcGh5cyhzZyk7DQogICAgIA0KICAgICAJCQkvKiBJZiBTR0Ug
YWRkciArIGxlbiBmbGlwcyBiaXRzIGluIHVwcGVyIDMyLWJpdHMgKi8NCiAgICAgCQkJaWYgKE1T
RChzbGVfcGh5cyArIHNnLT5sZW5ndGgpIF4gTVNEKHNsZV9waHlzKSkgew0KICAgIEBAIC0xMTc4
LDcgKzExNzgsNyBAQCBxbGEyNHh4X3dhbGtfYW5kX2J1aWxkX3Byb3Rfc2dsaXN0KHN0cnVjdCBx
bGFfaHdfZGF0YSAqaGEsIHNyYl90ICpzcCwNCiAgICAgDQogICAgIAkJCXFsX2RiZyhxbF9kYmdf
dGd0ICsgcWxfZGJnX3ZlcmJvc2UsIHZoYSwgMHhlMDIzLA0KICAgICAJCQkgICAgIiVzOiBzZ1sl
eF0gKHBoeXM9JWxseCBzZ2xlbj0leCkgbGRtYV9zZ19sZW46ICV4IGRpZl9idW5kbF9sZW46ICV4
IGxkbWFfbmVlZGVkOiAleFxuIiwNCiAgICAtCQkJICAgIF9fZnVuY19fLCBpLCBzZ19waHlzKHNn
KSwgc2dsZW4sIGxkbWFfc2dfbGVuLA0KICAgICsJCQkgICAgX19mdW5jX18sIGksICh1NjQpc2df
cGh5cyhzZyksIHNnbGVuLCBsZG1hX3NnX2xlbiwNCiAgICAgCQkJICAgIGRpZmN0eC0+ZGlmX2J1
bmRsX2xlbiwgbGRtYV9uZWVkZWQpOw0KICAgICANCiAgICAgCQkJd2hpbGUgKHNnbGVuKSB7DQog
ICAgLS0gDQogICAgMi4yMC4wDQogICAgDQpMb29rcyBnb29kDQoNCkFja2VkLWJ5OiBIaW1hbnNo
dSBNYWRoYW5pIDxobWFkaGFuaUBtYXJ2ZWxsLmNvbT4NCiAgICANCg0K
