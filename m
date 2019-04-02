Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7B2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484C12084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="a08Y2JZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfDBA2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:28:13 -0400
Received: from mail-eopbgr700127.outbound.protection.outlook.com ([40.107.70.127]:61370
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfDBA2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMdtiMYVx8+9wppkXzkWGB9P9yNAjBjnsK2B+fhdwgw=;
 b=a08Y2JZEcvXRhH+kkMewioSwSBYLqbDqRozhbNG5snIyVb9TvkYQE19KiEMYvQgjJYiJ8R99JgvCpGsGLEOQge8k/W9Mzxhcemj6iH8VvJ58rTUVKGrW6NUaFBnrDOU7R1duMHTmvCNBLffsYIawz11lNfXlgd/7ACoDxFSn8G8=
Received: from CY4PR13CA0092.namprd13.prod.outlook.com (2603:10b6:903:152::30)
 by BN6PR13MB1396.namprd13.prod.outlook.com (2603:10b6:404:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.7; Tue, 2 Apr
 2019 00:28:07 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by CY4PR13CA0092.outlook.office365.com
 (2603:10b6:903:152::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.11 via Frontend
 Transport; Tue, 2 Apr 2019 00:28:06 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.43)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.43; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.43) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1750.16 via Frontend Transport; Tue, 2 Apr 2019 00:28:06 +0000
Received: from JPYOKXHT203.jp.sony.com (117.103.191.81) by
 JPYOKXEG103.jp.sony.com (117.103.190.43) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 2 Apr 2019 00:28:04 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.107]) by
 JPYOKXHT203.jp.sony.com ([180.12.183.211]) with mapi id 14.03.0439.000; Tue,
 2 Apr 2019 00:28:04 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <Kento.A.Kobayashi@sony.com>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcAAgdcBTAAAJSpAACOr4UQABH/lYAA3G8Q4A==
Date:   Tue, 2 Apr 2019 00:28:04 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE58914EB@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE5872241@JPYOKXMS103.jp.sony.com>
         <1552063928.29776.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE587268B@JPYOKXMS103.jp.sony.com>
         <1552405047.21557.7.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE5873FFB@JPYOKXMS103.jp.sony.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE588EA40@JPYOKXMS103.jp.sony.com>
         <1553510086.2668.2.camel@suse.com>
         <AE5419EAB4965843B3C0C1FE29F1FFE588FCC9@JPYOKXMS103.jp.sony.com>
 <1553786139.14990.6.camel@suse.com>
In-Reply-To: <1553786139.14990.6.camel@suse.com>
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
X-Forefront-Antispam-Report: CIP:117.103.190.43;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(199004)(189003)(8936002)(7696005)(47776003)(76176011)(37786003)(229853002)(11346002)(2906002)(2876002)(186003)(26005)(336012)(6116002)(446003)(7736002)(50466002)(33656002)(86152003)(305945005)(55016002)(6246003)(2171002)(55846006)(126002)(426003)(7636002)(14444005)(23676004)(4326008)(246002)(316002)(5660300002)(8676002)(436003)(476003)(486006)(478600001)(2201001)(356004)(93886005)(107886003)(102836004)(77096007)(106002)(106466001)(72206003)(86362001)(54906003)(2486003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR13MB1396;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg103.jp.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ab61ba-5a94-4605-978f-08d6b70213a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR13MB1396;
X-MS-TrafficTypeDiagnostic: BN6PR13MB1396:
X-Microsoft-Antispam-PRVS: <BN6PR13MB1396719672B9C79E074D5F8AC9560@BN6PR13MB1396.namprd13.prod.outlook.com>
X-Forefront-PRVS: 0995196AA2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ah1N4Fo32u7g0TaBg8kqdAHus88p75O3MK1SGDmSaVJGu1SmHRjc2RlKxymHSN68kGyMBBXzh9YP5l6g1tyN5nVduxEP3NR8mFQdwemQ+lpCwbki6inKtURTUnDCNorlctPaq/bI6uEcYFU9hzzknk/Dsu5B2lp9S2jNftOPpwLuoxwppQbnej5W1e+eEvucI9I5TDANry1/jFDyL2pjLnfY3QN6oZUGDdrU67LMZmHLn2/PbspHRYXWzHjgYNrrkv+TJXKHrhpRAWwyTY6IpdXL+wehW53ijDHn2NQLosL9DdOMolYYBDMo7RcSWSF1ZVdTM0UwOSlo2MBQJceWD/8XAkvJa2jJ0GIgrl9DuShCu5zBjFFVOHcrl467PGEATDlh5bEuGthQYuwXvdelB4PeH0REFd+gr6YWY/tXJ0g=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2019 00:28:06.2498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ab61ba-5a94-4605-978f-08d6b70213a7
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.43];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+IEhpLA0KPj4gDQo+PiA+IFNvcnJ5LA0KPj4gPiANCj4+ID4gSSB0aG91Z2h0IHRo
aXMgd2FzIGNsZWFyLiBZb3VyIHBhdGNoIGlzIG1ha2luZyB0aGUgYXNzdW1wdGlvbiB0aGF0IHRo
ZSByZXNldCBpcyB0cmlnZ2VyZWQgYnkgdGhlIFNDU0kgbGF5ZXIuIFlvdSBjYW5ub3QgbWFrZSB0
aGF0IGFzc3VtcHRpb24sIGFzIHRoZXJlIGlzIGFuIGlvY3RsIGZvciByZXNldHRpbmcgYSBVU0Ig
ZGV2aWNlLg0KPj4gPiBJbiBjYXNlIHdlIGFyZSBnZXR0aW5nIGFuIGVycm9yIGR1cmluZyB0aGUg
cmVzZXQgKG91ciBlbmRwb2ludHMgdmFuaXNoKSwgdGhlIGRldmljZSBkcml2ZXIgbXVzdCByZXBv
cnQgdGhhdCB0byB0aGUgVVNCIGxheWVyLCBzbyB0aGUgZHJpdmVyIHdpbGwgYWx3YXlzIGJlIGRp
c2Nvbm5lY3RlZC4NCj4+ID4gV2UgY2Fubm90IGRyb3AgZXJyb3JzLg0KPj4gPiANCj4+ID4gCVJl
Z2FyZHMNCj4+ID4gCQlPbGl2ZXINCj4+IA0KPj4gVGhpcyBwYXRjaCBtb2RpZmllZCB1YXNfcG9z
dF9yZXNldCB0byBza2lwIHJlYmluZCBvcGVyYXRpb24gdG8gYXZvaWQgZXhjZXB0aW9uIHdoaWxl
IC1FTk9ERVYgaGFwcGVucyBub3QgZHJvcCBlcnJvci4NCj4+IElmIHVhc19wb3N0X3Jlc2V0IGhh
cHBlbnMgLUVOT0RFViwgdXNiX3Jlc2V0X2FuZF92ZXJpZnlfZGV2aWNlIG11c3QgaGFwcGVuIGVy
cm9yLg0KPj4gU28sd2hlbiB3ZSB1c2UgaW9jdGwoVVNCREVWRlNfUkVTRVQpIHRvIHJlc2V0IGRl
dmljZSwgaWYgdXNiX3Jlc2V0X2FuZF92ZXJpZnlfZGV2aWNlIGhhcHBlbnMgZXJyb3IsIHRoZSBl
cnJvciB3aWxsIGJlIHJlcG9ydGVkIHRocm91Z2ggaW9jdGwgcmV0dXJuIHZhbHVlLiANCj4NCj5P
SywgSXQgaXMgcG9zc2libGUgdGhhdCBJIGFtIHN0dXBpZC4gV2UgbXVzdCByZWJpbmQgaWYgdWFz
X3Bvc3RfcmVzZXQoKSBmYWlscy4gVGhlIGRyaXZlciB3aWxsIGNyYXNoIHdpdGhvdXQgdGhlIGVu
ZHBvaW50cy4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiBhZ2FpbiBpbiBncmVhdGVyIGRldGFpbCwg
d2hhdCB5b3UgYXJlIHRyeWluZyB0byBhY2hpZXZlPw0KDQpGb2xsb3cgaXMgZGV0YWlscyBmb3Ig
dGhpcyBwYXRjaC4NCg0KSXNzdWUNCi0gVVNCIHN1YnN5c3RlbSBoYW5ncyBpZiBwb3dlciBvZmYg
dGhlIGh1YiBwb3J0IGNvbm5lY3RpbmcgVUFTIFVTQjMuMC8zLjEgZGV2aWNlIGJ5IGNhbGxpbmcg
aW9jdGwoVVNCREVWRlNfQ09OVFJPTCkgdG8gZG8gSHViIENsYXNzIFJlcXVlc3QoQ0xFQVJfRkVB
VFVSRTpQT1JUX1BPV0VSKSB3aGlsZSB0aGUgZGV2aWNlIGlzIGJlaW5nIGFjY2Vzc2VkLiANCi0g
U3RhdHVzIG9mIHRoZSBwcm9jZXNzIHRoYXQgaXMgYWNjZXNzaW5nIHRoZSBkZXZpY2UgYmVjb21l
cyBERUFEIGFuZCBjYW5ub3QgYmUga2lsbGVkLg0KDQpSb290IENhdXNlDQotIEJsb2NrIGxheWVy
IHRpbWVvdXQgaGFwcGVucyBhZnRlciBwb3dlciBvZmYgVUFTIFVTQiBkZXZpY2Ugd2hpY2ggaXMg
YWNjZXNzZWQgYXMgcmVwcm9kdWNlIHN0ZXAuIER1cmluZyB0aW1lb3V0IGVycm9yIGhhbmRsZXIg
cHJvY2Vzcywgc2NzaSBob3N0IHN0YXRlIGJlY29tZXMgU0hPU1RfQ0FOQ0VMX1JFQ09WRVJZIHRo
YXQgY2F1c2VzIElPIGhhbmdzIHVwIGFuZCBsb2NrIGNhbm5vdCBiZSByZWxlYXNlZC4gQW5kIGlu
IGZpbmFsLCB1c2Igc3Vic3lzdGVtIGhhbmdzIHVwLg0KRm9sbG93IGlzIGZ1bmN0aW9uIGNhbGw6
DQpibGtfbXFfdGltZW91dF93b3JrIA0KICDigKYtPnNjc2lfdGltZXNfb3V0ICAo4oCmIG1lYW5z
IHNvbWUgZnVuY3Rpb25zIGFyZSBub3QgbGlzdGVkIGJlZm9yZSB0aGlzIGZ1bmN0aW9uLikNCiAg
ICDigKYtPiBzY3NpX2VoX3NjbWRfYWRkKHNjc2lfaG9zdF9zZXRfc3RhdGUgdG8gU0hPU1RfUkVD
T1ZFUlkpIA0KICAgICAg4oCmIC0+IHNjc2lfZXJyb3JfaGFuZGxlcg0KICAgICAgICDigKYtPiB1
YXNfZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXINCiAgICAgICAgICAgIC0+IHVzYl9sb2NrX2Rldmlj
ZV9mb3JfcmVzZXQgIDwtIHRha2UgbG9jaw0KICAgICAgICAgICAgICAtPiB1c2JfcmVzZXRfZGV2
aWNlDQogICAgICAgICAgICAgICAg4oCmLT4gcmViaW5kID0gdWFzX3Bvc3RfcmVzZXQgKHJldHVy
biAxIHNpbmNlIEVOT0RFVikgDQogICAgICAgICAgICAgICAg4oCmLT4gdXNiX3VuYmluZF9hbmRf
cmViaW5kX21hcmtlZF9pbnRlcmZhY2VzIChyZWJpbmQ9MSkNCiAgICAgICAgICAgICAgICAgICDi
gKYtPiB1YXNfZGlzY29ubmVjdCAgKHNjc2lfaG9zdF9zZXRfc3RhdGUgdG8gU0hPU1RfQ0FOQ0VM
X1JFQ09WRVJZKQ0KICAgICAgICAgICAgICAgICAgICAgICAg4oCmIC0+IHNjc2lfcXVldWVfcnEN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLT4gc2NzaV9ob3N0X3F1ZXVlX3JlYWR5KHJl
dHVybiAwIGNhdXNlcyBJTyBoYW5ncyB1cC4pDQogICAgICAgICAgICAtPiB1c2JfdW5sb2NrX2Rl
dmljZSAgICAgICAgICA8LSBsb2NrIGNhbm5vdCBiZSByZWxlYXNlIHNpbmNlIHVzYl9yZXNldF9k
ZXZpY2Ugbm90IGZpbmlzaC4NCg0KDQpDb3VudGVybWVhc3VyZQ0KLSBNYWtlIHVhc19wb3N0X3Jl
c2V0IGRvZXNu4oCZdCByZXR1cm4gMSB3aGVuIEVOT0RFViByZXR1cm5zIGZyb20gdWFzX2NvbmZp
Z3VyZV9lbmRwb2ludHMgc2luY2UgdXNiX3VuYmluZF9hbmRfcmViaW5kX21hcmRlZF9pbnRlcmZh
Y2VzIGRvZXNu4oCZdCBuZWVkIHRvIGRvIHVuYmluZC9yZWJpbmQgb3BlcmF0aW9ucyBpbiB0aGlz
IHNpdHVhdGlvbi4NCmJsa19tcV90aW1lb3V0X3dvcmsNCiAg4oCmLT5zY3NpX3RpbWVzX291dCAg
KOKApiBtZWFucyBzb21lIGZ1bmN0aW9ucyBhcmUgbm90IGxpc3RlZCBiZWZvcmUgdGhpcyBmdW5j
dGlvbi4pDQogICAg4oCmLT4gc2NzaV9laF9zY21kX2FkZChzY3NpX2hvc3Rfc2V0X3N0YXRlIHRv
IFNIT1NUX1JFQ09WRVJZKSANCiAgICAgIOKApiAtPiBzY3NpX2Vycm9yX2hhbmRsZXINCiAgICAg
ICDigKYtPiB1YXNfZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXIgKCoxKQ0KICAgICAgICAgICAtPiB1
c2JfbG9ja19kZXZpY2VfZm9yX3Jlc2V0ICA8LSB0YWtlIGxvY2sNCiAgICAgICAgICAgICAtPiB1
c2JfcmVzZXRfZGV2aWNlDQogICAgICAgICAgICAgICAtPiB1c2JfcmVzZXRfYW5kX3ZlcmlmeV9k
ZXZpY2UgKHJldHVybiBFTk9ERVYgYW5kIEZBSUxFRCB3aWxsIGJlIHJlcG9ydGVkIHRvICoxKQ0K
ICAgICAgICAgICAgICAgLT4gdWFzX3Bvc3RfcmVzZXQgcmV0dXJucyAwIHdoZW4gRU5PREVWID0+
IHJlYmluZD0wIA0KICAgICAgICAgICAgICAgLT4gdXNiX3VuYmluZF9hbmRfcmViaW5kX21hcmtl
ZF9pbnRlcmZhY2VzIChyZWJpbmQ9MCkNCiAgICAgICAgICAgLT4gdXNiX3VubG9ja19kZXZpY2Ug
ICAgICAgICAgPC0gcmVsZWFzZSBsb2NrDQoNCg0KV2UgY2FuIGdldCBlcnJvcigtRU5PREVWKSBh
dCB1YXNfZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXIgZnJvbSB1c2JfcmVzZXRfYW5kX3ZlcmlmeV9k
ZXZpY2UuDQoNClJlZ2FyZHMsDQpLZW50byBLb2JheWFzaGkNCg==
