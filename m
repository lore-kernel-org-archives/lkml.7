Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF854C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823E12084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OqxMq2u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfLDPBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:01:22 -0500
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:62592
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727878AbfLDPBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:01:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds8+R7WYJcL3hU/9c9ACQ6Nov31hzq5BsgN3XxZRC2QSdtZKnILJexrDcPnaWHLKbDu36/b06+EwJEScWCY2gnp4I3///7elras0xFjX6ar/owKc6Kb2a5rlrJWxI2dUQrpPIV8maPjSf/aNRL2ODzvZfn2xKEbt9StpCn17PMIDXsGrU96UJsU/gFufpB623WKbREqluBm3YRndKfSo/yubMnqgwWGomYbIc/2rl4Izeb4/piRh46YtUUEguWPbp/MsSnSuyRcqQ8epU75necWHO86cGkOdENHQ+DQp/ZBjvrmI8H+KtTYeCJVEY9dssIvJp38hmZcgi7KC1uO4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ9cKUQVIKWI/ktqhl/84zXUYvMczbyd2aOAZMwNcbI=;
 b=kzwWuYNQEjbaLeaP16CzjTwPlxIhPsNkt4CPJG9c1GF/I2yzsuYi0Ms2ni46z4aMsjv+/Ym2fpBRbhwPI0EY0RqfRRw9F017zk5V/zia/DjHnvfoBO4IJ0eYU9wgdq/Eq/3cMwzkCOmX51FOXsxZ8LIWFkbWfdgjhrxKkx2XVU0Bst1UzudOGvFdDo/fa75JTpnKHxFYAgohNtnjEd2OAcvne3P5tHUnoyC4Rav7lC7Rlkcfm+5NAe6yvHs/X4Daew67BOCsghYGC5896Zw0+q/ecsszvt2dZyOoTfDUKJNFmwZ21V2GxDnlbGwxOCmX2UT3SOUgxmN2FTGDByKTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ9cKUQVIKWI/ktqhl/84zXUYvMczbyd2aOAZMwNcbI=;
 b=OqxMq2u19CnxKn2hsmyo1DGGnb3XyAgIjI75mo1XOVl4nJvoFPZTtkeWugwbG56bsduL/8O3lv18xOdpY9CJE8KKIxC6nmhcjvV9YqDh/0aYYBqJRNoj6sZPAVPDy6oCjg2o0cPc1rNcaVkAhYAv3szs5dWUQ95k8pnmIslMUwM=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
 VI1PR04MB7022.eurprd04.prod.outlook.com (10.186.157.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 15:01:18 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::71d2:55b3:810d:c75b]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::71d2:55b3:810d:c75b%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 15:01:18 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: fsl-mc: properly empty-initialize structure
Thread-Topic: [PATCH] bus: fsl-mc: properly empty-initialize structure
Thread-Index: AQHVqq9Vr1zFh3okmEmQd2FiJW+WsKeqEf2A
Date:   Wed, 4 Dec 2019 15:01:18 +0000
Message-ID: <d73e2812-c53e-c480-2c61-b2c57c3c193d@nxp.com>
References: <20191204142950.30206-1-ioana.ciornei@nxp.com>
In-Reply-To: <20191204142950.30206-1-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47aecbde-44e2-4a14-6f34-08d778cad156
x-ms-traffictypediagnostic: VI1PR04MB7022:|VI1PR04MB7022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7022E3EB5FB439E8248743D9EC5D0@VI1PR04MB7022.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(6246003)(8936002)(86362001)(6512007)(81166006)(478600001)(6436002)(81156014)(14454004)(8676002)(229853002)(6486002)(31686004)(2501003)(4326008)(71200400001)(71190400001)(316002)(31696002)(110136005)(25786009)(76176011)(99286004)(7736002)(64756008)(66446008)(11346002)(102836004)(2616005)(6116002)(66476007)(3846002)(66556008)(305945005)(5660300002)(26005)(6506007)(53546011)(186003)(76116006)(91956017)(66946007)(2906002)(44832011)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7022;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okVCZu6lkKBXj1h3ja/1EZNQarL8VvX+UjCa9RrefwG41ldGODfo/cYbO1g9yMH8i/SCK2lI5KLVc/ILjJPEAB2O4lpeplJ74zLDLHJUm5T/vktQMeojEE2/aArKn4JnLTyDA2bb0/L92odQzSCdewQ8F82WA5d2OZF2PjMiLAX8QzVTIhIqTCwb4TxI1YXau2jhcA9LC3JZ0KxWAz/JMZWYGLEqQcCVIepHmR3zVn39X9otxhA0rQIqwVC7iPUjypaouU4PImB+GKpt8lEobynQ9I9qUgvt2nKK7OIeB2pIockCi6sA6lLqPRe2TeOkWzSR0YsdHemcoMhBEyPQAko1CVTXEgQGhMCFJJ1693hpDXuqGLk4lOw71xcxcvDWjMwPLIw5OmkzCYlVLbcBkhX9NnQH1OoPMKGDtFFtlhri51ZkdkjDkCNpPjw5vBLs
Content-Type: text/plain; charset="utf-8"
Content-ID: <7224FC9B4D571849A3F47DDFCE084EDB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aecbde-44e2-4a14-6f34-08d778cad156
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 15:01:18.5634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcmFUKA86nRiWEMK9WyaCXBn4Zu6kuTiBC+p9KkNtc7UAwvbE3NfVaDS/50ypF4MzOG8JP59J9DkU8SU6gpb3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LjEyLjIwMTkgMTY6MjksIElvYW5hIENpb3JuZWkgd3JvdGU6DQo+IFVzZSB0aGUg
cHJvcGVyIGZvcm0gb2YgdGhlIGVtcHR5IGluaXRpYWxpemVyIHdoZW4gd29ya2luZyB3aXRoDQo+
IHN0cnVjdHVyZXMgdGhhdCBjb250YWluIGFuIGFycmF5LiBPdGhlcndpc2UsIG9sZGVyIGdjYyB2
ZXJzaW9ucyAoZWcgZ2NjDQo+IDQuOSkgd2lsbCBjb21wbGFpbiBhYm91dCB0aGlzLg0KPiANCj4g
Rml4ZXM6IDFhYzIxMGQxMjhlZiAoImJ1czogZnNsLW1jOiBhZGQgdGhlIGZzbF9tY19nZXRfZW5k
cG9pbnQgZnVuY3Rpb24iKQ0KPiBSZXBvcnRlZC1ieToga2J1aWxkIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IElvYW5hIENpb3JuZWkgPGlvYW5hLmNpb3JuZWlA
bnhwLmNvbT4NCg0KVGhhbmtzLA0KDQpBY2tlZC1ieTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50
aXUudHVkb3JAbnhwLmNvbT4NCg0KLS0tDQpCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ0KDQo+IC0t
LQ0KPiAgIGRyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVzLmMgfCA2ICsrKy0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1tYy1idXMuYyBiL2RyaXZlcnMvYnVzL2Zz
bC1tYy9mc2wtbWMtYnVzLmMNCj4gaW5kZXggYTA3Y2MxOWJlY2RiLi5jNzhkMTBlYTY0MWYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVzLmMNCj4gKysrIGIvZHJp
dmVycy9idXMvZnNsLW1jL2ZzbC1tYy1idXMuYw0KPiBAQCAtNzE1LDkgKzcxNSw5IEBAIEVYUE9S
VF9TWU1CT0xfR1BMKGZzbF9tY19kZXZpY2VfcmVtb3ZlKTsNCj4gICBzdHJ1Y3QgZnNsX21jX2Rl
dmljZSAqZnNsX21jX2dldF9lbmRwb2ludChzdHJ1Y3QgZnNsX21jX2RldmljZSAqbWNfZGV2KQ0K
PiAgIHsNCj4gICAJc3RydWN0IGZzbF9tY19kZXZpY2UgKm1jX2J1c19kZXYsICplbmRwb2ludDsN
Cj4gLQlzdHJ1Y3QgZnNsX21jX29ial9kZXNjIGVuZHBvaW50X2Rlc2MgPSB7IDAgfTsNCj4gLQlz
dHJ1Y3QgZHByY19lbmRwb2ludCBlbmRwb2ludDEgPSB7IDAgfTsNCj4gLQlzdHJ1Y3QgZHByY19l
bmRwb2ludCBlbmRwb2ludDIgPSB7IDAgfTsNCj4gKwlzdHJ1Y3QgZnNsX21jX29ial9kZXNjIGVu
ZHBvaW50X2Rlc2MgPSB7eyAwIH19Ow0KPiArCXN0cnVjdCBkcHJjX2VuZHBvaW50IGVuZHBvaW50
MSA9IHt7IDAgfX07DQo+ICsJc3RydWN0IGRwcmNfZW5kcG9pbnQgZW5kcG9pbnQyID0ge3sgMCB9
fTsNCj4gICAJaW50IHN0YXRlLCBlcnI7DQo+ICAgDQo+ICAgCW1jX2J1c19kZXYgPSB0b19mc2xf
bWNfZGV2aWNlKG1jX2Rldi0+ZGV2LnBhcmVudCk7DQo+IA==
