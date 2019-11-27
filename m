Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BBC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9F2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DWI2IGhC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eXOq+QOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0NPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:15:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfK0NPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:15:37 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARDANdA008750;
        Wed, 27 Nov 2019 05:15:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4Ahhp7jSLINdmcBbWzvRKi1ZeiNGUhwXuaWbiv4L7mM=;
 b=DWI2IGhC4QvzxQbSLmBYB8XEVmO97hpd0MLEqP0IPHji1Dl7m//y/Ls4QDYaduXoO2eQ
 7tqY3Fgzqx46VBpU+YkprCOY3zDV11dT4+MfWL1tSm+Imh/89ohOyP80tnXmd8vMKmKl
 lh7d594ZOMMOJyoZ0Byoa5Fcgvh508JZg0g= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2whcy4m6x6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 05:15:07 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 27 Nov 2019 05:14:52 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 27 Nov 2019 05:14:51 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 27 Nov 2019 05:14:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVNsA83XWMJ2JXAKXybCXu2WM1/auptHzW5cRVEvfGS3BK1rnW8sdJf8Jz/VmKBLfVVdDtBw/lIlz7wXLIUwH5itEVegI2mpv8LCAChsnFQgBnM+D0kY9VH09s17ukfVhz90VQkKFMlyQZk5u5rk+JCudWleMVbSdZvN4vw7vQ09ZRGx2/rKpQv+ev2X3txQONGRLSJGaT0ajvjHVlcX2aHUNCKTz9vG18xovW8PEk7QK5ls8/ww7brPWp9PmHXANz/zK7vsEtGUymJaRmoeO9cR+YJKWK89+F0Ic3AN0ZGFYkNk5Xzrly4WsmCSYXTWnXrs9jtP4AJmT/EHwgI3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ahhp7jSLINdmcBbWzvRKi1ZeiNGUhwXuaWbiv4L7mM=;
 b=jwFhmS4INjOBGXOFeZPPjdQOFk7K3KycMsOgT7wZXU562fCL+ZMU5PIflTiX9Zn6YHPK8QDw2lmB/1yWuXnwpzxx6yySXsGLhxF69jPAI5Q4wqBuXjMCPuFeyqneAYmK/lwhSYUQ+ddaJxcvCW8STbCAk/IFxxX3XqczobQWUqHWlEdtQHcZbOGveSsNffilldqF5Nh8klOYSA3Hwgw60SSUyeIejYwDHhpDBvyFi48sEP/Qsk+o3KhJ0v5fnrI/0Ps8ji+7gw5vndAh1pMtn8pos28svLEmWSnulpVmBF872N9jJwNPAf364PR/ffOitTj/UKoT1hOSpVTNcRhIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ahhp7jSLINdmcBbWzvRKi1ZeiNGUhwXuaWbiv4L7mM=;
 b=eXOq+QOUoN7WTSWi+9d4OvFa8aOcso80PhlQlCBk2MrQT+8vrdwKztXgVxdvxicohfowrhCPEe/C/q0UnT9FMMwOe0mib2axqmKoKa8j6Z1xgptH/5U1eKKqi9c91DO4+UqV/4aNxzpfue89w0JziTK+9uVt65smt5kQOPYQBZg=
Received: from MWHPR15MB1597.namprd15.prod.outlook.com (10.173.234.137) by
 MWHPR15MB1888.namprd15.prod.outlook.com (10.174.100.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 27 Nov 2019 13:14:50 +0000
Received: from MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::2c43:c44b:2c95:e376]) by MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::2c43:c44b:2c95:e376%11]) with mapi id 15.20.2474.023; Wed, 27 Nov
 2019 13:14:50 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>
CC:     "andrew@aj.id.au" <andrew@aj.id.au>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "manikandan.e@hcl.com" <manikandan.e@hcl.com>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Topic: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Index: AQHVpOkG+MMCvXZVAU6DKaUkiiTbGaeeeVyA
Date:   Wed, 27 Nov 2019 13:14:50 +0000
Message-ID: <78F6056C-EBD3-439A-B5CF-D21FD3592924@fb.com>
References: <20191127060747.GA30829@cnn>
In-Reply-To: <20191127060747.GA30829@cnn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4b00:fd70:18e2:66b5:5e3d:3d1a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fabec25-2336-4cae-2044-08d7733bc8cb
x-ms-traffictypediagnostic: MWHPR15MB1888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB18884EAD626E9DBB632D1B15DD440@MWHPR15MB1888.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(376002)(366004)(346002)(47680400002)(189003)(199004)(7736002)(8676002)(6506007)(46003)(6916009)(33656002)(25786009)(478600001)(102836004)(6512007)(305945005)(6246003)(186003)(86362001)(4326008)(76176011)(66446008)(66476007)(2906002)(54906003)(2616005)(66946007)(81166006)(81156014)(76116006)(8936002)(91956017)(66556008)(6116002)(36756003)(14454004)(6436002)(11346002)(6486002)(229853002)(446003)(99286004)(316002)(64756008)(256004)(71190400001)(5660300002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1888;H:MWHPR15MB1597.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mW5haak10T4zP9mKJkyhsdrlcPVxwdOxncBJWpFRaayfEBdmUC4tjbNNYFIcZKsnXDKBref6nV7ntXcjoJ6iEqLsys5iAROx7JuWC/v/iiHs2HrKQVwoKbWH5fqiZqr7VZyd68ruHgsbJ1sqvNmj9aqgKFSzpCX8FjbG0AmRSFQXQfbAG8ADNHwlsd6aZrf04HKiyoV9ZKLlyHr3FXX9qG2hoE/MIV4mxB/or3sjXQFR2vAQy6AvVq5Q8Mu1uB2dpB910/CVFe36BOY3L3NinC2f9SvkWC4I0r4HhI8d+s1ZfR8ISA657MHmRoxTrnkHFMjtlNwKFM5E1LtPd8B419FGju65ddu0zGzyRQqIvcUQQ1vDnUu7A5MeRTFWOaC55todBftLR1jC6G2XkDLUKk9g75hqzDSuBSPbC6gNUS2Jc0lb4Cf202XRfWbuvdfN
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D90724A43BB8642BC085CDB17152293@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fabec25-2336-4cae-2044-08d7733bc8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 13:14:50.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pit8TNmBQAv/y0IfOJr7XlTe30KfaDOKblfhOjsMiph7mCH6A7jYzeiN8Z4IeFnwHsNpR4EkYs6UhFZwB5pQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270116
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzI2LzE5LCAxMDowOCBQTSwgIm1hbmlrYW5kYW4tZSIgPG1hbmlrYW5kYW4u
aGNsLmVycy5lcGxAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIFRoZSBZb3NlbWl0ZSBWMiBpcyBh
IGZhY2Vib29rIG11bHRpLW5vZGUgc2VydmVyDQogICAgcGxhdGZvcm0gdGhhdCBob3N0IGZvdXIg
T0NQIHNlcnZlci4gVGhlIEJNQw0KICAgIGluIHRoZSBZb3NlbWl0ZSBWMiBwbGF0b3JtIGJhc2Vk
IG9uIEFTVDI1MDAgU29DLg0KICAgIA0KICAgIFRoaXMgcGF0Y2ggYWRkcyBsaW51eCBkZXZpY2Ug
dHJlZSBlbnRyeSByZWxhdGVkIHRvDQogICAgWW9zZW1pdGUgVjIgc3BlY2lmaWMgZGV2aWNlcyBj
b25uZWN0ZWQgdG8gQk1DIFNvQy4NCg0KUmV2aWV3ZWQtYnk6IFZpamF5IEtoZW1rYSA8dmtoZW1r
YUBmYi5jb20+DQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogbWFuaWthbmRhbi1lIDxtYW5pa2Fu
ZGFuLmhjbC5lcnMuZXBsQGdtYWlsLmNvbT4NCiAgICAtLS0NCiAgICAgLi4uL2Jvb3QvZHRzL2Fz
cGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdHMgICAgfCAxNTAgKysrKysrKysrKysrKysr
KysrKysrDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAxNTAgaW5zZXJ0aW9ucygrKQ0KICAgICBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay15b3Nl
bWl0ZXYyLmR0cw0KICAgIA0KICAgIGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hc3Bl
ZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRldjIuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVk
LWJtYy1mYWNlYm9vay15b3NlbWl0ZXYyLmR0cw0KICAgIG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQog
ICAgaW5kZXggMDAwMDAwMC4uNDRlMmIxNw0KICAgIC0tLSAvZGV2L251bGwNCiAgICArKysgYi9h
cmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRldjIuZHRzDQogICAg
QEAgLTAsMCArMSwxNTAgQEANCiAgICArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjArDQogICAgKy8vIENvcHlyaWdodCAoYykgMjAxOCBGYWNlYm9vayBJbmMuDQogICAgKy9kdHMt
djEvOw0KICAgICsNCiAgICArI2luY2x1ZGUgImFzcGVlZC1nNS5kdHNpIg0KICAgICsjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvZ3Bpby9hc3BlZWQtZ3Bpby5oPg0KICAgICsNCiAgICArLyB7DQogICAg
Kwltb2RlbCA9ICJGYWNlYm9vayBZb3NlbWl0ZXYyIEJNQyI7DQogICAgKwljb21wYXRpYmxlID0g
ImZhY2Vib29rLHlvc2VtaXRldjItYm1jIiwgImFzcGVlZCxhc3QyNTAwIjsNCiAgICArCWFsaWFz
ZXMgew0KICAgICsJCXNlcmlhbDQgPSAmdWFydDU7DQogICAgKwl9Ow0KICAgICsJY2hvc2VuIHsN
CiAgICArCQlzdGRvdXQtcGF0aCA9ICZ1YXJ0NTsNCiAgICArCX07DQogICAgKw0KICAgICsJbWVt
b3J5QDgwMDAwMDAwIHsNCiAgICArCQlyZWcgPSA8MHg4MDAwMDAwMCAweDIwMDAwMDAwPjsNCiAg
ICArCX07DQogICAgKw0KICAgICsJaWlvLWh3bW9uIHsNCiAgICArCQkvLyBWT0xBVEFHRSBTRU5T
T1INCiAgICArCQljb21wYXRpYmxlID0gImlpby1od21vbiI7DQogICAgKwkJaW8tY2hhbm5lbHMg
PSA8JmFkYyAwPiAsIDwmYWRjIDE+ICwgPCZhZGMgMj4gLCAgPCZhZGMgMz4gLA0KICAgICsJCTwm
YWRjIDQ+ICwgPCZhZGMgNT4gLCA8JmFkYyA2PiAsICA8JmFkYyA3PiAsDQogICAgKwkJPCZhZGMg
OD4gLCA8JmFkYyA5PiAsIDwmYWRjIDEwPiwgPCZhZGMgMTE+ICwNCiAgICArCQk8JmFkYyAxMj4g
LCA8JmFkYyAxMz4gLCA8JmFkYyAxND4gLCA8JmFkYyAxNT4gOw0KICAgICsJfTsNCiAgICArfTsN
CiAgICArDQogICAgKyZmbWMgew0KICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJZmxhc2hA
MCB7DQogICAgKwkJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJCW0yNXAsZmFzdC1yZWFkOw0KICAg
ICsjaW5jbHVkZSAib3BlbmJtYy1mbGFzaC1sYXlvdXQuZHRzaSINCiAgICArCX07DQogICAgK307
DQogICAgKw0KICAgICsmc3BpMSB7DQogICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgKwlwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOw0KICAgICsJcGluY3RybC0wID0gPCZwaW5jdHJsX3NwaTFf
ZGVmYXVsdD47DQogICAgKwlmbGFzaEAwIHsNCiAgICArCQlzdGF0dXMgPSAib2theSI7DQogICAg
KwkJbTI1cCxmYXN0LXJlYWQ7DQogICAgKwkJbGFiZWwgPSAicG5vciI7DQogICAgKwl9Ow0KICAg
ICt9Ow0KICAgICsNCiAgICArJnVhcnQ1IHsNCiAgICArCS8vIEJNQyBDb25zb2xlDQogICAgKwlz
dGF0dXMgPSAib2theSI7DQogICAgK307DQogICAgKw0KICAgICsmbWFjMCB7DQogICAgKwlzdGF0
dXMgPSAib2theSI7DQogICAgKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KICAgICsJcGlu
Y3RybC0wID0gPCZwaW5jdHJsX3JtaWkxX2RlZmF1bHQ+Ow0KICAgICsJdXNlLW5jc2k7DQogICAg
K307DQogICAgKw0KICAgICsmYWRjIHsNCiAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICArCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfYWRj
MF9kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzFfZGVmYXVsdA0KICAgICsJCQkmcGluY3Ry
bF9hZGMyX2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjM19kZWZhdWx0DQogICAgKwkJCSZw
aW5jdHJsX2FkYzRfZGVmYXVsdA0KICAgICsJCQkmcGluY3RybF9hZGM1X2RlZmF1bHQNCiAgICAr
CQkJJnBpbmN0cmxfYWRjNl9kZWZhdWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzdfZGVmYXVsdA0K
ICAgICsJCQkmcGluY3RybF9hZGM4X2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjOV9kZWZh
dWx0DQogICAgKwkJCSZwaW5jdHJsX2FkYzEwX2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRj
MTFfZGVmYXVsdA0KICAgICsJCQkmcGluY3RybF9hZGMxMl9kZWZhdWx0DQogICAgKwkJCSZwaW5j
dHJsX2FkYzEzX2RlZmF1bHQNCiAgICArCQkJJnBpbmN0cmxfYWRjMTRfZGVmYXVsdA0KICAgICsJ
CQkmcGluY3RybF9hZGMxNV9kZWZhdWx0PjsNCiAgICArfTsNCiAgICArDQogICAgKyZpMmM4IHsN
CiAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICArCS8vRlJVIEVFUFJPTQ0KICAgICsJZWVwcm9t
QDUxIHsNCiAgICArCQljb21wYXRpYmxlID0gImF0bWVsLDI0YzY0IjsNCiAgICArCQlyZWcgPSA8
MHg1MT47DQogICAgKwkJcGFnZXNpemUgPSA8MzI+Ow0KICAgICsJfTsNCiAgICArfTsNCiAgICAr
DQogICAgKyZpMmM5IHsNCiAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICArCXRtcDQyMUA0ZSB7
DQogICAgKwkvL0lOTEVUIFRFTVANCiAgICArCQljb21wYXRpYmxlID0gInRpLHRtcDQyMSI7DQog
ICAgKwkJcmVnID0gPDB4NGU+Ow0KICAgICsJfTsNCiAgICArCS8vT1VUTEVUIFRFTVANCiAgICAr
CXRtcDQyMUA0ZiB7DQogICAgKwkJY29tcGF0aWJsZSA9ICJ0aSx0bXA0MjEiOw0KICAgICsJCXJl
ZyA9IDwweDRmPjsNCiAgICArCX07DQogICAgK307DQogICAgKw0KICAgICsmaTJjMTAgew0KICAg
ICsJc3RhdHVzID0gIm9rYXkiOw0KICAgICsJLy9IU0MNCiAgICArCWFkbTEyNzhANDAgew0KICAg
ICsJCWNvbXBhdGlibGUgPSAiYWRpLGFkbTEyNzgiOw0KICAgICsJCXJlZyA9IDwweDQwPjsNCiAg
ICArCX07DQogICAgK307DQogICAgKw0KICAgICsmaTJjMTEgew0KICAgICsJc3RhdHVzID0gIm9r
YXkiOw0KICAgICsJLy9NRVpaX1RFTVBfU0VOU09SDQogICAgKwl0bXA0MjFAMWYgew0KICAgICsJ
CWNvbXBhdGlibGUgPSAidGksdG1wNDIxIjsNCiAgICArCQlyZWcgPSA8MHgxZj47DQogICAgKwl9
Ow0KICAgICt9Ow0KICAgICsNCiAgICArJmkyYzEyIHsNCiAgICArCXN0YXR1cyA9ICJva2F5IjsN
CiAgICArCS8vTUVaWl9GUlUNCiAgICArCWVlcHJvbUA1MSB7DQogICAgKwkJY29tcGF0aWJsZSA9
ICJhdG1lbCwyNGM2NCI7DQogICAgKwkJcmVnID0gPDB4NTE+Ow0KICAgICsJCXBhZ2VzaXplID0g
PDMyPjsNCiAgICArCX07DQogICAgK307DQogICAgKw0KICAgICsmcHdtX3RhY2hvIHsNCiAgICAr
CXN0YXR1cyA9ICJva2F5IjsNCiAgICArCS8vRlNDDQogICAgKwlwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KICAgICsJcGluY3RybC0wID0gPCZwaW5jdHJsX3B3bTBfZGVmYXVsdCAmcGluY3Ry
bF9wd20xX2RlZmF1bHQ+Ow0KICAgICsJZmFuQDAgew0KICAgICsJCXJlZyA9IDwweDAwPjsNCiAg
ICArCQlhc3BlZWQsZmFuLXRhY2gtY2ggPSAvYml0cy8gOCA8MHgwMD47DQogICAgKwl9Ow0KICAg
ICsJZmFuQDEgew0KICAgICsJCXJlZyA9IDwweDAxPjsNCiAgICArCQlhc3BlZWQsZmFuLXRhY2gt
Y2ggPSAvYml0cy8gOCA8MHgwMj47DQogICAgKwl9Ow0KICAgICt9Ow0KICAgIC0tIA0KICAgIDIu
Ny40DQogICAgDQogICAgDQoNCg==
