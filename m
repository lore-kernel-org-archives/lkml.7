Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F4C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4820851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="hW6JuzoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFMPwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:52:51 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com ([40.107.5.102]:47672
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731632AbfFMJG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmkQyMRrS+WeHQ6vK9H+Cu7FwZrb/8eyGFDbIh/uw8k=;
 b=hW6JuzoLELo5AaljochyWZlSw9sK1VS/7u+i5M61FHKiiVSt3ZI4lPZn8zuU8JhlMkGMVPB510VM/vjHcAYMFoVQ9wwnwM2OSQoVv+qr62ghqxAF3kD6EzbSILmlbdiDmWfrK6ya3YhKE8T1nkjB67P3XENKclRMRXe/Vec6bbE=
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com (20.179.26.150) by
 VI1PR05MB5599.eurprd05.prod.outlook.com (20.177.203.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 09:06:23 +0000
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c]) by VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 09:06:23 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     "perex@perex.cz" <perex@perex.cz>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [PATCH v1 5/6] ASoC: Define a set of DAPM pre/post-up events
Thread-Topic: [PATCH v1 5/6] ASoC: Define a set of DAPM pre/post-up events
Thread-Index: AQHVD9h2n65i+TZ/JkawFJN4s0sAMaaZbtqA
Date:   Thu, 13 Jun 2019 09:06:23 +0000
Message-ID: <dbab9b60e46dde17a3dd0bd05a160d14e9e63860.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
         <20190521103619.4707-6-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190521103619.4707-6-oleksandr.suvorov@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb99e40f-5267-4cef-8d91-08d6efde68cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5599;
x-ms-traffictypediagnostic: VI1PR05MB5599:
x-microsoft-antispam-prvs: <VI1PR05MB5599968CDFFEE3EFA7D0E3E4FBEF0@VI1PR05MB5599.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(366004)(346002)(136003)(189003)(199004)(305945005)(186003)(118296001)(6636002)(11346002)(229853002)(26005)(6486002)(316002)(71190400001)(7736002)(71200400001)(54906003)(86362001)(478600001)(110136005)(14454004)(3846002)(6246003)(81156014)(99286004)(36756003)(76176011)(8676002)(6506007)(53936002)(476003)(6512007)(256004)(5660300002)(25786009)(4744005)(81166006)(6436002)(8936002)(66446008)(66066001)(4326008)(2501003)(66556008)(66476007)(64756008)(68736007)(66946007)(76116006)(44832011)(2616005)(2906002)(6116002)(486006)(446003)(102836004)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5599;H:VI1PR05MB6477.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A1zjQP3EgXEWSUNDuWJjXB2hJbTrC6nfoB8dJV8R9EXiY9RLT8Oh3rSDlw3nnXndVhWe7ghz60IswSS2hInT3DZLmfNYlelocJzos2zrQwjAjtHbYWXah+BAdZ433GivxPtFzjJkBzhq58X0zNbw41yGlZg88TUwAEUvF7l7OccgcIDuk6lcgxwVGWxH1Pz0VhFGhoR0JeuPwWVp8KahgxGhLXYZ3AdZYjVIjJ0Snxy13bWyE4ne2xaAx+5WnI7YReQzh7MGbn6PHqutjlFds8QbIpeJHUbasZRizXJ4Kzsi0ezWzfptR0+OA7Mrz5xS+HyeytAy8K5U/gDZNZX1Kb3sRiW4phkqV6bhUe6jwiSotLFl7+4PtApcirlQBaJCaJInbx4vlynBSxA+UlDjcMDbYJ0uPhyiTXWUKtdjwJg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5430796D926C44B9A1666479D72A936@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb99e40f-5267-4cef-8d91-08d6efde68cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:06:23.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: marcel.ziswiler@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDEzOjM2ICswMzAwLCBPbGVrc2FuZHIgU3V2b3JvdiB3cm90
ZToNCj4gUHJlcGFyZSB0byB1c2UgU05EX1NPQ19EQVBNX1BSRV9QT1NUX1BNVSBkZWZpbml0aW9u
IHRvDQo+IHJlZHVjZSBjb21pbmcgY29kZSBzaXplIGFuZCBtYWtlIGl0IG1vcmUgcmVhZGFibGUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9y
b3ZAdG9yYWRleC5jb20+DQoNClJldmlld2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56
aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gDQo+ICBpbmNsdWRlL3NvdW5kL3NvYy1k
YXBtLmggfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGluY2x1ZGUvc291bmQvc29jLWRhcG0uaCBpbmNsdWRlL3NvdW5kL3NvYy1kYXBt
LmgNCj4gaW5kZXggYzAwYTBiOGFkZTA4Li42YzY2OTQxNjAxMzAgMTAwNjQ0DQo+IC0tLSBpbmNs
dWRlL3NvdW5kL3NvYy1kYXBtLmgNCj4gKysrIGluY2x1ZGUvc291bmQvc29jLWRhcG0uaA0KPiBA
QCAtMzUzLDYgKzM1Myw4IEBAIHN0cnVjdCBkZXZpY2U7DQo+ICAjZGVmaW5lIFNORF9TT0NfREFQ
TV9XSUxMX1BNRCAgIDB4ODAgICAgLyogY2FsbGVkIGF0IHN0YXJ0IG9mDQo+IHNlcXVlbmNlICov
DQo+ICAjZGVmaW5lIFNORF9TT0NfREFQTV9QUkVfUE9TVF9QTUQgXA0KPiAgCQkJCShTTkRfU09D
X0RBUE1fUFJFX1BNRCB8DQo+IFNORF9TT0NfREFQTV9QT1NUX1BNRCkNCj4gKyNkZWZpbmUgU05E
X1NPQ19EQVBNX1BSRV9QT1NUX1BNVSBcDQo+ICsJCQkJKFNORF9TT0NfREFQTV9QUkVfUE1VIHwN
Cj4gU05EX1NPQ19EQVBNX1BPU1RfUE1VKQ0KPiAgDQo+ICAvKiBjb252ZW5pZW5jZSBldmVudCB0
eXBlIGRldGVjdGlvbiAqLw0KPiAgI2RlZmluZSBTTkRfU09DX0RBUE1fRVZFTlRfT04oZSkJXA0K
PiAtLSANCj4gMi4yMC4xDQo=
