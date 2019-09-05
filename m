Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B70C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C96E22CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bSwmgFFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfIEL6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:58:37 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:16451
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388280AbfIEL6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:58:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUGYsfjM9kyBVUywVeaX6y4zxqZfpujPG3nKRiUE3hziRXuqi7JQkurHbuZGMS/64w1u3TtmBDyIho/qLBpJzPi0Fwnl8/3aGDf5oM1Btk0fPkRMqXXM6QlCI9U2bixoHkmqa7feQKsh4HDVmy7a3O2Yre7DkHXQB7YjeLffB2kq0zW9Z17g+quXlQI1wH76w48Dx4ZLUwgym60ylbsz9PsxmCAprJUt4rXNIgtu97I6WYFGuPm7DF+fz4P7d//33eczwgLTibt4Lgh2cnkrvVcRQ8NP9iMlR8cCKl4EVLgtj/tz4UjXEWLgivIG7wzNJ0+Ed5+XDyHetl+CvKvq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG78jPdIsRqfdbqJDjpYA/m/cl7SG+Cj3A67sRT4aAM=;
 b=U5Ak56KckYPPDT5UPluaPBi+h/O6iStiQl48NHVGwS+7C2rKKRS8JYugMk+rt0XRSrWpaSwcye1mhOaWkkHBxOZQepLxHLWw0Qc43DjwwHRL/DZihRVG5sxFzTUuSkwpm0zujsX/LHX6RceWUa3Hk2AGQmVcD1OSJvmeR5vUsP7wgJmwavB/XlVYi8p+pf3i4AMLDxxwvIsWV0KkxSokU+aoDjMxKkl4LuR0KAcWh6YANz89a56ohrAGj1FPqkW9TO5aDKRkg1K9eFuG2HPabGWbsGOuKW9HC1FRDDeMtMKuLgqb3aSmobzNUzmWobcc5nA4S/NUApu3LFJ4dvpi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG78jPdIsRqfdbqJDjpYA/m/cl7SG+Cj3A67sRT4aAM=;
 b=bSwmgFFhg+R4vwyCOopvtWycmp5M5N7jvisxl6OUNXGVgqvNXMsrByniTL8F5vlkpka/mdrdTZpnEAJGmLjNRpVidC9oFUZ3VZ5saJEqzOI04W6+Qme7BY2I2KNstDq8LAfNKBxcROlZqAdh9Zy7CRAaj663abKP7pyGIuLVHUE=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3805.eurprd04.prod.outlook.com (52.134.16.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 5 Sep 2019 11:58:31 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 11:58:31 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/6] Add initial support for S32V234-EVB
Thread-Topic: [PATCH v4 0/6] Add initial support for S32V234-EVB
Thread-Index: AQHVY+E86t+wlWIUTUCUMKIcfhpZ8w==
Date:   Thu, 5 Sep 2019 11:58:30 +0000
Message-ID: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a16a4018-6fd5-4acd-b6d0-08d731f85ea0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3805;
x-ms-traffictypediagnostic: VI1PR0402MB3805:|VI1PR0402MB3805:
x-ms-exchange-purlcount: 7
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3805823CD424F90EACD7126CDFBB0@VI1PR0402MB3805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(476003)(81156014)(81166006)(2616005)(486006)(71190400001)(6436002)(1076003)(66574012)(54906003)(71200400001)(110136005)(53936002)(8676002)(7416002)(102836004)(478600001)(36756003)(966005)(14454004)(6512007)(25786009)(2501003)(2201001)(86362001)(256004)(66556008)(64756008)(66446008)(186003)(66946007)(26005)(4326008)(3846002)(7736002)(316002)(6506007)(52116002)(99286004)(8936002)(2906002)(305945005)(6486002)(14444005)(5660300002)(50226002)(66066001)(6306002)(6116002)(66476007)(6636002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3805;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iYR3QDEvB3VnGN0ntDNFNefGbtcr1Q0w8hjzDtHcdz8x5dp3i4wX1RbTBSYPoKEQZj9Cu8zDO60gbjdStR7wYXjAV4EMBB6Ehlv2aNTT+8zvLwXZkvniENzkbKcAAg1iLsY3xE79JpczToGW70K3VXyd+qxxuJOZlKAJovGtYtn8/xTJEdLnBmzHnGx+XvcFguVlukVUQfFL32tVUAivLtfXJBI7Dah1Zrb84Zpmdu0+guveFLsn5QFINcDLQGowG3Fimajr7+zRQ3si9nLhUJ4wFVXBeXN4sLnyrIGHyfyLESz2y8sOneYJPfeFxmM8IFtYpec+hqljUU/zaO6EnX8c4AoMIdCCBselxSIN2i7q44kWwtwkgM1N2jq29e3NYmoheR4eyWTYSt3Yv7oAcDe4/rS73A/JY6OfydRmBq8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26D469F00630354A92CD3F643147C50D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16a4018-6fd5-4acd-b6d0-08d731f85ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 11:58:30.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HARod8uDfm8DEsuuN1j503QgkWXyDdsPaZDvTXxQ4znKCzDqDTYXnz/a9vTK1wk3VeK1H3GIHojqPLt+SNdkzGevbNzFMCn55D8mrqSpaZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk5YUCdzIFMzMlYyMzRbMV0gKCJUcmVlcnVubmVyIikgdmlzaW9uIG1pY3JvcHJv
Y2Vzc29ycyBhcmUgdGFyZ2V0ZWQgZm9yDQpoaWdoLXBlcmZvcm1hbmNlLCBjb21wdXRhdGlvbmFs
bHkgaW50ZW5zaXZlIHZpc2lvbiBhbmQgc2Vuc29yIGZ1c2lvbg0KYXBwbGljYXRpb25zIHRoYXQg
cmVxdWlyZSBhdXRvbW90aXZlIHNhZmV0eSBsZXZlbHMuIFRoZXkgaW5jbHVkZSBsZWFkaW5nDQpl
ZGdlIENhbWVyYSBWaXNpb24gbW9kdWxlcyBsaWtlIEFQRVgtMiwgSVNQIGFuZCBHUFUuIFRoZSBT
MzJWMjM0LUVWQiBhbmQNClMzMlYyMzQtU0JDIGJvYXJkcyBhcmUgYXZhaWxhYmxlIGZvciBjdXN0
b21lciBldmFsdWF0aW9uLg0KDQpUaGUgZm9sbG93aW5nIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2Vz
IG1pbmltYWwgZW5hYmxlbWVudCBzdXBwb3J0IGZvciB0aGUNCk5YUCBTMzJWMjM0LUVWQjJbMl0g
Ym9hcmQsIHdoaWNoIGxldmVyYWdlcyBtb3N0IG9mIHRoZSBTb0MgY2FwYWJpbGl0aWVzLg0KVXAg
dG8gdjIsIHRoaXMgc2VyaWVzIGFsc28gaW5jbHVkZWQgdGhlIGZzbF9saW5mbGV4dWFydCBkcml2
ZXIsIHdoaWNoIGhhcw0KYmVlbiBpbmNsdWRlZCBpbiBHcmVnIEtyb2FoLUhhcnRtYW4ncyB0dHkg
Z2l0IHRyZWVbM10uDQoNCkluIHRoZSBmdXR1cmUsIHdlIGFpbSB0byBzdWJtaXQgbXVsdGlwbGUg
ZHJpdmVycyB1cHN0cmVhbSwgd2hpY2ggY2FuIGJlDQpmb3VuZCBpbiB0aGUga2VybmVsIG9mIG91
ciBBdXRvIExpbnV4IEJTUFs0XSAoIkFMQiIpLCBzdGFydGluZyB3aXRoIGJhc2ljDQpwaW5tdXhp
bmcsIGNsb2NrIGFuZCB1U0RIQyBkcml2ZXJzLg0KDQpGb3IgdmFsaWRhdGlvbiwgeW91IGNhbiB1
c2UgdGhlIFUtQm9vdCBib290bG9hZGVyIGluIHRoZSBBTEJbNV0sIHdoaWNoIHdlDQpidWlsZCBh
bmQgdGVzdCB3aXRoIG91ciBwYXRjaGVkIHZlcnNpb24gb2YgdGhlIExpbmFybyBHQ0MgNi4zLjEg
MjAxNy4wNQ0KdG9vbGNoYWluIGZvciBBUk0gNjQtYml0LCB3aXRoIHNvdXJjZXMgYXZhaWxhYmxl
IG9uIFs2XS4NCg0KQ2hhbmdlcyBpbiB2NDoNCiogUmVtb3ZlIHRoZSBwYXRjaCAnc2VyaWFsOiBm
c2xfbGluZmxleHVhcnQ6IFVwZGF0ZSBjb21wYXRpYmxlIHN0cmluZycNCiAgZm9sbG93aW5nIGl0
cyBhY2NlcHRhbmNlWzddOw0KKiBSZWJhc2VkIHRoZSBwYXRjaCAnc2VyaWFsOiBmc2xfbGluZmxl
eHVhcnQ6IEJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgbmFtZScNCiAgb24gdGhlIHR0eS1uZXh0IGJy
YW5jaCBpbiBHcmVnJ3MgdHR5IGdpdCB0cmVlLg0KDQpDaGFuZ2VzIGluIHYzOg0KKiBSZW1vdmUg
dGhlIHBhdGNoICd0dHk6IHNlcmlhbDogQWRkIGxpbmZsZXh1YXJ0IGRyaXZlciBmb3IgUzMyVjIz
NCcNCiAgZm9sbG93aW5nIGl0cyBhY2NlcHRhbmNlWzNdOw0KKiBSZXBsYWNlICdGcmVlc2NhbGUn
IHdpdGggJ05YUCcgaW4gdGhlIEFSQ0hfUzMyIGNvbmZpZyBkZWZpbml0aW9uIGFuZCB0aGUNCiAg
J21vZGVsJyBwcm9wZXJ0eSBmcm9tIHRoZSBkZXZpY2UgdHJlZTsNCiogUmVtb3ZlIHRoZSAnZnNs
LScgcHJlZml4ZXMgZnJvbSB0aGUgZHRzaSBhbmQgZHRzIGZpbGUgbmFtZXM7DQoqIE1vdmUgdGhl
ICdtb2RlbCcgcHJvcGVydHkgZnJvbSAoZnNsLSlzMzJ2MjM0LmR0c2kgdG8gczMydjIzNC1ldmIu
ZHRzOw0KKiBBZGQgbmV3bGluZXMgYmV0d2VlbiB0aGUgY3B1IG5vZGVzIGluIHMzMnYyMzQuZHRz
aTsNCiogTWFrZSB1c2Ugb2YgR0lDX1NQSSwgR0lDX1BQSSwgR0lDX0NQVV9NQVNLX1NJTVBMRSBh
bmQgSVJRX1RZUEVfKiBpbiB0aGUNCiAgJ2ludGVycnVwdHMnIHR1cGxlczsNCiogTW92ZSB0aGUg
J3RpbWVyJyBhbmQgJ2ludGVycnVwdC1jb250cm9sbGVyJyBub2RlcyBiZWZvcmUgJ3NvYycgaW4N
CiAgczMydjIzNC5kdHNpOw0KKiBCZSBjb25zaXN0ZW50IHdpdGggdGhlICdMSU5GbGV4RCcgc3Bl
bGxpbmcgaW4gZG9jdW1lbnRhdGlvbiwgc3RyaW5ncyBhbmQNCiAgY29tbWVudHM7IGFkZCBuZXcg
cGF0Y2ggJ3NlcmlhbDogZnNsX2xpbmZsZXh1YXJ0OiBCZSBjb25zaXN0ZW50IHdpdGggdGhlDQog
IG5hbWUnIHRvIHVwZGF0ZSB0aGUgTElORmxleEQgZHJpdmVyIGFzIHdlbGw7DQoqIFJlbW92ZSBm
cm9tIGZzbCxzMzItbGluZmxleHVhcnQudHh0IGEgc3RhdGVtZW50IHJlZ2FyZGluZyB0aGUgbGlt
aXRhdGlvbg0KICB0byBVQVJUIG1vZGU7DQoqIE1ha2UgdGhlIGNvbXBhdGlibGUgc3RyaW5nIFNv
QyBzcGVjaWZpYyAoImZzbCxzMzJ2MjM0LWxpbmZsZXh1YXJ0Iik7IGFkZA0KICBuZXcgcGF0Y2gg
J3NlcmlhbDogZnNsX2xpbmZsZXh1YXJ0OiBVcGRhdGUgY29tcGF0aWJsZSBzdHJpbmcnIHRvIHVw
ZGF0ZQ0KICB0aGUgTElORmxleEQgZHJpdmVyIGFzIHdlbGw7DQoqIEluIHRoZSBMSU5GbGV4RCBi
aW5kaW5nIGRvY3VtZW50YXRpb24sIGluc2VydCBhIHNwYWNlIGJldHdlZW4gbGFiZWwgYW5kDQog
IG5vZGUgbmFtZSBhbmQgcmVtb3ZlIHRoZSAnc3RhdHVzJyBwcm9wZXJ0eS4NCg0KQ2hhbmdlcyBp
biB2MjoNCiogVXBkYXRlIHRoZSBlbnRyeSBpbiBmc2wueWFtbCB0byBhcHBseSB0byBhbGwgUzMy
VjIzNCBiYXNlZCBib2FyZHM7DQoqIEFkZCBjaG9zZW4gbm9kZSB0byBkdHMsIHdpdGggYSAnc3Rk
b3V0LXBhdGgnIHByb3BlcnR5IGZvciBlYXJseWNvbjsNCiogUmVtb3ZlIGxpbmZsZXhfdmVyaWZ5
X3BvcnQoKSwgYmVjYXVzZSBpdCB3YXMgb25seSBjYWxsZWQgZnJvbQ0KICB1YXJ0X3NldF9pbmZv
KCksIHdoaWNoIHdhcyBnb2luZyB0byBhbHdheXMgZmFpbCBhdCB0aGUgImJhdWRfYmFzZSA8IDk2
MDAiDQogIGNoZWNrLCBhcyB3ZSBhcmUgbm90IHVzaW5nIHVhcnRjbGsgZnJvbSB1YXJ0X3BvcnQg
eWV0Ow0KKiBGaXggY29tcGF0aWJsZSBzdHJpbmcgdXNlZCBpbiBPRl9FQVJMWUNPTl9ERUNMQVJF
Lg0KDQpbMV0gaHR0cHM6Ly93d3cubnhwLmNvbS9wcm9kdWN0cy9wcm9jZXNzb3JzLWFuZC1taWNy
b2NvbnRyb2xsZXJzL2FybS1iYXNlZC1wcm9jZXNzb3JzLWFuZC1tY3VzL3MzMi1hdXRvbW90aXZl
LXBsYXRmb3JtL3Zpc2lvbi1wcm9jZXNzb3ItZm9yLWZyb250LWFuZC1zdXJyb3VuZC12aWV3LWNh
bWVyYS1tYWNoaW5lLWxlYXJuaW5nLWFuZC1zZW5zb3ItZnVzaW9uOlMzMlYyMzQNClsyXSBodHRw
czovL3d3dy5ueHAuY29tL3N1cHBvcnQvZGV2ZWxvcGVyLXJlc291cmNlcy9ldmFsdWF0aW9uLWFu
ZC1kZXZlbG9wbWVudC1ib2FyZHMvdWx0cmEtcmVsaWFibGUtZGV2LXBsYXRmb3Jtcy9zMzJ2LW1w
dXMtcGxhdGZvcm1zL3MzMnYtdmlzaW9uLWFuZC1zZW5zb3ItZnVzaW9uLWV2YWx1YXRpb24tc3lz
dGVtOlMzMlYyMzRFVkINClszXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9ncmVna2gvdHR5LmdpdC9jb21taXQvP2g9dHR5LW5leHQmaWQ9Yjk1MzgxNWI4
MTliMGYzMjdiNTUzOGZlYmEzNjM5ZDUyZGI3MDE3Mg0KWzRdIGh0dHBzOi8vc291cmNlLmNvZGVh
dXJvcmEub3JnL2V4dGVybmFsL2F1dG9ic3BzMzIvbGludXgvDQpbNV0gaHR0cHM6Ly9zb3VyY2Uu
Y29kZWF1cm9yYS5vcmcvZXh0ZXJuYWwvYXV0b2JzcHMzMi91LWJvb3QvDQpbNl0gaHR0cHM6Ly9z
b3VyY2UuY29kZWF1cm9yYS5vcmcvZXh0ZXJuYWwvczMyZHMvY29tcGlsZXIvZ2NjLw0KWzddIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdraC90dHku
Z2l0L2NvbW1pdC8/aD10dHktbmV4dCZpZD0yYmQzNjYxZWEwZWIyMDU2ODUyY2JjNThjNWQ5NmJi
NGRmMmYxNjRmDQoNCkVkZHkgUGV0cmnImW9yICgxKToNCiAgZHQtYmluZGluZ3M6IGFybTogZnNs
OiBBZGQgdGhlIFMzMlYyMzQtRVZCIGJvYXJkDQoNCk1paGFlbGEgTWFydGluYXMgKDIpOg0KICBh
cm02NDogSW50cm9kdWNlIGNvbmZpZyBmb3IgUzMyDQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJs
ZSBjb25maWdzIGZvciBTMzJWMjM0DQoNClN0ZWZhbi1HYWJyaWVsIE1pcmVhICgxKToNCiAgc2Vy
aWFsOiBmc2xfbGluZmxleHVhcnQ6IEJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgbmFtZQ0KDQpTdG9p
Y2EgQ29zbWluLVN0ZWZhbiAoMik6DQogIGFybTY0OiBkdHM6IGZzbDogQWRkIGRldmljZSB0cmVl
IGZvciBTMzJWMjM0LUVWQg0KICBkdC1iaW5kaW5nczogc2VyaWFsOiBEb2N1bWVudCBGcmVlc2Nh
bGUgTElORmxleEQgVUFSVA0KDQogLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4
dCAgICAgICAgIHwgICAyICstDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1s
ICAgICAgICAgIHwgICA2ICsNCiAuLi4vYmluZGluZ3Mvc2VyaWFsL2ZzbCxzMzItbGluZmxleHVh
cnQudHh0ICAgfCAgMjIgKysrDQogYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3JtcyAgICAgICAg
ICAgICAgICAgIHwgICA1ICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmls
ZSAgICAgICAgfCAgIDIgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL3MzMnYyMzQt
ZXZiLmR0cyB8ICAyNSArKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvczMydjIz
NC5kdHNpICAgIHwgMTM5ICsrKysrKysrKysrKysrKysrKw0KIGFyY2gvYXJtNjQvY29uZmlncy9k
ZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAgMyArDQogZHJpdmVycy90dHkvc2VyaWFsL0tj
b25maWcgICAgICAgICAgICAgICAgICAgIHwgICA4ICstDQogZHJpdmVycy90dHkvc2VyaWFsL2Zz
bF9saW5mbGV4dWFydC5jICAgICAgICAgIHwgICA0ICstDQogaW5jbHVkZS91YXBpL2xpbnV4L3Nl
cmlhbF9jb3JlLmggICAgICAgICAgICAgIHwgICA0ICstDQogMTEgZmlsZXMgY2hhbmdlZCwgMjEx
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvZnNsLHMzMi1saW5mbGV4dWFydC50
eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvczMy
djIzNC1ldmIuZHRzDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL3MzMnYyMzQuZHRzaQ0KDQotLSANCjIuMjIuMA0KDQo=
