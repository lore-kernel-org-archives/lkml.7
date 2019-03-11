Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32547C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E772D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="W180dxqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfCKIhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:37:02 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:9033
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfCKIhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoJnVoITaSMNvCOiiedWtrObEwBewMk28kv6Qpbcu7E=;
 b=W180dxqQE3tlZEER+8VWHrgdcCH5q/p94jsgmkHFcp57o23IuHuJM5pOQrFqgMBGTnTl42IMvgqNKy9FXXojd2kFmK8RrwsDW3KTERkPFshBGUARsSn4jYLhQ/L/eHNHyxJipvELuSkYy0bCT0Ry/aI+gygg5J1FtbbQJW3pXvA=
Received: from CY4PR13CA0039.namprd13.prod.outlook.com (2603:10b6:903:99::25)
 by MWHPR13MB1469.namprd13.prod.outlook.com (2603:10b6:300:123::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.11; Mon, 11 Mar
 2019 08:36:57 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR13CA0039.outlook.office365.com
 (2603:10b6:903:99::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.8 via Frontend
 Transport; Mon, 11 Mar 2019 08:36:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.44; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.44) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1686.19 via Frontend Transport; Mon, 11 Mar 2019 08:36:54 +0000
Received: from JPYOKXHT106.jp.sony.com (117.103.191.53) by
 JPYOKXEG104.jp.sony.com (117.103.190.44) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Mon, 11 Mar 2019 08:36:45 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.233]) by
 JPYOKXHT106.jp.sony.com ([117.103.191.53]) with mapi id 14.03.0435.000; Mon,
 11 Mar 2019 08:36:45 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <Jacky.Cao@sony.com>,
        <No.Tanaka@sony.com>, <Kan.Iibuchi@sony.com>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcA=
Date:   Mon, 11 Mar 2019 08:36:44 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
 <1552063928.29776.2.camel@suse.com>
In-Reply-To: <1552063928.29776.2.camel@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:539:0:dddd:1bac:d758]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.44;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(199004)(189003)(13464003)(8936002)(11346002)(6116002)(50466002)(446003)(246002)(8676002)(106466001)(33656002)(356004)(426003)(436003)(102836004)(336012)(6346003)(72206003)(55846006)(2906002)(37786003)(106002)(86152003)(55016002)(14444005)(54906003)(110136005)(4326008)(53546011)(478600001)(2171002)(47776003)(5660300002)(186003)(107886003)(26005)(77096007)(229853002)(7636002)(7736002)(86362001)(486006)(2201001)(316002)(76176011)(6246003)(2876002)(305945005)(2486003)(23676004)(126002)(7696005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1469;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg104.jp.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe8ea2af-8b88-4539-ef1a-08d6a5fcb8a0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7193020);SRVR:MWHPR13MB1469;
X-MS-TrafficTypeDiagnostic: MWHPR13MB1469:
X-Microsoft-Antispam-PRVS: <MWHPR13MB146902A378CB6AA424A882F9C9480@MWHPR13MB1469.namprd13.prod.outlook.com>
X-Forefront-PRVS: 09730BD177
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: shKlBKx1I+MWWtjPSJuHHcbddK3OLiJT2s+3Uy96l/o/nlnteue3c4Bdh5tObloXGG0WatELapT6sbh+11scsGn9Mrk/vu+bNlLwTKp61jQrGRDAGs5IFWqxeUa+1tRqIAJ7UweD5tDcROaattBwb0ytqteI8Yj799oZahuy03H4q5VrO5CxLqPsI4I5eBEUJO3btnvH7RFU2+tBg6ImvfICOvbJJlPRaijvlaunnxlgnVCUkLQcJ7FKPXFlGUcES6Kyt0aRPIiDswrJRpYUM9gkl/6xzozocKufXnsjmKxlGzzJYF1y/Ue570F63Phce5EbkDtXU4o4UdYZ+bHPJBoRx3i1U7zuUL9bQzXG72C5ZiJz7hQrB1PsaGUMupC3rQwzzoMdKorJMgPfoQKYLy0WyX97UqUZIEQh3V47fx0=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2019 08:36:54.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8ea2af-8b88-4539-ef1a-08d6a5fcb8a0
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.44];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj5ubyBJIGFtIHNvcnJ5LCB0aGF0IGlzIGFuIGFzc3VtcHRpb24geW91IGp1c3QgY2Fu
bm90IG1ha2UuDQo+QW55dGhpbmcgY2FuIHRyaWdnZXIgYSByZXNldC4gVGhhdCBiZWluZyBTQ1NJ
IGlzIHRoZSBjb21tb24gY2FzZSBjZXJ0YWlubHksIGJ1dCBub3QgdGhlIG9ubHkgY2FzZS4gQW5k
IGluIHRob3NlIGNhc2VzIHdlIGNhbm5vdCBkZXBlbmQgb24gdXBwZXIgbGF5ZXJzIGRvaW5nIHRo
ZSByaWdodCB0aGluZywgaWYgd2UganVzdCBpZ25vcmUgYW4gZXJyb3IuDQpXaGlsZSB3ZSBpbnZl
c3RpZ2F0ZSB0aGlzIGlzc3VlLCB3ZSBkZWJ1Z2dlZCBhbmQgZm91bmQgdXNiX3Jlc2V0X2FuZF92
ZXJpZnlfZGV2aWNlIHdpbGwgcmV0dXJuIC1OT0RFViBiZWZvcmUgZW50ZXIgcG9zdF9yZXNldCBv
cGVyYXRpb24uDQpBbmQgdGhlIHJldHVybiB2YWx1ZSgtRU5PREVWKSB3aWxsIGJlIHJldHVybmVk
IHRvIGVycm9yIGhhbmRsZXIuDQp1YXNfZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXItPnVzYl9yZXNl
dF9kZXZpY2UgLT4gdXNiX3Jlc2V0X2FuZF92ZXJpZnlfZGV2aWNlIChyZXR1cm4gLUVOT0RFVikg
VGhlbiBJIHdyb3RlIHRoYXQgY29tbWl0IG1lc3NhZ2UgdGhhdCB3ZSB0aGluayBldmVuIGlmIHdl
IGlnbm9yZSAiRU5PREVWIiBpbiBwb3N0IHJlc2V0IHRvIGF2b2lkIGhhbmcgaXNzdWUgYnV0IHRo
ZSBlcnJvciB3aWxsIGFsc28gYmUgcmVwb3J0ZWQgdG8gZXJyb3IgaGFuZGxlci4NCiNJZiBpZ25v
cmUgYW4gZXJyb3IgYW5kIHRoZSBlcnJvciB3aWxsIG5vdCBiZSByZXBvcnRlZCB0aGVuIGl0IGlz
IG5vdCBnb29kLg0KDQpBZGRpdGlvbmFsIGluZm9ybWF0aW9uIGFib3V0IHVzYi1zdG9yYWdlIGRy
aXZlcih1c2Ivc3RvcmFnZS91c2IuYykgaW4gdXNiX3N0b3JfcG9zdF9yZXNldCgpIGZ1bmN0aW9u
LCBpdCBhbHdheXMgcmV0dXJuIDAgdGhhdCBtZWFucyByZWJpbmQgd2lsbCBub3QgYmUgZXhlY3V0
ZSBhbmQgdGhpcyBpc3N1ZSBkb2Vzbid0IGhhcHBlbi4NCg0KUmVnYXJkcywNCktlbnRvIEtvYmF5
YXNoaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogT2xpdmVyIE5ldWt1bSA8
b25ldWt1bUBzdXNlLmNvbT4gDQpTZW50OiBTYXR1cmRheSwgTWFyY2ggOSwgMjAxOSAxOjUyIEFN
DQpUbzogS29iYXlhc2hpLCBLZW50byAoU29ueSkgPEtlbnRvLkEuS29iYXlhc2hpQHNvbnkuY29t
PjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHUN
CkNjOiB1c2Itc3RvcmFnZUBsaXN0cy5vbmUtZXllZC1hbGllbi5uZXQ7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdl
ci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSB1c2I6IHVhczogZml4IHVzYiBzdWJz
eXN0ZW0gaGFuZyBhZnRlciBwb3dlciBvZmYgaHViIHBvcnQNCg0KT24gRnIsIDIwMTktMDMtMDgg
YXQgMDk6MTMgKzAwMDAsIEtlbnRvLkEuS29iYXlhc2hpQHNvbnkuY29tIHdyb3RlOg0KPiBUaGUg
dXNiX3Jlc2V0X2FuZF92ZXJpZnlfZGV2aWNlIGluY2x1ZGVkIGluIHVzYl9yZXNldF9kZXZpY2Ug
ZmFpbHMgDQo+IHdpdGggLUVOT0RFViBhZnRlciBwb3dlciBvZmYgaHViIHBvcnQsIGFuZCB0aGUg
LUVOT0RFViBlcnJvciB3aWxsIGJlIA0KPiByZXBvcnRlZCB0byB1YXNfZWhfYnVzX3Jlc2V0X2hh
bmRsZXIgYW5kIHVwcGVyIGxheWVyLCBzbyBpdCBkb2Vzbid0IA0KPiBuZWVkIHRvIGRvIHJlYmlu
ZCBpZiAtRU5PREVWIGhhcHBlbnMuDQoNCkhpLA0KDQpubyBJIGFtIHNvcnJ5LCB0aGF0IGlzIGFu
IGFzc3VtcHRpb24geW91IGp1c3QgY2Fubm90IG1ha2UuDQpBbnl0aGluZyBjYW4gdHJpZ2dlciBh
IHJlc2V0LiBUaGF0IGJlaW5nIFNDU0kgaXMgdGhlIGNvbW1vbiBjYXNlIGNlcnRhaW5seSwgYnV0
IG5vdCB0aGUgb25seSBjYXNlLiBBbmQgaW4gdGhvc2UgY2FzZXMgd2UgY2Fubm90IGRlcGVuZCBv
biB1cHBlciBsYXllcnMgZG9pbmcgdGhlIHJpZ2h0IHRoaW5nLCBpZiB3ZSBqdXN0IGlnbm9yZSBh
biBlcnJvci4NCg0KTkFDSw0KDQoJU29ycnkNCgkJT2xpdmVyDQoNCg==
