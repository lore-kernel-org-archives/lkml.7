Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3355020863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="dspGvsTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfB1MCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:02:51 -0500
Received: from mail-eopbgr740058.outbound.protection.outlook.com ([40.107.74.58]:11427
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732306AbfB1MCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pcA0Hdnc59ZddInpT4xVan2dno8oYWgHbfq5IAQP70=;
 b=dspGvsTHuBgZlsr5fI6H1whZismFt2TK0cJDPt6ms3+S/HfCW1R2ZdTLkLr6+++tw1cZOSc7PcGY8//EAtagtV7P4+qKkb2iPtayQjT8vCKSM1NSwdD2cV30894jQ8CooIn+S6jO+fy2If+im6Sc9gmqpNjxH0H1SeqC7n3JmU0=
Received: from MWHPR03CA0016.namprd03.prod.outlook.com (2603:10b6:300:117::26)
 by BYAPR03MB3751.namprd03.prod.outlook.com (2603:10b6:a03:6f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Thu, 28 Feb
 2019 12:02:45 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR03CA0016.outlook.office365.com
 (2603:10b6:300:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Thu, 28 Feb 2019 12:02:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 28 Feb 2019 12:02:44 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x1SC2h6r014088
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Feb 2019 04:02:43 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Thu, 28 Feb 2019 07:02:43 -0500
From:   "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "bhole_prashant_q7@lab.ntt.co.jp" <bhole_prashant_q7@lab.ntt.co.jp>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
Thread-Topic: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
Thread-Index: AQHUznmR5TuwCY0+1U2y4bcOxmYc/aXzuTmAgAAAMICAACytgIAAHpqAgAFtMgA=
Date:   Thu, 28 Feb 2019 12:02:42 +0000
Message-ID: <895e1f1108cac84ad9720e3270867c1b9764b93f.camel@analog.com>
References: <20190227085050.30000-1-alexandru.ardelean@analog.com>
         <CAHp75VfsLJq1ei5U-jkgFc-zj-T6KCdTy8+Je+GnjB=KN4BS5w@mail.gmail.com>
         <CAHp75VdgwM_ybfymh28iqxu2qOfzZo79VOF+XE+brj70Aji6YQ@mail.gmail.com>
         <26f1c0d1a7d98a6a41301d58e53bd9abc1d2f5c9.camel@analog.com>
         <CAHp75Vcup+UUYmqo7stwC4FOmG3GWqOOuewmmG_dSiDoeBms7w@mail.gmail.com>
In-Reply-To: <CAHp75Vcup+UUYmqo7stwC4FOmG3GWqOOuewmmG_dSiDoeBms7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED1BE0D6D4261D48871C5F2E97C5AEE0@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(7696005)(76176011)(23676004)(2486003)(5660300002)(316002)(110136005)(3846002)(54906003)(2501003)(478600001)(86362001)(106002)(6116002)(14444005)(356004)(50466002)(6246003)(6306002)(7736002)(102836004)(4326008)(305945005)(7636002)(8676002)(11346002)(246002)(336012)(486006)(53546011)(229853002)(93886005)(106466001)(118296001)(436003)(426003)(2616005)(26005)(186003)(72206003)(966005)(36756003)(47776003)(2906002)(14454004)(126002)(476003)(446003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3751;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea1d8cf-136c-492a-415d-08d69d74a650
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3751;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3751:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3751;20:D7zJI5vWT9kr3cQa7xZK7ng4wZN11xhvxJ5riOxJ9tUtPPy11Ex+LQja/77hvVpDgJNJmbk78cncNxIWW4UYBQ1cz9FuCdlDgttF1RcN/n78fxiuWkFvdQ04ap7nneazZRlEf43+lXYooov8EDgmtGQxet6CpcNg5R5jYu9CwD+p6xrwJY8mYyk6EnmcyBQWq4xnK44NUUOwKbLJZKr049wwgAzxJJpQ4SgH2ObtlAh7tN+s8JU9bmoX84IOwNQTvF8lmtM9JEsJdE6lY6jgdnS2n5/JoltD/PosjlN/pcHo/ZQ9F7iwANIAB8THtQTJ+PXq43rFW7eKy/DgeTaPEf7vmzAuGmVpiokGSZcAiKP2x2+h+2CJfX/bgRm8mfP5Ql7wXJE49KBFrssgg50NASzujFcKPBSLmVMxO30Y6BgniA4PwkpyRwLpH9s88lPIgzclzIwU++4ndHbL6AuWtyyKPV7R2Xdp8Fx8kJG88nY1vkNssMuV41yDxm4y0zFS
X-Microsoft-Antispam-PRVS: <BYAPR03MB3751ADAB972F624593FF4C9695750@BYAPR03MB3751.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0962D394D2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAzTUIzNzUxOzIzOnlBSlIrZ1BGbG9Ddi9hRXo3bnFjWTJyMXpV?=
 =?utf-8?B?RFRsaElKUmcvZys3U0lqRkZSa0o4QkJpRHRzNCt5OEtmdEVsZmluRnJFSTdh?=
 =?utf-8?B?WHFBN3RHL1kycUJoUzR5Q21xTEFxMUdGd0NKSW1xN2UwZ0pMVTFYRXdmODJJ?=
 =?utf-8?B?SFJIbmJjMHZsL3hkTTRCU0tTcXF3UGJhZ2U3TGxXdjdEd3piUDJWMThHS3VR?=
 =?utf-8?B?YWhRYjJZYmFiVGN3OHhaaDE2ZWkreURraUtIZDFFRVhoOTZSclhqTkJlems3?=
 =?utf-8?B?RW9JWkYwSFpjTDBWQ21HT2UvN3Q1QnBrbThKZzdsTnROSEptVlpiVjdFb1Vu?=
 =?utf-8?B?a25zQ1dVQUNMVnY4UzQrcjBiTmtKR2huTjdmdlQwblRZTUlOTWRuL0hYRGZ4?=
 =?utf-8?B?ZzVURmtWWjlyNFRXOFB1cmcxN0pWQzM0M0VXZk9rSWR1aUh0T2R4NmlNNlhX?=
 =?utf-8?B?aXlDcHBMbGxOaTF0QU44YUd5VzNGRmRvMHFiQVZQR2JWUnZMcDQzb05YUmZT?=
 =?utf-8?B?bUVqTXJ3dm8xejZnNktHSHFBem4zVTVCdlFISXpIQ2NnenNBMUtONFpGYmI0?=
 =?utf-8?B?UXh1bi9hOHNteWE3YTRPS0VLYWVXRktIMzJITC9teWNrSzBXSFZKVEtVRFFI?=
 =?utf-8?B?cVdrakdFYWFuYkJlRnFmVU9jbzhWaGxnMjF5SVprQ1JTRXJ3SG9nZEZGVkNG?=
 =?utf-8?B?VEkwK251T0I2QUI2OGtoOUJwbVh6ZGN2TzFhTDd2VjBhR3hPbVdLdFJGU2Mz?=
 =?utf-8?B?WFZUNmNETmlobktzMnJlQ1E0YmhZVHpBaFNjZ0xzbklwOHZnMStvSDFWRlFC?=
 =?utf-8?B?aGlTaHk0RlFKeHRMdEVNclQvY0oxUzBxMDRBVkp1UWJSOEkwUElwOGJOdG56?=
 =?utf-8?B?MmpnTTEwbldnTEtKc0FBRjVBUk5aZ2tVeU9GMk5DZk5WY1d0TXcyUUF3ZFdz?=
 =?utf-8?B?QThFVmlPUHVjNFJPMjJuNy9QbS9Ea1NIQzRJT3ZUejA3MFlPNU5VMGR4NDNu?=
 =?utf-8?B?WmxpU0kvZlNna211eVpGd3c3cUFyV3o1VzlaWjZwdGJ1ZVR1TVN6TEZHQllS?=
 =?utf-8?B?SjBvNisrWjcxckRpTlBLL0RTZ0RuKzVrZVpHRmhrRUZhUHZtTUljSGZEWlV4?=
 =?utf-8?B?VG9zd2FGSGFXMklSekZOL2xYWEJoQTkzcHlYR0VKdXc2Y3B1aVFwbjZDQk05?=
 =?utf-8?B?OFVDOG44aVhrK08wU0o3S2M3bTNZMWk4dXdtTHRpck5jNWFITUMyNlRkeWh4?=
 =?utf-8?B?ZGRlWklvbmhXOUF5eG5kYk96alNsR1hsclhrUFBMM2xsVStXTURNUDMvYndX?=
 =?utf-8?B?QUNNM3BMZlBiU3crRTBHZE9mZ2lXRjJkYnJPYkJYWXhwNHQrVkJRMUJmMFpT?=
 =?utf-8?B?cVNwRW42VWUxUUhSbERiTWlEU3BHdnhWTHJkNHgvenFnZnM4VXlYTmdqWHJ2?=
 =?utf-8?B?Sk5wNUtxL2RVcksyOGlkNGlOeHlIMDc5WnJxNWN5bCtrUk9RRDZiL0ZIb0or?=
 =?utf-8?B?TkRIU0FZOFp0KzJYaFZHeWNDQnZubVArL1UyMXVEbzdvZXhicnZMbG9sYWQw?=
 =?utf-8?B?WWxpUWpDWEthcWN2R2R5THQvQ2IyMVhxMUVSM3pjL2Z2ZGJTS1YybmpRc3dR?=
 =?utf-8?B?RkpWYitPTUY3YjQvQVlGRTVTaUd2U1VBajZTbXlDc0doR2UrSmNNc2J3PT0=?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WXhArAZwjh61yr2SGaHgY0fRt8MtmfYcIyNWwVmxjuqIbdqNd7HjPwF0UN5e+BkU41cBjjStJie5EvzCFksjalWwCJ3c6yqlHxfEvCcUq+ej2ND+AxOlGF+2Y9tOdVYDTe5gC0iRcHqBmYRwdmWR83Z7WcuRQcoWDxuGz4B7bP5vMlg1r8QVpUYtVDz9ufBdkCZYu4wQfVStL9yt8y17KMrQ3qEG0rn6xQlTEYd2r/AO1ecvAEizYDS3JrXv3toPU/PseoNholguCdtGZoPBQEsGnlvvZNxXhdc6xr73aKDyG5FYx7LSXDbU4f89BbAF1sAE52TMLL2PO1HputgnugGO3B+0fu+4l932QdjVZjIbzbe7MA0gBKTIjQ9SzAraxnWTdp7JIzcWvuXptdUM9DsCQdYUC45gxB1i1I5Jndg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2019 12:02:44.6734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea1d8cf-136c-492a-415d-08d69d74a650
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTI3IGF0IDE2OjE1ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBXZWQsIEZlYiAyNywgMjAxOSBhdCAyOjI2IFBN
IEFyZGVsZWFuLCBBbGV4YW5kcnUNCj4gPEFsZXguQXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6
DQo+ID4gDQo+ID4gT24gV2VkLCAyMDE5LTAyLTI3IGF0IDExOjQ2ICswMjAwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gK0Nj
IFZpbm9kDQo+ID4gPiANCj4gPiA+IE9uIFdlZCwgRmViIDI3LCAyMDE5IGF0IDExOjQ1IEFNIEFu
ZHkgU2hldmNoZW5rbw0KPiA+ID4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0K
PiA+ID4gPiANCj4gPiA+ID4gT24gV2VkLCBGZWIgMjcsIDIwMTkgYXQgMTA6NTEgQU0gQWxleGFu
ZHJ1IEFyZGVsZWFuDQo+ID4gPiA+IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNo
ZXZjaGVua29AZ21haWwuY29tPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNvbWV0aW1lcyB0aGUg
dXNlciBuZWVkcyB0byBzcGxpdCBlYWNoIGVudHJ5IG9uIHRoZSBtYXBwZWQNCj4gPiA+ID4gPiBz
Y2F0dGVyDQo+ID4gPiA+ID4gbGlzdA0KPiA+ID4gPiA+IGR1ZSB0byBETUEgbGVuZ3RoIGNvbnN0
cmFpbnMuIFRoaXMgaGVscGVyIHJldHVybnMgYSBudW1iZXIgb2YNCj4gPiA+ID4gPiBlbnRpdGll
cw0KPiA+ID4gPiA+IGFzc3VtaW5nIHRoYXQgZWFjaCBvZiB0aGVtIGlzIG5vdCBiaWdnZXIgdGhh
biBzdXBwbGllZCBtYXhpbXVtDQo+ID4gPiA+ID4gbGVuZ3RoLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWls
LmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhh
bmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gSG1tLi4uIFVzdWFs
bHkgd2UgZG9uJ3QgYWNjZXB0IGdlbmVyaWMgQVBJIHdpdGhvdXQgdXNlcnMuDQo+ID4gPiA+IERv
IHlvdSBoYXZlIGFueSB1c2UgY2FzZSBpbiBtaW5kPw0KPiA+IA0KPiA+IFllcDogdGhpcyBvbmU6
DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDgxNDUyNy8NCj4gPiAN
Cj4gPiBCdXQsIEkgY2FuIHJld29yayB0aGlzIHBhdGNoIHRvIHdvcmsgd2l0aG91dCB0aGUgaGVs
cGVyLg0KPiANCj4gQWgsIG9rYXksIHdvcnRoIHRvIG1lbnRpb24gdGhpcyBpbiBjb21tZW50cyAo
aW4gYWRkaXRpb24gdG8gd2hhdCB5b3UNCj4gcHV0IGFib3V0IHRoZSBwYXRjaCBiZWxvdykuDQo+
IA0KPiA+ID4gPiA+IFBhdGNoIHdhcyBzZW50IGluIDIwMTYgaW5pdGlhbGx5IHRvIHRoZSBETUEg
ZW5naW5lIHN1Yi1zeXN0ZW0uDQo+ID4gPiA+ID4gTGluazoNCj4gPiA+ID4gPiAgIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTM4OTgyMS8NCj4gPiA+ID4gPiBUaGlzIHdhcyBw
YXJ0IG9mIGEgbGFyZ2VyIHNlcmllczoNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1kbWFlbmdpbmUvbGlzdC8/cT1zZ19u
ZW50c19mb3JfZG1hJmFyY2hpdmU9Ym90aCZzZXJpZXM9JnN1Ym1pdHRlcj0mZGVsZWdhdGU9JnN0
YXRlPSoNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBzdXBw
b3NlZCB0byBnbyBpbnRvIERNQUVuZ2luZSBvcg0KPiA+ID4gPiA+IGxpYi9zY2F0dGVybGlzdC4N
Cj4gPiA+ID4gPiBJdCBkb2Vzbid0IGxvb2sgbGlrZSBsaWIvc2NhdHRlcmxpc3QgaXMgbWFuYWdl
ZCBieSBETUFFbmdpbmUsIHNvDQo+ID4gPiA+ID4gKGJ5DQo+ID4gPiA+ID4gdXNpbmcNCj4gPiA+
ID4gPiB0aGUgYGdldF9tYWludGFpbmVycy5wbGAgc2NyaXB0KSBJJ20gc2VuZGluZyB0aGlzIHBh
dGNoIHRvIHRoaXMNCj4gPiA+ID4gPiBncm91cA0KPiA+ID4gPiA+IG9mDQo+ID4gPiA+ID4gcGFy
dGllcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBwcm9ibGVtIHRoZSBwYXRjaCB0cmllZCB0byBz
b2x2ZSBpcyBtdWNoIGRlZXBlciBhbmQgY29ycmVjdA0KPiA+ID4gPiBzb2x1dGlvbiBzaG91bGQg
YmUgbW9yZSBnZW5lcmljLCBpLmUuDQo+ID4gPiA+IGVhY2ggY2hhbm5lbCBzaG91bGQgcHJvdmlk
ZSBhIHNldCBvZiBwYXJhbWV0ZXJzLCBzdWNoIGFzIERNQQ0KPiA+ID4gPiBzZWdtZW50DQo+ID4g
PiA+IHNpemUsIHRvIHRoZSB1c2VycyAodmlhIERNQSBlbmdpbmUgQVBJKSBhbmQgdXNlcnMgc2hv
dWxkIHByZXBhcmUNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IFNHIGxpc3QgYWNjb3JkaW5nIHRvIHRo
ZSBsaW1pdHMgb2YgdGhlIGNoYW5uZWwuDQo+ID4gPiA+IEluIHRoYXQgY2FzZSB3ZSBkb24ndCBu
ZWVkIHRvIHJlLXNwbGl0L3JlLWFsbG9jYXRlIGdpdmVuIFNHIGxpc3QgYXQNCj4gPiA+ID4gYWxs
LCB3aGljaCB3b3VsZCBzaW1wbGlmeSBETUEgc2xhdmUgZHJpdmVycyBhbmQgdGhlaXIgdXNlcnMu
DQo+ID4gPiA+IA0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgSSBtYW5hZ2VkIHRvIGZvbGxvdyBb
b3IgZmluZF0gdGhlIGZ1bGwgbGVuZ3RoIG9mIHRoYXQNCj4gPiBkaXNjdXNzaW9uLiBPciwgdGhl
IGNvbmNsdXNpb24gd2Fzbid0IHRoYXQgb2J2aW91cyB0byBtZSwgZnJvbSB3aGF0IEkNCj4gPiBm
b3VuZC4NCj4gPiBJIGFzc3VtZWQgdGhpcyBtYXkgaGF2ZSBiZWVuIGRyb3BwZWQvZm9yZ290dGVu
Lg0KPiA+IA0KPiA+IEluIGFueSBjYXNlLCBJIGFtIGZpbmUgd2l0aCBqdXN0IHJld29ya2luZy4N
Cj4gDQo+IEl0J3MgZmluZSB0byBhcHBseSBpdCwgbXkgcG9pbnQgdGhhdCBpdCBoZWxwIHRvIHNv
bHZlIGEgc3ltcHRvbSBpbiBhDQo+IHNob3J0LXRlcm0gKGhvd2V2ZXIgdGhpcyBzaG9ydC10ZXJt
IGNhbiBiZSBlYXNpbHkgYSBsb25nIG9uZSBkdWUgdG8gbm8NCj4gZ3VhcmFudGVlIHRoYXQgYWxs
IGRyaXZlcnMgdXNpbmcgU0cgZm9yIERNQSB3aWxsIGJlIGNvbnZlcnRlZCkuDQo+IFNvLCBwbGVh
c2UsIHVwZGF0ZSB0aGUgY29tbWVudHMgYW5kIHJlc3VibWl0IGFzIGEgbmV3IHZlcnNpb24uDQo+
IA0KDQpUaGVyZSdzIHNvIG11Y2ggdW5jZXJ0YWludHkgYWJvdXQgdGhpcyBwYXRjaCwgdGhhdCBp
dCBtYWtlcyBpdCBlYXNpZXIgW2FuZA0KcHJvYmFibHkgbWFrZXMgbW9yZSBzZW5zZV0gdG8ganVz
dCByZXdvcmsgdGhlIEFYSSBETUFDIHBhdGNoIHRvIG5vdCB1c2UNCnRoaXMgaGVscGVyLg0KDQpU
aGlzIGlzIGFsc28gaW4gdGhlIGhvcGUgdGhhdCBvbmUgZGF5IHdlIHdpbGwgZ2V0IHRvIHRoZSBt
b3JlIGdlbmVyaWMgQVBJDQp0aGF0IHlvdSBtZW50aW9uZWQuDQoNCj4gLS0NCj4gV2l0aCBCZXN0
IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
