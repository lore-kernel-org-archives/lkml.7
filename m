Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D21C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41C020863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 08:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GMLZNVVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfCCImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 03:42:33 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:35206
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfCCImd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 03:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf9aSd7bnskM+a+4XkrGfDBFHDG5+prIO7Uw6iCaiHU=;
 b=GMLZNVVuc/9ZuJVisZxVPGs1p87GqXm5po4ejoQ85PEVXSvfafvwFO1spQoDnb4YAGCqGEExlqk5JlUObT4aDw+Jg7T1q48eH1W9OpFQFkmbu1Hq2K0B28ADOhG1JqQWKpLWq7UkIjlAkqdR2KD/0ojvfKPqYlhqBN15c/fCBd4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5988.eurprd04.prod.outlook.com (20.178.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.17; Sun, 3 Mar 2019 08:42:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1665.019; Sun, 3 Mar 2019
 08:42:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/12] percpu: manage chunks based on contig_bits instead
 of free_bytes
Thread-Topic: [PATCH 04/12] percpu: manage chunks based on contig_bits instead
 of free_bytes
Thread-Index: AQHUzwv2qzl7fj3BX0OARXhmoz6omaX4XeFQgACTlICAAKpB4A==
Date:   Sun, 3 Mar 2019 08:42:27 +0000
Message-ID: <AM0PR04MB448143E26F0D60DFE81AA7AA88700@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190228021839.55779-1-dennis@kernel.org>
 <20190228021839.55779-5-dennis@kernel.org>
 <AM0PR04MB4481BE90E46F3635B7131CED88770@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190302223211.GC1196@dennisz-mbp.home>
In-Reply-To: <20190302223211.GC1196@dennisz-mbp.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 828719e9-ab0c-40bc-af7b-08d69fb42a9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5988;
x-ms-traffictypediagnostic: AM0PR04MB5988:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI1OTg4OzIzOmlzNm5BWHNoNm1XVkoraXRDUmNMdU4yR2RD?=
 =?utf-8?B?dzlTTFprYXVwcUlEZko0dVVpbWgrblVva2wyelRmQ1d1UmFtRVJQY3hTZUF1?=
 =?utf-8?B?dzhnaElPMVpXZWo4V09OTWFoK2czTWtHMWlxS0w2M1BSbDZlaklHQVMxbVM5?=
 =?utf-8?B?QkYveDFaVlIvdEdMTmNmaDY3NjErczJDNCtYMEVSWW55b2V2Yzh0c0l4b0RF?=
 =?utf-8?B?UEtXOE5FTjBqMXRJQ1pCVkJpd2gxTEk0aUlrQ0FiZG9kQ0lVejVIUE13ejJ3?=
 =?utf-8?B?Tmt5NTBEM3NWdG9yUGlPTTUyRVNvOE1NRWxkN3YvWjJ2Q29NQ3dNNGRFZE9l?=
 =?utf-8?B?K3BNZTFHODc3b0JSbUxPdmhvYUh2WGVxRW5CeXZ2M3N5YWljQ2V5Z29IeVdq?=
 =?utf-8?B?Q08yM2pKNHVHUW5lT0xVYzBKWUJuOEg5ck1SUllaWjNlSEZWKzJyK1FoOVVS?=
 =?utf-8?B?UWI0cW4vLzBTMTFLZWVpSUFEZVZWdk9mU091V0RwR2h6N0hzZnZLWnZhM2t6?=
 =?utf-8?B?UUROamtJN2ppa2lzaTBpd0ZhL2M5WThTNnAxRERzekVMc0MyL3RMdldXT3M4?=
 =?utf-8?B?ZmR6bmFiSkY0bWZqS3RMVlFjdSs4eFdBWEJ6TTRmdXQrUDA0eXFxLy90VWYx?=
 =?utf-8?B?VjVEVjRkdFBDK1k1aVZKemZUSnRwYXpLdXlhS1dOdUZacDRTUkl2b1JVVTkv?=
 =?utf-8?B?R1NKUEt2SzRpYlhaUHhmVUVmMFZ4Tk5iNHBmMHJ5b05ldUlsejNJUDZxdTgw?=
 =?utf-8?B?TStBQ0hSWFZ4YXI2MXdjdnFFdlVLS01mQ3Q4WnVrQlpRZFBPKzZ1QlRaS21q?=
 =?utf-8?B?eE0rZS9LWHc1Y2NJQzNDRzdSVVBlWjFpejV2WDZETE1iMWpSaVJiNmF3U2do?=
 =?utf-8?B?TThaZzREa3c2Vm4vWW5IK0VEdzREMit4TFJ0N1NrTm8xa1g1N3BKQ0UyR0R5?=
 =?utf-8?B?cXYrcVlBcWRqVFkvdy9hSWlKTDBsUThxUXU5WDU0Q29vY3ZBSnRSNDBqK2p6?=
 =?utf-8?B?UnpGWTJBbE9qV0JST0dTU25uRHZXejZuS29vcklPelU3YkhVb2RsMDdDYjJm?=
 =?utf-8?B?TmR1NTVnb2tuR2NuUmlQc0t0Sys1c0RYWjgyaHA5OTZZUHJZZ1ZVYUJRV0d5?=
 =?utf-8?B?RHRzbW1IbFBDWnZCZzJ0V2dtUjRjcUd3dC9MbmpGcHpjQ0NXYkVCbjJ4enRl?=
 =?utf-8?B?TzNJeTZZUWFFYzZ6SlNBRFp4MGlZSTQ3OXV4ZSs2RnlyelRTZ2I0Y3NoaTRx?=
 =?utf-8?B?ejllSHI0K0VkTHRXRGRhZDVucXA1NkpaUmdpUERxcVA3MWtDUm5hVlBNcHFO?=
 =?utf-8?B?RlRhcHpGc3FHM0tRcG1QRVVDMHhIdHd5aUtaMlpITWN2bFUyY00zRENubjNt?=
 =?utf-8?B?MFMyNWxlU1Qya3pOd0ZVbm84Q2JuMHhTc3NKSWlqT3VSNmNxbTM3U3hiVDhG?=
 =?utf-8?B?UHpOajRTa0NFMjNEcFlTaG53dThsOFh3NWVabUFWdXZ4ekdNNmxiMlBLVUxF?=
 =?utf-8?B?aUdub0VmT0VvQVlMdlp4M3JNMERGZGMzUzM5WTRIRng3L2p5amxJVzZVRnhL?=
 =?utf-8?B?c1BMYitpbmZiY25LSUZObmREc29nNUxkaTV1ZEpPRDVuMEthR3dCUWpFYnpS?=
 =?utf-8?B?c1dXR1NJa0lkVlh3UzFrWlprcGs4NkVlYW9JNStWQ3JvOGMvQlpmRFpHeFVs?=
 =?utf-8?B?VXhqS1BtWC9OMnBVcFgzQkJKbGVHRzVUSU9ybjVaOTBBeE9PeU02emFkV3E4?=
 =?utf-8?Q?hIZ5O5OmwFj82IJZo0jlivuw1tnRQQ+YoxiRQ=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5988BCE1712111F3F71599A088700@AM0PR04MB5988.eurprd04.prod.outlook.com>
x-forefront-prvs: 096507C068
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(13464003)(189003)(199004)(14454004)(446003)(11346002)(33656002)(68736007)(102836004)(76176011)(53546011)(6506007)(476003)(7696005)(6246003)(486006)(2906002)(7736002)(81156014)(305945005)(74316002)(8676002)(81166006)(8936002)(71200400001)(71190400001)(99286004)(6916009)(44832011)(186003)(26005)(52536013)(478600001)(105586002)(106356001)(66066001)(97736004)(5660300002)(3846002)(9686003)(6116002)(229853002)(6436002)(93886005)(256004)(53936002)(25786009)(14444005)(86362001)(55016002)(4326008)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5988;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: seEnRMWCdo+9eJNkGLBHPcMvT46WGxNZs9bFxSDAl6J/oYnNMcU7q89v+A92FUH7m/2aVR7Ls+MoxRli98vmEBU4LJVh7nBwUPLIrcFju5HF6F6CmQtyQ5zu48mpuMNtjBufLMj4t4PUmpmMWw/YGwGmj82FwbEkQBa8W5Hy4piURTdvp6h9RiqcH2Gmx+sjkxk9yyOi2K23HKjshku5ke1rqYXC5hWZSTOraF1m6CyAHRyqbd/+m/Xk4FBHir4m8rnUUrMmfNeG8SZYKeC/sLtIxmZ24jLuMYW5o1adaCdk8qiICcHwrOCjmfRyyI3wHVV3PjeKZZLdDyqR7BhITsYMQ71cxTMIE54yNVBVFyKiysBtVQAWiHJ/hUVhTciymzMNI1UdU4b+CDCA0ew++gMPmnWdAJhPLJNW2pP/Tvw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828719e9-ab0c-40bc-af7b-08d69fb42a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2019 08:42:27.5658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVubmlzIFpob3UgW21h
aWx0bzpkZW5uaXNAa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOeW5tDPmnIgz5pelIDY6MzINCj4g
VG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogVGVqdW4gSGVvIDx0akBrZXJu
ZWwub3JnPjsgQ2hyaXN0b3BoIExhbWV0ZXIgPGNsQGxpbnV4LmNvbT47IFZsYWQNCj4gQnVzbG92
IDx2bGFkYnVAbWVsbGFub3guY29tPjsga2VybmVsLXRlYW1AZmIuY29tOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAwNC8xMl0gcGVyY3B1OiBtYW5hZ2UgY2h1bmtzIGJhc2VkIG9uIGNvbnRpZ19iaXRzDQo+
IGluc3RlYWQgb2YgZnJlZV9ieXRlcw0KPiANCj4gT24gU2F0LCBNYXIgMDIsIDIwMTkgYXQgMDE6
NDg6MjBQTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IG93bmVyLWxpbnV4LW1tQGt2YWNrLm9yZyBb
bWFpbHRvOm93bmVyLWxpbnV4LW1tQGt2YWNrLm9yZ10NCj4gT24NCj4gPiA+IEJlaGFsZiBPZiBE
ZW5uaXMgWmhvdQ0KPiA+ID4gU2VudDogMjAxOeW5tDLmnIgyOOaXpSAxMDoxOQ0KPiA+ID4gVG86
IERlbm5pcyBaaG91IDxkZW5uaXNAa2VybmVsLm9yZz47IFRlanVuIEhlbyA8dGpAa2VybmVsLm9y
Zz47DQo+ID4gPiBDaHJpc3RvcGggTGFtZXRlciA8Y2xAbGludXguY29tPg0KPiA+ID4gQ2M6IFZs
YWQgQnVzbG92IDx2bGFkYnVAbWVsbGFub3guY29tPjsga2VybmVsLXRlYW1AZmIuY29tOw0KPiA+
ID4gbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4g
PiBTdWJqZWN0OiBbUEFUQ0ggMDQvMTJdIHBlcmNwdTogbWFuYWdlIGNodW5rcyBiYXNlZCBvbiBj
b250aWdfYml0cw0KPiA+ID4gaW5zdGVhZCBvZiBmcmVlX2J5dGVzDQo+ID4gPg0KPiA+ID4gV2hl
biBhIGNodW5rIGJlY29tZXMgZnJhZ21lbnRlZCwgaXQgY2FuIGVuZCB1cCBoYXZpbmcgYSBsYXJn
ZSBudW1iZXINCj4gPiA+IG9mIHNtYWxsIGFsbG9jYXRpb24gYXJlYXMgZnJlZS4gVGhlIGZyZWVf
Ynl0ZXMgc29ydGluZyBvZiBjaHVua3MNCj4gPiA+IGxlYWRzIHRvIHVubmVjZXNzYXJ5IGNoZWNr
aW5nIG9mIGNodW5rcyB0aGF0IGNhbm5vdCBzYXRpc2Z5IHRoZSBhbGxvY2F0aW9uLg0KPiA+ID4g
U3dpdGNoIHRvIGNvbnRpZ19iaXRzIHNvcnRpbmcgdG8gcHJldmVudCBzY2FubmluZyBjaHVua3Mg
dGhhdCBtYXkNCj4gPiA+IG5vdCBiZSBhYmxlIHRvIHNlcnZpY2UgdGhlIGFsbG9jYXRpb24gcmVx
dWVzdC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWmhvdSA8ZGVubmlzQGtl
cm5lbC5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+ICBtbS9wZXJjcHUuYyB8IDIgKy0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvbW0vcGVyY3B1LmMgYi9tbS9wZXJjcHUuYyBpbmRleA0KPiA+ID4gYjQw
MTEyYjJmYzU5Li5jOTk2YmNmZmJiMmEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9tbS9wZXJjcHUuYw0K
PiA+ID4gKysrIGIvbW0vcGVyY3B1LmMNCj4gPiA+IEBAIC0yMzQsNyArMjM0LDcgQEAgc3RhdGlj
IGludCBwY3B1X2NodW5rX3Nsb3QoY29uc3Qgc3RydWN0DQo+ID4gPiBwY3B1X2NodW5rDQo+ID4g
PiAqY2h1bmspDQo+ID4gPiAgCWlmIChjaHVuay0+ZnJlZV9ieXRlcyA8IFBDUFVfTUlOX0FMTE9D
X1NJWkUgfHwNCj4gY2h1bmstPmNvbnRpZ19iaXRzDQo+ID4gPiA9PSAwKQ0KPiA+ID4gIAkJcmV0
dXJuIDA7DQo+ID4gPg0KPiA+ID4gLQlyZXR1cm4gcGNwdV9zaXplX3RvX3Nsb3QoY2h1bmstPmZy
ZWVfYnl0ZXMpOw0KPiA+ID4gKwlyZXR1cm4gcGNwdV9zaXplX3RvX3Nsb3QoY2h1bmstPmNvbnRp
Z19iaXRzICoNCj4gPiA+ICtQQ1BVX01JTl9BTExPQ19TSVpFKTsNCj4gPiA+ICB9DQo+ID4gPg0K
PiA+ID4gIC8qIHNldCB0aGUgcG9pbnRlciB0byBhIGNodW5rIGluIGEgcGFnZSBzdHJ1Y3QgKi8N
Cj4gPg0KPiA+IFJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0K
PiA+IE5vdCByZWxldmFudCB0byB0aGlzIHBhdGNoLCBhbm90aGVyIG9wdGltaXphdGlvbiB0byBw
ZXJjcHUgbWlnaHQgYmUNCj4gPiBnb29kIHRvIHVzZSBwZXIgY2h1bmsgc3Bpbl9sb2NrLCBub3Qg
Z29iYWwgcGNwdV9sb2NrLg0KPiA+DQo+IA0KPiBQZXJjcHUgbWVtb3J5IGl0c2VsZiBpcyBleHBl
bnNpdmUgYW5kIGZvciB0aGUgbW9zdCBwYXJ0IHNob3VsZG4ndCBiZSBwYXJ0IG9mDQo+IHRoZSBj
cml0aWNhbCBwYXRoLiBJZGVhbGx5LCB3ZSBkb24ndCBoYXZlIG11bHRpcGxlIGNodW5rcyBiZWlu
ZyBhbGxvY2F0ZWQNCj4gc2ltdWx0YW5lb3VzbHkgYmVjYXVzZSBvbmNlIGFuIGFsbG9jYXRpb24g
aXMgZ2l2ZW4gb3V0LCB0aGUgY2h1bmsgaXMgcGlubmVkDQo+IHVudGlsIGFsbCBhbGxvY2F0aW9u
cyBhcmUgZnJlZWQuDQoNClRoYW5rcyBmb3IgY2xhcmlmaWNhdGlvbiwgc2luY2Ugbm90IGNyaXRp
Y2FsIHBhdGNoLCB1c2UgZ2xvYmFsIGxvY2sgc2hvdWxkIGJlIG9rLg0KDQpUaGFua3MsDQpQZW5n
Lg0KDQo+IA0KPiBUaGFua3MsDQo+IERlbm5pcw0K
