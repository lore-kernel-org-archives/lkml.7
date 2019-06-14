Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26853C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D0621841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eXOUrpG1";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="kTU5n83c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfFNRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:43:09 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51058 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbfFNRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:43:03 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EHeWZQ023707;
        Fri, 14 Jun 2019 10:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=vpkHhvh8wBhAOPzxRgsYfzrwgXDeaEiF9/+fPDKhCvU=;
 b=eXOUrpG1TiuEiNpGTmvLpto+mSGauL7jwawnsVmeO1pGbmByULxK+hP/4HBkpcnUQAaI
 Vx+W29lmmxR5mPkXD0xLpa23hAoTDgeJqyt4GnuVvpnJS4F3gey+5ZKCTGbqFTW/I88V
 lXdsCihPLjcqBSTJ4sSj+VvrqOe7fNLAsjqXJ3KQcYyt+slnE6J3p9qZnkD8cyxZ0maG
 4khwHiUn29obXw14LWC8/xsHxk7eDBJ7QCkdF8Sm+8Vn+d2puDdATpfRu/4tXQ+6ovqq
 ZjyqH9pISBGDnJELGyyXTO7Ehtw2ZmS6+MLu2ROPj5Qnvn2VRh+z78/Z/3X95lzj4iTn eA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t3hvpy5gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 10:42:53 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 10:42:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 10:42:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpkHhvh8wBhAOPzxRgsYfzrwgXDeaEiF9/+fPDKhCvU=;
 b=kTU5n83cDZAFxwKhQBwAx6q91yOQxyjdqMb4IuE95aqQYRPdVekpr+KDJrtVw/pbY9mv56Z+DAF4GVDXZFgLV+NjKOa5ZlQLLSnSEe49wzquJjWbMYWh9fmmcWnX2qKvC8uGgxGLYERVEiXI3WEPjT05xJl/hxfWMHQwhhGdrnI=
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com (10.164.205.31) by
 MWHPR1801MB1936.namprd18.prod.outlook.com (10.164.204.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 17:42:46 +0000
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::7c5a:e2f5:64e0:5b70]) by MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::7c5a:e2f5:64e0:5b70%7]) with mapi id 15.20.1987.013; Fri, 14 Jun 2019
 17:42:46 +0000
From:   Ganapatrao Kulkarni <gkulkarni@marvell.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "Jan.Glauber@cavium.com" <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH 1/2] Documentation: perf: Update documentation for ThunderX2
 PMU uncore driver
Thread-Topic: [PATCH 1/2] Documentation: perf: Update documentation for
 ThunderX2 PMU uncore driver
Thread-Index: AQHVItiT5TVHcomozEC71pshr7ncRA==
Date:   Fri, 14 Jun 2019 17:42:45 +0000
Message-ID: <1560534144-13896-2-git-send-email-gkulkarni@marvell.com>
References: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
In-Reply-To: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:a03:60::35) To MWHPR1801MB2030.namprd18.prod.outlook.com
 (2603:10b6:301:69::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae792e24-945f-4219-4495-08d6f0efb5bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR1801MB1936;
x-ms-traffictypediagnostic: MWHPR1801MB1936:
x-microsoft-antispam-prvs: <MWHPR1801MB1936FE23B233BD5450D3F2CDB2EE0@MWHPR1801MB1936.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39850400004)(396003)(376002)(366004)(199004)(189003)(66946007)(6116002)(71200400001)(76176011)(2501003)(102836004)(3846002)(7416002)(4720700003)(52116002)(66066001)(99286004)(6512007)(14454004)(6506007)(446003)(71190400001)(4326008)(386003)(478600001)(6436002)(2906002)(54906003)(110136005)(68736007)(5660300002)(256004)(8936002)(2616005)(305945005)(2201001)(476003)(36756003)(7736002)(53936002)(11346002)(81166006)(66556008)(66476007)(26005)(50226002)(25786009)(186003)(64756008)(66446008)(73956011)(486006)(81156014)(316002)(86362001)(8676002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1801MB1936;H:MWHPR1801MB2030.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lp8faelQsa9Q2Ve7y9CdtjqIFnaF9fG1dPZgVIG3bxcbQXSZ/U6fGEnbCmZ+UkIyq3swOCZz6Z8x41ToXWBSead7O3J/Z/5wQ8DErb/47oSYJe5U7ZT0O6VXR+sNNvZntU3dcE79G6dbI8VUMF4fp+VGDmjMQhTq+KpD80S8Y0yDe0hZUi8Xw+SrPqVrss3B6/gYLsagOmeLTYO1EB2A0HYByBqUZUQQXMGLFbMt1L4e+9zW18UykJm+S9H2hEo3F7A4r1xa1QcwENJmNOic07t0hJ+QC5BNIKrNGPUilWN/ROeY3cg480KjsrClGb0XaBlD/SBM1XMIwCMDSWmFu3dGFNSDtU4DhO8+e1pO751dJnVpgVzPac5iRvdcksYmEpqbklnZo5h1o2oqTP0GVmptWmK4OISgonnt5LpSIlA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae792e24-945f-4219-4495-08d6f0efb5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 17:42:45.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkulkarni@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1936
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2FuYXBhdHJhbyBLdWxrYXJuaSA8Z2FuYXBhdHJhby5rdWxrYXJuaUBtYXJ2ZWxsLmNv
bT4NCg0KQWRkIGRvY3VtZW50YXRpb24gZm9yIENhdml1bSBDb2hlcmVudCBQcm9jZXNzb3IgSW50
ZXJjb25uZWN0IChDQ1BJMikgUE1VLg0KDQpTaWduZWQtb2ZmLWJ5OiBHYW5hcGF0cmFvIEt1bGth
cm5pIDxna3Vsa2FybmlAbWFydmVsbC5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL3BlcmYvdGh1
bmRlcngyLXBtdS50eHQgfCAyMCArKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9wZXJmL3RodW5kZXJ4Mi1wbXUudHh0IGIvRG9jdW1lbnRhdGlvbi9wZXJmL3RodW5k
ZXJ4Mi1wbXUudHh0DQppbmRleCBkZmZjNTcxNDM3MzYuLjYyMjQzMjMwYWJjMyAxMDA2NDQNCi0t
LSBhL0RvY3VtZW50YXRpb24vcGVyZi90aHVuZGVyeDItcG11LnR4dA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9wZXJmL3RodW5kZXJ4Mi1wbXUudHh0DQpAQCAtMiwyNCArMiwyNiBAQCBDYXZpdW0gVGh1
bmRlclgyIFNvQyBQZXJmb3JtYW5jZSBNb25pdG9yaW5nIFVuaXQgKFBNVSBVTkNPUkUpDQogPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KIA0KIFRoZSBUaHVuZGVyWDIgU29DIFBNVSBjb25zaXN0cyBvZiBpbmRlcGVuZGVudCwgc3lz
dGVtLXdpZGUsIHBlci1zb2NrZXQNCi1QTVVzIHN1Y2ggYXMgdGhlIExldmVsIDMgQ2FjaGUgKEwz
QykgYW5kIEREUjQgTWVtb3J5IENvbnRyb2xsZXIgKERNQykuDQorUE1VcyBzdWNoIGFzIHRoZSBM
ZXZlbCAzIENhY2hlIChMM0MpLCBERFI0IE1lbW9yeSBDb250cm9sbGVyIChETUMpIGFuZA0KK0Nh
dml1bSBDb2hlcmVudCBQcm9jZXNzb3IgSW50ZXJjb25uZWN0IChDQ1BJMikuDQogDQogVGhlIERN
QyBoYXMgOCBpbnRlcmxlYXZlZCBjaGFubmVscyBhbmQgdGhlIEwzQyBoYXMgMTYgaW50ZXJsZWF2
ZWQgdGlsZXMuDQogRXZlbnRzIGFyZSBjb3VudGVkIGZvciB0aGUgZGVmYXVsdCBjaGFubmVsIChp
LmUuIGNoYW5uZWwgMCkgYW5kIHByb3JhdGVkDQogdG8gdGhlIHRvdGFsIG51bWJlciBvZiBjaGFu
bmVscy90aWxlcy4NCiANCi1UaGUgRE1DIGFuZCBMM0Mgc3VwcG9ydCB1cCB0byA0IGNvdW50ZXJz
LiBDb3VudGVycyBhcmUgaW5kZXBlbmRlbnRseQ0KLXByb2dyYW1tYWJsZSBhbmQgY2FuIGJlIHN0
YXJ0ZWQgYW5kIHN0b3BwZWQgaW5kaXZpZHVhbGx5LiBFYWNoIGNvdW50ZXINCi1jYW4gYmUgc2V0
IHRvIGEgZGlmZmVyZW50IGV2ZW50LiBDb3VudGVycyBhcmUgMzItYml0IGFuZCBkbyBub3Qgc3Vw
cG9ydA0KLWFuIG92ZXJmbG93IGludGVycnVwdDsgdGhleSBhcmUgcmVhZCBldmVyeSAyIHNlY29u
ZHMuDQorVGhlIERNQywgTDNDIHN1cHBvcnQgdXAgdG8gNCBjb3VudGVycyBhbmQgQ0NQSTIgc3Vw
cG9ydCB1cCB0byA4IGNvdW50ZXJzLg0KK0NvdW50ZXJzIGFyZSBpbmRlcGVuZGVudGx5IHByb2dy
YW1tYWJsZSBhbmQgY2FuIGJlIHN0YXJ0ZWQgYW5kIHN0b3BwZWQNCitpbmRpdmlkdWFsbHkuIEVh
Y2ggY291bnRlciBjYW4gYmUgc2V0IHRvIGEgZGlmZmVyZW50IGV2ZW50LiBETUMgYW5kIEwzQw0K
K0NvdW50ZXJzIGFyZSAzMi1iaXQgYW5kIGRvIG5vdCBzdXBwb3J0IGFuIG92ZXJmbG93IGludGVy
cnVwdDsgdGhleSBhcmUgcmVhZA0KK2V2ZXJ5IDIgc2Vjb25kcy4gQ0NQSTIgY291bnRlcnMgYXJl
IDY0LWJpdC4NCiANCiBQTVUgVU5DT1JFIChwZXJmKSBkcml2ZXI6DQogDQogVGhlIHRodW5kZXJ4
Ml9wbXUgZHJpdmVyIHJlZ2lzdGVycyBwZXItc29ja2V0IHBlcmYgUE1VcyBmb3IgdGhlIERNQyBh
bmQNCi1MM0MgZGV2aWNlcy4gIEVhY2ggUE1VIGNhbiBiZSB1c2VkIHRvIGNvdW50IHVwIHRvIDQg
ZXZlbnRzDQotc2ltdWx0YW5lb3VzbHkuIFRoZSBQTVVzIHByb3ZpZGUgYSBkZXNjcmlwdGlvbiBv
ZiB0aGVpciBhdmFpbGFibGUgZXZlbnRzDQotYW5kIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyB1bmRl
ciBzeXNmcywgc2VlDQotL3N5cy9kZXZpY2VzL3VuY29yZV88bDNjX1MvZG1jX1MvPjsgUyBpcyB0
aGUgc29ja2V0IGlkLg0KK0wzQyBkZXZpY2VzLiAgRWFjaCBQTVUgY2FuIGJlIHVzZWQgdG8gY291
bnQgdXAgdG8gNChETUMvTDNDKSBvciB1cCB0byA4DQorKENDUEkyKSBldmVudHMgc2ltdWx0YW5l
b3VzbHkuIFRoZSBQTVVzIHByb3ZpZGUgYSBkZXNjcmlwdGlvbiBvZiB0aGVpcg0KK2F2YWlsYWJs
ZSBldmVudHMgYW5kIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyB1bmRlciBzeXNmcywgc2VlDQorL3N5
cy9kZXZpY2VzL3VuY29yZV88bDNjX1MvZG1jX1MvY2NwaTJfUy8+OyBTIGlzIHRoZSBzb2NrZXQg
aWQuDQogDQogVGhlIGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0IHNhbXBsaW5nLCB0aGVyZWZvcmUg
InBlcmYgcmVjb3JkIiB3aWxsIG5vdA0KIHdvcmsuIFBlci10YXNrIHBlcmYgc2Vzc2lvbnMgYXJl
IGFsc28gbm90IHN1cHBvcnRlZC4NCi0tIA0KMi4xNy4xDQoNCg==
