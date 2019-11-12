Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC4720818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kUxmHabr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="knJKbGG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLT5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:57:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46446 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726376AbfKLT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:57:15 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xACJrD6F016062;
        Tue, 12 Nov 2019 11:56:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OwqTzyJy6I/cpOWZty84Q8k4PzOWW83iEqJVvwBBVVw=;
 b=kUxmHabry93mpPjdKuA8cR2DxYnedIXzGoxVNJvDJJIJMKtSsF2bfGe3rLRy/pzx/E4b
 cAZuiDMwbCyL3D10s3cAF7LOh+9JbHXIblOtM4HP+pPB19cLQ2ttToilW5aTkoIsF56O
 C8qVv0OIKuDONQInSchKrsluAJ/ZuOXb9W4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2w7pr9uwn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Nov 2019 11:56:36 -0800
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 11:56:35 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 11:56:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuBAi14GHv8RtDNDx0kMH+py3oMUBvPgGBqmVIwptMXUaB6OU3EMstTLnGwynVKbG65K3sAI8QruaYbm6xai5b62HuJy2K36wTp/tP250YuyYgzaGteIDCOsWcN76Q9KtvcHrujmNzr+mGLAKDn75ROXKLBLbT310x6wYXhyfVRcLmqSEU7dSvuP35gciVLX85WOiW/aDI92kpLDxQdOXHrPKh5ylXVWPl76UmftXMDrcCEL/Trds+f7hp/wFCbfN8H7ekvZaFrsdGzGq/O3NUWM9RhOBiyxNQges9kph7dVHheD2fJBhHf/fd23I8PC4f6gW8EVtZInMTSMoQ1TlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwqTzyJy6I/cpOWZty84Q8k4PzOWW83iEqJVvwBBVVw=;
 b=IqDrsLx1dpCSaiDK80ITWPK+4ea+o1PmsSK129L6JG7H1SR3P5+RzxudwSnH80X6T5PKVBn6MYRAEDAhD2eOU+pBJq1wkoq8BEb9lgaOXjklvw7O+0G4BysTXUtJspjZwWkGVp9qpPN56kfJyV5r6SqZG1ubogW8hxffHpcciwv16HCN8ulrBdHBegZ0AusOmGvdS6eteKfKQAzwmtSevU0TK2/kdlwfdxXTAvvvaHofLxfEBNY/4jGA1a7Wa2zdIC2IlkkASttcSYDdPRT6AeCSxbGV0u+bGft5wNMA+NKMtjNt08aHIQDMEHAt5XhZaoHcJvGgJz17JV5axLlWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwqTzyJy6I/cpOWZty84Q8k4PzOWW83iEqJVvwBBVVw=;
 b=knJKbGG79VWogkmHJ38ipZvSrl2fnykTyFfXcvDlAaNgqUlA1ru94Ez147tyHPJpMJhOO+IeNuTIuMoFMQ7eiRCaC1lfMZaQ8v8AxoB/CWNRdjbNEwf1e1yxUeeve6SpoIXU02OVb3gVaGzbwMs4HPwTYPUvyrMJIjLJn8Zp1F4=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3650.namprd15.prod.outlook.com (52.133.253.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 19:56:34 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 19:56:34 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "asmaa@mellanox.com" <asmaa@mellanox.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Thread-Topic: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Thread-Index: AQHVmQJeBnbge6VCjUulKeqNucSkKaeHfQWA///xaoA=
Date:   Tue, 12 Nov 2019 19:56:34 +0000
Message-ID: <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
 <20191112124845.GE2882@minyard.net>
In-Reply-To: <20191112124845.GE2882@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::1:8011]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b043b65-6513-402b-dbed-08d767aa6bc7
x-ms-traffictypediagnostic: BY5PR15MB3650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3650DE746F790831D1FFB643DD770@BY5PR15MB3650.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(366004)(376002)(189003)(199004)(486006)(76176011)(5660300002)(2906002)(2501003)(6116002)(14444005)(4326008)(81156014)(6506007)(81166006)(6436002)(64756008)(66556008)(66476007)(66446008)(54906003)(25786009)(6512007)(2616005)(66946007)(6246003)(14454004)(86362001)(186003)(102836004)(476003)(8936002)(36756003)(11346002)(446003)(46003)(256004)(6916009)(99286004)(91956017)(316002)(7736002)(305945005)(76116006)(2351001)(229853002)(33656002)(5640700003)(478600001)(6486002)(71200400001)(71190400001)(8676002)(1730700003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3650;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: is0Hbmgvqx72XV9vOOwNkKzA0LQ4b8IQnzqRyoLMP7aU/ctxveAew7wUGKk6kurtDpYMqQSr/zpQDhXIBNxoZMfegn7jZNOYKT/WR/3Ll371ub5Yono3wtHr/IplUO5pbH0Y2Uw+WLMHNdr10DIwYHQ1hmhgBWpx7CXvDc4IyKxKT3cUc/iqgyiSfFY7ydFdiLY9a2m6VjXqjI4jFAr8v+JzlUj0RmlRDnO7vyaouS5osPXo1iRQ1Aa3A1e0c4t5KQlg2NfamCbQNGRG7nc+O2len43RisYiJDLBp1xuktGWZUtIEzsxho4iZWmrzpcvy/Zj75lafPnQu88ntcHyGGjqOLinAHCzSr6tjvTBV1eew8eWn+d6/pMu+yZGnYNcswvY5E7yofO+J2PLPsciPeQFELCmfrenE+ziLCsd3DAXEDdf5zUnUySXofYcgCC2
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA64DA43BDB6D24685771A81C8BB1078@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b043b65-6513-402b-dbed-08d767aa6bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 19:56:34.5456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbQ3uxyaq0JgxtyeYQgfM2e06SmZ3WNYVptDQmiBQHy0KyjEk+UeuyxZpNdJnSP/DlK46V5j5066vqGK79VMgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3650
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_07:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzEyLzE5LCA0OjQ4IEFNLCAiQ29yZXkgTWlueWFyZCIgPHRjbWlueWFyZEBn
bWFpbC5jb20gb24gYmVoYWxmIG9mIG1pbnlhcmRAYWNtLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBN
b24sIE5vdiAxMSwgMjAxOSBhdCAwNjozNjoxMFBNIC0wODAwLCBWaWpheSBLaGVta2Egd3JvdGU6
DQogICAgPiBBcyBwZXIgSVBNQiBzcGVjaWZpY2F0aW9uLCBtYXhpbXVtIHBhY2tldCBzaXplIHN1
cHBvcnRlZCBpcyAyNTUsDQogICAgPiBtb2RpZmllZCBNYXggbGVuZ3RoIHRvIDI0MCBmcm9tIDEy
OCB0byBhY2NvbW1vZGF0ZSBtb3JlIGRhdGEuDQogICAgDQogICAgSSBjb3VsZG4ndCBmaW5kIHRo
aXMgaW4gdGhlIElQTUIgc3BlY2lmaWNhdGlvbi4NCiAgICANCiAgICBJSVJDLCB0aGUgbWF4aW11
bSBvbiBJMkMgaXMgMzIgYnl0cywgYW5kIHRhYmxlIDYtOSBpbiB0aGUgSVBNSSBzcGVjLA0KICAg
IHVuZGVyICJJUE1CIE91dHB1dCIgc3RhdGVzOiBUaGUgSVBNQiBzdGFuZGFyZCBtZXNzYWdlIGxl
bmd0aCBpcw0KICAgIHNwZWNpZmllZCBhcyAzMiBieXRlcywgbWF4aW11bSwgaW5jbHVkaW5nIHNs
YXZlIGFkZHJlc3MuDQoNCldlIGFyZSB1c2luZyBJUE1JIE9FTSBtZXNzYWdlcyBhbmQgb3VyIHJl
c3BvbnNlIHNpemUgaXMgYXJvdW5kIDE1MCBieXRlcw0KRm9yIHNvbWUgb2YgcmVzcG9uc2VzLiBU
aGF0J3Mgd2h5IEkgaGFkIHNldCBpdCB0byAyNDAgYnl0ZXMuDQogICAgDQogICAgSSdtIG5vdCBz
dXJlIHdoZXJlIDEyOCBjYW1lIGZyb20sIGJ1dCBtYXliZSBpdCBzaG91bGQgYmUgcmVkdWNlZCB0
byAzMS4NCiAgICANCiAgICAtY29yZXkNCiAgICANCiAgICA+IA0KICAgID4gU2lnbmVkLW9mZi1i
eTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQogICAgPiAtLS0NCiAgICA+ICBk
cml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYyB8IDIgKy0NCiAgICA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCiAgICA+IA0KICAgID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIGIvZHJpdmVycy9jaGFyL2lw
bWkvaXBtYl9kZXZfaW50LmMNCiAgICA+IGluZGV4IDI0MTliOWE5MjhiMi4uN2Y5MTk4YmJjZTk2
IDEwMDY0NA0KICAgID4gLS0tIGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCiAg
ICA+ICsrKyBiL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jDQogICAgPiBAQCAtMTks
NyArMTksNyBAQA0KICAgID4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KICAgID4gICNp
bmNsdWRlIDxsaW51eC93YWl0Lmg+DQogICAgPiAgDQogICAgPiAtI2RlZmluZSBNQVhfTVNHX0xF
TgkJMTI4DQogICAgPiArI2RlZmluZSBNQVhfTVNHX0xFTgkJMjQwDQogICAgPiAgI2RlZmluZSBJ
UE1CX1JFUVVFU1RfTEVOX01JTgk3DQogICAgPiAgI2RlZmluZSBORVRGTl9SU1BfQklUX01BU0sJ
MHg0DQogICAgPiAgI2RlZmluZSBSRVFVRVNUX1FVRVVFX01BWF9MRU4JMjU2DQogICAgPiAtLSAN
CiAgICA+IDIuMTcuMQ0KICAgID4gDQogICAgDQoNCg==
