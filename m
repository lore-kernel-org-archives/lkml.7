Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928B820675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZvIaOeSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCGNDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:03:04 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:63779
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbfCGNDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyzhdEb2LGR7F+u7Z9l/JGomYJnPvdvEtpp8OlKmRLg=;
 b=ZvIaOeSOfoeWnsCpu7N9ZhsGDFDaf5MbHZnmz9p9PcmHI3FBrMsb4izUkgJ+wqdEgzi06M+sZB/LhfbMcVllEUWMCh8OChyglTzm9zDow/DWJYVfmO9nUg/2mApeNcEGklyHw4unj7j7M4uJxSA5CXFpPISseCjJtZELoSmK9d0=
Received: from AM6PR04MB5447.eurprd04.prod.outlook.com (20.178.92.212) by
 AM6PR04MB5655.eurprd04.prod.outlook.com (20.179.0.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 13:02:58 +0000
Received: from AM6PR04MB5447.eurprd04.prod.outlook.com
 ([fe80::f963:78c8:7bed:5b60]) by AM6PR04MB5447.eurprd04.prod.outlook.com
 ([fe80::f963:78c8:7bed:5b60%5]) with mapi id 15.20.1686.016; Thu, 7 Mar 2019
 13:02:58 +0000
From:   Franck Lenormand <franck.lenormand@nxp.com>
To:     =?utf-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        David Gstir <david@sigma-star.at>
Subject: RE: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use in
 dmcrypt
Thread-Topic: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use in
 dmcrypt
Thread-Index: AQHU0ElJyiKbG2HSEkeGNjbUGrGl3KX+2BMAgAFQ+HA=
Date:   Thu, 7 Mar 2019 13:02:58 +0000
Message-ID: <AM6PR04MB54479B9BFFC5A8DE1041A6DD924C0@AM6PR04MB5447.eurprd04.prod.outlook.com>
References: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
 <1551890866.5086.125.camel@pengutronix.de>
In-Reply-To: <1551890866.5086.125.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=franck.lenormand@nxp.com; 
x-originating-ip: [81.1.10.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4483909c-8ae2-40fd-cbd6-08d6a2fd38de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5655;
x-ms-traffictypediagnostic: AM6PR04MB5655:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI1NjU1OzIzOnhRUjdtRmJEcWh6cStMcDdlZUFjV0VJb2Mw?=
 =?utf-8?B?T2tMYnZwZXg5bGdUMGhRRktmZy8vRGl3cFRmSmdrVmh6Z1Nld1hOKzNYT29y?=
 =?utf-8?B?c1pqK2lpd3RhVGNtdTNsUjZoVytQbkdiN25Icy9taWxpZFkxbzhjeU9RUmJp?=
 =?utf-8?B?Nkh6cmxwYWM5b1RCNnlFNE55eGJhRmJHeUlBdm5SOTRkSTV6YkZEUFJmTGxt?=
 =?utf-8?B?WUJYUTRUcG9hbGt6NkR0K0Z6WUlQQnF0TmZrUU53OHlCM2NuNTdmSGVmdU5u?=
 =?utf-8?B?bDVvOEpuNnZQeFdqVVdkYmJUbmVodk1CbHRFSDltbm5kR1d6S1YrZ1BzZUNT?=
 =?utf-8?B?cldlVGtzSmM3bGVuOCt4L20xS2VOU0NsMnFwRVMyeEtFWmRCK2JUWmd6Q21Q?=
 =?utf-8?B?VVgyblZYc0pSZjFGOVFzQURXemNNOTlHS0EzL2dRNG1OSW16OTJmNGV5T1F3?=
 =?utf-8?B?TDhybUZMK0tMT3NEZmw5SjBXT2NPSzFhS3M3cmNWUzU1ZVlYWFlUb0tCRlFJ?=
 =?utf-8?B?SkFPaHZFSnZxVzdPU1ptWVNMT3ZEM1cyWUhzY0NuRmJ4K1QxZ2lXZ09TbEJj?=
 =?utf-8?B?ejBoYlNIdVVuZi9pWGEyR01NWmpCbHYrTWduNGVwQisvclNkS3ZVaktRNVhR?=
 =?utf-8?B?MndWZ3MxQlpxTWxHNGxMU25zZEc4MmJ2aHgvcWxFNVhvZlR1ZUNVVGs0OWxE?=
 =?utf-8?B?aGdlM1k1VE1WbDg0c1pabURLdHFsT0hYVklRTFR1ZnFlM283VEVOb1M1cWda?=
 =?utf-8?B?VnpUWWkrdVpQd2JRVDFqWHQ4VXJMUlRBZFREZ2pSaTdGUHRBc3dWNEJoNXpi?=
 =?utf-8?B?UlhZZWJLUll0bC82OU1XMzdGTjc3NnpmUkRDcVM0d05UeGdEZE1EZjRXbmxX?=
 =?utf-8?B?dnRPU3pWUW9PTlpiRTNjeXhuNW5jWVZvaGhpeHFINW13dUJoZjhrQkFXcERw?=
 =?utf-8?B?ejJTNnZmaHVET2hrZUNWNzcva2RtUDhNRmxBYTVFTTdhaDAyaVl2bm1pTGM3?=
 =?utf-8?B?REF3UUJQUE1ITnVsZHVTUWxxL2RMOTgzTGtydkdMazJmYlAvQ0FmZk9jNjM3?=
 =?utf-8?B?MHlOUHd5YnpQc1hpdDBkN3lzMkFUOXpDZFNxNWNIWk1nTlpuTWtiSXdPNFVN?=
 =?utf-8?B?VEd3NGgwRDBrRFNkRjFNck5zTm5VMXpPbDMyZVJsRXJ5NFd5RXJGaTRVRlZV?=
 =?utf-8?B?czNqakFMRXhRVWhHK0Vua09lcHdJOGpWODZHVjdWWDAxeWxOS3BJRmRxVWVx?=
 =?utf-8?B?dCs3aTBzNjdMa0hRQUNnaG1ZcE05QXRJd3R5NitsaDNWeFo5cURSaEplTkMv?=
 =?utf-8?B?cHl6ZHFWU2lJUEhxSU5zOWxkZ3dPV2hsOEVQZE05ZXJvWVVEYlJOeTZaZnND?=
 =?utf-8?B?OE1LQW1xcytEZXYzOXZGRlJ3K2RscDBOSHd5V2h5Y0FBcVVvdmlrZE9Fem5B?=
 =?utf-8?B?aUR3eVBieHlPU1V4ZUkwNWgvaWZacVFWQnBtb2x4NklCVEUyMG5henIzRldC?=
 =?utf-8?B?MjkzV0lWaW9aS2x0RW5ObzRkMzVTVDhsYnYzWEZBMGxLQllUOG5FY1BRcXdQ?=
 =?utf-8?B?a2ppTnA5QWZzYjJWa3ZtUCtOUG13S3Bjb0c4bC95d3RndUwrZlZXeU8vNGNr?=
 =?utf-8?B?QkNMVkpMVUQzMXZNd3d4NVpYYnZqQkdUVk8zUXZwNkp6L3VWNTdCeGZ1QWVw?=
 =?utf-8?B?d1FKd0J6d2hQRHpSVzdJRWNqOGQvZ3VPMlFDL3ZUbzZ3Lzhaa1lMQVd2a2Vi?=
 =?utf-8?B?VDNSOW1MNlU3Q0ZZWUwyQ2RGUG1GSytzS214aFVUSmF5TG4rT0dBcFBXdCtB?=
 =?utf-8?B?ZXdVUmZJMG9PRmNXSWVHSUhteG1BZHBFSWFkbEVGdlFoWUxJaTRhaU92aFhw?=
 =?utf-8?B?OWsydWxxUmJSaDRkT00vQlY5Q2ExRUpSOUw0SCtmVzYxOUFLeGpOU2JzU3dO?=
 =?utf-8?Q?XmvSgLzTvdjnkL5PuyoXj8W3ngr6tU=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5655E67E38E87E3A0CDBC632924C0@AM6PR04MB5655.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(13464003)(7696005)(66066001)(53936002)(105586002)(97736004)(106356001)(76176011)(478600001)(86362001)(6306002)(99286004)(9686003)(6116002)(3846002)(45080400002)(55016002)(110136005)(316002)(6436002)(25786009)(2201001)(44832011)(486006)(14454004)(71190400001)(71200400001)(68736007)(2906002)(446003)(26005)(52536013)(66574012)(5660300002)(11346002)(7736002)(476003)(305945005)(4326008)(229853002)(74316002)(102836004)(8676002)(81156014)(81166006)(54906003)(6506007)(53546011)(186003)(7416002)(256004)(14444005)(33656002)(2501003)(6246003)(8936002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5655;H:AM6PR04MB5447.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ZHZGu59yFPIDqhl50kHgU/Il6Ov9cxm+jg8hVb6lFtcVibsvm/agtplhOt328hTeCKvMu1l8QD6OkkYfc5Nq36myOcYx9CaF2Xr4TOko60UPqONObR7u7Ys+Vl0ETgmyju1P29v3oEeM0hEljRewhfVoiEAFNuA1SUI6EoYuLbg1hlq0Bu1wsour96C2NJbUioonq6nEfcMNiIylFqq6ZpWFYb6izmIOfvz9wH799EM01VBqAyh1rKRWo+sesiOOB7ICzOaBPiv7mQigqppyySVBr6k8/9ZYY9mO1FmZpsoGZqQXIiIM1a5QgV6aIKYdw/BP6GULts6TNvBMhe2gHzNwt30OPYVCYmeFZOgwHfPBvo3AMJs/GDYQaIaUDGDUHL5A+8bE069vIV4cdXrTlq8/F4I4yR6urkLUN73NT0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4483909c-8ae2-40fd-cbd6-08d6a2fd38de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 13:02:58.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gTMO8YmJlIDxqbHVAcGVu
Z3V0cm9uaXguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggNiwgMjAxOSA1OjQ4IFBNDQo+
IFRvOiBGcmFuY2sgTGVub3JtYW5kIDxmcmFuY2subGVub3JtYW5kQG54cC5jb20+OyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga2V5cmluZ3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBIb3JpYSBHZWFudGEg
PGhvcmlhLmdlYW50YUBueHAuY29tPjsgU2lsdmFubyBEaSBOaW5ubw0KPiA8c2lsdmFuby5kaW5p
bm5vQG54cC5jb20+OyBhZ2tAcmVkaGF0LmNvbTsgc25pdHplckByZWRoYXQuY29tOyBkbS0NCj4g
ZGV2ZWxAcmVkaGF0LmNvbTsgZGhvd2VsbHNAcmVkaGF0LmNvbTsgam1vcnJpc0BuYW1laS5vcmc7
DQo+IHNlcmdlQGhhbGx5bi5jb207IERhdmlkIEdzdGlyIDxkYXZpZEBzaWdtYS1zdGFyLmF0Pg0K
PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzJdIENyZWF0ZSBDQUFNIEhXIGtleSBpbiBsaW51
eCBrZXlyaW5nIGFuZCB1c2UgaW4NCj4gZG1jcnlwdA0KPiANCj4gSGkgRnJhbmNrLA0KPiANCj4g
dGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMhDQo+IA0KPiBPbiBGcmksIDIwMTktMDMtMDEgYXQg
MTc6MDkgKzAxMDAsIEZyYW5jayBMRU5PUk1BTkQgd3JvdGU6DQo+ID4gVGhlIGNyZWF0aW9uIG9m
IHN1Y2ggc3RydWN0dXJlcyBhbmQgaXRzIHVzZSB3YXMgbm90IGV4cG9zZWQgdG8NCj4gPiB1c2Vy
c3BhY2Ugc28gaXQgd2FzIGNvbXBsaWNhdGVkIHRvIHVzZSBhbmQgcmVxdWlyZWQgY3VzdG9tDQo+
ID4gZGV2ZWxvcG1lbnQuIFdlIHdvdWxkIGxpa2UgdG8gZWFzZSB0aGlzIHVzaW5nIGludGVyZmFj
ZSB3aGljaCBhcmUga25vd24NCj4gYW5kIHVzZWQ6DQo+ID4gIC0gTGludXgga2V5IHJldGVudGlv
biBzZXJ2aWNlIDogQWxsb3cgdG8gZ2VuZXJhdGUgb3IgbG9hZCBrZXlzIGluIGENCj4gPiAgICAg
ICAgIGtleXJpbmcgd2hpY2ggY2FuIGJlIHVzZWQgYnkgYXBwbGljYXRpb25zLg0KPiA+ICAtIGRt
LWNyeXB0IDogZGV2aWNlIG1hcHBlciBhbGxvd2luZyB0byBlbmNyeXB0IGRhdGEuDQo+ID4NCj4g
PiBUaGUgY2FwYWNpdHkgdG8gZ2VuZXJhdGUgb3IgbG9hZCBrZXlzIGFscmVhZHkgYXZhaWxhYmxl
IGluIHRoZSBMaW51eA0KPiA+IGtleSByZXRlbnRpb24gc2VydmljZSBkb2VzIG5vdCBhbGxvd3Mg
dG8gZXhwbG9pdCBDQUFNIGNhcGFiaWxpdGllcw0KPiA+IGhlbmNlIHdlIG5lZWQgdG8gY3JlYXRl
IGEgbmV3IGtleV90eXBlLiBUaGUgbmV3IGtleSB0eXBlICJjYWFtX3RrIg0KPiBhbGxvd3MgdG86
DQo+ID4gIC0gQ3JlYXRlIGEgYmxhY2sga2V5IGZyb20gcmFuZG9tDQo+ID4gIC0gQ3JlYXRlIGEg
YmxhY2sga2V5IGZyb20gYSByZWQga2V5DQo+ID4gIC0gTG9hZCBhIGJsYWNrIGJsb2IgdG8gcmV0
cmlldmUgdGhlIGJsYWNrIGtleQ0KPiANCj4gT24gMjAxOC0wNy0yMywgVWRpdCBBZ2Fyd2FsIDx1
ZGl0LmFnYXJ3YWxAbnhwLmNvbT4gc2VudCBhIHNlcmllcyB3aGljaA0KPiBzZWVtcyByZWxhdGVk
IHRvIHRoaXM6DQo+IFtQQVRDSCB2MiAxLzJdIHNlY3VyaXR5L2tleXMvc2VjdXJlX2tleTogQWRk
cyB0aGUgc2VjdXJlIGtleSBzdXBwb3J0IGJhc2VkDQo+IG9uIENBQU0uDQo+IFtQQVRDSCB2MiAy
LzJdIGVuY3J5cHRlZF9rZXlzOiBBZGRzIHN1cHBvcnQgZm9yIHNlY3VyZSBrZXktdHlwZSBhcyBt
YXN0ZXINCj4ga2V5Lg0KPiANCj4gSXMgdGhpcyBzZXJpZXMgaW50ZW5kZWQgdG8gY29udGludWUg
dGhhdCB3b3JrIGFuZCBjb3ZlciB0aGUgc2FtZSB1c2VzLSBjYXNlcz8NCj4gDQo+IElmIEkgcmVt
ZW1iZXIgY29ycmVjdGx5LCB0aGUgQ0FBTSBhbHNvIHN1cHBvcnRzIG1hcmtpbmcgYmxvYnMgdG8g
YWxsb3cgb3INCj4gZGlzYWxsb3cgZXhwb3J0aW5nIHRoZSBlbmNhcHN1bGF0ZWQga2V5IGZyb20g
dGhlIGhhcmR3YXJlLiBPciBpcyB0aGlzDQo+IHVubmVlZGVkIGFuZCB3ZSBjb3VsZCBlbmNyeXB0
L2RlY3J5cHQgb3RoZXIgKGxlc3MgY3JpdGljYWwpIGtleSBtYXRlcmlhbA0KPiBhZ2FpbnN0IHRo
ZSB0ayhjYmMoYWVzKSkgQ0FBTSBrZXkgdmlhIHRoZSBrZXlyaW5nIG1lY2hhbmlzbXM/DQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEphbg0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiBJbmR1
c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfA0KPiBodHRwczovL2VtZWEw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3dw0K
PiB3LnBlbmd1dHJvbml4LmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NmcmFuY2subGVub3JtYW5k
JTQwbnhwLmNvDQo+IG0lN0MyOWFiODllOTlmOTA0MGUzMGFhOTA4ZDZhMjUzNzk2NyU3QzY4NmVh
MWQzYmMyYjRjNmZhOTJjZDk5Yw0KPiA1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODc0ODc2NzMyMTUz
MDkzJmFtcDtzZGF0YT1ieUtENFNtWWZ6TVRzDQo+IEZLNmNYNUw4MSUyQjloeHhxVGJuT0xmNyUy
QkFKZ1h5bFUlM0QmYW1wO3Jlc2VydmVkPTAgIHwNCj4gUGVpbmVyIFN0ci4gNi04LCAzMTEzNyBI
aWxkZXNoZWltLCBHZXJtYW55IHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10
c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIx
LTIwNjkxNy01NTU1IHwNCg0KSGVsbG8gSmFuLA0KDQpUaGUgY3VycmVudCBzZXJpZXMgaXMgYWlt
ZWQgdG8gY2hhbmdlIHdoaWNoIGtleSB0eXBlIGlzIGFjY2VwdGFibGUgaW4gZG0tY3J5cHQuIFdp
dGhvdXQNCnRoaXMgY2hhbmdlLCB0aGUga2V5IHR5cGUgY2Fubm90IGJlIGludGVncmF0ZWQgcHJv
cGVybHkuDQoNCkFib3V0IHRoZSBrZXkgdHlwZSBpbXBsZW1lbnRhdGlvbjoNClRoZSBpbXBsZW1l
bnRhdGlvbiBvZiB0aGUga2V5IHR5cGUgaXMgYW4gaW1wcm92ZW1lbnQgcmVsYXRlZCB0byB0aGUg
d29yayBvZiBVZGl0IEFnYXJ3YWwuDQoNClRoZSB0cmFuc2Zvcm0gdGsoY2JjKGFlcykpIGlzIGlu
dGVuZGVkIHRvIHJlY2VpdmUga2V5IG1hdGVyaWFsIHdob3NlIGZvcm1hdCBjYW4gY2hhbmdlDQpo
ZW5jZSB0aGUgInRhZ2dpbmciIHRvIGhhbmRsZSBpdCBwcm9wZXJseS4gSXQgY291bGQsIGZvciBl
eGFtcGxlLCBoYW5kbGUgcGxhaW4ga2V5cywgYmxhY2sga2V5cyBvciBibG9icyBhcyBrZXkgbWF0
ZXJpYWwgYW5kIHRoaXMgbWF0ZXJpYWwgd291bGQgYmUgc3RvcmVkIGluIGtleXJpbmcuDQoNClJl
Z2FyZHMsDQpGcmFuY2sNCg==
