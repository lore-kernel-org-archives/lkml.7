Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CFDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9962D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="WOeUziOu";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="SUtS/7iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfCTQxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:53:30 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:59949 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfCTQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/relaxed;
        q=dns/txt; i=@ericsson.com; t=1553100800; x=1555692800;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vqD6SuHw54AChNUFoU0bTLmF56UrkD9eCqF2O3Pt7AU=;
        b=WOeUziOuC0EiUfzeId2Focqq9eTbuZDyRNOj0424LwuIZohfLhRmbGywL+gfFtQO
        dF4hqdjR1maM0C4QlvUFieNx4IzoHzEfVj2EgXub2NJqH69D9jD4Vrz3FKIOXCjW
        sPUyB+D7wSqfAuIkskfsqqYjfXvw+4hecKPnfyZRuxI=;
X-AuditID: c1b4fb2d-2198b9e00000062f-b1-5c92700066f4
Received: from ESESSMB501.ericsson.se (Unknown_Domain [153.88.183.119])
        by sessmg23.ericsson.net (Symantec Mail Security) with SMTP id 15.D4.01583.000729C5; Wed, 20 Mar 2019 17:53:20 +0100 (CET)
Received: from ESESBMB501.ericsson.se (153.88.183.168) by
 ESESSMB501.ericsson.se (153.88.183.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 20 Mar 2019 17:53:10 +0100
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESBMB501.ericsson.se (153.88.183.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5 via Frontend Transport; Wed, 20 Mar 2019 17:53:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqD6SuHw54AChNUFoU0bTLmF56UrkD9eCqF2O3Pt7AU=;
 b=SUtS/7iBV3S2a+5vob3jXvwjlWueqaCKb9BLpwrL2TpjRnrFWWeokRMtyKRT7IK2pmlHBJGi65BnG+cRw2ydD/gOIqIz5XbQvfV/wGRryzjzaS6pknhOgW25nzBM35Tu2ekrgqSr+IkeJhb8TP70yKXyfu3iwS9ZQakBOS2hyfs=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB2017.namprd15.prod.outlook.com (52.132.21.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 16:53:07 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 16:53:07 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Subject: RE: general protection fault in fib6_purge_rt
Thread-Topic: general protection fault in fib6_purge_rt
Thread-Index: AQHU3Vwdjz3ygVPNV0SvlVexcwldMqYUrNfQgAAP14CAAALk8A==
Date:   Wed, 20 Mar 2019 16:53:07 +0000
Message-ID: <BL0PR1501MB200362E55B2A1570CF9909529A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <000000000000dbe73a057cd65da2@google.com>
 <00000000000010f4270584595484@google.com>
 <BL0PR1501MB20039998B662DCC11E2B38D79A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
 <CACT4Y+anbSEh89LaFeT2Bi4qVM1Maf_0x11ynrfCk9PNvg9UXw@mail.gmail.com>
In-Reply-To: <CACT4Y+anbSEh89LaFeT2Bi4qVM1Maf_0x11ynrfCk9PNvg9UXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 324a4a29-ebec-4ac4-537d-08d6ad54873f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2017;
x-ms-traffictypediagnostic: BL0PR1501MB2017:
x-ms-exchange-purlcount: 9
x-microsoft-antispam-prvs: <BL0PR1501MB2017C228F02AEB4C1CFD438F9A410@BL0PR1501MB2017.namprd15.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(13464003)(102836004)(186003)(53546011)(305945005)(7736002)(3846002)(76176011)(6116002)(99286004)(7696005)(68736007)(97736004)(6506007)(25786009)(11346002)(6916009)(476003)(486006)(74316002)(66066001)(44832011)(45080400002)(26005)(106356001)(53936002)(478600001)(14454004)(6306002)(81166006)(86362001)(966005)(2906002)(105586002)(33656002)(81156014)(8676002)(256004)(55016002)(54906003)(446003)(4326008)(6246003)(316002)(71200400001)(93886005)(14444005)(5660300002)(71190400001)(6436002)(52536014)(229853002)(8936002)(9686003)(7416002)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB2017;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Iun3H/rcb/Si6ZDSH7wH80L86pPJ3EGtGmoH66ZBaWjafi4eRKhD1CC7eWaBFnwSqKCxxk9EAqwnLaHR7aDEtRpAqWkUcIxJ1y9Rn4uaV7ZRz1PE6Nmt5KYjhyY/Q/WD2pypdt7XF7GXIm5EIxPpliBY58+/aqvSXZO5uLvKp4LNb0mXMK6490VQMjzZBbFAvjUWSzHLdLVCQKhg4GcwTZQthYMp/ev1i9KvR3CbNNe/DIX1BVD25LWfhX0SEIbSD9SZCVBJGSV6DoWTL9TANmCosYOUVNMxIJOA5RDNy7nsgtwny0Q35jg3pMWuiW+GlkmYSWmdzyqA/Q5pGNYljUQz0Gfj3/KIq+gK+Y09TgXhWGwf/ZxVrWNzoYH3Cvb+5T42X8Y170deGnKaL5vIvuD4csQ/2kj16rQQqBhTm5Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 324a4a29-ebec-4ac4-537d-08d6ad54873f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 16:53:07.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2017
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe+69u7ubrZ6W2slKaqSY+V7oTSyqD3GhIsMPZQxq1E1nvrW7
        yvqkUVqzF5UyphNHhZJLsnFzZm8kkc2XTKWsDGxZ1hIzWSlhaW7XoG+/c/7/8z/PgYch1R2y
        IEafbeQN2bpMDa2kzLsdxyLn5JZpY0aKEllL1ymKLXEVytkXhV9lbG+zhWafWgPZpoEeOfta
        rCJZsSuDHezrI9mfD0zURiUn3nhDcFb7Ee5+qZPmCl/VEdw9q4fgxMkJmjOPhHIeezB3S7xD
        JCv2KJMO8Jn6o7whesM+ZfoHcweZK4bk2T7V0/moaaUJKRjAa6H39FXahJSMGj9BUD3hRFIx
        juC59fOscp2A7u+vfQqFS0iocg9QklJOQGlbo1wqhhA4L/eT3mQah4G7/Azysj8OhYLhc74s
        ElsouH1hymdaiOPB1dpJSKYEqGxyzPJmqPluprxM4RCorqn1BanwPhAf2mdXTyM4f7dV7hUU
        eCdUTbtoLyMcCBNtN31BJF4Ebz9WE9KtGK7f7yIlDgD34JTMhJgZfyq0f0qV2ivA1vkISbwM
        eqqLkdcCeDv0uDK8awH3I3CcPEtJnggorrDPxgfBl2eTMolzwDP6jpZ4KVzrmiCl4VoaCq6O
        +YbVmIfa+tOoBEVW/PfUipl9JF4Ft5qjpfYKuFTsklf4zl8ATvNHyoqoOhQg8IKQlRa3Joo3
        6PcLQk52VDZvtKOZP/ZYnIxsQrbhTS0IM0gzV5WTVqZVy3RHheNZLQgYUuOv2q2ZaakO6I6f
        4A05ew1HMnmhBS1hKM0i1W/1Aq0ap+mM/CGez+UN/1SCUQTlo3UJjoTBce5K2XtzWKPHk7zN
        klxUfjJx/NrL8Kn1NuFb/aB+/YnFlu6hw8Oq9NT2hozRMbGSCR4w+TXqg0OKph944pZox/w3
        GDtvN0THy/TzUn5s/TUaUXoxJWzraJBlV1LsgLu2YcvyguAbX2NWZ86vqfzjevjE5bfDeq//
        oOJpnoYS0nWx4aRB0P0FmNSFLV8DAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IFZ5dWtvdiA8
ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiBTZW50OiAyMC1NYXItMTkgMTc6NDENCj4gVG86IEpvbiBN
YWxveSA8am9uLm1hbG95QGVyaWNzc29uLmNvbT4NCj4gQ2M6IHN5emJvdCA8c3l6Ym90K2EyNTMw
N2FkMDk5MzA5ZjFjMmI5QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20+Ow0KPiBkYXZlbUBkYXZl
bWxvZnQubmV0OyBrdXpuZXRAbXMyLmluci5hYy5ydTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHN5emthbGxlci0NCj4gYnVnc0Bnb29n
bGVncm91cHMuY29tOyB0aXBjLWRpc2N1c3Npb25AbGlzdHMuc291cmNlZm9yZ2UubmV0Ow0KPiB5
aW5nLnh1ZUB3aW5kcml2ZXIuY29tOyB5b3NoZnVqaUBsaW51eC1pcHY2Lm9yZw0KPiBTdWJqZWN0
OiBSZTogZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGluIGZpYjZfcHVyZ2VfcnQNCj4gDQo+IE9u
IFdlZCwgTWFyIDIwLCAyMDE5IGF0IDQ6NTkgUE0gSm9uIE1hbG95IDxqb24ubWFsb3lAZXJpY3Nz
b24uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgb25lIGlkZW50aWZpZXMgdGhlIHNhbWUg
Y3VscHJpdCBhcw0KPiBzeXpib3QrOWQ0YzEyYmZkNDVhNTg3MzhkMGFAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbSwgYnV0IHBvaW50cyB0byBhDQo+IGRpZmZlcmVudCBidWcuDQo+ID4gVGhhdCBi
dWcgaGFzIGFsc28gYmVlbiBmaXhlZCwgaW4gY29tbWl0IGFkYmE3NWJlMGQyMyAgKCJ0aXBjOiBm
aXggbG9ja2RlcA0KPiB3YXJuaW5nIHdoZW4gcmVpbml0aWxhaXppbmcgc29ja2V0cyIpLCBhcHBs
aWVkIGluIDQuMjAgYnV0IG5vdCBwcmVzZW50IGluIDQuMTYsIC0NCj4gdGhlIHNvdXJjZSBvZiB0
aGUgZHVtcC4NCj4gPiBPbmNlIGFnYWluLCBhIGR1bXAgZnJvbSA0LjIwLzUuMCBtaWdodCBiZSBh
IGhlbHAuDQo+IA0KPiANCj4gTG9va2luZyBhdCB0aGUgYmlzZWN0aW9uIGxvZyBtYXliZSB0aGlz
IHJlcHJvZHVjZXIgdHJpZ2dlcnMgbXVsdGlwbGUga2VybmVsDQo+IGJ1Z3MuDQoNCkkgdGhpbmsg
c28uIA0KDQo+IEFsbCBjcmFzaGVzIGluY2x1ZGluZyB0aGUgbGF0ZXN0IG9uZXMgYW5kIG90aGVy
IGluZm8gYXJlIGFsd2F5cyBhdmFpbGFibGUgb24NCj4gdGhlIGRhc2hib2FyZC4NCg0KTG9va2lu
ZyBhdCB0aGUgbGF0ZXN0IGRhc2hib2FyZCByZXBvcnRzLCBJIGRvbid0IHNlZSBhbnl0aGluZyB0
aGF0IHBvaW50cyB0byBUSVBDLiANCg0KLy8vam9uDQoNCg0KPiANCj4gDQo+ID4gLy8vam9uDQo+
ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IHN5
emJvdA0KPiA8c3l6Ym90K2EyNTMwN2FkMDk5MzA5ZjFjMmI5QHN5emthbGxlci5hcHBzcG90bWFp
bC5jb20+DQo+ID4gPiBTZW50OiAxOC1NYXItMTkgMDg6MjgNCj4gPiA+IFRvOiBkYXZlbUBkYXZl
bWxvZnQubmV0OyBKb24gTWFsb3kgPGpvbi5tYWxveUBlcmljc3Nvbi5jb20+Ow0KPiA+ID4ga3V6
bmV0QG1zMi5pbnIuYWMucnU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBzeXprYWxsZXItYnVnc0Bnb29nbGVncm91cHMuY29tOyB0
aXBjLQ0KPiA+ID4gZGlzY3Vzc2lvbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IHlpbmcueHVlQHdp
bmRyaXZlci5jb207DQo+ID4gPiB5b3NoZnVqaUBsaW51eC0gaXB2Ni5vcmcNCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQgaW4gZmliNl9wdXJnZV9ydA0KPiA+ID4N
Cj4gPiA+IHN5emJvdCBoYXMgYmlzZWN0ZWQgdGhpcyBidWcgdG86DQo+ID4gPg0KPiA+ID4gY29t
bWl0IDUyZGZhZTVjODVhNGMxMDc4ZTlmMWQ1ZTg5NDdkNGEyNWY3M2RkODENCj4gPiA+IEF1dGhv
cjogSm9uIE1hbG95IDxqb24ubWFsb3lAZXJpY3Nzb24uY29tPg0KPiA+ID4gRGF0ZTogICBUaHUg
TWFyIDIyIDE5OjQyOjUyIDIwMTggKzAwMDANCj4gPiA+DQo+ID4gPiAgICAgIHRpcGM6IG9idGFp
biBub2RlIGlkZW50aXR5IGZyb20gaW50ZXJmYWNlIGJ5IGRlZmF1bHQNCj4gPiA+DQo+ID4gPiBi
aXNlY3Rpb24gbG9nOg0KPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2Jpc2VjdC50
eHQ/eD0xMTE2ZDJhMzIwMDAwMA0KPiA+ID4gc3RhcnQgY29tbWl0OiAgIDUyZGZhZTVjIHRpcGM6
IG9idGFpbiBub2RlIGlkZW50aXR5IGZyb20gaW50ZXJmYWNlIGJ5DQo+IGRlZmEuLg0KPiA+ID4g
Z2l0IHRyZWU6ICAgICAgIGxpbnV4LW5leHQNCj4gPiA+IGZpbmFsIGNyYXNoOg0KPiBodHRwczov
L3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcG9ydC50eHQ/eD0xMzE2ZDJhMzIwMDAwMA0KPiA+
ID4gY29uc29sZSBvdXRwdXQ6DQo+ID4gPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94
L2xvZy50eHQ/eD0xNTE2ZDJhMzIwMDAwMA0KPiA+ID4ga2VybmVsIGNvbmZpZzoNCj4gPiA+IGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PWM4YjYwNzNkOTkyZTgyMTcN
Cj4gPiA+IGRhc2hib2FyZCBsaW5rOg0KPiA+ID4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPWEyNTMwN2FkMDk5MzA5ZjFjMmI5DQo+ID4gPiBzeXogcmVwcm86DQo+IGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTZiMmM1NmYyMDAwMDAN
Cj4gPiA+IEMgcmVwcm9kdWNlcjoNCj4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9y
ZXByby5jP3g9MTNiODg5MGIyMDAwMDANCj4gPiA+DQo+ID4gPiBSZXBvcnRlZC1ieTogc3l6Ym90
K2EyNTMwN2FkMDk5MzA5ZjFjMmI5QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gPiA+IEZp
eGVzOiA1MmRmYWU1YyAoInRpcGM6IG9idGFpbiBub2RlIGlkZW50aXR5IGZyb20gaW50ZXJmYWNl
IGJ5DQo+ID4gPiBkZWZhdWx0IikNCj4gPg0KPiA+IC0tDQo+ID4gWW91IHJlY2VpdmVkIHRoaXMg
bWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlDQo+IEdyb3Vw
cyAic3l6a2FsbGVyLWJ1Z3MiIGdyb3VwLg0KPiA+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBn
cm91cCBhbmQgc3RvcCByZWNlaXZpbmcgZW1haWxzIGZyb20gaXQsIHNlbmQgYW4NCj4gZW1haWwg
dG8gc3l6a2FsbGVyLWJ1Z3MrdW5zdWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbS4NCj4gPiBUbyB2
aWV3IHRoaXMgZGlzY3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0DQo+IGh0dHBzOi8vZ3JvdXBzLmdv
b2dsZS5jb20vZC9tc2dpZC9zeXprYWxsZXItDQo+IGJ1Z3MvQkwwUFIxNTAxTUIyMDAzOTk5OEI2
NjJEQ0MxMUUyQjM4RDc5QTQxMCU0MEJMMFBSMTUwMU1CMjAwDQo+IDMubmFtcHJkMTUucHJvZC5v
dXRsb29rLmNvbS4NCj4gPiBGb3IgbW9yZSBvcHRpb25zLCB2aXNpdCBodHRwczovL2dyb3Vwcy5n
b29nbGUuY29tL2Qvb3B0b3V0Lg0K
