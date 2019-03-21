Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA005C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A272075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="V4xQyThg";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="DptOHjCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfCUIx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:53:56 -0400
Received: from sessmg22.ericsson.net ([193.180.251.58]:43388 "EHLO
        sessmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfCUIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/relaxed;
        q=dns/txt; i=@ericsson.com; t=1553158426; x=1555750426;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pR7jPF6RXgEzJW7rA6E+GSH0xsfJDVfTDHNbc2YkW8k=;
        b=V4xQyThg1K0cfSDq8SJiXslAvuODZmMgHviKrx2N/neP9ijRXu5IPGppaq3xc5ov
        +Cym9QKY51cMh5o2DkvhjNrzv/6HxWpvZkqhX5y1YtFSXxpvSvrETppcg5hhsypF
        /yfwwhEZ9z5wunLNpxCAvIViD34WTmX477Qy3HoJJFM=;
X-AuditID: c1b4fb3a-5c9c29e00000672c-e2-5c93511a41e5
Received: from ESESSMB505.ericsson.se (Unknown_Domain [153.88.183.123])
        by sessmg22.ericsson.net (Symantec Mail Security) with SMTP id 7E.85.26412.A11539C5; Thu, 21 Mar 2019 09:53:46 +0100 (CET)
Received: from ESESSMB501.ericsson.se (153.88.183.162) by
 ESESSMB505.ericsson.se (153.88.183.166) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 21 Mar 2019 09:53:45 +0100
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESSMB501.ericsson.se (153.88.183.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5 via Frontend Transport; Thu, 21 Mar 2019 09:53:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR7jPF6RXgEzJW7rA6E+GSH0xsfJDVfTDHNbc2YkW8k=;
 b=DptOHjCJlmkYwlfyOMlT85OJpd4NHIYgVvn8HCmo/hq+WE/2OzutCXQzm3M00oQAtxbvqu7UHdmWlAT0/HrofkjmcQOnsP07dqQSvUJAyHnJAkgC5Q3H0sdSSstvNWawdLlIufszZoNMSmYlgL95Mgm7arMh1scNUDYbH5giciQ=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB2019.namprd15.prod.outlook.com (52.132.21.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 08:53:42 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 08:53:42 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Xin Long <lucien.xin@gmail.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>,
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
Thread-Index: AQHU3Vwdjz3ygVPNV0SvlVexcwldMqYUrNfQgAAP14CAAALk8IAAJlyAgADciqA=
Date:   Thu, 21 Mar 2019 08:53:41 +0000
Message-ID: <BL0PR1501MB2003C2ACA307A456A534DF859A420@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <000000000000dbe73a057cd65da2@google.com>
 <00000000000010f4270584595484@google.com>
 <BL0PR1501MB20039998B662DCC11E2B38D79A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
 <CACT4Y+anbSEh89LaFeT2Bi4qVM1Maf_0x11ynrfCk9PNvg9UXw@mail.gmail.com>
 <BL0PR1501MB200362E55B2A1570CF9909529A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
 <CADvbK_eHRy6jerprBd0uVmWyL9dWtkhJ2K-EWWDG88HEPP23UA@mail.gmail.com>
In-Reply-To: <CADvbK_eHRy6jerprBd0uVmWyL9dWtkhJ2K-EWWDG88HEPP23UA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [198.24.6.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a813d65-3629-45d4-05b0-08d6addab82b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2019;
x-ms-traffictypediagnostic: BL0PR1501MB2019:
x-ms-exchange-purlcount: 9
x-microsoft-antispam-prvs: <BL0PR1501MB201968E9476D6D524F070BBE9A420@BL0PR1501MB2019.namprd15.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(13464003)(256004)(44832011)(186003)(6436002)(55016002)(9686003)(6306002)(53936002)(478600001)(52536014)(3846002)(71200400001)(6116002)(26005)(476003)(71190400001)(7416002)(446003)(486006)(6916009)(966005)(229853002)(7696005)(11346002)(305945005)(76176011)(14444005)(99286004)(7736002)(53546011)(14454004)(6506007)(93886005)(74316002)(86362001)(33656002)(68736007)(8676002)(66066001)(102836004)(25786009)(97736004)(106356001)(2906002)(5660300002)(4326008)(105586002)(81156014)(81166006)(6246003)(54906003)(316002)(8936002)(45080400002)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB2019;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: biMx3Co27mDFo7/KXTDnBj9L8/R43m1Ctsk46vFRP4AU2HaznRTdvmCkJWMrPeQR+q5RdqdoPTUaXOnr82k+KV/VYds14V33xsl5GAxNB0gMxlJr4ZHW3xEbgPLwRxcJz5hQMzfX26scc25I+Nz8zzh0uXhuVHA3vSAVx1RsiltfGWGNlWJDImpUQQGMQVNsS1xkQETkec/PivbSx4Uh+3Kf0DMIV+ZjMoTadKptNVZnoZ+PgFa/+s5Uc7cadELBpu9avvezO970Tl/oS7P4D0MjsqghnpXnZS4kDnxa5p4tGDsdIRJIJdq7ExG1wTbEy0ImfgOMbT98Ii6+NnYyGVh5JhBlylSAXp0ZprGg2o0T7i3OYODyzJejHkfSxUXW5ZL/GrXY065vnMXS7Fq/Qv5TaFVpfkm9ktXo8cKTPJM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a813d65-3629-45d4-05b0-08d6addab82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 08:53:41.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2019
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85O5uz1ety9rAu1KKoyLxkdYhuFsEJKvJLdBnkyqNpOmXH
        SetCE1LCLiwUSVOU0MKyVrLyTmijvF/JuW62LFNLKjVvy9G2Y9C33/P8/8/7XHglpLxHpJTE
        apM5nVYTr6KlVM6R8vOByohMdbApNZTJa79MMSZHupjpSB8WMd1VeTTzyfyDYF4WBjAVfV1i
        pteSTzKW9jim32Yjmd+1GdQuX9ZSYifYytz3YrawTM/W3Gyk2fSe+wRbXThGsBbnJM3mjKxm
        x8qWsWbLU+KQ9Jh0WxQXH5vC6YJ2REpPV85WU0lXjp91PKgVGdG7IxnIRwI4DKYdbYSH5diK
        oGPmQgaSunkCwbMRGy0ERQQ8qXGSnoDCJhKm2h4TgpJNQKbVKhaCAQSuR+Pex2i8BoayryAP
        ++OV8H6oTeQxkbiegs60OrFHWIg3g+NVKyGYtsDtivI5PgjTRaNepvAqGG197mUZjoSWlmJK
        6JZPws+cXyKP4IMjwFabT3sY4QCYbCr1FpB4Ebz5XEAIq2IoqmknBVbAUL/LXStx+49C85ej
        Qno5NL02IoGXQlfB1Tk+AK6sUW9fwG8RGCtKxIKwHj7O2imBlTDY4BQJnAiOJ9dogZeA2X6H
        EIrv0VDaa527Nwf3HqYhEwrM/W/WXPdMJF4L5qogIb0Csq46xLne/f2gMeczVYio+0jBczyf
        EBMauoHTxZ7i+UTtBi2XXIbcv63O4txageq+htcjLEGqebI/ezLVcpEmhTck1COQkCp/Wdh2
        d0oWpTGc43SJJ3T6eI6vR4sllGqR7I/cTy3HMZpk7gzHJXG6fyoh8VEakbYypHRlSFqCerhy
        4EWa+M3SCc7g23FS4R/fY4BrMZv0bZaS4Fto/7GdCR0z+pYbA64Mhbz509mwuEP9zdzF6zsv
        VSmSnsl8xjbG2rKz5++++32we2Sw5sPedFen39TH7cuMSv2CqfCpXcXqw0Orb22dWDIevcn8
        rc9qT23YF+wXraL405qQdaSO1/wFq5Q+l2kDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWGluIExvbmcgPGx1Y2ll
bi54aW5AZ21haWwuY29tPg0KPiBTZW50OiAyMC1NYXItMTkgMjA6MDkNCj4gVG86IEpvbiBNYWxv
eSA8am9uLm1hbG95QGVyaWNzc29uLmNvbT4NCj4gQ2M6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZA
Z29vZ2xlLmNvbT47IHN5emJvdA0KPiA8c3l6Ym90K2EyNTMwN2FkMDk5MzA5ZjFjMmI5QHN5emth
bGxlci5hcHBzcG90bWFpbC5jb20+Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBrdXpuZXRAbXMy
Lmluci5hYy5ydTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IHN5emthbGxlci0NCj4gYnVnc0Bnb29nbGVncm91cHMuY29tOyB0aXBjLWRp
c2N1c3Npb25AbGlzdHMuc291cmNlZm9yZ2UubmV0Ow0KPiB5aW5nLnh1ZUB3aW5kcml2ZXIuY29t
OyB5b3NoZnVqaUBsaW51eC1pcHY2Lm9yZw0KPiBTdWJqZWN0OiBSZTogZ2VuZXJhbCBwcm90ZWN0
aW9uIGZhdWx0IGluIGZpYjZfcHVyZ2VfcnQNCj4gDQo+IE9uIFRodSwgTWFyIDIxLCAyMDE5IGF0
IDEyOjU0IEFNIEpvbiBNYWxveSA8am9uLm1hbG95QGVyaWNzc29uLmNvbT4NCj4gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiA+ID4gU2VudDogMjAtTWFy
LTE5IDE3OjQxDQo+ID4gPiBUbzogSm9uIE1hbG95IDxqb24ubWFsb3lAZXJpY3Nzb24uY29tPg0K
PiA+ID4gQ2M6IHN5emJvdCA8c3l6Ym90K2EyNTMwN2FkMDk5MzA5ZjFjMmI5QHN5emthbGxlci5h
cHBzcG90bWFpbC5jb20+Ow0KPiA+ID4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3V6bmV0QG1zMi5p
bnIuYWMucnU7IGxpbnV4LQ0KPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgc3l6a2FsbGVyLQ0KPiA+ID4gYnVnc0Bnb29nbGVncm91cHMuY29tOyB0
aXBjLWRpc2N1c3Npb25AbGlzdHMuc291cmNlZm9yZ2UubmV0Ow0KPiA+ID4geWluZy54dWVAd2lu
ZHJpdmVyLmNvbTsgeW9zaGZ1amlAbGludXgtaXB2Ni5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBn
ZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQgaW4gZmliNl9wdXJnZV9ydA0KPiA+ID4NCj4gPiA+IE9u
IFdlZCwgTWFyIDIwLCAyMDE5IGF0IDQ6NTkgUE0gSm9uIE1hbG95IDxqb24ubWFsb3lAZXJpY3Nz
b24uY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgb25lIGlkZW50aWZp
ZXMgdGhlIHNhbWUgY3VscHJpdCBhcw0KPiA+ID4gc3l6Ym90KzlkNGMxMmJmZDQ1YTU4NzM4ZDBh
QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20sIGJ1dCBwb2ludHMgdG8NCj4gPiA+IHN5emJvdCth
DQo+ID4gPiBkaWZmZXJlbnQgYnVnLg0KPiA+ID4gPiBUaGF0IGJ1ZyBoYXMgYWxzbyBiZWVuIGZp
eGVkLCBpbiBjb21taXQgYWRiYTc1YmUwZDIzICAoInRpcGM6IGZpeA0KPiA+ID4gPiBsb2NrZGVw
DQo+ID4gPiB3YXJuaW5nIHdoZW4gcmVpbml0aWxhaXppbmcgc29ja2V0cyIpLCBhcHBsaWVkIGlu
IDQuMjAgYnV0IG5vdA0KPiA+ID4gcHJlc2VudCBpbiA0LjE2LCAtIHRoZSBzb3VyY2Ugb2YgdGhl
IGR1bXAuDQo+ID4gPiA+IE9uY2UgYWdhaW4sIGEgZHVtcCBmcm9tIDQuMjAvNS4wIG1pZ2h0IGJl
IGEgaGVscC4NCj4gSGksIEpvbiwNCj4gDQo+IEkgd2FzIHJ1bm5pbmcgdGhlIHJlcHJvZHVjZXIg
YWdhaW5zdCB0aGUgbmV0LmdpdCBrZXJuZWwgd2hpY2ggaW5jbHVkZXMNCj4gY29tbWl0IGFkYmE3
NWJlMGQyMy4NCj4gDQo+IEFub3RoZXIgcGFuaWMgc2hvd2VkIHVwOg0KPiANCj4gWyAgMTU2LjA4
NjQ4N10NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KPiA9PT09PT09PQ0KPiBbICAxNTYuMDg4MjI4XSBCVUc6IEtBU0FOOiB1c2Ut
YWZ0ZXItZnJlZSBpbg0KPiB0aXBjX2Rpc2NfdGltZW91dCsweDljOS8weGIyMCBbdGlwY10NCj4g
WyAgMTU2LjA4OTc0MF0gUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZmODg4MDJmZGIxYmU4IGJ5
IHRhc2sgc3dhcHBlci8xLzAgWw0KPiAxNTYuMDkxMTIwXSBbICAxNTYuMDkxNDcxXSBDUFU6IDEg
UElEOiAwIENvbW06IHN3YXBwZXIvMSBOb3QgdGFpbnRlZA0KPiA1LjAuMC50ZXN0LnN5eiAjMjU3
IFsgIDE1Ni4wOTI4NzNdIEhhcmR3YXJlIG5hbWU6IFJlZCBIYXQgS1ZNLCBCSU9TDQo+IHNlYWJp
b3MtMS43LjUtOC5lbDcgMDQvMDEvMjAxNCBbICAxNTYuMDk0MzE1XSBDYWxsIFRyYWNlOg0KPiBb
ICAxNTYuMDk0ODQ0XSAgPElSUT4NCj4gWyAgMTU2LjA5NTMwNl0gIGR1bXBfc3RhY2srMHg3Yy8w
eGMwDQo+IFsgIDE1Ni4wOTYwNDBdICA/IHRpcGNfZGlzY190aW1lb3V0KzB4OWM5LzB4YjIwIFt0
aXBjXSBbICAxNTYuMDk3MzQ2XQ0KPiBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uKzB4NjUvMHgy
MmUNCj4gWyAgMTU2LjA5ODM2MF0gID8gdGlwY19kaXNjX3RpbWVvdXQrMHg5YzkvMHhiMjAgW3Rp
cGNdIFsgIDE1Ni4wOTk0MDhdICA/DQo+IHRpcGNfZGlzY190aW1lb3V0KzB4OWM5LzB4YjIwIFt0
aXBjXSBbICAxNTYuMTAwNDQ1XQ0KPiBrYXNhbl9yZXBvcnQuY29sZC4zKzB4MzcvMHg3YSBbICAx
NTYuMTAxMzQ4XSAgPw0KPiB0aXBjX2Rpc2NfdGltZW91dCsweDljOS8weGIyMCBbdGlwY10gWyAg
MTU2LjEwMjQwMl0NCj4gdGlwY19kaXNjX3RpbWVvdXQrMHg5YzkvMHhiMjAgW3RpcGNdIFsgIDE1
Ni4xMDM2NDFdICA/DQo+IHRpcGNfZGlzY19tc2dfeG1pdC5pc3JhLjE5KzB4MTgwLzB4MTgwIFt0
aXBjXSBbICAxNTYuMTA0ODMwXSAgPw0KPiBfX2xvY2tfaXNfaGVsZCsweGI0LzB4MTQwIFsgIDE1
Ni4xMDU2NjldICA/IGNhbGxfdGltZXJfZm4rMHhkMS8weDYxMCBbDQo+IDE1Ni4xMDY1MTddICBj
YWxsX3RpbWVyX2ZuKzB4MTlhLzB4NjEwIFsgIDE1Ni4xMDczNDJdICA/DQo+IHRpcGNfZGlzY19t
c2dfeG1pdC5pc3JhLjE5KzB4MTgwLzB4MTgwIFt0aXBjXSBbICAxNTYuMTA4NTM4XSAgPw0KPiB0
aW1lcl9maXh1cF9pbml0KzB4MzAvMHgzMCBbICAxNTYuMTA5NDExXSAgPw0KPiBfcmF3X3NwaW5f
dW5sb2NrX2lycSsweDI5LzB4NDAgWyAgMTU2LjExMDM0M10gID8NCj4gdGlwY19kaXNjX21zZ194
bWl0LmlzcmEuMTkrMHgxODAvMHgxODAgW3RpcGNdIFsgIDE1Ni4xMTE1NDVdICA/DQo+IHRpcGNf
ZGlzY19tc2dfeG1pdC5pc3JhLjE5KzB4MTgwLzB4MTgwIFt0aXBjXSBbICAxNTYuMTEyNzQ5XQ0K
PiBydW5fdGltZXJfc29mdGlycSsweGI1MS8weDEwOTAgWyAgMTU2LjExMzY1Nl0gID8gYWRkX3Rp
bWVyKzB4OGQwLzB4OGQwIFsNCj4gMTU2LjExNDQzM10gID8ga3ZtX3NjaGVkX2Nsb2NrX3JlYWQr
MHgxNC8weDMwIFsgIDE1Ni4xMTUzNTVdICA/DQo+IHNjaGVkX2Nsb2NrKzB4NS8weDEwIFsgIDE1
Ni4xMTYxMjRdICBfX2RvX3NvZnRpcnErMHgyMzYvMHhhMWMgWw0KPiAxNTYuMTE2OTQzXSAgaXJx
X2V4aXQrMHgyODEvMHgyZDAgWyAgMTU2LjExNzY1N10NCj4gc21wX2FwaWNfdGltZXJfaW50ZXJy
dXB0KzB4MTcyLzB4NWQwDQo+IFsgIDE1Ni4xMTg2NThdICBhcGljX3RpbWVyX2ludGVycnVwdCsw
eGYvMHgyMA0KPiANCj4gDQo+IEkgdGhpbmsgaXQncyBjYXVzZWQgYnkgdGhhdCBkLT50aW1lciB3
YXNuJ3QgZGVsZXRlZCBhZnRlciB0aGUgbmV0bnMgaGFzIGJlZW4NCj4gZGVzdHJveWVkLCBhbmQg
dGlwY19kaXNjX3RpbWVvdXQoKSBzdGlsbCB1c2VkIGQtPm5ldCB0aGF0IGhhcyBiZWVuIGZyZWVk
Lg0KPiANCj4gSSBsb29rZWQgYXQgdGhlIF9fbmV0X2V4aXQgcGF0aCwgaXQgc2hvdWxkIGhhdmUg
YmVlbiBkb25lIGJ5Og0KPiB0aXBjX2V4aXRfbmV0KCkgLT4NCj4gdGlwY19uZXRfc3RvcCgpLT4N
Cj4gdGlwY19iZWFyZXJfc3RvcCgpLT4NCj4gYmVhcmVyX2Rpc2FibGUoKS0+DQo+IHRpcGNfZGlz
Y19kZWxldGUoKS0+DQo+IGRlbF90aW1lcl9zeW5jKCZkLT50aW1lcikNCj4gDQo+IGJ1dCBiZWNh
dXNlIG9mIGlmICghc2VsZiksIGl0IHJldHVybmVkIGluIHRpcGNfbmV0X3N0b3AoKS4NCj4gDQo+
IEl0IHNlZW1zIHRvIG1lIHRoYXQgd2hldGhlciB0byBkbyB0aXBjX2JlYXJlci9ub2RlX3N0b3Ao
KSBmb3IgbmV0bnMgb3Igbm90DQo+IHNob3VsZG4ndCBkZXBlbmQgb24gdGlwY19uZXQobmV0KS0+
bm9kZV9hZGRyLg0KPiBDYW4gd2UganVzdCByZW1vdmUgdGhhdCBpZighc2VsZikgZnJvbSB0aXBj
X25ldF9zdG9wKCkgdG8gZml4IGl0Pw0KDQpUaGF0IHdvdWxkIHByb2JhYmx5IHdvcmsuIFByZXZp
b3VzIHRvIHRoZSBwcm9ibGVtYXRpYyBjb21taXQsICghc2VsZikganVzdCBtZWFudCB0aGF0IHdl
IGhhZCBuZXZlciBlbnRlcmVkDQpuZXR3b3JrIG1vZGUsIGFuZCB0aGF0IHRoZXJlIHdhcyBub3Ro
aW5nIHRvIHN0b3Agb3IgZGVsZXRlLiAgVGhhdCBjaGFuZ2VkIHdoZW4gdGhpcyBwYXRjaCBpbnRy
b2R1Y2VkDQp0aGUgYWRkcmVzcyBuZWdvdGlhdGlvbiBwZXJpb2QuIFNvLCBpZiBzb21lYm9keSBs
ZWF2ZXMgbmV0d29yayBtb2RlIGJlZm9yZSB0aGUgaGFzaCBhZGRyZXNzIGhhcyBiZWVuIHNldCwg
dGhpcyB3aWxsIGhhcHBlbi4NCg0KTXkgY29uY2VybiBpcyB0aGF0IHdlIG1pZ2h0IHJ1biBpbnRv
IHN1cnByaXNlcyB3aGVuIHdlIGNvbnRpbnVlIGludG8gdGhlIGxhdGVyIGZ1bmN0aW9ucywgc3Vj
aCBhcyB0aXBjX2JlYXJlcl9zdG9wKCksIHNvIEkgd291bGQgcHJlZmVyIHRvIGF2b2lkIHRoYXQu
DQpUaGUgc2FmZXIgYXBwcm9hY2ggd291bGQgYmUgdG8gbm93IGluc3RlYWQgdGVzdCBmb3IgIGlm
ICghdGlwY19vd25faWQobmV0KSksIHdoaWNoIG5vdyBzZXJ2ZXMgYXMgYSBzYWZlIGluZGljYXRv
ciBpZiB3ZSBoYXZlIGVudGVyZWQgbmV0d29yayBub2RlIG9yIG5vdC4NCg0KPiBhbmQgYWxzbyBz
ZWVtcyB0aXBjX25hbWV0Ymxfc3RvcCgpIHdpbGwgZG8gdGhlIGNsZWFuIGpvYiBmb3IgbmFtZXRi
bCwgc2hvdWxkDQo+IHRpcGNfbmFtZXRibF93aXRoZHJhdygpIGFsc28gYmUgcmVtb3ZlZCBmcm9t
IHRpcGNfbmV0X3N0b3AoKT8NCg0KWWVzLiBUaGlzIGxvb2tzIGxpa2UgbGVnYWN5IGZyb20gdGhl
IHByZXZpb3VzIGltcGxlbWVudGF0aW9uLg0KDQovLy9qb24NCg0KPiANCj4gZGlmZiAtLWdpdCBh
L25ldC90aXBjL25ldC5jIGIvbmV0L3RpcGMvbmV0LmMgaW5kZXggZjA3NmVkYi4uMzY0Nzk4NCAx
MDA2NDQNCj4gLS0tIGEvbmV0L3RpcGMvbmV0LmMNCj4gKysrIGIvbmV0L3RpcGMvbmV0LmMNCj4g
QEAgLTE2MywxMiArMTYzLDYgQEAgdm9pZCB0aXBjX3NjaGVkX25ldF9maW5hbGl6ZShzdHJ1Y3Qg
bmV0ICpuZXQsIHUzMg0KPiBhZGRyKQ0KPiANCj4gIHZvaWQgdGlwY19uZXRfc3RvcChzdHJ1Y3Qg
bmV0ICpuZXQpDQo+ICB7DQo+IC0gICAgICAgdTMyIHNlbGYgPSB0aXBjX293bl9hZGRyKG5ldCk7
DQo+IC0NCj4gLSAgICAgICBpZiAoIXNlbGYpDQo+IC0gICAgICAgICAgICAgICByZXR1cm47DQo+
IC0NCj4gLSAgICAgICB0aXBjX25hbWV0Ymxfd2l0aGRyYXcobmV0LCBUSVBDX0NGR19TUlYsIHNl
bGYsIHNlbGYsIHNlbGYpOw0KPiAgICAgICAgIHJ0bmxfbG9jaygpOw0KPiAgICAgICAgIHRpcGNf
YmVhcmVyX3N0b3AobmV0KTsNCj4gICAgICAgICB0aXBjX25vZGVfc3RvcChuZXQpOw0KPiANCj4g
PiA+DQo+ID4gPg0KPiA+ID4gTG9va2luZyBhdCB0aGUgYmlzZWN0aW9uIGxvZyBtYXliZSB0aGlz
IHJlcHJvZHVjZXIgdHJpZ2dlcnMgbXVsdGlwbGUNCj4gPiA+IGtlcm5lbCBidWdzLg0KPiA+DQo+
ID4gSSB0aGluayBzby4NCj4gPg0KPiA+ID4gQWxsIGNyYXNoZXMgaW5jbHVkaW5nIHRoZSBsYXRl
c3Qgb25lcyBhbmQgb3RoZXIgaW5mbyBhcmUgYWx3YXlzDQo+ID4gPiBhdmFpbGFibGUgb24gdGhl
IGRhc2hib2FyZC4NCj4gPg0KPiA+IExvb2tpbmcgYXQgdGhlIGxhdGVzdCBkYXNoYm9hcmQgcmVw
b3J0cywgSSBkb24ndCBzZWUgYW55dGhpbmcgdGhhdCBwb2ludHMgdG8NCj4gVElQQy4NCj4gPg0K
PiA+IC8vL2pvbg0KPiA+DQo+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gPiAvLy9qb24NCj4gPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiA+IEZyb206IHN5emJvdA0KPiA+ID4gPHN5emJvdCthMjUzMDdhZDA5OTMwOWYxYzJiOUBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IDE4LU1hci0xOSAwODoyOA0K
PiA+ID4gPiA+IFRvOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBKb24gTWFsb3kgPGpvbi5tYWxveUBl
cmljc3Nvbi5jb20+Ow0KPiA+ID4gPiA+IGt1em5ldEBtczIuaW5yLmFjLnJ1OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHN5
emthbGxlci1idWdzQGdvb2dsZWdyb3Vwcy5jb207IHRpcGMtDQo+ID4gPiA+ID4gZGlzY3Vzc2lv
bkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IHlpbmcueHVlQHdpbmRyaXZlci5jb207DQo+ID4gPiA+
ID4geW9zaGZ1amlAbGludXgtIGlwdjYub3JnDQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IGdlbmVy
YWwgcHJvdGVjdGlvbiBmYXVsdCBpbiBmaWI2X3B1cmdlX3J0DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBzeXpib3QgaGFzIGJpc2VjdGVkIHRoaXMgYnVnIHRvOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
Y29tbWl0IDUyZGZhZTVjODVhNGMxMDc4ZTlmMWQ1ZTg5NDdkNGEyNWY3M2RkODENCj4gPiA+ID4g
PiBBdXRob3I6IEpvbiBNYWxveSA8am9uLm1hbG95QGVyaWNzc29uLmNvbT4NCj4gPiA+ID4gPiBE
YXRlOiAgIFRodSBNYXIgMjIgMTk6NDI6NTIgMjAxOCArMDAwMA0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gICAgICB0aXBjOiBvYnRhaW4gbm9kZSBpZGVudGl0eSBmcm9tIGludGVyZmFjZSBieSBkZWZh
dWx0DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBiaXNlY3Rpb24gbG9nOg0KPiA+ID4gaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20veC9iaXNlY3QudHh0P3g9MTExNmQyYTMyMDAwMDANCj4gPiA+
ID4gPiBzdGFydCBjb21taXQ6ICAgNTJkZmFlNWMgdGlwYzogb2J0YWluIG5vZGUgaWRlbnRpdHkg
ZnJvbSBpbnRlcmZhY2UgYnkNCj4gPiA+IGRlZmEuLg0KPiA+ID4gPiA+IGdpdCB0cmVlOiAgICAg
ICBsaW51eC1uZXh0DQo+ID4gPiA+ID4gZmluYWwgY3Jhc2g6DQo+ID4gPiBodHRwczovL3N5emth
bGxlci5hcHBzcG90LmNvbS94L3JlcG9ydC50eHQ/eD0xMzE2ZDJhMzIwMDAwMA0KPiA+ID4gPiA+
IGNvbnNvbGUgb3V0cHV0Og0KPiA+ID4gPiA+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29t
L3gvbG9nLnR4dD94PTE1MTZkMmEzMjAwMDAwDQo+ID4gPiA+ID4ga2VybmVsIGNvbmZpZzoNCj4g
PiA+ID4gPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD1jOGI2MDcz
ZDk5MmU4MjE3DQo+ID4gPiA+ID4gZGFzaGJvYXJkIGxpbms6DQo+ID4gPiA+ID4gaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWEyNTMwN2FkMDk5MzA5ZjFjMmI5DQo+ID4g
PiA+ID4gc3l6IHJlcHJvOg0KPiA+ID4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9y
ZXByby5zeXo/eD0xNmIyYzU2ZjIwMDAwMA0KPiA+ID4gPiA+IEMgcmVwcm9kdWNlcjoNCj4gPiA+
IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uYz94PTEzYjg4OTBiMjAwMDAw
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBSZXBvcnRlZC1ieToNCj4gPiA+ID4gPiBzeXpib3QrYTI1
MzA3YWQwOTkzMDlmMWMyYjlAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiA+ID4gPiA+IEZp
eGVzOiA1MmRmYWU1YyAoInRpcGM6IG9idGFpbiBub2RlIGlkZW50aXR5IGZyb20gaW50ZXJmYWNl
IGJ5DQo+ID4gPiA+ID4gZGVmYXVsdCIpDQo+ID4gPiA+DQo+ID4gPiA+IC0tDQo+ID4gPiA+IFlv
dSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgYmVjYXVzZSB5b3UgYXJlIHN1YnNjcmliZWQgdG8gdGhl
IEdvb2dsZQ0KPiA+ID4gR3JvdXBzICJzeXprYWxsZXItYnVncyIgZ3JvdXAuDQo+ID4gPiA+IFRv
IHVuc3Vic2NyaWJlIGZyb20gdGhpcyBncm91cCBhbmQgc3RvcCByZWNlaXZpbmcgZW1haWxzIGZy
b20gaXQsDQo+ID4gPiA+IHNlbmQgYW4NCj4gPiA+IGVtYWlsIHRvIHN5emthbGxlci1idWdzK3Vu
c3Vic2NyaWJlQGdvb2dsZWdyb3Vwcy5jb20uDQo+ID4gPiA+IFRvIHZpZXcgdGhpcyBkaXNjdXNz
aW9uIG9uIHRoZSB3ZWIgdmlzaXQNCj4gPiA+IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9t
c2dpZC9zeXprYWxsZXItDQo+ID4gPg0KPiBidWdzL0JMMFBSMTUwMU1CMjAwMzk5OThCNjYyREND
MTFFMkIzOEQ3OUE0MTAlNDBCTDBQUjE1MDFNQjIwMA0KPiA+ID4gMy5uYW1wcmQxNS5wcm9kLm91
dGxvb2suY29tLg0KPiA+ID4gPiBGb3IgbW9yZSBvcHRpb25zLCB2aXNpdCBodHRwczovL2dyb3Vw
cy5nb29nbGUuY29tL2Qvb3B0b3V0Lg0K
