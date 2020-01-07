Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828C3C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EFA2072E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MoWNf6xH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="hxmpGODz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgAGBDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:03:17 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:53292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbgAGBDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:03:16 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9E938C04FD;
        Tue,  7 Jan 2020 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578358995; bh=tOXFYtCehtHbtLNum2aM13+ZUQIsKILrvqqeeJ8dbfo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MoWNf6xH+fvPWWtgl9ZQmUja7DsB2m9daHKAk4LHkVH1lSSBmADgsNfQfduQlAqnj
         EpQfDmTHpirOe5VDshKaPKqOAOD8I+OrKdpJg/WZck+W50xGvmBlGB8x4nMwBTBJtI
         osoZRZkA1fIZ7GtiApmYj0eNi/RwUKLBR+hPF0aNHGKluQVOgudmjWadu2xbcUGQs+
         3IUmK3P7T8EYaMlxWGMe1T5peDLHMZwNUTOCObBonE3x9IwcvBt9QrjkUDB1Wj4ZOc
         Ey4guBscd8XH5LmLiKFQG/1IvhlTqFjYKileZLO3+2tdLuzuHl3xHMNQ6vhGvxBCrH
         u8taNKFo6IHIw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 363FBA006C;
        Tue,  7 Jan 2020 01:03:13 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 6 Jan 2020 17:03:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 6 Jan 2020 17:03:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbGeuhVq6c3SWPar4/k1A/+Fq1G7uJFXMvgDS9gCgyBe2dzSI+o7t5RgNwIskmDYJ0TCbDBZnTuYi+RRD1pb+LmeevA13fj1YW4OsJS0gKdqNPJPU5Q53RFe+lSiq9veTZdIjx0BS6utpkFenMWUZX45502FKIwalVioFut2kpMAeSs8dhN1l56wm9zaW7qrF1hoeP4Wvv0fRuKe+4OdkFa0YgQoR7LC4IwLAo1BQoA5rRD4BhdFEZYaML0/fV50TAlEjGBvzYzbafHvehExOG1RIfJP8pjEF9wTSSgEf3WfwHIde9FjMMDSeIuWWlMonkRNRCn9erQIOGWG2rkaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOXFYtCehtHbtLNum2aM13+ZUQIsKILrvqqeeJ8dbfo=;
 b=N7VKypn3BKC9nCgQ+BVwY5Z997ZzpJZOnTm85PWQvQsYopa6hnl7Uzgirs1gAs9iqJ7Zbbwk55Ky7QwWVeHWN5Fb+Q9r9RrqDwQJDndke/QOgzTUxPcjF2rl1jhIL5jxhy4s/lRvZX8r2Ws/9Lif4EzDbdIuwzGXV72T1vdiCteExlVBXimEwBv8h/p7IFW9sF6TVeLiaYedRM1nzkkG04BlT+rGLRwlMhn06k9RQa32zfBf77mt2BqykaL7IJL6Vg7nSBJNYjqUI6mzakwdGwLnhV8EczwDRXYAtut9dchlBynpaFice5jfyuWh1z5OEoEqrTnYoO8dNPJBUMg00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOXFYtCehtHbtLNum2aM13+ZUQIsKILrvqqeeJ8dbfo=;
 b=hxmpGODzJAImZQWdMs3brD3kVAEXAftKkn+seHKOeRwJ5t4UvMea+XN9kIwFePB63Fln3CaeYGurWJEtOc7l/86Cb6E96EZE72HyFTC3VkRb69fUL6aRH4GxE0esri/ObuP4AmzW8POZ0CCk6qlfQ/f7UXrNmEZroo3qecn0imk=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3334.namprd12.prod.outlook.com (20.178.55.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Tue, 7 Jan 2020 01:03:11 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 01:03:11 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 3/5] ARC: handle DSP presence in HW
Thread-Topic: [PATCH 3/5] ARC: handle DSP presence in HW
Thread-Index: AQHVvOAPR1zSenMpqUm+DVM4mBlrGafecrQA
Date:   Tue, 7 Jan 2020 01:03:10 +0000
Message-ID: <6b80df9d-d0f2-d1e1-8e4b-b65531b938d9@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-4-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20191227180347.3579-4-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34e44f43-8516-4028-c8ba-08d7930d5d9a
x-ms-traffictypediagnostic: BYAPR12MB3334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3334D9B1AFA9822A6FBE4D74B63F0@BYAPR12MB3334.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(189003)(71200400001)(54906003)(8936002)(5660300002)(6486002)(107886003)(110136005)(316002)(31686004)(6512007)(2906002)(66946007)(66556008)(64756008)(66446008)(66476007)(86362001)(2616005)(31696002)(6506007)(53546011)(26005)(36756003)(81166006)(186003)(81156014)(8676002)(4326008)(478600001)(76116006)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3334;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0W2PhPnKUALjrT2KyIZgGb+dlxhJA5a9noLmomglHtbdbD2izfm5kidZvKQtZ4FWjpRbZVKWzPj4UcQ7dFX8OwuLschifR0/U1V74M8GGLSQXNY4cqbWXqr3zduKEwoAz9yBOYNVO3iMTatxTI/i4JgJdHKf8YB/9zVRURPEuU2H5HTAoaIdb91BepMfDf9KhqYuoYW9Kt+a8gaWXCxNzt0xrrxn15KBRToKt3pdBdGyeIDd5woQdIAn5aaK1a5Ds884jZLXfiPBjHoVn108tuagxUe5mDh9+By1BZ87tSz2i15ORE8NeLCMw3mrErV2yVSjEMRyTaCmycxes4ObSJD71C4yvqfv13LiFasSUJ751UuonozMSqquompITMbTMuusMvnZ3f3lO4sNHN89dgaz/B0neWcaybMO6Ukzc7Tqn2lWMkQdWN19U7ypY0pA4vGFJ4tDkqOGfTg4gxAM0Z+V7cO8bIsm8OaWRPXcDVGTw7atMJxxJXCR4SYOSSRVdhkn3VrOFtkFtdVDleZ4J75/xkaFe3ktcZTXX+Y+R49Gq76ynxwHz3sqtgKCAsTC
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F010D41A31FA149810EEB146F8ADCE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e44f43-8516-4028-c8ba-08d7930d5d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 01:03:10.8688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+8uJWjAl+plA+W7VfgD5Ldb0SO11Gd3FNigMXAMMNpsMuvz0PzTHz/uVAW6EoR6DpK7EWB7qL0mWVFCMtIcwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjcvMTkgMTA6MDMgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gSW4gY2FzZSBv
ZiBEU1AgZXh0ZW5zaW9uIHByZXNlbmNlIGluIEhXIHNvbWUgaW5zdHJ1Y3Rpb25zDQo+IChyZWxh
dGVkIHRvIGludGVnZXIgbXVsdGlwbHksIG11bHRpcGx5LWFjY3VtdWxhdGUsIGFuZCBkaXZpZGUN
Cj4gb3BlcmF0aW9uKSBleGVjdXRlcyBvbiB0aGlzIERTUCBleGVjdXRpb24gdW5pdC4gU28gdGhl
aXINCj4gZXhlY3V0aW9uIHdpbGwgZGVwZW5kIG9uIGRzcCBjb25maWd1cmF0aW9uIHJlZ2lzdGVy
IChEU1BfQ1RSTCkNCj4NCj4gQXMgd2Ugd2FudCB0aGVzZSBpbnN0cnVjdGlvbnMgdG8gZXhlY3V0
ZSB0aGUgc2FtZSB3YXkgcmVnYXJkbGVzcw0KPiBvZiBEU1AgcHJlc2VuY2Ugd2UgbmVlZCB0byBz
ZXQgRFNQX0NUUkwgcHJvcGVybHkuIEhvd2V2ZXIgdGhpcw0KPiByZWdpc3RlciBjYW4gYmUgbW9k
aWZpZWQgYnUgYW55IHVzZXJzYWNlIGFwcCB0aGVyZWZvcmUgYW55DQo+IHVzZXJzYWNlIG1heSBi
cmVhayBrZXJuZWwgZXhlY3V0aW9uLg0KPg0KPiBGaXggdGhhdCBieSBjb25maWd1cmUgRFNQX0NU
UkwgaW4gQ1BVIGVhcmx5IGNvZGUgYW5kIGluIElSUXMNCj4gZW50cmllcy4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0K
PiAtLS0NCj4gIGFyY2gvYXJjL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAyNSArKysrKysr
KysrKysrKysrLQ0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vYXJjcmVncy5oICAgICB8IDEyICsr
KysrKysrDQo+ICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9kc3AtaW1wbC5oICAgIHwgNDUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9lbnRyeS1h
cmN2Mi5oIHwgIDMgKysNCj4gIGFyY2gvYXJjL2tlcm5lbC9oZWFkLlMgICAgICAgICAgICAgfCAg
NCArKysNCj4gIGFyY2gvYXJjL2tlcm5lbC9zZXR1cC5jICAgICAgICAgICAgfCAgNCArKysNCj4g
IDYgZmlsZXMgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmgNCj4NCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJjL0tjb25maWcgYi9hcmNoL2FyYy9LY29uZmlnDQo+IGluZGV4IDgz
ODMxNTVjOGM4Mi4uYjljZDdjZTNmODc4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9LY29uZmln
DQo+ICsrKyBiL2FyY2gvYXJjL0tjb25maWcNCj4gQEAgLTQwNCwxMyArNDA0LDM2IEBAIGNvbmZp
ZyBBUkNfSEFTX0RJVl9SRU0NCj4gIAlkZWZhdWx0IHkNCj4gIA0KPiAgY29uZmlnIEFSQ19IQVNf
QUNDTF9SRUdTDQo+IC0JYm9vbCAiUmVnIFBhaXIgQUNDTDpBQ0NIIChGUFUgYW5kL29yIE1QWSA+
IDYpIg0KPiArCWJvb2wgIlJlZyBQYWlyIEFDQ0w6QUNDSCAoRlBVIGFuZC9vciBNUFkgPiA2IGFu
ZC9vciBEU1ApIg0KPiAgCWRlZmF1bHQgeQ0KPiAgCWhlbHANCj4gIAkgIERlcGVuZGluZyBvbiB0
aGUgY29uZmlndXJhdGlvbiwgQ1BVIGNhbiBjb250YWluIGFjY3VtdWxhdG9yIHJlZy1wYWlyDQo+
ICAJICAoYWxzbyByZWZlcnJlZCB0byBhcyByNTg6cjU5KS4gVGhlc2UgY2FuIGFsc28gYmUgdXNl
ZCBieSBnY2MgYXMgR1BSIHNvDQo+ICAJICBrZXJuZWwgbmVlZHMgdG8gc2F2ZS9yZXN0b3JlIHBl
ciBwcm9jZXNzDQo+ICANCj4gK2Nob2ljZQ0KPiArCXByb21wdCAiRFNQIHN1cHBvcnQiDQo+ICsJ
ZGVmYXVsdCBBUkNfTk9fRFNQDQo+ICsJaGVscA0KPiArCSAgRGVwZW5kaW5nIG9uIHRoZSBjb25m
aWd1cmF0aW9uLCBDUFUgY2FuIGNvbnRhaW4gRFNQIHJlZ2lzdGVycw0KPiArCSAgKEFDQzBfR0xP
LCBBQ0MwX0dISSwgRFNQX0JGTFkwLCBEU1BfQ1RSTCwgRFNQX0ZGVF9DVFJMKS4NCj4gKwkgIEJl
bGxvdyBpcyBvcHRpb25zIGRlc2NyaWJpbmcgaG93IHRvIGhhbmRsZSB0aGVzZSByZWdpc3RlcnMg
aW4NCj4gKwkgIGludGVycnVwdCBlbnRyeSAvIGV4aXQgYW5kIGluIGNvbnRleHQgc3dpdGNoLg0K
PiArDQo+ICtjb25maWcgQVJDX05PX0RTUA0KDQpDYW4gdGhpcyBiZSBjYWxsZWQgQVJDX0RTUF9O
T05FIGZvciBiZXR0ZXIgaW50dWl0aXZlIHJlZ2V4IHNlYXJjaGVzICENCg0KPiArCWJvb2wgIk5v
IERTUCBleHRlbnNpb24gcHJlc2VuY2UgaW4gSFciDQo+ICsJaGVscA0KPiArCSAgTm8gRFNQIGV4
dGVuc2lvbiBwcmVzZW5jZSBpbiBIVw0KPiArDQo+ICtjb25maWcgQVJDX0RTUF9LRVJORUwNCj4g
Kwlib29sICJEU1AgZXh0ZW5zaW9uIGluIEhXLCBubyBzdXBwb3J0IGZvciB1c2Vyc3BhY2UiDQo+
ICsJc2VsZWN0IEFSQ19IQVNfQUNDTF9SRUdTDQo+ICsJaGVscA0KPiArCSAgRFNQIGV4dGVuc2lv
biBwcmVzZW5jZSBpbiBIVywgbm8gc3VwcG9ydCBmb3IgRFNQLWVuYWJsZWQgdXNlcnNwYWNlDQo+
ICsJICBhcHBsaWNhdGlvbnMuIFdlIGRvbid0IHNhdmUgLyByZXN0b3JlIERTUCByZWdpc3RlcnMg
YW5kIG9ubHkgZG8NCj4gKwkgIHNvbWUgbWluaW1hbCBwcmVwYXJhdGlvbnMgc28gdXNlcnNwYWNl
IHdvbid0IGJlIGFibGUgdG8gYnJlYWsga2VybmVsDQo+ICtlbmRjaG9pY2UNCj4gKw0KPiAgY29u
ZmlnIEFSQ19JUlFfTk9fQVVUT1NBVkUNCj4gIAlib29sICJEaXNhYmxlIGhhcmR3YXJlIGF1dG9z
YXZlIHJlZ2ZpbGUgb24gaW50ZXJydXB0cyINCj4gIAlkZWZhdWx0IG4NCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJjL2luY2x1ZGUvYXNtL2FyY3JlZ3MuaCBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2Fy
Y3JlZ3MuaA0KPiBpbmRleCA1MTM0ZjBiYWYzM2MuLjAwMDRiMWU5YjMyNSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vYXJjcmVncy5oDQo+ICsrKyBiL2FyY2gvYXJjL2luY2x1
ZGUvYXNtL2FyY3JlZ3MuaA0KPiBAQCAtMTE2LDYgKzExNiwxOCBAQA0KPiAgI2RlZmluZSBBUkNf
QVVYX0RQRlBfMkggICAgICAgICAweDMwNA0KPiAgI2RlZmluZSBBUkNfQVVYX0RQRlBfU1RBVCAg
ICAgICAweDMwNQ0KPiAgDQo+ICsvKg0KPiArICogRFNQLXJlbGF0ZWQgcmVnaXN0ZXJzDQo+ICsg
Ki8NCj4gKyNkZWZpbmUgQVJDX0FVWF9EU1BfQlVJTEQJMHg3QQ0KPiArI2RlZmluZSBBUkNfQVVY
X0FDQzBfTE8JCTB4NTgwDQo+ICsjZGVmaW5lIEFSQ19BVVhfQUNDMF9HTE8JMHg1ODENCj4gKyNk
ZWZpbmUgQVJDX0FVWF9BQ0MwX0hJCQkweDU4Mg0KPiArI2RlZmluZSBBUkNfQVVYX0FDQzBfR0hJ
CTB4NTgzDQo+ICsjZGVmaW5lIEFSQ19BVVhfRFNQX0JGTFkwCTB4NTk4DQo+ICsjZGVmaW5lIEFS
Q19BVVhfRFNQX0NUUkwJMHg1OUYNCj4gKyNkZWZpbmUgQVJDX0FVWF9EU1BfRkZUX0NUUkwJMHg1
OUUNCj4gKw0KPiAgI2lmbmRlZiBfX0FTU0VNQkxZX18NCj4gIA0KPiAgI2luY2x1ZGUgPHNvYy9h
cmMvYXV4Lmg+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9pbmNsdWRlL2FzbS9kc3AtaW1wbC5o
IGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vZHNwLWltcGwuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjc4ODA5M2NiZTY4OQ0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmgNCj4gQEAgLTAsMCArMSw0NSBA
QA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KPiArLyoN
Cj4gKyAqIENvcHlyaWdodCAoQykgMjAyMCBTeW5vcHN5cywgSW5jLiAod3d3LnN5bm9wc3lzLmNv
bSkNCj4gKyAqDQo+ICsgKiBBdXRob3I6IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2
QHN5bm9wc3lzLmNvbT4NCj4gKyAqLw0KPiArI2lmbmRlZiBfX0FTTV9BUkNfRFNQX0lNUExfSA0K
PiArI2RlZmluZSBfX0FTTV9BUkNfRFNQX0lNUExfSA0KPiArDQo+ICsjZGVmaW5lIERTUF9DVFJM
X0RJU0FCTEVEX0FMTAkJMA0KPiArDQo+ICsjaWZkZWYgX19BU1NFTUJMWV9fDQo+ICsNCj4gKy8q
IGNsb2JiZXJzIHI1IHJlZ2lzdGVyICovDQo+ICsubWFjcm8gRFNQX0VBUkxZX0lOSVQNCj4gKwls
cglyNSwgW0FSQ19BVVhfRFNQX0JVSUxEXQ0KPiArCWJtc2sJcjUsIHI1LCA3DQo+ICsJYnJlcSAg
ICByNSwgMCwgMWYNCj4gKwltb3YJcjUsIERTUF9DVFJMX0RJU0FCTEVEX0FMTA0KPiArCXNyCXI1
LCBbQVJDX0FVWF9EU1BfQ1RSTF0NCj4gKzE6DQo+ICsuZW5kbQ0KPiArDQo+ICsvKiBjbG9iYmVy
cyByNTgsIHI1OSByZWdpc3RlcnMgcGFpciAqLw0KPiArLm1hY3JvIERTUF9TQVZFX1JFR0ZJTEVf
SVJRDQo+ICsjaWYgZGVmaW5lZChDT05GSUdfQVJDX0RTUF9LRVJORUwpDQo+ICsJLyogRHJvcCBh
bnkgY2hhbmdlcyB0byBEU1BfQ1RSTCBtYWRlIGJ5IHVzZXJzcGFjZSBzbyB1c2Vyc3BhY2Ugd29u
J3QgYmUNCj4gKwkgKiBhYmxlIHRvIGJyZWFrIGtlcm5lbCAqLw0KPiArCW1vdglyNTgsIERTUF9D
VFJMX0RJU0FCTEVEX0FMTA0KPiArCXNyCXI1OCwgW0FSQ19BVVhfRFNQX0NUUkxdDQoNCkluIGxv
dyBsZXZlbCBlbnRyeSBjb2RlLCB3ZSB0eXBpY2FsbHkgdXNlIHIxMC9yMTEgZm9yIHNjcmF0Y2gg
cHVycG9zZXMsIGNhbiB1IHVzZQ0KcjEwIGhlcmUgZm9yIGNvbnNpc3RlbmN5ICENCg0KPiArI2Vu
ZGlmIC8qIEFSQ19EU1BfS0VSTkVMICovDQo+ICsuZW5kbQ0KPiArDQo+ICsjZWxzZSAvKiBfX0FT
RU1CTFlfXyAqLw0KPiArDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgZHNwX2V4aXN0KHZvaWQpDQo+
ICt7DQo+ICsJc3RydWN0IGJjcl9nZW5lcmljIGJjcjsNCj4gKw0KPiArCVJFQURfQkNSKEFSQ19B
VVhfRFNQX0JVSUxELCBiY3IpOw0KPiArCXJldHVybiAhIWJjci52ZXI7DQoNCm9wZW4gY29kZSB0
aGVzZSB1c2Ugb25jZSAvIG9uZSBsaW5lcnMgaW4gdGhlIGNhbGwgc2l0ZSBpdHNlbGYuDQoNCj4g
K30NCj4gKw0KPiArI2VuZGlmIC8qIF9fQVNFTUJMWV9fICovDQo+ICsjZW5kaWYgLyogX19BU01f
QVJDX0RTUF9JTVBMX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2Vu
dHJ5LWFyY3YyLmggYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9lbnRyeS1hcmN2Mi5oDQo+IGluZGV4
IDBiOGI2M2QwYmVjMS4uZTNmOGJkM2UyZWJhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9pbmNs
dWRlL2FzbS9lbnRyeS1hcmN2Mi5oDQo+ICsrKyBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2VudHJ5
LWFyY3YyLmgNCj4gQEAgLTQsNiArNCw3IEBADQo+ICAjZGVmaW5lIF9fQVNNX0FSQ19FTlRSWV9B
UkNWMl9IDQo+ICANCj4gICNpbmNsdWRlIDxhc20vYXNtLW9mZnNldHMuaD4NCj4gKyNpbmNsdWRl
IDxhc20vZHNwLWltcGwuaD4NCj4gICNpbmNsdWRlIDxhc20vaXJxZmxhZ3MtYXJjdjIuaD4NCj4g
ICNpbmNsdWRlIDxhc20vdGhyZWFkX2luZm8uaD4JLyogRm9yIFRIUkVBRF9TSVpFICovDQo+ICAN
Cj4gQEAgLTE2NSw2ICsxNjYsOCBAQA0KPiAgCVNUMglyNTgsIHI1OSwgUFRfcjU4DQo+ICAjZW5k
aWYNCj4gIA0KPiArCS8qIGNsb2JiZXJzIHI1OCwgcjU5IHJlZ2lzdGVycyBwYWlyLCBzbyBtdXN0
IGJlIGFmdGVyIHI1OCwgcjU5IHNhdmUgKi8NCj4gKwlEU1BfU0FWRV9SRUdGSUxFX0lSUQ0KPiAg
LmVuZG0NCj4gIA0KPiAgLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cmMva2VybmVsL2hlYWQuUyBiL2FyY2gvYXJjL2tlcm5lbC9oZWFkLlMNCj4gaW5kZXggNmY0MTI2
NWY2MjUwLi42ZWIyM2YxNTQ1ZWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2tlcm5lbC9oZWFk
LlMNCj4gKysrIGIvYXJjaC9hcmMva2VybmVsL2hlYWQuUw0KPiBAQCAtMTQsNiArMTQsNyBAQA0K
PiAgI2luY2x1ZGUgPGFzbS9lbnRyeS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9hcmNyZWdzLmg+DQo+
ICAjaW5jbHVkZSA8YXNtL2NhY2hlLmg+DQo+ICsjaW5jbHVkZSA8YXNtL2RzcC1pbXBsLmg+DQo+
ICAjaW5jbHVkZSA8YXNtL2lycWZsYWdzLmg+DQo+ICANCj4gIC5tYWNybyBDUFVfRUFSTFlfU0VU
VVANCj4gQEAgLTU5LDYgKzYwLDkgQEANCj4gICNlbmRpZg0KPiAgCWtmbGFnCXI1DQo+ICAjZW5k
aWYNCj4gKwk7IENvbmZpZyBEU1BfQ1RSTCBwcm9wZXJseSwgc28ga2VybmVsIG1heSB1c2UgaW50
ZWdlciBtdWx0aXBseSwNCj4gKwk7IG11bHRpcGx5LWFjY3VtdWxhdGUsIGFuZCBkaXZpZGUgb3Bl
cmF0aW9ucw0KDQoNCg0KPiArCURTUF9FQVJMWV9JTklUDQo+ICAuZW5kbQ0KPiAgDQo+ICAJLnNl
Y3Rpb24gLmluaXQudGV4dCwgImF4IixAcHJvZ2JpdHMNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJj
L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC9hcmMva2VybmVsL3NldHVwLmMNCj4gaW5kZXggZWRiNTVi
NmVlMjc4Li5iMzk5NWRkNjczZDkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2tlcm5lbC9zZXR1
cC5jDQo+ICsrKyBiL2FyY2gvYXJjL2tlcm5lbC9zZXR1cC5jDQo+IEBAIC0yNiw2ICsyNiw3IEBA
DQo+ICAjaW5jbHVkZSA8YXNtL3Vud2luZC5oPg0KPiAgI2luY2x1ZGUgPGFzbS9tYWNoX2Rlc2Mu
aD4NCj4gICNpbmNsdWRlIDxhc20vc21wLmg+DQo+ICsjaW5jbHVkZSA8YXNtL2RzcC1pbXBsLmg+
DQo+ICANCj4gICNkZWZpbmUgRklYX1BUUih4KSAgX19hc21fXyBfX3ZvbGF0aWxlX18oIjsiIDog
IityIih4KSkNCj4gIA0KPiBAQCAtNDQ0LDYgKzQ0NSw5IEBAIHN0YXRpYyB2b2lkIGFyY19jaGtf
Y29yZV9jb25maWcodm9pZCkNCj4gIAkJLyogQWNjdW11bGF0b3IgTG93OkhpZ2ggcGFpciAocjU4
OjU5KSBwcmVzZW50IGlmIERTUCBNUFkgb3IgRlBVICovDQo+ICAJCXByZXNlbnQgPSBjcHUtPmV4
dG5fbXB5LmRzcCB8IGNwdS0+ZXh0bi5mcHVfc3AgfCBjcHUtPmV4dG4uZnB1X2RwOw0KPiAgCQlD
SEtfT1BUX1NUUklDVChDT05GSUdfQVJDX0hBU19BQ0NMX1JFR1MsIHByZXNlbnQpOw0KPiArDQo+
ICsJCXByZXNlbnQgPSBkc3BfZXhpc3QoKTsNCg0KT3BlbiBjb2RlIGFzIHN1Z2dlc3RlZCBhYm92
ZS4NCg0KPiArCQlDSEtfT1BUX1NUUklDVChDT05GSUdfQVJDX0RTUF9LRVJORUwsIHByZXNlbnQp
Ow0KPiAgCX0NCj4gIH0NCj4gIA0KDQo=
