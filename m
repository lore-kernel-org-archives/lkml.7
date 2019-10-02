Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E8C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F2D21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AW2oQg75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJBNEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:04:44 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:20989
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfJBNEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:04:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK0oBnddHlKCrLVxMeHKt7iHeRH/gYYv0Pv7UNgRaduN0P7zHE7wSjDWnbies8OSVItUamRu/wtBGhC9VgQtgRM6v0hc2xOFVgkcUzpvp3zqN3w75ThZVEryPEq95l4QKhY6Y8C6JA1Q32xhCdM+xFw7Ok6SWzjwC+07duO+OKVHGojHJTw3JmmQKDE3f7N0AuEl2kDZf5FA5JiA4WhfeN2LDHpRT+TSUsR/CX7ahvSi9n+GA9xpgTOXRsNDU9XoX58z4Rc3xDw4GwLU/sd7EaHcjvRdEOBgdHLzdzuEdrOtv7BjxBEg4EDcfv1Gx86J10/uOiwxOE2X/9pTL0+qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkgXfm8mQ24S7y13V3pySjZbirx2XF7jJfYKjIRsH7s=;
 b=XfnTsUOYDn8rrLDQhYOv2kdYPS3LL/kk4MEOvgLIrMNehHQmPuqg7i+dK1ZZTfpyM0u50DMpMqKhessFPov6eVIJFV9WXsMtt8VpcAVQZyXfsDbZS77d4RaaRh6+M4z1t/+7LKkeXAud3aXAbsRL69EhOXnhzAXIJUApiKM7JhJaY6itR0IHqWlITVhlGtrxaKeOPPjGGjKI+m/DODuicKCSWzKsozj8i+wD/OCfg6WpQTqosq/FNYdXa6aPEH2k/oosl8CPCdlEY9EQ2ypTAYk6ZuIc4+5zcUMbdfHCxUajLm4z7SKL/mT3SGl6p+ECkCawJClddBhMqhgzF+Ljtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkgXfm8mQ24S7y13V3pySjZbirx2XF7jJfYKjIRsH7s=;
 b=AW2oQg75wjaHGNdZTPQIse0TYchYxI6V+IIUFEW/RkTIFvDBuZ4QlTbWleSLavrap4G/IJYt1+4z2WxnjKp6yG23h9EIy8kZzY8kSkgkCLF8hqgHa/TJ0blKq5mSJxcTuWdIzq+9aj+l0D1Gd/ecY3wKOnxp30t/cg4gVkRNw9g=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (52.134.17.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 2 Oct 2019 13:04:38 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36%7]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:04:38 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/5] Add initial support for S32V234-EVB
Thread-Topic: [PATCH v5 0/5] Add initial support for S32V234-EVB
Thread-Index: AQHVeSHyR4no+PwBAUSt2LzGXGVLyQ==
Date:   Wed, 2 Oct 2019 13:04:38 +0000
Message-ID: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: PR0P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::14) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e60774f8-d51a-4773-4e15-08d7473914a1
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3918:
x-ms-exchange-purlcount: 8
x-microsoft-antispam-prvs: <VI1PR0402MB39180C5C637BE789EA006D7EDF9C0@VI1PR0402MB3918.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(102836004)(2201001)(5660300002)(26005)(478600001)(486006)(386003)(14454004)(50226002)(8676002)(8936002)(81156014)(305945005)(81166006)(6506007)(7736002)(7416002)(64756008)(6436002)(66556008)(66446008)(476003)(66066001)(2906002)(2616005)(66476007)(6486002)(66946007)(25786009)(52116002)(2501003)(186003)(966005)(14444005)(256004)(6306002)(6512007)(6116002)(3846002)(36756003)(71190400001)(71200400001)(4326008)(1076003)(66574012)(86362001)(54906003)(99286004)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 439W6zDtBZIOdYySROBVeMicKdssy/0hGFu3+th6+zIkqaPqYPfVJNn+qTBJt7rnU/Ur7AG9qzkt0ooVSNkCsmu1WWdU7PcbXjnuIAMu+maBLpDcU2bFpQ/FvDwEtZ+lwTBmBwXiA5LPXX9czfWWUaMcgTJzgnsVMulTRF5b1PK0V+279UdAdcQvTJJCvo9/yg28u6X5oc2c2dBYd2ka4kzHjXb4WChZk6FyrClGQ4dsvsTay0C6Zc5uoxy3Gtsj6KmKB80hliti0wL4FaTQxDUCaOmguzXxvWp314oTF730CwuKOibsH7ykg896qkF/k/R6Wl/Ar1jYDLSweyuji0FWw2yk4i4Ds6JcrYzP7QQjmf5BC/s86eNZUNUMtvGAr/cV9LYoZA4DLDRzXBFhxt2BYY8fsllVuLeVJYUuJtmZCvB/MBfsneR+h5f/Nf9nStQtTyljw1F35TJOFfn2aQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CECC0E352FF9974F8779C045346C4632@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60774f8-d51a-4773-4e15-08d7473914a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:04:38.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcSvq3dtIb6+jpAoAxTmvm0cMa6g3NU7dATt7RXUaMrZ77ObGpXRJwnhyRej2czhqqcjd7l0MYVVimZZJdhn9UF1hYKGOxwgXnjMgYEOsQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
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
ZXIsIHdoaWNoIGhhcw0KYmVlbiBpbmNsdWRlZCBpbiBMaW51eCA1LjQtcmMxWzNdLg0KDQpJbiB0
aGUgZnV0dXJlLCB3ZSBhaW0gdG8gc3VibWl0IG11bHRpcGxlIGRyaXZlcnMgdXBzdHJlYW0sIHdo
aWNoIGNhbiBiZQ0KZm91bmQgaW4gdGhlIGtlcm5lbCBvZiBvdXIgQXV0byBMaW51eCBCU1BbNF0g
KCJBTEIiKSwgc3RhcnRpbmcgd2l0aCBiYXNpYw0KcGlubXV4aW5nLCBjbG9jayBhbmQgdVNESEMg
ZHJpdmVycy4NCg0KRm9yIHZhbGlkYXRpb24sIHlvdSBjYW4gdXNlIHRoZSBVLUJvb3QgYm9vdGxv
YWRlciBpbiB0aGUgQUxCWzVdLCB3aGljaCB3ZQ0KYnVpbGQgYW5kIHRlc3Qgd2l0aCBvdXIgcGF0
Y2hlZCB2ZXJzaW9uIG9mIHRoZSBMaW5hcm8gR0NDIDYuMy4xIDIwMTcuMDUNCnRvb2xjaGFpbiBm
b3IgQVJNIDY0LWJpdCwgd2l0aCBzb3VyY2VzIGF2YWlsYWJsZSBvbiBbNl0uDQoNCkNoYW5nZXMg
aW4gdjU6DQoqIFJlbW92ZSB0aGUgcGF0Y2ggJ2R0LWJpbmRpbmdzOiBzZXJpYWw6IERvY3VtZW50
IEZyZWVzY2FsZSBMSU5GbGV4RCBVQVJUJw0KICBmb2xsb3dpbmcgaXRzIGFjY2VwdGFuY2UgaW4g
TGludXggNS40LXJjMVs4XTsNCiogUmViYXNlIHRoZSBvdGhlciBwYXRjaGVzIG9uIHY1LjQtcmMx
Lg0KDQpDaGFuZ2VzIGluIHY0Og0KKiBSZW1vdmUgdGhlIHBhdGNoICdzZXJpYWw6IGZzbF9saW5m
bGV4dWFydDogVXBkYXRlIGNvbXBhdGlibGUgc3RyaW5nJw0KICBmb2xsb3dpbmcgaXRzIGFjY2Vw
dGFuY2VbN107DQoqIFJlYmFzZSB0aGUgcGF0Y2ggJ3NlcmlhbDogZnNsX2xpbmZsZXh1YXJ0OiBC
ZSBjb25zaXN0ZW50IHdpdGggdGhlIG5hbWUnDQogIG9uIHRoZSB0dHktbmV4dCBicmFuY2ggaW4g
R3JlZydzIHR0eSBnaXQgdHJlZS4NCg0KQ2hhbmdlcyBpbiB2MzoNCiogUmVtb3ZlIHRoZSBwYXRj
aCAndHR5OiBzZXJpYWw6IEFkZCBsaW5mbGV4dWFydCBkcml2ZXIgZm9yIFMzMlYyMzQnDQogIGZv
bGxvd2luZyBpdHMgYWNjZXB0YW5jZVszXTsNCiogUmVwbGFjZSAnRnJlZXNjYWxlJyB3aXRoICdO
WFAnIGluIHRoZSBBUkNIX1MzMiBjb25maWcgZGVmaW5pdGlvbiBhbmQgdGhlDQogICdtb2RlbCcg
cHJvcGVydHkgZnJvbSB0aGUgZGV2aWNlIHRyZWU7DQoqIFJlbW92ZSB0aGUgJ2ZzbC0nIHByZWZp
eGVzIGZyb20gdGhlIGR0c2kgYW5kIGR0cyBmaWxlIG5hbWVzOw0KKiBNb3ZlIHRoZSAnbW9kZWwn
IHByb3BlcnR5IGZyb20gKGZzbC0pczMydjIzNC5kdHNpIHRvIHMzMnYyMzQtZXZiLmR0czsNCiog
QWRkIG5ld2xpbmVzIGJldHdlZW4gdGhlIGNwdSBub2RlcyBpbiBzMzJ2MjM0LmR0c2k7DQoqIE1h
a2UgdXNlIG9mIEdJQ19TUEksIEdJQ19QUEksIEdJQ19DUFVfTUFTS19TSU1QTEUgYW5kIElSUV9U
WVBFXyogaW4gdGhlDQogICdpbnRlcnJ1cHRzJyB0dXBsZXM7DQoqIE1vdmUgdGhlICd0aW1lcicg
YW5kICdpbnRlcnJ1cHQtY29udHJvbGxlcicgbm9kZXMgYmVmb3JlICdzb2MnIGluDQogIHMzMnYy
MzQuZHRzaTsNCiogQmUgY29uc2lzdGVudCB3aXRoIHRoZSAnTElORmxleEQnIHNwZWxsaW5nIGlu
IGRvY3VtZW50YXRpb24sIHN0cmluZ3MgYW5kDQogIGNvbW1lbnRzOyBhZGQgbmV3IHBhdGNoICdz
ZXJpYWw6IGZzbF9saW5mbGV4dWFydDogQmUgY29uc2lzdGVudCB3aXRoIHRoZQ0KICBuYW1lJyB0
byB1cGRhdGUgdGhlIExJTkZsZXhEIGRyaXZlciBhcyB3ZWxsOw0KKiBSZW1vdmUgZnJvbSBmc2ws
czMyLWxpbmZsZXh1YXJ0LnR4dCBhIHN0YXRlbWVudCByZWdhcmRpbmcgdGhlIGxpbWl0YXRpb24N
CiAgdG8gVUFSVCBtb2RlOw0KKiBNYWtlIHRoZSBjb21wYXRpYmxlIHN0cmluZyBTb0Mgc3BlY2lm
aWMgKCJmc2wsczMydjIzNC1saW5mbGV4dWFydCIpOyBhZGQNCiAgbmV3IHBhdGNoICdzZXJpYWw6
IGZzbF9saW5mbGV4dWFydDogVXBkYXRlIGNvbXBhdGlibGUgc3RyaW5nJyB0byB1cGRhdGUNCiAg
dGhlIExJTkZsZXhEIGRyaXZlciBhcyB3ZWxsOw0KKiBJbiB0aGUgTElORmxleEQgYmluZGluZyBk
b2N1bWVudGF0aW9uLCBpbnNlcnQgYSBzcGFjZSBiZXR3ZWVuIGxhYmVsIGFuZA0KICBub2RlIG5h
bWUgYW5kIHJlbW92ZSB0aGUgJ3N0YXR1cycgcHJvcGVydHkuDQoNCkNoYW5nZXMgaW4gdjI6DQoq
IFVwZGF0ZSB0aGUgZW50cnkgaW4gZnNsLnlhbWwgdG8gYXBwbHkgdG8gYWxsIFMzMlYyMzQgYmFz
ZWQgYm9hcmRzOw0KKiBBZGQgY2hvc2VuIG5vZGUgdG8gZHRzLCB3aXRoIGEgJ3N0ZG91dC1wYXRo
JyBwcm9wZXJ0eSBmb3IgZWFybHljb247DQoqIFJlbW92ZSBsaW5mbGV4X3ZlcmlmeV9wb3J0KCks
IGJlY2F1c2UgaXQgd2FzIG9ubHkgY2FsbGVkIGZyb20NCiAgdWFydF9zZXRfaW5mbygpLCB3aGlj
aCB3YXMgZ29pbmcgdG8gYWx3YXlzIGZhaWwgYXQgdGhlICJiYXVkX2Jhc2UgPCA5NjAwIg0KICBj
aGVjaywgYXMgd2UgYXJlIG5vdCB1c2luZyB1YXJ0Y2xrIGZyb20gdWFydF9wb3J0IHlldDsNCiog
Rml4IGNvbXBhdGlibGUgc3RyaW5nIHVzZWQgaW4gT0ZfRUFSTFlDT05fREVDTEFSRS4NCg0KWzFd
IGh0dHBzOi8vd3d3Lm54cC5jb20vcHJvZHVjdHMvcHJvY2Vzc29ycy1hbmQtbWljcm9jb250cm9s
bGVycy9hcm0tYmFzZWQtcHJvY2Vzc29ycy1hbmQtbWN1cy9zMzItYXV0b21vdGl2ZS1wbGF0Zm9y
bS92aXNpb24tcHJvY2Vzc29yLWZvci1mcm9udC1hbmQtc3Vycm91bmQtdmlldy1jYW1lcmEtbWFj
aGluZS1sZWFybmluZy1hbmQtc2Vuc29yLWZ1c2lvbjpTMzJWMjM0DQpbMl0gaHR0cHM6Ly93d3cu
bnhwLmNvbS9zdXBwb3J0L2RldmVsb3Blci1yZXNvdXJjZXMvZXZhbHVhdGlvbi1hbmQtZGV2ZWxv
cG1lbnQtYm9hcmRzL3VsdHJhLXJlbGlhYmxlLWRldi1wbGF0Zm9ybXMvczMydi1tcHVzLXBsYXRm
b3Jtcy9zMzJ2LXZpc2lvbi1hbmQtc2Vuc29yLWZ1c2lvbi1ldmFsdWF0aW9uLXN5c3RlbTpTMzJW
MjM0RVZCDQpbM10gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MDk4NjRjMWNkZjVjNTM3YmQwMWJmZjQ1
MTgxNDA2ZTQyMmVhOTg4Yw0KWzRdIGh0dHBzOi8vc291cmNlLmNvZGVhdXJvcmEub3JnL2V4dGVy
bmFsL2F1dG9ic3BzMzIvbGludXgvDQpbNV0gaHR0cHM6Ly9zb3VyY2UuY29kZWF1cm9yYS5vcmcv
ZXh0ZXJuYWwvYXV0b2JzcHMzMi91LWJvb3QvDQpbNl0gaHR0cHM6Ly9zb3VyY2UuY29kZWF1cm9y
YS5vcmcvZXh0ZXJuYWwvczMyZHMvY29tcGlsZXIvZ2NjLw0KWzddIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPTJiZDM2NjFlYTBlYjIwNTY4NTJjYmM1OGM1ZDk2YmI0ZGYyZjE2NGYNCls4XSBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQvY29tbWl0Lz9pZD0wZTE2ZmVhYjZjY2UyYjkxZDI5OTZkNGJjNGVmZjAxZWNlNTc3YzRhDQoN
CkVkZHkgUGV0cmnImW9yICgxKToNCiAgZHQtYmluZGluZ3M6IGFybTogZnNsOiBBZGQgdGhlIFMz
MlYyMzQtRVZCIGJvYXJkDQoNCk1paGFlbGEgTWFydGluYXMgKDIpOg0KICBhcm02NDogSW50cm9k
dWNlIGNvbmZpZyBmb3IgUzMyDQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBjb25maWdzIGZv
ciBTMzJWMjM0DQoNClN0ZWZhbi1HYWJyaWVsIE1pcmVhICgxKToNCiAgc2VyaWFsOiBmc2xfbGlu
ZmxleHVhcnQ6IEJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgbmFtZQ0KDQpTdG9pY2EgQ29zbWluLVN0
ZWZhbiAoMSk6DQogIGFybTY0OiBkdHM6IGZzbDogQWRkIGRldmljZSB0cmVlIGZvciBTMzJWMjM0
LUVWQg0KDQogLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwg
ICAyICstDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sICAgICAgICAgIHwg
ICA2ICsNCiBhcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zICAgICAgICAgICAgICAgICAgfCAg
IDUgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlICAgICAgICB8ICAg
MiArDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvczMydjIzNC1ldmIuZHRzIHwgIDI1
ICsrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9zMzJ2MjM0LmR0c2kgICAgfCAx
MzkgKysrKysrKysrKysrKysrKysrDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAg
ICAgICAgICAgICAgIHwgICAzICsNCiBkcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgfCAgIDggKy0NCiBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xpbmZsZXh1YXJ0
LmMgICAgICAgICAgfCAgIDQgKy0NCiBpbmNsdWRlL3VhcGkvbGludXgvc2VyaWFsX2NvcmUuaCAg
ICAgICAgICAgICAgfCAgIDQgKy0NCiAxMCBmaWxlcyBjaGFuZ2VkLCAxODkgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvczMydjIzNC1ldmIuZHRzDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL3MzMnYyMzQuZHRzaQ0KDQotLSANCjIuMjIuMA0KDQo=
