Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934B0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4488D20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="q2V232j1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfD2CGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 22:06:32 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.211]:62825 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbfD2CGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:06:31 -0400
Received: from [67.219.251.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-west-2.aws.symcld.net id B0/43-08672-32C56CC5; Mon, 29 Apr 2019 02:06:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSfUgTcRj2d3fbLvHiPC3fhlotozI2nP7hERQ
  RRBIUUVBm6+OW1zadc91NtOiPFX1q9p3kbFZW2Idirog0q2kpOFLDMikimQl+4AeWUhRZu90q
  ++95n+d5f8/7/nhJnOlQqkm+wMELNs6qUYYT5gE/pl1gaDEkVXSr2BpfC84+GS1TsK/rLyvZs
  8e7MHb0W7GKPVo7idiG5uP4SlXa2NMuZdoXT3xaR8+UagOeobDYjLkFuxTmC91fMHu7rsDzfq
  MTOXWFKJxk6H4ER/sHlXLxAoHfXRssCPoWDo1PrmGycgoD78PDoaIHwde2OlUhmkEq6SXQOvw
  Wl3B0AHdeHlZIJpyuwaD7vguThCh6C/i9k0g2pcPjyiOYjHXgHjoS5Al6Ifhe9wV5ijaA7+C7
  YACi46CktyfI43QMuEtcCgkDTcONhg5cxrNg8NNUgCcD/o0w+mCHTGtg7EYpJuM46LxShGS8D
  oqOlSFpTqBfIShu8yhlIRHut1eFGrKh+eOJEF4Eh8fLQ7mx4D35XCU3v1fAhK8qGMzQRqj+YZ
  E98XCn2E/Ing4cPhTfQ/ICiVDu/BFaZj5cKPKrzqDFrmm7uabZXNNsruC/REJraR9xFRF3UKp
  RsJjMjhzOYtXqk5K0en2yVp/CatkUHbdfu1uXJ2rzedGhTdZx+aJO3Jez25qps/EODwqcVaa9
  cNMjVFZkakJzSEwzi7r5sNnAzDTmZu4zc6J5p5Bn5cUmFEuSGqDmbWsxMJECb+IL9lisgdv8I
  wMZoYmmKEmmRDuXI1pMsuRDKaS3wu/GyZHGfjfOELZcG6+OodZKVlqymvNsfx/6c+edKE4dRa
  GwsDAmws4LORbH//oQiiGRJopKlV6JsNgcf/OGAqNggVEybzdJozi4f5LaiUprpybeMPUHTq0
  p2Rpb33ZxpLUnqqE8ayD++kSXcvYBszFak306LZ356f9odZ+vbM895H+VNNe2IivhWSV9l14W
  8/3mlLAr4+vc6tbml3vPbZ8pOI8lqH89UGQs9dnHrw9ujrROKlaYPhPeVR82j1TUUXUZNULT8
  qFL51f3ZnvWp2oI0czpE3FB5H4DQ2C9teIDAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-14.tower-366.messagelabs.com!1556503584!2692696!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18854 invoked from network); 29 Apr 2019 02:06:26 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-14.tower-366.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Apr 2019 02:06:26 -0000
Received: from USEXEDGE02.lenovo.com (unknown [10.62.65.5]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 4921_17ec_39a1e29f_94dc_4e43_8554_480da70d35b7;
        Mon, 29 Apr 2019 02:06:20 +0000
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.51)
 by USEXEDGE02.lenovo.com (10.62.65.5) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Sun, 28 Apr 2019 22:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj46vvHH4yTgBXx7K5aHjOUwavC9Lmgbt+7NafH3BmM=;
 b=q2V232j1brnTuMs3P644urgp5fiIzH2zyRrXt1q/gYt/0U91L6O+zsqvLyLcR/iy0cyiidVJP2FFnE/4yfbCPRNs+h/VX7MJljbqlTS13wFgEUDiAZrFYubtWEInfckWoq8OYTE2PFx+CvcKUsZyKfGYfI6ofL2lXeGpG4UOgnY=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB1746.apcprd03.prod.outlook.com (10.165.179.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.9; Mon, 29 Apr 2019 02:06:16 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::c5e2:754c:4a83:59c2]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::c5e2:754c:4a83:59c2%5]) with mapi id 15.20.1856.007; Mon, 29 Apr 2019
 02:06:16 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        NingTing Cheng <chengnt@lenovo.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: Re: [PATCH] dm-writecache: avoid unnecessary lookups in
 writecache_find_entry
Thread-Topic: [PATCH] dm-writecache: avoid unnecessary lookups in
 writecache_find_entry
Thread-Index: AdT+Lz3qx9IFZ0iARsWJtQbJywgOzA==
Date:   Mon, 29 Apr 2019 02:06:16 +0000
Message-ID: <HK2PR03MB4418630B5A3A114F21B5986692390@HK2PR03MB4418.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.95.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b60004bd-427d-42f7-713c-08d6cc474353
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:HK2PR03MB1746;
x-ms-traffictypediagnostic: HK2PR03MB1746:
x-microsoft-antispam-prvs: <HK2PR03MB1746C636968521CAE6A6448F92390@HK2PR03MB1746.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(136003)(346002)(396003)(366004)(199004)(189003)(6116002)(54906003)(102836004)(3846002)(6916009)(6436002)(53936002)(99286004)(6246003)(7696005)(229853002)(256004)(25786009)(6506007)(97736004)(4326008)(305945005)(7736002)(33656002)(74316002)(2906002)(86362001)(26005)(186003)(66556008)(66476007)(8936002)(14454004)(81166006)(52536014)(81156014)(8676002)(66066001)(73956011)(66946007)(68736007)(478600001)(76116006)(486006)(71200400001)(55016002)(316002)(9686003)(5660300002)(71190400001)(476003)(66446008)(64756008)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1746;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2xhOqlHJIvS9oPQk1ucLfAy86+LdUkMh0LagwQJyel9dJUyW8wLE5yFZhSZSRV0LZPTUNtOBhQYfI1FCgtvizM72eCT2PbV4nEiOs89lyVKoRTMdwmr4n/UhIEkfMUzfDUHa/w8Q9mmi00gsRyZdZbhinDuseju6H20SEYGrGacF4iyQ5sakJbeHBgHCdyF/xPLBpZ/pXVoBZ9qc0vJ8MBkhkMiYz4CKsh0nX69txg/lE2tYNe9YS6GIk3dDJSQKiwHXmXWUAy4xs9wVpVvvT0N10c1mdX++bO6JoSbhixOrHnSq01DkUDfmPegeS8CyB9QbuxE2qCuLTjnlXZCZHmcY1Z+iOH6L2uXyL1T9L5CJKp7Mis1JXMBXlPXhkDGSj4MK6nYSiZod4lDwYrjo1iWJSoyHTIgnM6LX+Bxlb1g=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b60004bd-427d-42f7-713c-08d6cc474353
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 02:06:16.1931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpGcm9tOiBNaWt1bGFzIFBhdG9ja2EgPG1wYXRvY2thQHJlZGhhdC5jb20+DQpTZW50OiBGcmlk
YXksIEFwcmlsIDI2LCAyMDE5IDk6NTkgUE0NCj4gDQo+IA0KPiBPbiBXZWQsIDI0IEFwciAyMDE5
LCBIdWFpc2hlbmcgSFMxIFllIHdyb3RlOg0KPiANCj4gPiBGcm9tOiBNaWt1bGFzIFBhdG9ja2Eg
PG1wYXRvY2thQHJlZGhhdC5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMjMsIDIwMTkg
MTE6NDQgUE0NCj4gPiA+DQo+ID4gPiBPbiBTdW4sIDIxIEFwciAyMDE5LCBIdWFpc2hlbmcgWWUg
d3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBIdWFpc2hlbmcgWWUgPHllaHMxQGxlbm92by5j
b20+DQo+ID4gPiA+DQo+ID4gPiA+IE9ubHkgd2hlbiBlbnRyeSBoYXMgYmVlbiBmb3VuZCwgdGhh
dCB3b3VsZCBvbmx5IGJlIG5lY2Vzc2FyeSB0byBjaGVjayB0aGUNCj4gPiA+ID4gbG93ZXN0IG9y
IGhpZ2hlc3Qgc2VxLWNvdW50Lg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQgbG9jYWwgdmFyaWFibGUg
ImZvdW5kIiBpbiB3cml0ZWNhY2hlX2ZpbmRfZW50cnksIGlmIG5vIGVudHJ5IGhhcyBiZWVuDQo+
ID4gPiA+IGZvdW5kLCBpdCBpcyBtZWFuaW5nbGVzcyB0aGF0IGhhdmluZyBhIHVzZWxlc3MgcmJf
cHJldiBvciByYl9uZXh0Lg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBIaQ0KPiA+ID4NCj4gPiA+IEkg
ZG9uJ3QgcXVpdGUgc2VlIHdoYXQgaXMgdGhpcyBwYXRjaCB0cnlpbmcgdG8gZml4Lg0KPiA+ID4g
RG9uJ3QgZml4IHNvbWV0aGluZyB0aGF0IGlzbid0IGJyb2tlbg0KPiA+DQo+ID4gSGkgTWlrdWxh
cywNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXBseS4NCj4gPiBUaGlzIHBhdGNoIGlzIG5v
dCBkZXNpZ25lZCBmb3IgZml4aW5nIGxvZ2ljYWwgZXJyb3IuIFRoYXQgaXMgdXNlZCBmb3Igb3B0
aW1pemluZyB0aGUgYmVoYXZpb3INCj4gb2Ygd3JpdGVjYWNoZV9maW5kX2VudHJ5Lg0KPiA+DQo+
ID4gTGV0IG1lIGdpdmUgYW4gZXhhbXBsZSB0byBpbGx1c3RyYXRlIHRoZSBwb2ludCBiZWxvdy4N
Cj4gPiBTdXBwb3NlIHRoYXQgaXMgdGhlIGNhc2UsIGhlcmUgaXMgYSBub3JtYWwgUkVBRCBiaW8g
Y29tZXMgdG8gd3JpdGVjYWNoZV9tYXAuIEFuZCBiZWNhdXNlIG9mDQo+IGJpbydzIGRpcmVjdGlv
biBpcyBSRUFELCB3cml0ZWNhY2hlX2ZpbmRfZW50cnkgd291bGQgYmUgY2FsbGVkIHdpdGggZmxh
Z3MgV0ZFX1JFVFVSTl9GT0xMT1dJTkcuDQo+ID4NCj4gPiBOb3cgdGhlcmUgYXJlIHR3byBzY2Vu
YXJpb3MsDQo+ID4gMS4gd3JpdGVjYWNoZV9maW5kX2VudHJ5IHN1Y2Nlc3NmdWxseSBnZXQgYW4g
ZXhpc3RpbmcgZW50cnkgYnkgc2VhcmNoaW5nIHJiX3RyZWUsIHdlIGNvdWxkDQo+IGNhbGwgaXQg
SElULiBUaGVuIHRoZSBmaXJzdCAnd2hpbGUnIHdpbGwgYmUgZmluaXNoZWQgYnkgJ2JyZWFrJy4g
TmV4dCBpdCB3aWxsIG1vdmUgdG8gc2Vjb25kDQo+ICd3aGlsZScgbG9vcCwgYmVjYXVzZSBvZiB0
aGUgZmxhZ3MgaGFzbid0IGJlZW4gbWFya2VkIGFzIFdGRV9MT1dFU1RfU0VRLiB3cml0ZWNhY2hl
X2ZpbmRfZW50cnkNCj4gd2lsbCB0cnkgdG8gcmV0dXJuIGFuIGVudHJ5IHdpdGggSElHSEVTVF9T
RVEsIGlmIHRoZXJlIGFyZSBvdGhlciBlbnRyaWVzIHdoaWNoIGhhcyBzYW1lDQo+IG9yaWdpbmFs
X3NlY3RvciBpbiByYl90cmVlLg0KPiA+IEZvciB0aGlzIHNpdHVhdGlvbiwgdGhlIGN1cnJlbnQg
Y29kZSBpcyBva2F5IHRvIGRlYWwgd2l0aCBpdC4NCj4gPg0KPiA+IDIuIHdyaXRlY2FjaGVfZmlu
ZF9lbnRyeSBjb3VsZG4ndCBnZXQgYW4gZXhpc3RpbmcgZW50cnkgZnJvbSByYl90cmVlLCB3ZSBj
b3VsZCBjYWxsIGl0IE1JU1MuDQo+IEJlY2F1c2Ugb2Ygc2FtZSBmbGFncyBXRkVfUkVUVVJOX0ZP
TExPV0lORywgd3JpdGVjYWNoZV9maW5kX2VudHJ5IHdpbGwgZ2V0IG90aGVyIGVudHJ5LCB3aGlj
aCdzDQo+IG9yaWdpbmFsX3NlY3RvciB3aWxsIHNsaWdodGx5IGxhcmdlciB0aGFuIGlucHV0IHBh
cmFtZXRlciBibG9jaywgd2l0aCBiaWcgcHJvYmFiaWxpdHkuDQo+ID4gRm9yIHRoaXMgc2NlbmFy
aW8sIGZ1bmN0aW9uIHdyaXRlY2FjaGVfZmluZF9lbnRyeSBkb2Vzbid0IG5lZWQgdG8gZW50ZXIg
c2Vjb25kICd3aGlsZScgbG9vcC4NCj4gQnV0IGN1cnJlbnQgY29kZSB3b3VsZCBzdGlsbCB0cnkg
dG8gY2hlY2sgdGhlcmUgd2VyZSBvdGhlciBlbnRyeSB3aXRoIHNhbWUgb3JpZ2luYWxfc2VjdG9y
Lg0KPiA+IFNvIHRoZSBhZGRpdGlvbmFsIHJiX25leHQgb3IgcmJfcHJldiBpcyB1bm5lY2Vzc2Fy
eSBieSB0aGlzIGNhc2UsIGFsc28gdGhlIGNvZGUgZG9lc24ndCBuZWVkDQo+IHRvIGNvbXBhcmUg
dGhlIG9yaWdpbmFsX3NlY3RvciBvZiAnZTInIHdpdGggcGFyYW1ldGVyICdibG9jaycuDQo+ID4N
Cj4gPiBNeSBwYXRjaCBpcyBkZXNpZ25lZCB0byBvcHRpbWl6ZSB0aGUgc2Vjb25kIGNhc2UuIHNv
IHdlIGNvdWxkIHNraXAgdGhlIHNlY29uZCAnd2hpbGUnIGxvb3ANCj4gd2hlbiB0aGUgYmxvY2sg
aXMgbWlzc2VkIGZyb20gcmJfdHJlZS4NCj4gPg0KPiA+IENoZWVycywNCj4gPiBIdWFpc2hlbmcg
WWUNCj4gDQo+IFNvLCBpdCBzZWVtcyB0aGF0IHdlIGRvbid0IG5lZWQgdGhlICJmb3VuZCIgdmFy
aWFibGUgYXQgYWxsLCB3ZSBjb3VsZCBqdXN0DQo+IHJldHVybiB0aGUgdmFyaWFibGUgImUiIGRp
cmVjdGx5IHdoZW4gd2UgYXJlIGluIGEgcG9zaXRpb24gd2hlcmUgImZvdW5kIg0KPiBpcyBmYWxz
ZS4NCj4gDQo+IFdoYXQgYWJvdXQgdGhpcyBwYXRjaD8gQ291bGQgeW91IHRlc3QgaXQ/DQo+IA0K
PiBNaWt1bGFzDQoNCg0KSGkgTWlrdWxhcywNCg0KU3VyZSwgSSBsaWtlIHlvdXIgcGF0Y2guIEl0
IGlzIHF1aXRlIHN0cmFpZ2h0IGZvcndhcmQuDQpBbmQgdGhlcmUgaXMgbm8gbG9naWNhbCBkaWZm
ZXJlbmNlIGJldHdlZW4gdGhlbSwgSSBoYXZlIHRlc3RlZCBpdCBhbmQgZ2V0IGEgcG9zaXRpdmUg
cmVzdWx0Lg0KDQpDaGVlcnMsDQpIdWFpc2hlbmcgWWUgfCDStruzyqQNCkxpbnV4IGtlcm5lbCB8
IExlbm92byBEQ0cNCg0KPiANCj4gDQo+IEZyb206IE1pa3VsYXMgUGF0b2NrYSA8bXBhdG9ja2FA
cmVkaGF0LmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkbS13cml0ZWNhY2hlOiBhIHNtYWxsIG9w
dGltaXphdGlvbiBpbiB3cml0ZWNhY2hlX2ZpbmRfZW50cnkNCj4gDQo+IElmIHdlIGdvIHBhc3Qg
dGhlIGNvbmRpdGlvbiAiaWYgKHVubGlrZWx5KCFub2RlKSkiLCB3ZSBjYW4gYmUgY2VydGFpbiB0
aGF0DQo+IHRoZXJlIGlzIG5vIGVudHJ5IGluIHRoZSB0cmVlIHRoYXQgaGFzIHRoZSBibG9jayBl
cXVhbCB0byB0aGUgImJsb2NrIg0KPiB2YXJpYWJsZS4NCj4gDQo+IENvbnNlcXVlbnRseSwgd2Ug
Y2FuIHJldHVybiB0aGUgbmV4dCBlbnRyeSBkaXJlY3RseSwgd2UgZG9uJ3QgbmVlZCB0byBnbw0K
PiB0byB0aGUgc2Vjb25kIHBhcnQgb2YgdGhlIGZ1bmN0aW9uIHRoYXQgZmluZHMgdGhlIGVudHJ5
IHdpdGggbG93ZXN0IG9yDQo+IGhpZ2hlc3Qgc2VxIG51bWJlciB0aGF0IG1hdGNoZXMgdGhlICJi
bG9jayIgdmFyaWFibGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWt1bGFzIFBhdG9ja2EgPG1w
YXRvY2thQHJlZGhhdC5jb20+DQo+IA0KPiAtLS0NCj4gIGRyaXZlcnMvbWQvZG0td3JpdGVjYWNo
ZS5jIHwgICAgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL21kL2RtLXdyaXRlY2Fj
aGUuYw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL21kL2RtLXdy
aXRlY2FjaGUuYwkyMDE5LTAzLTE4IDEwOjI4OjUwLjAwMDAwMDAwMCArMDEwMA0KPiArKysgbGlu
dXgtMi42L2RyaXZlcnMvbWQvZG0td3JpdGVjYWNoZS5jCTIwMTktMDQtMjYgMTU6NDk6MTguMDAw
MDAwMDAwICswMjAwDQo+IEBAIC01NTMsMTQgKzU1MywxNCBAQCBzdGF0aWMgc3RydWN0IHdjX2Vu
dHJ5ICp3cml0ZWNhY2hlX2ZpbmRfDQo+ICAJCQkJcmV0dXJuIE5VTEw7DQo+ICAJCQl9DQo+ICAJ
CQlpZiAocmVhZF9vcmlnaW5hbF9zZWN0b3Iod2MsIGUpID49IGJsb2NrKSB7DQo+IC0JCQkJYnJl
YWs7DQo+ICsJCQkJcmV0dXJuIGU7DQo+ICAJCQl9IGVsc2Ugew0KPiAgCQkJCW5vZGUgPSByYl9u
ZXh0KCZlLT5yYl9ub2RlKTsNCj4gIAkJCQlpZiAodW5saWtlbHkoIW5vZGUpKSB7DQo+ICAJCQkJ
CXJldHVybiBOVUxMOw0KPiAgCQkJCX0NCj4gIAkJCQllID0gY29udGFpbmVyX29mKG5vZGUsIHN0
cnVjdCB3Y19lbnRyeSwgcmJfbm9kZSk7DQo+IC0JCQkJYnJlYWs7DQo+ICsJCQkJcmV0dXJuIGU7
DQo+ICAJCQl9DQo+ICAJCX0NCj4gIAl9DQo=
