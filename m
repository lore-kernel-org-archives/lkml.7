Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB9BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C114F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DvYdzC+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfCFAor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:44:47 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:5536
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbfCFAoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpcL+tADT6AO1opyay0FNqZn1e/2JCgbgkX652QdOC8=;
 b=DvYdzC+aIkV0UvOdhzUblJQxxeqrL/VYTAQb2ZSOyYixLti+puS+L4veMHRMxOJ5lu798fJn+hPyVu6EVZ0saBKsRMdww9Zto1DykztCPjssVUWPgiwiNUWmZcD33W1Zw3Tum1NugE/56v/WOX9SZm4dOv8kpuqdgmFSSAXZ03A=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2605.eurprd05.prod.outlook.com (10.168.137.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 00:44:39 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 00:44:39 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Index: AQHUz/D0zHEkReNVsEa2RSWOI/Q4NKX3M+0AgAOlj4CAAW4QgIABFdqggABLTwCAAAI9cIAADqcQgAAOtWA=
Date:   Wed, 6 Mar 2019 00:44:39 +0000
Message-ID: <VI1PR0501MB227137E2040C23E255DAC4F3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <20190301120358.7970f0ad@cakuba.netronome.com>
 <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
 <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2600:387:a:19::94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3517450-7ae2-4f15-7c4e-08d6a1ccea32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2605;
x-ms-traffictypediagnostic: VI1PR0501MB2605:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjI2MDU7MjM6TlY2V2FaWFgyUEZMK2FwWjY5Wlp6S3d0?=
 =?utf-8?B?a2NSdmF2U0diODFaNFJCR3paTkZSYXV1dGhmbWRMamlEdkZOMXlFRmVGR1B5?=
 =?utf-8?B?cFVQOUVsUDNreFhpa2JHQi9sNFFrNHA4WG1mL0NSUFpqTVZJV2NJQi9pN2pm?=
 =?utf-8?B?VDlNdXBEdm5rQUZUbE1xOXhMQlRQc2tKNzlTdUVXUjU1MVdGdTBkNkYyWkhi?=
 =?utf-8?B?NWlUWVpxcHBIZTFCQlBIS3V0WHVneUpBS3B3NEFPTFhOTENzR0xEVnBhSGZV?=
 =?utf-8?B?Sk9MSUVqL3B1RVg5YXhnYzRsTk9oLzk3VGppVUcyMDg5dzhLY0Q1MnFCdWJi?=
 =?utf-8?B?bnFxNXNiWUNlZFdpK0pzMkxyTGJuN2pMWWlLeC94b3FZT2JieVc2VlpJQjNm?=
 =?utf-8?B?eW1seXpNRWV1REV2ZkNsSFptTnNIbWJQNTBCTnMxbThrRGpmYWNlVzY0UGN6?=
 =?utf-8?B?VlE0eU1PcXVFTU9qblk4UVZQUXA0bjZqaW8vS2JNYmRJQnhlUXo1Sy9WYjBS?=
 =?utf-8?B?R0NaQUh2NGQ0VXp0amdlZFBKcCtBOE1FclRvL2ZXYXI2Q1hRcFM2NFk5YWt0?=
 =?utf-8?B?dGRTUDdOb21mckx2aEVzYUcvMHdpM0VHYUdBNHJWR3JyNkljR3l5ay9TRDZV?=
 =?utf-8?B?UWNVSGFJYzhsMXBuYnkxSGNWSkhRWjNlaDFLdE4yVmd3VmVVcXQ2d0ZTdksw?=
 =?utf-8?B?UEgzaW91VUIvblBabEhOaGVnVjRQdzh6elA0NkdhOG10Q3ZWWFExL0xQcGtl?=
 =?utf-8?B?QTdjL2U1SmRwZnpiK2hZZUY5MC9zRzV2K0RDMDNMaU5FR2hOQkxSVkR5RzBJ?=
 =?utf-8?B?cFNPUXBaNC9EdEIwTllqdVdmNlJoTHJzd3VqVFJ6OTVFTkZseVAvU3ZsRHJ6?=
 =?utf-8?B?UklJZks5RG5lV0lnS1kyb3lXZGlBSDlhbVBISGliRDZoaW5KV2FjUG42UHp3?=
 =?utf-8?B?aEU0c2pQejZrODR1NGF5TDlOMXoyYVdNYVMzbjd5ajNoRFViK2NqMUdDbGYz?=
 =?utf-8?B?c0wwQjJPRDdkMG42MWhwUUI1WEptTzkrZnpkRVhZOEg1WHk5cDR3U3ZvclNk?=
 =?utf-8?B?VnJ3U01KVWF3UTI4REdURUhaTVpNSTMvQm5pZ3M5ODhYdEJnSlFHOFI0MUE4?=
 =?utf-8?B?UzJBclJRNVV2dzZTaXNIZEd5VDRoalhOODFNc21BTEhCM0hVRUFZdDhxVnhR?=
 =?utf-8?B?aFU2Ty9DaHJuc0kzRFZjaGY4RjdIOHBSeUlQbDdhOWxYeloyZ3hKZzdneHhP?=
 =?utf-8?B?MzJhYzlQRmwzTjJWdm9ZVFZVRkRBQkJiZm90ay9YcXdYcnlCVHNUSVVmdTRV?=
 =?utf-8?B?Umpab1N6dU9pVnZkMTM3U1BobmFwZDRDWUowaThnV2pyc1RGeGdIRCtBelpt?=
 =?utf-8?B?eXlhUk5vbWQ5Y01NKzlGRG9udHlTUlc5anEzV2JJL1QrWjZVcmFFa2llL3NT?=
 =?utf-8?B?aENzWllBam1kOExYTjBCOVhPWm9NNXZrZWUzbGxORzh2Mi9rRzZidjlYdEYw?=
 =?utf-8?B?ZXduR2haY1VJeHJHMHY1TzAvVGp0dkozWDlGS1FxZEYvQ3I2b1Izb21YanVu?=
 =?utf-8?B?YzEwZHowUG1OL3Q3K1kyYk1yeVBGdUlNTGVrSXArbkdtbHgyajNBMUNRaHRq?=
 =?utf-8?B?NmUrM2hwZGM5NXhKY1M4ZDRyYXA0MGU2R21ueER0OUMvUmE1RTdRVFNyd3Uw?=
 =?utf-8?B?SzRZbjhDNW1xelNOOUtORkNQYjVnU2NURGZNVzBrMTdoU1YxcDNqc0g0bWxx?=
 =?utf-8?Q?BiNePYlmSCM43RSkBSzlEbDBI3vyzaNQn+R6ULE=3D?=
x-microsoft-antispam-prvs: <VI1PR0501MB2605C38A663A2A37A078C3F2D1730@VI1PR0501MB2605.eurprd05.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(13464003)(93886005)(14444005)(256004)(71190400001)(446003)(11346002)(486006)(55016002)(6306002)(99286004)(71200400001)(6246003)(46003)(476003)(229853002)(6436002)(6116002)(33656002)(7696005)(52536013)(186003)(5660300002)(105586002)(106356001)(53936002)(102836004)(76176011)(6506007)(305945005)(53546011)(68736007)(9686003)(7736002)(966005)(2906002)(4326008)(25786009)(74316002)(86362001)(478600001)(8936002)(14454004)(54906003)(97736004)(8676002)(316002)(81156014)(107886003)(110136005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2605;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i6HYIXIAOPhXb03qj3GwfiQJ1sVWh5w2rD7y4hFtoNB/22R+BstEByZrR7V4VM2SV+4A4gRFmUSl3jL7jJpecV+c4bR/wWxJu6naZx3VXYMN2HtjXvvByTXSSRxYPDHIBPVkdBHifC7Z/sRc76h+BEIGXce7BcIRanJrgzryhb9guFCQwCLRuYVk6XCmYbk7clWm8CqynoyTTQM/mjalFgjpSMYWUwgp1IzqCH0FeMDREVKwLAtizXqJW3WVxdB6UeW2u9D0A7ts2/9e+zgssZKCkpWPF++aGv9+dMuhRr1FxKIVcGi+I2yguLYwefgDzjvTtx9L2lAxTrWt3IRNn328/VNW5XfEliKeRpfZk8VmDoY2WDOPkG0Yl27XXf5fUMjW4dJvZjW4TMbPqIWTPqdCicfTBQKglj0OinHAq8g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3517450-7ae2-4f15-7c4e-08d6a1ccea32
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 00:44:39.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywgS2lydGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
UGFyYXYgUGFuZGl0DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDUsIDIwMTkgNTo0NSBQTQ0KPiBU
bzogUGFyYXYgUGFuZGl0IDxwYXJhdkBtZWxsYW5veC5jb20+OyBLaXJ0aSBXYW5raGVkZQ0KPiA8
a3dhbmtoZWRlQG52aWRpYS5jb20+OyBKYWt1YiBLaWNpbnNraSA8amFrdWIua2ljaW5za2lAbmV0
cm9ub21lLmNvbT4NCj4gQ2M6IE9yIEdlcmxpdHogPGdlcmxpdHoub3JAZ21haWwuY29tPjsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1p
Y2hhbC5sa21sQG1hcmtvdmkubmV0OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZzsgSmlyaSBQaXJrbyA8amlyaUBtZWxsYW5veC5jb20+DQo+IFN1Ympl
Y3Q6IFJFOiBbUkZDIG5ldC1uZXh0IDAvOF0gSW50cm9kdWNpbmcgc3ViZGV2IGJ1cyBhbmQgZGV2
bGluayBleHRlbnNpb24NCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtl
cm5lbC0NCj4gPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBQYXJhdiBQYW5k
aXQNCj4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCA1LCAyMDE5IDU6MTcgUE0NCj4gPiBUbzogS2ly
dGkgV2Fua2hlZGUgPGt3YW5raGVkZUBudmlkaWEuY29tPjsgSmFrdWIgS2ljaW5za2kNCj4gPiA8
amFrdWIua2ljaW5za2lAbmV0cm9ub21lLmNvbT4NCj4gPiBDYzogT3IgR2VybGl0eiA8Z2VybGl0
ei5vckBnbWFpbC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBtaWNoYWwubGttbEBtYXJrb3ZpLm5ldDsgZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsNCj4gPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgSmlyaSBQaXJrbyA8amly
aUBtZWxsYW5veC5jb20+DQo+ID4gU3ViamVjdDogUkU6IFtSRkMgbmV0LW5leHQgMC84XSBJbnRy
b2R1Y2luZyBzdWJkZXYgYnVzIGFuZCBkZXZsaW5rDQo+ID4gZXh0ZW5zaW9uDQo+ID4NCj4gPiBI
aSBLaXJ0aSwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IEtpcnRpIFdhbmtoZWRlIDxrd2Fua2hlZGVAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFR1
ZXNkYXksIE1hcmNoIDUsIDIwMTkgNDo0MCBQTQ0KPiA+ID4gVG86IFBhcmF2IFBhbmRpdCA8cGFy
YXZAbWVsbGFub3guY29tPjsgSmFrdWIgS2ljaW5za2kNCj4gPiA+IDxqYWt1Yi5raWNpbnNraUBu
ZXRyb25vbWUuY29tPg0KPiA+ID4gQ2M6IE9yIEdlcmxpdHogPGdlcmxpdHoub3JAZ21haWwuY29t
PjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBtaWNoYWwubGttbEBtYXJrb3ZpLm5ldDsNCj4gPiA+IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBKaXJpIFBpcmtvDQo+ID4gPiA8amlyaUBt
ZWxsYW5veC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1JGQyBuZXQtbmV4dCAwLzhdIEludHJv
ZHVjaW5nIHN1YmRldiBidXMgYW5kIGRldmxpbmsNCj4gPiA+IGV4dGVuc2lvbg0KPiA+ID4NCj4g
PiA+DQo+ID4gPg0KPiA+ID4gPiBJIGFtIG5vdmljZSBhdCBtZGV2IGxldmVsIHRvby4gbWRldiBv
ciB2ZmlvIG1kZXYuDQo+ID4gPiA+IEN1cnJlbnRseSBieSBkZWZhdWx0IHdlIGJpbmQgdG8gc2Ft
ZSB2ZW5kb3IgZHJpdmVyLCBidXQgd2hlbiBpdA0KPiA+ID4gPiB3YXMNCj4gPiA+IGNyZWF0ZWQg
YXMgcGFzc3Rocm91Z2ggZGV2aWNlLCB2ZW5kb3IgZHJpdmVyIHdvbid0IGNyZWF0ZSBuZXRkZXZp
Y2UNCj4gPiA+IG9yIHJkbWEgZGV2aWNlIGZvciBpdC4NCj4gPiA+ID4gQW5kIHZmaW8vbWRldiBv
ciB3aGF0ZXZlciBtYXR1cmUgYXZhaWxhYmxlIGRyaXZlciB3b3VsZCBiaW5kIGF0DQo+ID4gPiA+
IHRoYXQNCj4gPiA+IHBvaW50Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFVzaW5nIG1kZXYgZnJh
bWV3b3JrLCBpZiB5b3Ugd2FudCB0byBwYXJ0aXRpb24gYSBwaHlzaWNhbCBkZXZpY2UNCj4gPiA+
IGludG8gbXVsdGlwbGUgbG9naWMgZGV2aWNlcywgeW91IGNhbiBiaW5kIHRob3NlIGRldmljZXMg
dG8gc2FtZQ0KPiA+ID4gdmVuZG9yIGRyaXZlciB0aHJvdWdoIHZmaW8tbWRldiwgd2hlcmUgYXMg
aWYgeW91IHdhbnQgdG8gcGFzc3Rocm91Z2gNCj4gPiA+IHRoZSBkZXZpY2UgYmluZCBpdCB0byB2
ZmlvLXBjaS4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgdGhhdCBpcw0KPiA+ID4gd2hhdCB5
b3UgYXJlDQo+ID4gbG9va2luZyBmb3IuDQo+ID4gPg0KPiA+ID4NCj4gPiBXZSBjYW5ub3QgYmlu
ZCBhIHdob2xlIFBDSSBkZXZpY2UgdG8gdmZpby1wY2ksIHJlYXNvbiBpcywgQSBnaXZlbiBQQ0kN
Cj4gPiBkZXZpY2UgaGFzIGV4aXN0aW5nIHByb3RvY29sIGRldmljZXMgb24gaXQgc3VjaCBhcyBu
ZXRkZXZzIGFuZCByZG1hIGRldi4NCj4gPiBUaGlzIGRldmljZSBpcyBwYXJ0aXRpb25lZCB3aGls
ZSB0aG9zZSBwcm90b2NvbCBkZXZpY2VzIGV4aXN0IGFuZA0KPiA+IG1seDVfY29yZSwgbWx4NV9p
YiBkcml2ZXJzIGFyZSBsb2FkZWQgb24gaXQuDQo+ID4gQW5kIHdlIGFsc28gbmVlZCB0byBjb25u
ZWN0IHRoZXNlIG9iamVjdHMgcmlnaHRseSB0byBlc3dpdGNoIGV4cG9zZWQNCj4gPiBieSBkZXZs
aW5rIGludGVyZmFjZSAobmV0L2NvcmUvZGV2bGluay5jKSB0aGF0IHN1cHBvcnRzIGVzd2l0Y2gN
Cj4gPiBiaW5kaW5nLCBoZWFsdGgsIHJlZ2lzdGVycywgcGFyYW1ldGVycywgcG9ydHMgc3VwcG9y
dC4NCj4gPiBJdCBhbHNvIHN1cHBvcnRzIGV4aXN0aW5nIFBDSSBWRnMuDQo+ID4NCj4gPiBJIGRv
buKAmXQgdGhpbmsgd2Ugd2FudCB0byByZXBsaWNhdGUgYWxsIG9mIHRoaXMgYWdhaW4gaW4gbWRl
diBzdWJzeXN0ZW0gWzFdLg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9j
L0RvY3VtZW50YXRpb24vdmZpby1tZWRpYXRlZC1kZXZpY2UudHh0DQo+ID4NCj4gPiBTbyBkZXZs
aW5rIGludGVyZmFjZSB0byBtaWdyYXRlIHVzZXJzIGZyb20gbWFuYWdpbmcgVkZzIHRvIG5vbl9W
RiBzdWINCj4gPiBkZXZpY2UgaXMgbmF0dXJhbCBwcm9ncmVzc2lvbi4NCj4gPg0KPiA+IEhvd2V2
ZXIsIGluIGZ1dHVyZSwgSSBiZWxpZXZlIHdlIHdvdWxkIGJlIGNyZWF0aW5nIG1lZGlhdGVkIGRl
dmljZXMgb24NCj4gPiB1c2VyIHJlcXVlc3QsIHRvIHVzZSBtZGV2IG1vZHVsZXMgYW5kIG1hcCB0
aGVtIHRvIFZNLg0KPiA+DQo+ID4gQWxzbyAnbWRldl9idXMnIGlzIGNyZWF0ZWQgYXMgYSBjbGFz
cyBhbmQgbm90IGFzIGEgYnVzLiBUaGlzIGxpbWl0cyB0bw0KPiA+IG5vdCB1c2UgZGV2bGluayBp
bnRlcmZhY2Ugd2hvc2UgaGFuZGxlIGlzIGJ1cytkZXZpY2UgbmFtZS4NCj4gPg0KPiA+IFNvIG9u
ZSBvcHRpb24gaXMgdG8gY2hhbmdlIG1kZXYgZnJvbSBjbGFzcyB0byBidXMuDQo+ID4gZGV2bGlu
ayB3aWxsIGNyZWF0ZSBtZGV2cyBvbiB0aGUgYnVzLCBtZGV2IGRyaXZlciBjYW4gcHJvYmUgdGhl
c2UNCj4gPiBkZXZpY2VzIG9uIGhvc3Qgc3lzdGVtIGJ5IGRlZmF1bHQuDQo+ID4gQW5kIGlmIHRv
bGQgdG8gZG8gcGFzc3Rocm91Z2gsIGEgZGlmZmVyZW50IGRyaXZlciBleHBvc2VzIHRoZW0gdG8g
Vk0uDQo+ID4gSG93IGZlYXNpYmxlIGlzIHRoaXM/DQo+ID4NCj4gV2FpdCwgSSBkbyBzZWUgYSBt
ZGV2IGJ1cyBhbmQgbWRldnMgYXJlIGNyZWF0ZWQgb24gdGhpcyBidXMgdXNpbmcNCj4gbWRldl9k
ZXZpY2VfY3JlYXRlKCkuDQo+IFNvIGhvdyBhYm91dCB3ZSBjcmVhdGUgbWRldnMgb24gdGhpcyBi
dXMgdXNpbmcgZGV2bGluaywgaW5zdGVhZCBvZiBzeXNmcz8NCj4gQW5kIGRyaXZlciBzaWRlIG9u
IGhvc3QgZ2V0cyB0aGUgbWRldl9yZWdpc3Rlcl9kcml2ZXIoKS0+cHJvYmUoKT8NCj4gDQoNClRo
aW5raW5nIG1vcmUgYW5kIHJldmlld2luZyBtb3JlIG1kZXYgY29kZSwgSSBiZWxpZXZlIG1kZXYg
Zml0cyANCnRoaXMgbmVlZCBhIGxvdCBiZXR0ZXIgdGhhbiBuZXcgc3ViZGV2IGJ1cywgbWZkLCBw
bGF0Zm9ybSBkZXZpY2UsIG9yIGRldmxpbmsgc3VicG9ydC4NCkZvciBjb21pbmcgZnV0dXJlLCB0
byBtYXAgdGhpcyBzdWIgZGV2aWNlIChtZGV2KSB0byBWTSB3aWxsIGFsc28gYmUgZWFzaWVyIGJ5
IHVzaW5nIG1kZXYgYnVzLg0KDQpJIGFsc28gYmVsaWV2ZSB3ZSBjYW4gdXNlIHRoZSBzeXNmcyBp
bnRlcmZhY2UgZm9yIG1kZXYgbGlmZSBjeWNsZS4NCkhlcmUgd2hlbiBtZGV2IGFyZSBjcmVhdGVk
IGl0IHdpbGwgcmVnaXN0ZXIgYXMgZGV2bGluayBpbnN0YW5jZSBhbmQgDQp3aWxsIGJlIGFibGUg
dG8gcXVlcnkvY29uZmlnIHBhcmFtZXRlcnMgYmVmb3JlIGRyaXZlciBwcm9iZSB0aGUgZGV2aWNl
Lg0KKGluc3RlYWQgb2YgaGF2aW5nIGxpZmUgY3ljbGUgdmlhIGRldmxpbmspDQoNCkZldyBlbmhh
bmNlbWVudHMgd291bGQgYmUgbmVlZGVkIGZvciBtZGV2IHNpZGUuDQoxLiBtYWtpbmcgaW9tbXUg
b3B0aW9uYWwuDQoyLiBjb25maWd1cmluZyBtZGV2IGRldmljZSBwYXJhbWV0ZXJzIGR1cmluZyBj
cmVhdGlvbiB0aW1lDQoNCk1vcmUgb25jZSBnZXQgbXkgaGFuZHMgZGlydHkgd2l0aCBtZGV2IGlu
IFJGQ3YyLg0KDQpXaGF0IGRvIHlvdSB0aGluaz8NCg0K
