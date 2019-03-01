Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E712083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="O9kgjYl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCAW0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:26:52 -0500
Received: from mail-eopbgr710137.outbound.protection.outlook.com ([40.107.71.137]:51853
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfCAW0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBoytU4di1d2wJH9rJL9rYWeAprbS5ZvJ3aVWqkH5ZQ=;
 b=O9kgjYl4CdH6OX8plEAS/Jr/V3109BGS9xJWdmZ4G7mEoqoV4QpZGZOElZRMu3JALZbd4G1QH9KyvPAJEK/mDs725vKgu687pVf6RGZDPnOB6mu35C8qCwPqZN37YllOj3N2+zClhr2+JCGbz/CYfLqxIGOti1WvelLAP5JgHuI=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3787.namprd06.prod.outlook.com (10.167.236.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 22:26:42 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::91d4:ba4b:1424:9452]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::91d4:ba4b:1424:9452%2]) with mapi id 15.20.1665.017; Fri, 1 Mar 2019
 22:26:42 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jiada_wang@mentor.com" <jiada_wang@mentor.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>
Subject: Re: Bug in spi: imx: Add support for SPI Slave mode
Thread-Topic: Bug in spi: imx: Add support for SPI Slave mode
Thread-Index: AQHUzhwSBRMy/pK+/0CNaGtu+2RbfqXy4q8AgAR8yIA=
Date:   Fri, 1 Mar 2019 22:26:41 +0000
Message-ID: <1551479201.6059.23.camel@impinj.com>
References: <20170905051232.21203-1-jiada_wang@mentor.com>
         <1551217306.3075.188.camel@impinj.com>
         <2ea41684-69b2-e7e8-0d2b-325c799104e1@mentor.com>
In-Reply-To: <2ea41684-69b2-e7e8-0d2b-325c799104e1@mentor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef3c88ee-c7f5-47e3-4638-08d69e94faee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3787;
x-ms-traffictypediagnostic: MWHPR0601MB3787:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3787;20:Yi9c2bI9lcrNMIAiMis+VUS2PczpD1mb/OZhz86lWTdithT47OeDomvkY/fSefvsPWNnW/dHWv1ArpRk9sQ9sPLepkkbal8Y6/VPChNsSFQwlx4ww/F5aSENoVzV8hrQkLIU4dycuVGvWnNjDFuVfY/snFQFN/Ucay2nehTKfWs=
x-microsoft-antispam-prvs: <MWHPR0601MB3787ED45B2A6E6E8D0A0E374D3760@MWHPR0601MB3787.namprd06.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(51914003)(54094003)(68736007)(305945005)(478600001)(7736002)(8936002)(14454004)(71200400001)(71190400001)(25786009)(66066001)(486006)(446003)(476003)(2616005)(11346002)(106356001)(316002)(2906002)(110136005)(54906003)(8676002)(256004)(14444005)(81156014)(36756003)(81166006)(105586002)(186003)(6486002)(99286004)(102836004)(6506007)(2501003)(103116003)(229853002)(97736004)(6512007)(6436002)(86362001)(2201001)(76176011)(5660300002)(4326008)(3846002)(6116002)(26005)(6246003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3787;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mYfDXnH4v2LmIbqrlMudNOkdKKIUhyUbqlZiK01tGllf2RsBXdmlQtjyWE5v2GCv+fiJ5mGBLBZ4JyuNSCk4YRy04g6g2MsswDHQ+lilxnlZuNotB/8PB5uYgbj+c+Dvt8Byr4qEPWut18/957k3LiIynFHNnOFWVH31WiL2OQPwHjdG8FCdmfjOioZj15g/Y/VvC1zpH0+rIk4s53IsddsR5GOkBNkPymT8ucrCHQU5UJhBPpzKpKTccgLrkzUG2ADIe50RlNaOWJOYXhO3oiUJ0NcXp1kmJCpFt+/ZzzCDMt71g11fsxkIiB522Zs69nCxCExhsg2a26qZCgjOisUcZIzvKGp6oWisfK3runpubS5DQNWRr7Hz+/aLPrH2M9s23ML5e8YfP+eQ0UnfdeQ9UczFfX94FLhpaCiRq9A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AEFA3561EA4F94980AF8DC493D09C3A@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3c88ee-c7f5-47e3-4638-08d69e94faee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 22:26:41.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTI3IGF0IDEwOjU1ICswOTAwLCBKaWFkYSBXYW5nIHdyb3RlOg0KPiBI
aSBUcmVudA0KPiANCj4gVGhhbmtzIGZvciByZXBvcnRpbmcNCg0KVGhhbmtzIGZvciB0aGUgaW5m
b3JtYXRpb24sIGl0IHdhcyB2ZXJ5IGhlbHBmdWwhDQoNCj4gDQo+IGluIHRoZSBjb21taXQgbWVz
c2FnZSBvZiBjb21taXQgKCJzcGk6IGlteDogQWRkIHN1cHBvcnQgZm9yIFNQSSBTbGF2ZSANCj4g
bW9kZSIpLCBpdCBtZW50aW9ucw0KPiANCj4gIlRoZSBzdGFsZSBkYXRhIGluIFJYRklGTyB3aWxs
IGJlIGRyb3BwZWQgd2hlbiB0aGUgU2xhdmUgZG9lcyBhbnkgbmV3IA0KPiB0cmFuc2ZlciINCg0K
U29ycnksIHNvbWVob3cgSSB0b3RhbGx5IG1pc3NlZCB0aGF0Lg0KDQo+IA0KPiA+IElmIGl0J3Mg
bmVjZXNzYXJ5IHRvIGVtcHR5IHRoZSBmaWZvIGJlZm9yZSBhbiB4ZmVyLCB0aGVuIGhvdyBkaWQg
dGhpcw0KPiA+IGRyaXZlciBldmVyIHdvcmsgYmVmb3JlIHRoaXMgY2hhbmdlPyAgSSBzZWUgbm8g
Y2hhbmdlIGFueXdoZXJlIGVsc2UNCj4gPiB0aGF0IHdvdWxkIG1ha2UgdGhpcyBhIG5ldyByZXF1
aXJlbWVudC4NCj4gPiANCj4gDQo+IG9ubHkgc2xhdmUgbW9kZSBuZWVkcyB0byBmbHVzaCBzdGFs
ZSBkYXRhIGluIFJYRklGTywNCg0KT2ssIHNvIG1heWJlIEkgY2FuIG1vdmUgdGhpcyBpbnRvIGEg
c2xhdmUgbW9kZSBvbmx5IHBhdGguICBUaGF0IGNvdWxkDQphdm9pZCB0aGUgY2hlY2sgaW4gbWFz
dGVyIG1vZGUsIGlmIGl0J3Mgbm90IG5lY2Vzc2FyeSB0aGVyZS4NCg0KT2sgY291cnNlLCB0aGF0
IGRvZXNuJ3QgcmVhbGx5IGZpeCBteSB1bmRlcmx5aW5nICJkbWEgdGhlbiBwaW8iDQpwcm9ibGVt
LCBhcyBldmVuIGlmIGl0IGF2b2lkcyBjb3JydXB0aW5nIG1lbW9yeSwgYXMgdGhlcmUgaXMgc3Rp
bGwgZGF0YQ0KaW4gdGhlIFJYIGZpZm8gd2hlcmUgdGhlcmUgc2hvdWxkIG5vdCBiZS4NCg0KPiBD
dXJyZW50bHkgSSBhbSBub3QgYWJsZSB0byB0ZXN0IGFuZCB0aGlzIHBhdGNoIHdhcyBjcmVhdGVk
IHNldmVyYWwgeWVhcnMgDQo+IGJlZm9yZSwgYnV0IGFzIEkgY2FuIHJlY2FsbCwgdGhlIHB1cnBv
c2UgaXMgdG8gZmx1c2ggc3RhbGUgZGF0YSBpbiBSWEZJRk8NCj4gYmVmb3JlIHNwaS0+cnhfYnVm
IGlzIHNldCwgYnV0IHNlZW1zIHRoZXJlIGlzIGJ1ZywgYWZ0ZXIgdGhlIGZpcnN0IHhmZXIsDQo+
IHJ4X2J1ZiB3aWxsIGFsd2F5cyBwb2ludCB0byBzb21ld2hlcmUsIHdoaWNoIGNhbiBsZWFkIHRv
IG1lbW9yeSBjb3JydXB0aW9uLg0KPiANCj4gPiBJbiBteSB0ZXN0LCBzd2l0Y2hpbmcgZnJvbSBE
TUEgdG8gUElPLCB3aGljaCBoYXBwZW5zIGlmIHRoZSAxc3QgeGZlciBpcw0KPiA+ICAgbGFyZ2Ug
ZW5vdWdoIHRvIHBhc3MgYSA+Zmlmby8yIHNpemUgdGVzdCwgYW5kIHVzZXMgRE1BLCBhbmQgdGhl
IDJuZA0KPiA+IHhmZXIgaXMgc21hbGxlciwgYW5kIHdpbGwgdXNlIFBJTywgcmVzdWx0cyBpbiB0
aGUgUElPIHhmZXIgdHJ5aW5nIHRvDQo+ID4gZW1wdHkgdGhlIHJ4IGJ1ZmZlciBpbiB0aGlzIGNv
ZGUgYWJvdmUuICBJZiB0aGVyZSBpcyBub3QgZW5vdWdoIHNwYWNlDQo+ID4gaW4gdGhlIHhmZXIn
cyByeCBidWZmZXIsIGFuZCB0aGVyZSBpcyBubyByZWFzb24gZm9yIHRoZXJlIHRvIGJlIGFueQ0K
PiA+IHNwYWNlIGF0IGFsbCwgaXQgY2xvYmJlcnMgbWVtb3J5Lg0KPiA+IA0KPiA+IEkgc3VzcGVj
dCB0aGUgYXV0aG9yIG9mIHRoaXMgd2Fzbid0IGF3YXJlIHRoYXQgc3BpX2lteC0+cngoKSB3aWxs
IHdyaXRlDQo+ID4gdGhlIGRhdGEgcmVjZWl2ZWQgaW50byB0aGUgY3VycmVudCB4ZmVyJ3Mgcngg
YnVmZmVyIHJhdGhlciB0aGFuIHRocm93DQo+ID4gaXQgYXdheSwgYW5kIG5ldmVyIHRlc3RlZCB0
aGlzIGFjdHVhbGx5IGdldHRpbmcgdXNlZCBmb3IgYSB0cmFuc2Zlcg0KPiA+IHdoZXJlIHRoZSBy
eCBkYXRhIG1hdHRlcmVkLg0KPiA+IA0KPiANCj4geWVzLCB5b3UgYXJlIHJpZ2h0LA0KPiBhcyBJ
IGRvbid0IGhhdmUgYWNjZXNzIHRvIEhXLCBjYW4geW91IHBsZWFzZSBzdWJtaXQgYSBmaXgNCj4g
KGZvciBleGFtcGxlIHJlc2V0IHJ4X2J1ZiBhZnRlciBlYWNoIHhmZXI/KQ0KPiA+IFN0aWxsLCBJ
J2QgbGlrZSB0byBrbm93IHdoeSB0aGUgZmx1c2ggcnggdGhpbmcgaXMgZXZlbiBoZXJlLiAgTm90
aGluZw0KPiA+IGluIHRoZSBjb21taXQgbWVzc2FnZSBvciBhbnkgZGlzY3Vzc2lvbiBJIGNvdWxk
IGZpbmQgYWRkcmVzc2VkIHRoaXMuDQo+ID4gDQo+IA0KPiBtYXN0ZXIgc2lkZSBtYXkgeGZlciBk
YXRhIGxvbmdlciB0aGFuIHNsYXZlIHNpZGUgaXMgZXhwZWN0aW5nLA0KPiB0aGUgZXh0cmEgZGF0
YSByZWNlaXZlZCBpbiBSWEZJRk8sIG5lZWQgdG8gYmUgZHJvcHBlZCBiZWZvcmUgbmV3IHhmZXIN
Cg0KWWVzLCB0aGF0IG1ha2VzIGEgbG90IG9mIHNlbnNlIHdoeSB0aGlzIHdvdWxkIGJlIG5lZWRl
ZC4NCg0KSSB3b25kZXIgaWYgcHV0dGluZyB0aGUgZmx1c2ggYWZ0ZXIgdGhlIHhmZXIgbWlnaHQg
YmUgdG9vIGVhcmx5LiAgSWYNCnRoZSBtYXN0ZXIgaXMgc2VuZGluZyBtb3JlIGRhdGEgdGhhbiBl
eHBlY3RlZCwgaG93IGRvIHdlIGtub3dzIGl0IGhhcw0Kc3RvcHBlZCB3aGVuIHdlIGRvIHRoZSBw
b3N0IHhmZXIgZmx1c2g/ICBQZXJoYXBzIHRoZSBtYXN0ZXIgc2VuZHMgbW9yZQ0KYWZ0ZXIgdGhl
IGZsdXNoIGlzIGZpbmlzaGVkLiAgSXMgdGhlcmUgc29tZSBwb2ludCB3aGVyZSBhZGRpdGlvbmFs
IGRhdGENCmludG8gdGhlIFJYIGZpZm8gaXMgZGlzYWJsZWQ/DQoNClVuZm9ydHVuYXRlbHksIEkg
ZG9uJ3QgaGF2ZSBoYXJkd2FyZSB0byB0ZXN0IHNsYXZlIG1vZGUuICBPciBldmVuDQptYXN0ZXIg
bW9kZSBSWCwgYXMgbXkgaGFyZHdhcmUgaXMgVFggb25seS4gIFRoZSBpbXggc3BpIGlzIGp1c3QN
CnJlY2VpdmluZyB6ZXJvcyB0byBwdXQgaW50byBhIHNwaSBjb3JlIHByb3ZpZGVkIGR1bW15IGJ1
ZmZlci4gIEkgY2FuDQpzdG9wIG92ZXJmbG93IHRoZSBidWZmZXIsIGJ1dCBJIHdvdWxkbid0IGtu
b3cgaWYgdGhlIGRhdGEgdGhhdCBpcyBpbiBpdA0KaXMgY29ycmVjdC4=
