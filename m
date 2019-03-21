Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34606218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="hKXk4oF9";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="YwA7pDph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfCUTuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:50:07 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:48785 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfCUTuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/relaxed;
        q=dns/txt; i=@ericsson.com; t=1553197799; x=1555789799;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tCqsN79S0hX+jOMxeWGWBrAFmypcQ/ldI5F4X7zHPYI=;
        b=hKXk4oF9EzoWkceAIoOsR2+01fwFIiM+6ebvOW9CpMftIWdFiLvN59NmYjNyqSPC
        z2WKhlVCcTuUvaYdKckZsRJOPTO6BpP6wS/IYIvAYmnOEUgwPg87PltmHvs73Zk+
        HTdmcChTyST7ZIL2/PWRNYaRCprM5gqgo4Z3eZdz2oI=;
X-AuditID: c1b4fb2d-fc7ff70000002218-88-5c93eae73428
Received: from ESESBMB502.ericsson.se (Unknown_Domain [153.88.183.115])
        by sessmg23.ericsson.net (Symantec Mail Security) with SMTP id D0.6F.08728.7EAE39C5; Thu, 21 Mar 2019 20:49:59 +0100 (CET)
Received: from ESESSMR505.ericsson.se (153.88.183.127) by
 ESESBMB502.ericsson.se (153.88.183.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 21 Mar 2019 20:49:59 +0100
Received: from ESESSMB502.ericsson.se (153.88.183.163) by
 ESESSMR505.ericsson.se (153.88.183.127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 21 Mar 2019 20:49:59 +0100
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESSMB502.ericsson.se (153.88.183.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5 via Frontend Transport; Thu, 21 Mar 2019 20:49:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCqsN79S0hX+jOMxeWGWBrAFmypcQ/ldI5F4X7zHPYI=;
 b=YwA7pDphy9H3e4vBw9Xhhe08HpMBM7GNEkPxKMJ46beXGW10D5DZAC+JJn6iGS3CupKdRPV2jbh7HfkXY+aVXJ1NWBuTefdhVNcCOi02XPoamOXkenSPLBuZJXLTPS9BoSBsjQu5k2UQv9YDQfJUtFDoXdM6hGj0uMH5silxPpw=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB2036.namprd15.prod.outlook.com (52.132.21.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 19:49:55 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 19:49:55 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
Thread-Topic: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
Thread-Index: AQHU1URbJbY3pMcMUU6L6QM6fD+WRaYU9eYAgAAcz4CAAPnLAIAANGKAgAAJJwCAADGYAIAAGBqA
Date:   Thu, 21 Mar 2019 19:49:55 +0000
Message-ID: <BL0PR1501MB200350D36DD72F151218894D9A420@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <20190308001723.GA11197@archlinux-ryzen>
 <20190320190752.GA28744@archlinux-ryzen>
 <CAKwvOd=6916txvLmtEC3BcZgjLTNdtU-ou=YM+_dsd8CC-T_zw@mail.gmail.com>
 <CAK8P3a2pGo8HeHS5zcFnc_jLiLkXSPWKe4AYVm4TAmZxc_h2GA@mail.gmail.com>
 <BL0PR1501MB2003762D0D1CB08622C9244F9A420@BL0PR1501MB2003.namprd15.prod.outlook.com>
 <CAK8P3a0Pq7qN-D9OsY7NWf=vQwqqSZFFXdEZ+xNckOLLCX40QA@mail.gmail.com>
 <CAK8P3a0z9sPihaCWwzJ7iEkD-tmU62=yPpHuLFH=dmkJ30Sysg@mail.gmail.com>
In-Reply-To: <CAK8P3a0z9sPihaCWwzJ7iEkD-tmU62=yPpHuLFH=dmkJ30Sysg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a38a4e3-2d0f-49f6-5f0f-08d6ae366484
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2036;
x-ms-traffictypediagnostic: BL0PR1501MB2036:
x-microsoft-antispam-prvs: <BL0PR1501MB2036D801CE6982F840512D409A420@BL0PR1501MB2036.namprd15.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(13464003)(7736002)(106356001)(305945005)(74316002)(105586002)(44832011)(71200400001)(8676002)(81166006)(71190400001)(33656002)(478600001)(229853002)(6916009)(55016002)(9686003)(2906002)(6246003)(446003)(53936002)(81156014)(11346002)(486006)(476003)(256004)(14454004)(5660300002)(68736007)(54906003)(102836004)(186003)(6436002)(26005)(6116002)(8936002)(14444005)(25786009)(97736004)(66066001)(3846002)(93886005)(86362001)(6346003)(76176011)(52536014)(4326008)(53546011)(6506007)(99286004)(7696005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB2036;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sqnWI9Ce1+AMXXmhZZcojpJVY0PVNtPQNv3SHowAnm8H9QnvasOZVTJKa8WBDpv5twbS2r/c8JqOWSCGOfcWsSd07US1SvypfXU84WCXOY51JTM5TkrdjdyswgT4QUsFh/ZIzfDdWnP0YzNfyFDOezqwTm8ZLX5jNUsRAJAdJZy5bUrPtLM/Z80spdONylq3wzAtXRNPdMuxPlJHC7nb3CfuNVFqkSL6GN6cAyWVvyHI1Dl5G7BpSGp5v2jiESlrmiLwIyAgC18E790ujuKWrrr7Mw1ro9K1WWFmI9DeVrIV5i7bXFMyZXY/48sZmQbel0GrjrZyjfo7tMdeIJBGMYqrKS67+pZTl69lwg9sMvqHhBEouRfKPG3YHXMfvLljLFhqrEsVaZWX696pZl1gzMSjnhhbOjNxKV9+mHuFOrA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a38a4e3-2d0f-49f6-5f0f-08d6ae366484
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 19:49:55.6627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2036
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85OzsbDt5WzifLykVgkZcu0PlQ0QXq9CFon8q0y9gO05wX
        dlZYH8JuzEvZbLXmFBoihKkYOi0v1bQ0L5RhhiyREq1WJhhhiq7Lzs6ivv3+z//hef9/eBlS
        7ZPFMpk5Vt6SozdraSVVfuSBkPjpiyM95U3VcvbnjR45+/5rBc1WDl6m2NdtlTQ7M21lZ+y/
        CbbHo2G9g6fYiZERcpeCW1y4gThvjZ/gWt1jcs7TeJrrKOujuXbPd4L73riKa/A2E4eYo8rt
        Rt6ceYa3JO88qczonLPm9WjyK/wBsgAFo4uRggG8Fe4/ui0vRkpGjZ8hcD7oJCXxA8Flr/uf
        KK9/S0uimoC5ZgclCgrbSRirqo04TgIKa7sj1z4iGC5bIMRnaJwAn52FSORlOB5uBT6GD5PY
        RUJ/bystGkvxfrA/biKlJQ5c87MhZkJ8FHxFSeKYwutguuk6JbIKn4TevkvhdTUeIsH3PE5k
        BdbBxOS78A7CGpjrrwtnIHEMvJ28Q0i1MVR3DJISR8PniV8yieOh9sUTJHEcDN0pifBBCNhq
        IjyKYOTWXok3QnFdPS1xLtiC3+QSr4QGfxUhdgQclEHLTwclBeXhbv0VJPZCOBUGPqTaUaL7
        v3jukEPi9dDQliyN4+FmybjcHW68BPrKJykPou6haIEXhGzT5i1JvCXTIAi5OUk5vLURhf5V
        p3cx8SGqndrdhTCDtFGqipeOdLVMf0Y4m92FgCG1y1RtaaGRyqg/e4635J6wnDbzQhdawVDa
        GFVQvSRdjU16K5/F83m85a9LMIrYApRy+KpqOCFadn7twCvjjqInik7DGuPotuOuqj3jU6vN
        CSl1qQFb1jt/QoaptPvpxTSXX6db53HuC3irx14UMOP5KtOY3Vbafs1tDLor3wtPZ3Vvbse0
        DtEzBtbw5dsF00tXi6bFp5bPmtGHqRJD3GDWfPp+07GofNSQdiBboaWEDP2mDaRF0P8BIPD0
        J1MDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmV0ZGV2LW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bmV0ZGV2LW93bmVyQHZnZXIua2VybmVsLm9yZz4NCj4gT24gQmVoYWxm
IE9mIEFybmQgQmVyZ21hbm4NCj4gU2VudDogMjEtTWFyLTE5IDE5OjIzDQo+IFRvOiBKb24gTWFs
b3kgPGpvbi5tYWxveUBlcmljc3Nvbi5jb20+DQo+IENjOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVz
YXVsbmllcnNAZ29vZ2xlLmNvbT47IE5hdGhhbiBDaGFuY2VsbG9yDQo+IDxuYXRlY2hhbmNlbGxv
ckBnbWFpbC5jb20+OyBZaW5nIFh1ZSA8eWluZy54dWVAd2luZHJpdmVyLmNvbT47IERhdmlkIFMu
DQo+IE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IHRpcGMtZGlzY3Vzc2lvbkBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQ7DQo+IE5ldHdvcmtpbmcgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBM
S01MIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGNsYW5nLWJ1aWx0LWxpbnV4
QGdvb2dsZWdyb3Vwcy5jb20NCj4gU3ViamVjdDogUmU6IC1Xc29tZXRpbWVzLXVuaW5pdGlhbGl6
ZWQgQ2xhbmcgd2FybmluZyBpbiBuZXQvdGlwYy9ub2RlLmMNCj4gDQo+IE9uIFRodSwgTWFyIDIx
LCAyMDE5IGF0IDQ6MjUgUE0gQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6DQo+
ID4NCj4gPiBPbiBUaHUsIE1hciAyMSwgMjAxOSBhdCAzOjU3IFBNIEpvbiBNYWxveSA8am9uLm1h
bG95QGVyaWNzc29uLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvbmV0L3RpcGMvbm9kZS5jIGIvbmV0L3RpcGMvbm9kZS5jIGluZGV4DQo+ID4gPiA+IDJk
YzQ5MTlhYjIzYy4uMTQ3Nzg2Nzk1ZTQ4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9uZXQvdGlwYy9u
b2RlLmMNCj4gPiA+ID4gKysrIGIvbmV0L3RpcGMvbm9kZS5jDQo+ID4gPiA+IEBAIC04NDQsNyAr
ODQ0LDggQEAgc3RhdGljIHZvaWQgdGlwY19ub2RlX2xpbmtfZG93bihzdHJ1Y3QNCj4gPiA+ID4g
dGlwY19ub2RlICpuLCBpbnQgYmVhcmVyX2lkLCBib29sIGRlbGV0ZSkNCj4gPiA+ID4gICAgICAg
ICB0aXBjX25vZGVfd3JpdGVfdW5sb2NrKG4pOw0KPiA+ID4gPiAgICAgICAgIGlmIChkZWxldGUp
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICB0aXBjX21vbl9yZW1vdmVfcGVlcihuLT5uZXQsIG4t
PmFkZHIsIG9sZF9iZWFyZXJfaWQpOw0KPiA+ID4gPiAtICAgICAgIHRpcGNfYmVhcmVyX3htaXQo
bi0+bmV0LCBiZWFyZXJfaWQsICZ4bWl0cSwgbWFkZHIpOw0KPiA+ID4gPiArICAgICAgIGlmIChz
a2JfcXVldWVfZW1wdHkoeG1pdHEpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgdGlwY19iZWFy
ZXJfeG1pdChuLT5uZXQsIGJlYXJlcl9pZCwgJnhtaXRxLA0KPiA+ID4gPiArIG1hZGRyKTsNCj4g
PiA+ID4gICAgICAgICB0aXBjX3NrX3JjdihuLT5uZXQsICZsZS0+aW5wdXRxKTsgIH0NCj4gPiA+
ID4NCj4gPiA+ID4gVGhpcyBkdXBsaWNhdGVzIHRoZSBjaGVjayBpbnNpZGUgb2Ygc2tiX3F1ZXVl
X2VtcHR5KCksIGJ1dCBJIGRvbid0DQo+ID4gPiA+IGtub3cgaWYgdGhlIGNvbXBpbGVyIGNhbiBz
ZWUgdGhyb3VnaCB0aGUgbG9naWMgYmVoaW5kIHRoZSBpbmxpbmVkDQo+IGZ1bmN0aW9uIGNhbGxz
Lg0KPiA+ID4NCj4gPiA+IFByb2JhYmx5IG5vdCwgYnV0IHRoaXMgaXMgbm90IGluIGFueSB3YXkg
dGltZSBjcml0aWNhbC4NCj4gPg0KPiA+IEkgbWVhbnQgaXQncyB1bmNsZWFyIHdoZXRoZXIgY29t
cGlsZXJzIHNob3VsZCBiZSBleHBlY3RlZCB0byBzZWUgdGhhdA0KPiA+IHNrYl9xdWV1ZV9lbXB0
eSgpIGlzIHRydWUgYWZ0ZXIgdGhlIGNhbGwgdG8gX19za2JfcXVldWVfaGVhZF9pbml0KCkNCj4g
PiBpbml0aWFsaXplcyBpdC4NCj4gDQo+IEkgcmVwcm9kdWNlZCB0aGUgd2FybmluZyBub3csIGFu
ZCB2ZXJpZmllZCB0aGF0IG15IGNoYW5nZSBlbGltaW5hdGVzIHRoZQ0KPiB3YXJuaW5nLiBJIHN0
aWxsIHRoaW5rIHRoYXQgaXMgdGhlIG1vcmUgbG9naWNhbCBzb2x1dGlvbiBoZXJlLg0KDQpPay4g
IE5vIHByb2JsZW1zIHdpdGggdGhhdC4NCg0KLy8vam9uDQoNCj4gDQo+ICAgICAgIEFybmQNCg==
