Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YQzJDOUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGVCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:02:40 -0500
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:63234
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfCGVCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWp7bbK45OQ8sgYL4VmtpjhtJouBzx+hTMPZS8ue3yk=;
 b=YQzJDOUpAhoeBCxWlAI1z5109wJNUiZcMG9vvDVFCA0/1S8Daskad0sWygby7wHTAt+gPuiPHJ3jdHwql04bARoXHZXMqAjHUzNe4p0oTeikWa+X4+tcHKd+6XBNg4BTfnSE7BgGubqa4+jMcd+TjAt+Y3Tvzvq1H2M9ERdiCYU=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2384.eurprd05.prod.outlook.com (10.168.135.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 21:02:31 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 21:02:31 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Topic: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Thread-Index: AQHUz/D0zHEkReNVsEa2RSWOI/Q4NKX3M+0AgAOlj4CAAW4QgIABFdqggABLTwCAAAI9cIAADqcQgAAOtWCAADeQgIAAGIjAgAJ44YCAABQVAIAACmcAgAAAnZA=
Date:   Thu, 7 Mar 2019 21:02:31 +0000
Message-ID: <VI1PR0501MB22715BECE805956776809A1FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <20190301120358.7970f0ad@cakuba.netronome.com>
 <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
 <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB227137E2040C23E255DAC4F3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <97d63e18-b151-8b35-6687-1dcf5216f08a@nvidia.com>
 <VI1PR0501MB22711C5925D09B9822382AC3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <9dbc644f-4e4c-7119-8f99-99850fc67b73@nvidia.com>
 <VI1PR0501MB227181D2B27A29BCD8F5342FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <9e9b3e39-a649-a9cd-83cc-dab74cf77ac7@nvidia.com>
In-Reply-To: <9e9b3e39-a649-a9cd-83cc-dab74cf77ac7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 405d3858-2bd2-4d66-7e84-08d6a340370c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2384;
x-ms-traffictypediagnostic: VI1PR0501MB2384:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjIzODQ7MjM6ak5HSHBCK1FDZytjdldoUWFzWFFDemRu?=
 =?utf-8?B?RjBPdXo4N1Z3TDhNVE9ON1Z1N2NJaGUxSHp1a0t4dGlDWjRoZmFrUFdUUHhV?=
 =?utf-8?B?OHJSSFBvWEFueWxGczZBTVN0czZTZVVZTllDdEN3c0lXcFRNYmh4bGhRVWtC?=
 =?utf-8?B?Sk5rdDlHd0xRRmtjYUVnczZqcXU1SUFBR3NqUnpNZWw4TllXNkNlZ1B2QkV4?=
 =?utf-8?B?aCtaWGdWZm1uc3d5QjRWSU1EckdzZ1NtRHZEekVhMWlnRkQ1VE1IQ0Niciti?=
 =?utf-8?B?bDEycTQyTHZwODE1aE9DWDk0QUhFb2dHMXpBM0JreWwrL0RBalNGZGg2bkEz?=
 =?utf-8?B?N2ZOcXNsTUhpdTV5WWJlVWs2Vzk5c0M2ODFuSDlOQ3J1blRPd0EvbG5DeHE0?=
 =?utf-8?B?WnI2anZtNDd4NG9WQ3BaVGE4NWJ6WmRlZnBJdXNQYUIvSFJlV0VzcHNnL2RK?=
 =?utf-8?B?cDVMb3dQL0VrbTRoWEpVWXNNd1hQdUwvODlKK1JKM1ZFNEcxWENKWGJTOEFL?=
 =?utf-8?B?eElnbkhYYmY1Y203ajdIU0VYMXA3aE9IMFVsZnhvWUs3ZjY4UXk5ZkI2aWlY?=
 =?utf-8?B?Ym1TY3J4QU1LVEdDSE5YOFB5YURWRVJ3MkVnQWg2T0ZLc3BmVmtZaE9RZ3Zm?=
 =?utf-8?B?N21mRXNRQkpOdENhb2M0TW40MmR2MGRVNUQyRWpSVk5LYkpDeXpLK0Z3Zk9P?=
 =?utf-8?B?OWxqeXpVSnlOK3VvdWVheGF0MmtRQlI2Q2VubjZVQmQ5eTFiWXJEQWxhcE90?=
 =?utf-8?B?VDdyVC9IazZIOXJNVHhpdkdPN25hOWdqaUdXYit4WGVKNndsZlV4TmlOWCtZ?=
 =?utf-8?B?RmxjbGxOaU45OFF5Nm04UlVtSkRlNzNLNmJuaVV2SG91SXg0Mm1ZZlJmNGo3?=
 =?utf-8?B?YnYyMS9qdUpLSmJGWHAyc3k5SDVEa1RwZ3F2QzVBSmZNdTZaNEZRMmhaOTJj?=
 =?utf-8?B?dE40QldtRWZkSUNjaDBjYndTS04wOWcyOXdsaXY5c0ovTFI2S05rUG1iK1ZE?=
 =?utf-8?B?TlBQaGx3c0ZOYWxMN3l1bjg1N2FIWkU1aERPNVJGQTlMTjhybEFtQXliWGJY?=
 =?utf-8?B?YlZDem5TU2Npa1UrWGk2SVNaeFlkSVhhL05BUi9WWTZsVndud1hXQmp2ZlJ6?=
 =?utf-8?B?KytWWkZlOXU4cDlNak9Yb0hRK2k1d200Y2t3QURhaGVjamQ3RlJwUGs1RGJP?=
 =?utf-8?B?NVlLZzVhNS9nRDg1SU9LQWNVSjI2RnI0Y0xMdVpKL1RIZUJOVkRmcUh1QmY4?=
 =?utf-8?B?M25JcHNLdWMwMiszbnVpVUUvRUszelpsZm9LYmFWVldWWVdCSkhBL3hEdjV1?=
 =?utf-8?B?K3Nzb3VJUEM0U0gzdzMxd0pGL0MzaTlzMnp0aGZVR1dieExFbjFBQ0p0TFdH?=
 =?utf-8?B?QzJZZzVYUGEzSDIyOWE4eVIrRkp6ZitvdEppQm1YRTcwK0szaSt4RnpHUk8v?=
 =?utf-8?B?eUtrNGt2Z0kxUk5ZVmorQUxGN013ZHg2MVFPUVBGbzJLM2JRMjdqTU52dU11?=
 =?utf-8?B?Z1pFOVo5UW0xc0R2RmxndkZsMFFsYWpCUm1mM28yMHh2UzRqc1FnOERUNzhp?=
 =?utf-8?B?cFlubnFQZTkzcmZqSGZBdG1KNy9qNTJ4QURJVHV5UGdNVEc2dXlJMzFWMm9z?=
 =?utf-8?B?eXlEZVU0VDF6RW9scGJaUGZIWWRZYWZXN1RKYURvWFp3U1VHN296RHgxQ25s?=
 =?utf-8?B?VWdlOTd2U2ppejVlL2pUOTZMazJzNHVwcEJxU3FOcVlnMEt6dWlvSHJvQk9I?=
 =?utf-8?B?SVQvS1RXdk5jYVpYN0dLa20rTzRpd0dpWnc0Z29qSEEvUSt1SEpMRTN2ZWZM?=
 =?utf-8?B?MGF4Qm9VNGRYQWZlRCtkaWZsMWpDNTlFUkVLRThTNEVUOTlFdnMzUk8vbzVT?=
 =?utf-8?Q?FVbmJuef+C7Y0=3D?=
x-microsoft-antispam-prvs: <VI1PR0501MB238411563FCEFF60B2C329FCD14C0@VI1PR0501MB2384.eurprd05.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(13464003)(25786009)(256004)(26005)(53546011)(6506007)(9686003)(55016002)(3846002)(186003)(6116002)(229853002)(76176011)(7696005)(86362001)(105586002)(6246003)(102836004)(33656002)(316002)(486006)(11346002)(476003)(446003)(53936002)(4326008)(66066001)(71200400001)(14454004)(71190400001)(106356001)(54906003)(110136005)(5660300002)(2906002)(8676002)(81166006)(478600001)(81156014)(7736002)(305945005)(8936002)(99286004)(74316002)(97736004)(6436002)(52536013)(68736007)(93886005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2384;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ehVsDf57xo975F4dnqH0kotCocAxe6kPHY9tNpRZftXWNKzIek6rJWTDuTiLDN+zskD3pgfR/RoaJWVsSA9mgdl8ppsYIWvryzN7ZgFMuth5YQoStg+SM4fl5CLdgRgVZ6lGb2UXnME4hOMU5AtviMK2gADAYnH7HpHIGs7R4L6OaqOkDE4Kff3t1q6F17Xr2sziFVz7EhOLmWjVeE0GY9+84ubL8RADzlIAHKoOSnVBDECKHlgK/uJCTmgY7cV7lbqfRiyPaxR4xFiCQRr0WEY6TqFEvDI/C+yK7RLQxvdU80aPNGKlK79HZQF1mZtflaPpjleyXZxH/vaSUhy+H6uqDzBx1bC8nkvbeXUzD/X7e8TesJbDmWReWjwU+D4pwEtzLlVgWFvmNlf9w+S1omVzcldL3mO/m2s1/Uzj2Rg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405d3858-2bd2-4d66-7e84-08d6a340370c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 21:02:31.5093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lydGkgV2Fua2hlZGUg
PGt3YW5raGVkZUBudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggNywgMjAxOSAy
OjU0IFBNDQo+IFRvOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT47IEpha3ViIEtp
Y2luc2tpDQo+IDxqYWt1Yi5raWNpbnNraUBuZXRyb25vbWUuY29tPg0KPiBDYzogT3IgR2VybGl0
eiA8Z2VybGl0ei5vckBnbWFpbC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWljaGFsLmxrbWxAbWFya292aS5uZXQ7IGRhdmVt
QGRhdmVtbG9mdC5uZXQ7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBKaXJpIFBpcmtv
IDxqaXJpQG1lbGxhbm94LmNvbT47IEFsZXgNCj4gV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29u
QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIG5ldC1uZXh0IDAvOF0gSW50cm9kdWNp
bmcgc3ViZGV2IGJ1cyBhbmQgZGV2bGluayBleHRlbnNpb24NCj4gDQo+IA0KPiANCj4gPHNuaXA+
DQo+IA0KPiA+Pj4NCj4gPj4+IFllcy4gSSBnb3QgbXkgcGF0Y2hlcyB0byBhZGFwdCB0byBtZGV2
IHdheS4gV2lsbCBiZSBwb3N0aW5nIFJGQyB2MiBzb29uLg0KPiA+Pj4gV2lsbCB3YWl0IGZvciBh
IGRheSB0byByZWNlaXZlIG1vcmUgY29tbWVudHMvdmlld3MgZnJvbSBHcmVnIGFuZA0KPiBvdGhl
cnMuDQo+ID4+Pg0KPiA+Pj4gQXMgSSBleHBsYWluZWQgaW4gdGhpcyBjb3Zlci1sZXR0ZXIgYW5k
IGRpc2N1c3Npb24sIEZpcnN0IHVzZSBjYXNlDQo+ID4+PiBpcyB0byBjcmVhdGUgYW5kIHVzZSBt
ZGV2cyBpbiB0aGUgaG9zdCAoYW5kIG5vdCBpbiBWTSkuDQo+ID4+PiBMYXRlciBvbiwgSSBhbSBz
dXJlIG9uY2Ugd2UgaGF2ZSBtZGV2cyBhdmFpbGFibGUsIFZNIHVzZXJzIHdpbGwNCj4gPj4+IGxp
a2VseSB1c2UNCj4gPj4gaXQuDQo+ID4+Pg0KPiA+Pj4gU28sIG1seDVfY29yZSBkcml2ZXIgd2ls
bCBoYXZlIHR3byBjb21wb25lbnRzIGFzIHN0YXJ0aW5nIHBvaW50Lg0KPiA+Pj4NCj4gPj4+IDEu
IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9tZGV2L21kZXYuYw0KPiA+
Pj4gVGhpcyBpcyBtZGV2IGRldmljZSBsaWZlIGN5Y2xlIGRyaXZlciB3aGljaCB3aWxsIGRvLA0K
PiA+Pj4gbWRldl9yZWdpc3Rlcl9kZXZpY2UoKQ0KPiA+PiBhbmQgaW1wbGVtZW50cyBtbHg1X21k
ZXZfb3BzLg0KPiA+Pj4NCj4gPj4gT2suIEkgd291bGQgc3VnZ2VzdCBub3QgdXNlIG1kZXYuYyBm
aWxlIG5hbWUsIG1heSBiZSBhZGQgZGV2aWNlIG5hbWUsDQo+ID4+IHNvbWV0aGluZyBsaWtlIG1s
eF9tZGV2LmMgb3IgdmZpb19tbHguYw0KPiA+Pg0KPiA+IG1seDUvY29yZSBpcyBjb2RpbmcgY29u
dmVudGlvbiBpcyBub3QgZm9sbG93aW5nIHRvIHByZWZpeCBtbHggdG8gaXRzIDQwKw0KPiBmaWxl
cy4NCj4gPg0KPiA+IGl0IHVzZXMgYWN0dWFsIHN1YnN5c3RlbSBvciBmdW5jdGlvbmFsaXR5IG5h
bWUsIHN1Y2ggYXMsIHNyaW92LmMNCj4gPiBlc3dpdGNoLmMgZncuYyBlbl90Yy5jIChlbiBmb3Ig
RXRoZXJuZXQpIGxhZy5jIHNvLCBtZGV2LmMgYWxpZ25zIHRvDQo+ID4gcmVzdCBvZiB0aGUgNDAr
IGZpbGVzLg0KPiA+DQo+ID4NCj4gPj4+IDIuIGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94
L21seDUvY29yZS9tZGV2L21kZXZfZHJpdmVyLmMNCj4gPj4+IFRoaXMgaXMgbWRldiBkZXZpY2Ug
ZHJpdmVyIHdoaWNoIGRvZXMgbWRldl9yZWdpc3Rlcl9kcml2ZXIoKSBhbmQNCj4gPj4+IHByb2Jl
KCkgY3JlYXRlcyBuZXRkZXYgYnkgaGVhdmlseSByZXVzaW5nIGV4aXN0aW5nIGNvZGUgb2YgdGhl
IFBGIGRldmljZS4NCj4gPj4+IFRoZXNlIGRyaXZlcnMgd2lsbCBub3QgYmUgcGxhY2VkIHVuZGVy
IGRyaXZlcnMvdmZpby9tZGV2LCBiZWNhdXNlDQo+ID4+PiB0aGlzIGlzDQo+ID4+IG5vdCBhIHZm
aW8gZHJpdmVyLg0KPiA+Pj4gVGhpcyBpcyBmaW5lLCByaWdodD8NCj4gPj4+DQo+ID4+DQo+ID4+
IEknbSBub3QgdG9vIGZhbWlsaWFyIHdpdGggbmV0ZGV2LCBidXQgY2FuIHlvdSBjcmVhdGUgbmV0
ZGV2IG9uIG9wZW4oKQ0KPiA+PiBjYWxsIG9uIG1seCBtZGV2IGRldmljZT8gVGhlbiB5b3UgZG9u
J3QgaGF2ZSB0byB3cml0ZSBtZGV2IGRldmljZQ0KPiBkcml2ZXIuDQo+ID4+DQo+ID4gV2hvIGlu
dm9rZXMgb3BlbigpIGFuZCByZWxlYXNlKCk/DQo+ID4gSSBiZWxpZXZlIGl0IGlzIHRoZSBxZW11
IHdvdWxkIGRvIG9wZW4oKSwgcmVsZWFzZSwgcmVhZC93cml0ZS9tbWFwPw0KPiA+DQo+ID4gQXNz
dW1pbmcgdGhhdCBpcyB0aGUgY2FzZSwNCj4gPiBJIHRoaW5rIGl0cyBpbmNvcnJlY3QgdG8gY3Jl
YXRlIG5ldGRldiBpbiBvcGVuLg0KPiA+IEJlY2F1c2Ugd2hlbiB3ZSB3YW50IHRvIG1hcCB0aGUg
bWRldiB0byBWTSB1c2luZyBhYm92ZSBtZGV2IGNhbGxzLCB3ZQ0KPiBhY3R1YWxseSB3b250IGJl
IGNyZWF0aW5nIG5ldGRldiBpbiBob3N0Lg0KPiA+IEluc3RlYWQsIHNvbWUgcXVldWVzIGV0YyB3
aWxsIGJlIHNldHVwIGFzIHBhcnQgb2YgdGhlc2UgY2FsbHMuDQo+ID4NCj4gPiBCeSBkZWZhdWx0
IHRoaXMgY3JlYXRlZCBtZGV2IGlzIGJvdW5kIHRvIHZmaW9fbWRldi4NCj4gPiBBbmQgb25jZSB3
ZSB1bmJpbmQgdGhlIGRldmljZSBmcm9tIHRoaXMgZHJpdmVyLCB3ZSBuZWVkIHRvIGJpbmQgdG8g
bWx4NQ0KPiBkcml2ZXIgc28gdGhhdCBkcml2ZXIgY2FuIGNyZWF0ZSB0aGUgbmV0ZGV2IGV0Yy4N
Cj4gPg0KPiA+IE9yIGRpZCBJIGdldCBvcGVuKCkgYW5kIGZyaWVuZHMgY2FsbCB3cm9uZz8NCj4g
Pg0KPiANCj4gSW4gJ3N0cnVjdCBtZGV2X3BhcmVudF9vcHMnIHRoZXJlIGFyZSBjcmVhdGUoKSBh
bmQgcmVtb3ZlKCkuIFdoZW4gdXNlcg0KPiBjcmVhdGVzIG1kZXYgZGV2aWNlIGJ5IHdyaXRpbmcg
VVVJRCB0byBjcmVhdGUgc3lzZnMsIHZlbmRvciBkcml2ZXIncw0KPiBjcmVhdGUoKSBjYWxsYmFj
ayBnZXRzIGNhbGxlZC4gVGhpcyBzaG91bGQgYmUgdXNlZCB0byBhbGxvY2F0ZS9jb21taXQNClll
cy4gSSBhbSBhbHJlYWR5IHBhc3QgdGhhdCBzdGFnZS4NCg0KPiByZXNvdXJjZXMgZnJvbSBwYXJl
bnQgZGV2aWNlIGFuZCBvbiByZW1vdmUoKSBjYWxsYmFjayBmcmVlIHRob3NlIHJlc291cmNlcy4N
Cj4gU28gdGhlcmUgaXMgbm8gbmVlZCB0byBiaW5kIG1seDUgZHJpdmVyIHRvIHRoYXQgbWRldiBk
ZXZpY2UuDQo+IA0KSWYgd2UgZG9uJ3QgYmluZCBtbHg1IGRyaXZlciwgdmZpb19tZGV2IGRyaXZl
ciBpcyBib3VuZCB0byBpdC4gU3VjaCBkcml2ZXIgd29uJ3QgY3JlYXRlIG5ldGRldi4NCkFnYWlu
LCB3ZSBkbyBub3Qgd2FudCB0byBtYXAgdGhpcyBtZGV2IHRvIGEgVk0uDQpXZSB3YW50IHRvIGNv
bnN1bWUgaXQgaW4gdGhlIGhvc3Qgd2hlcmUgbWRldiBpcyBjcmVhdGVkLg0KU28gSSBhbSBhYmxl
IHRvIGRldGFjaCB0aGlzIG1kZXYgZnJvbSB2ZmlvX21kZXYgZHJpdmVyIGFzIHVzYXVhbCB1c2lu
ZyANCiQgZWNobyBtZGV2X25hbWUgPiAuLi9kcml2ZXJzL3ZmaW9fbWRldi91bmJpbmQNCg0KRm9s
bG93ZWQgYnkgYmluZGluZyBpdCB0byBtbHg1X2NvcmUgZHJpdmVyLg0KDQpCZWxvdyBpcyBzYW1w
bGUgb3V0cHV0IGJlZm9yZSBiaW5kaW5nIGl0IHRvIG1seDVfY29yZSBkcml2ZXIuDQpXaGVuIHdl
IGJpbmQgd2l0aCBtbHg1X2NvcmUgZHJpdmVyLCB0aGF0IGRyaXZlciBjcmVhdGVzIHRoZSBuZXRk
ZXYgaW4gaG9zdC4NCklmIHVzZXIgd2FudHMgdG8gbWFwIHRoaXMgbWRldiB0byBWTSwgdXNlciB3
b24ndCBiaW5kIHRvIG1seDVfY29yZSBkcml2ZXIuIGluc3RlYWQgaGUgd2lsbCBiaW5kIHRvIHZm
aW8gZHJpdmVyIGFuZCB0aGF0IGRvZXMgdXN1YWwgb3Blbi9yZWxlYXNlLy4uLg0KDQoNCmxyd3hy
d3hyd3ggMSByb290IHJvb3QgMCBNYXIgIDcgMTQ6MjQgNjllYTE1NTEtZDA1NC00NmU5LTk3NGQt
OGVkYWU4ZjBhZWZlIC0+IC4uLy4uLy4uL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAyLjIv
MDAwMDowNTowMC4wLzY5ZWExNTUxLWQwNTQtNDZlOS05NzRkLThlZGFlOGYwYWVmZQ0KW3Jvb3RA
c3ctbXR4LTAzNiBuZXQtbmV4dF0jIGxzIC1sIC9zeXMvYnVzL21kZXYvZGV2aWNlcy82OWVhMTU1
MS1kMDU0LTQ2ZTktOTc0ZC04ZWRhZThmMGFlZmUvDQp0b3RhbCAwDQpscnd4cnd4cnd4IDEgcm9v
dCByb290ICAgIDAgTWFyICA3IDE0OjI0IGRyaXZlciAtPiAuLi8uLi8uLi8uLi8uLi9idXMvbWRl
di9kcml2ZXJzL3ZmaW9fbWRldg0KbHJ3eHJ3eHJ3eCAxIHJvb3Qgcm9vdCAgICAwIE1hciAgNyAx
NDoyNCBpb21tdV9ncm91cCAtPiAuLi8uLi8uLi8uLi8uLi9rZXJuZWwvaW9tbXVfZ3JvdXBzLzAN
Cmxyd3hyd3hyd3ggMSByb290IHJvb3QgICAgMCBNYXIgIDcgMTQ6MjQgbWRldl90eXBlIC0+IC4u
L21kZXZfc3VwcG9ydGVkX3R5cGVzL21seDVfY29yZS1tZ210DQpkcnd4ci14ci14IDIgcm9vdCBy
b290ICAgIDAgTWFyICA3IDE0OjI0IHBvd2VyDQotLXctLS0tLS0tIDEgcm9vdCByb290IDQwOTYg
TWFyICA3IDE0OjI0IHJlbW92ZQ0KbHJ3eHJ3eHJ3eCAxIHJvb3Qgcm9vdCAgICAwIE1hciAgNyAx
NDoyNCBzdWJzeXN0ZW0gLT4gLi4vLi4vLi4vLi4vLi4vYnVzL21kZXYNCi1ydy1yLS1yLS0gMSBy
b290IHJvb3QgNDA5NiBNYXIgIDcgMTQ6MjQgdWV2ZW50DQoNCj4gb3Blbi9yZWxlYXNlL3JlYWQv
d3JpdGUvbW1hcC9pb2N0bCBhcmUgcmVndWxhciBmaWxlIG9wZXJhdGlvbnMgZm9yIHRoYXQNCj4g
bWRldiBkZXZpY2UuDQo+IA0KDQo+IFRoYW5rcywNCj4gS2lydGkNCg0K
