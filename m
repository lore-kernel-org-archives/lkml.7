Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B210DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ED1206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="qHFp4kZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfH0NSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:18:22 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:14974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfH0NSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii1glYbNlsmCnYxsMLD0imAczlLLjlbpqjwCwzdHWz5ltOAWcnQuHCUX5lblzSgUvGpaJeKUBV0qp3S5OZoh0ZqvHBhc7Nzhzz7XX6+S4Ios7vDzRd2+J+fyG8kfbORqxT3+qZMFZZeK6id+/q6LX0ahu8DYWfZEwOph2VHXWRCzJMxitfAsSLOuKmWc+RY5qqN6/5TaXR9WQAq+2GZYw/hPe6RwQ2z84LnpIxyWnp5NE8ox0S5dHG8GjpBNdhKGZM5Fpk0OAdG4U2ZBBXz1xnJYqRMXIPrDZQYDNgyUbGV2oq9Xxr+E/A9ZaV3o+7G78oYognl2nNlJT60xGm5nkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c38jKzZzL1YLNMypixVtDvWLs5M48WiAq9DnHYbgF0=;
 b=PCUrxb3+gxvFoeqvpEKV5hU7fgm3eUCKqaaXwNfpGI//xVyN/1QhzwDqh7+fwVJj0EzYZhob2VcQji4HqKUNZswQYOgmdFnZ2CokyQkDZCkS5H3d+OG8kqcPFkD93PDNcy45k2OGYGLoyW2cW2ru3PIN+4cdpdjxC4XstqiRZ8vE/5G0Mhk2VThwbe5EzbzGmVjkY/+WKqbUWcaJAbdJgZsfdAuJzN+qV3jyexiQ+f9rc+4QL/mInEaZ7AF94ZjMijeoCe9+Xpz0XNiHadSi2Rjo2bkYOZOKSMHjUh33hVZL1kzcooFXzIpqxhTRJUsFt6brfGamfZpC0SINEZa/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c38jKzZzL1YLNMypixVtDvWLs5M48WiAq9DnHYbgF0=;
 b=qHFp4kZvRqmVXPNTROLOtdAmmtT/QyMPINBM4JJdGTtiHzZNEROhpFb5z1dj2J9wAGTL1J7815R7asjO12g0+MIJ4muMx1CYPQI3QHwAPhwpVzAoalW/h+OlO4JWn1aUMaNctzQzSjmeQxCbQ2EUboNAFQ5nZfBDrmWEOJYHgoc=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3872.eurprd05.prod.outlook.com (52.134.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:16 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:16 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan @ agner . ch" <stefan@agner.ch>,
        "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 00/13] Common patches from downstream development
Thread-Topic: [PATCH v5 00/13] Common patches from downstream development
Thread-Index: AQHVXNnirAUAmshgM0GrJ2yVzzun2A==
Date:   Tue, 27 Aug 2019 13:18:16 +0000
Message-ID: <20190827131806.6816-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc8600a-51f8-4d88-7216-08d72af10555
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3872;
x-ms-traffictypediagnostic: VI1PR0502MB3872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB38728A19B912DF5E5DB53C61F4A00@VI1PR0502MB3872.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(8936002)(66946007)(2906002)(5660300002)(50226002)(54906003)(110136005)(316002)(14454004)(1076003)(561944003)(14444005)(256004)(64756008)(6506007)(386003)(7736002)(478600001)(36756003)(53936002)(66556008)(6116002)(66066001)(66446008)(3846002)(6436002)(476003)(2616005)(486006)(6512007)(26005)(305945005)(102836004)(6486002)(71200400001)(186003)(8676002)(86362001)(81166006)(4326008)(71190400001)(81156014)(66476007)(25786009)(99286004)(7416002)(52116002)(44832011)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3872;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x2vV1BoMOXB0f49Jcumk4GwxWp2E6wKD184vmfI/rYZ9KzjMpjCSWkN7DaMmLQ5btEqzaEq60H3e6OYlg8+ZbV/sfUE46cFuMRpKaXovpQa/UZeSKvWJPBPBitGlailPtvkaruNlIQ8wyNobr5oFciU63fLLkfSqP+EuV5JH41Wh9WFSNJua/Au5jxSO+2s+oSkfjNKb4QunvxdzHw/r7lEXi7vA8GldvfoEGrxlMCcn49ej7loIA0ZWP6YM5PEabAgeS1X1jt3dPeJ1O5NWGKWy3HAnOEQzcfWOd1u7Dfx6VRHhvV3EWjyR6FXl0lX6dzWGCHV417aPpiJ+JIU2ExnaspfTbXFSj14b+K7cjoJP7HsB02Rq/kixfRwz2EMcIWwHUp0Oc68EoSWeCI7CvuC+vxOVF6W0Rb8gKYskQh4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9D7C2CC8883B8409492F23CF1D14A42@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc8600a-51f8-4d88-7216-08d72af10555
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:16.3434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaiWVF6wJYk43u0xnVVMJxiA+qzAJpFAk4dVOaRPH2UYq95qv9xKHQw/ukv2WYHuOlRAhVgNv4gE3h4oKdBwrocb447Pi4e/2MKkZutQBHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGhvbGRzIHNvbWUgY29tbW9uIGNoYW5nZXMgdGhhdCB3ZXJlIG5ldmVy
IHVwc3RyZWFtZWQuDQpXaXRoIGxhdGVzdCBkb3duc3RyZWFtIGtlcm5lbCB1cGdyYWRlLCBJIHRv
b2sgdGhlIGFwcm9hY2ggdG8gc2VsZWN0DQptYWlubGluZSBkZXZpY2V0cmVlcyBhbmQgYXRvbWlj
YWxseSBhZGQgbWlzc2luZyBzdHVmZiBmb3IgZG93bnN0cmVhbS4NCg0KVGhlc2UgcGF0Y2hlcyBJ
IHNlbmQgaGVyZSBhcmUgc2VwYXJhdGVkIG91dCB3aXRoIGNoYW5nZXMgdGhhdCBhbHNvDQpoYXZl
IGEgYmVuZWZpdCBmb3IgbWFpbmxpbmUuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLSBVcGRhdGUg
dmVyc2lvbiA0IGFuZCBsYXRlciAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUGF0Y2hlcyB0aGF0
IGdvdCBwdWxsZWQgaW4gYW4gZWFybGllciBwYXRjaHNldCB2ZXJzaW9uIGdvdCBkcm9wcGVkIGlu
DQp0aGlzIHBhdGNoc2V0Lg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNClBoaWxpcHBlDQoNCkNoYW5nZXMg
aW4gdjU6DQotIGNoYW5nZWQgbGVnYWN5IGdwaW8ta2V5LHdha2V1cCB0byB3YWtldXAtc291cmNl
DQotIEFkZCBub3RlIGluIGNvbW1pdCBtZXNzYWdlIGFib3V0IGRpc2FibGVkIHN0YXR1cw0KLSBB
ZGRlZCBPbGVrJ3MgcmV2aWV3ZWQtYnkNCi0gY2hhbmdlIGdyb3VwIG5hbWUNCi0gQWRkIHBpbm11
eCB0byBpb211eGMNCi0gQWRqdXN0ZWQgY29tbWl0IG1lc3NhZ2UNCi0gU3dpdGNoZWQgdG8gY29u
c2lzdGVudCBuYW1pbmc6IHBpbmN0cmxfeHh4OiB4eHhncnANCi0gQWRkZWQgT2xlaydzIFJldmll
d2VkLWJ5DQotIEFkZGVkIE9sZWsncyBSZXZpZXdlZC1ieQ0KLSBBZGRlZCBPbGVrJ3MgUmV2aWV3
ZWQtYnkNCi0gQWRkZWQgT2xlaydzIFJldmlld2QtYnkNCi0gQWRkZWQgT2xlaydzIFJldmlld2Vk
LWJ5DQotIEFkZCBPbGVrJ3MgUmV2aWV3ZWQtYnkNCi0gQWRkZWQgbm90ZSB0byBjb21taXQgbWVz
c2FnZSBhYm91dCBkaXNhYmxlZCBzdGF0dXMNCi0gQWRkIE9sZWsncyBSZXZpZXdlZC1ieQ0KDQpD
aGFuZ2VzIGluIHY0Og0KLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3MgQWNrDQotIEFkZCBNYXJjZWwg
Wmlzd2lsZXIncyBBY2sNCi0gQWRkIE1hcmNlbCBaaXN3aWxlcidzIEFjaw0KLSBBZGQgTWFyY2Vs
IFppc3dpbGVyJ3MgQWNrDQotIEFkZCBNYXJjZWwgWmlzd2lsZXIncyBBY2sNCi0gQWRkIE1hcmNl
bCBaaXN3aWxlcidzIEFjaw0KLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3MgQWNrDQotIEFkZCBNYXJj
ZWwgWmlzd2lsZXIncyBBY2sNCi0gQWRkIE1hcmNlbCBaaXN3aWxlcidzIEFjaw0KLSBBZGQgTWFy
Y2VsIFppc3dpbGVyJ3MgQWNrDQotIE1vdmUgY2FuIG5vZGVzIHRvIG1vZHVsZSBkZXZpY2V0ZXJl
ZSBpbmNsdWRlIGlteDZ1bGwtY29saWJyaS5kdHNpDQotIEFkZCBNYXJjZWwgWmlzd2lsZXIncyBB
Y2sNCg0KQ2hhbmdlcyBpbiB2MzoNCi0gQWRkIG5ldyBjb21taXQgbWVzc2FnZSBmcm9tIFN0ZWZh
bidzIHByb3Bvc2FsIG9uIE1MDQotIEZpeCBjb21taXQgbWVzc2FnZQ0KLSBGaXggY29tbWl0IHRp
dGxlIHRvICIuLi5pbXg2LWFwYWxpczouLi4iDQoNCkNoYW5nZXMgaW4gdjI6DQotIERlbGV0ZWQg
dG91Y2hyZXZvbHV0aW9uIGRvd25zdHJlYW0gc3R1ZmYNCi0gVXNlIGdlbmVyaWMgbm9kZSBuYW1l
DQotIEJldHRlciBjb21tZW50DQotIENoYW5nZWQgY29tbWl0IHRpdGxlIHRvICcuLi5pbXg2cWRs
LWFwYWxpczouLi4nDQotIERlbGV0ZWQgdG91Y2hyZXZvbHV0aW9uIGRvd25zdHJlYW0gc3R1ZmYN
Ci0gVXNlIGdlbmVyaWMgbm9kZSBuYW1lDQotIFB1dCBhIGJldHRlciBjb21tZW50IGluIHRoZXJl
DQotIENvbW1pdCB0aXRsZQ0KLSBSZW1vdmVkIGYwNzEwYQ0KdGhhdCBpcyBkb3duc3RyZWFtIG9u
bHkNCi0gQ2hhbmdlZCB0byBnZW5lcmljIG5vZGUgbmFtZQ0KLSBCZXR0ZXIgY29tbWVudA0KDQpN
YXggS3J1bW1lbmFjaGVyICgyKToNCiAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogcmVkdWNl
IHZfYmF0dCBjdXJyZW50IGluIHBvd2VyIG9mZg0KICBBUk06IGR0czogaW14NnVsbDogaW1wcm92
ZSBjYW4gdGVtcGxhdGVzDQoNClBoaWxpcHBlIFNjaGVua2VyICg5KToNCiAgQVJNOiBkdHM6IGlt
eDctY29saWJyaTogQWRkIHRvdWNoIGNvbnRyb2xsZXJzDQogIEFSTTogZHRzOiBpbXg2cWRsLWNv
bGlicmk6IEFkZCBtaXNzaW5nIHBpbiBkZWNsYXJhdGlvbiBpbiBpb211eGMNCiAgQVJNOiBkdHM6
IGlteDZxZGwtYXBhbGlzOiBBZGQgc2xlZXAgc3RhdGUgdG8gY2FuIGludGVyZmFjZXMNCiAgQVJN
OiBkdHM6IGlteDYtYXBhbGlzOiBBZGQgdG91Y2hzY3JlZW5zIHVzZWQgb24gVG9yYWRleCBldmFs
IGJvYXJkcw0KICBBUk06IGR0czogaW14Ni1jb2xpYnJpOiBBZGQgbWlzc2luZyBwaW5tdXhpbmcg
dG8gVG9yYWRleCBldmFsIGJvYXJkDQogIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IEFkZCBz
bGVlcCBtb2RlIHRvIGZlYw0KICBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBBZGQgd2F0Y2hk
b2cNCiAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogQWRkIGdlbmVyYWwgd2FrZXVwIGtleSB1
c2VkIG9uIENvbGlicmkNCiAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogQWRkIHRvdWNoc2Ny
ZWVuIHVzZWQgd2l0aCBFdmFsIEJvYXJkDQoNClN0ZWZhbiBBZ25lciAoMik6DQogIEFSTTogZHRz
OiBpbXg3LWNvbGlicmk6IGFkZCBHUElPIHdha2V1cCBrZXkNCiAgQVJNOiBkdHM6IGlteDctY29s
aWJyaTogZml4IDEuOFYvVUhTIHN1cHBvcnQNCg0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC1j
b2xpYnJpLWV2YWwtdjMuZHRzICB8IDM5ICsrKysrKysrKysrDQogYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnEtYXBhbGlzLWV2YWwuZHRzICAgICAgIHwgMTMgKysrKw0KIGFyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxLWFwYWxpcy1peG9yYS12MS4xLmR0cyB8IDEzICsrKysNCiBhcmNoL2FybS9ib290L2R0
cy9pbXg2cS1hcGFsaXMtaXhvcmEuZHRzICAgICAgfCAxMyArKysrDQogYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnFkbC1hcGFsaXMuZHRzaSAgICAgICAgIHwgMjcgKysrKysrLS0NCiBhcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaSAgICAgICAgfCAxNyArKysrKw0KIC4uLi9hcm0v
Ym9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8IDM4ICsrKysrKysrKysrDQog
Li4uL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktbm9ud2lmaS5kdHNpIHwgIDIgKy0NCiBh
cmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktd2lmaS5kdHNpICAgfCAgMiArLQ0KIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpICAgICAgICB8IDY0ICsrKysrKysr
KysrKysrKysrLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNp
ICAgfCAzOCArKysrKysrKysrKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNp
ICAgICAgICAgICB8IDMwICsrKysrKysrLQ0KIDEyIGZpbGVzIGNoYW5nZWQsIDI4MCBpbnNlcnRp
b25zKCspLCAxNiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIzLjANCg0K
