Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2B921738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="jqSvuIgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfDDD5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:57:39 -0400
Received: from mail-eopbgr800113.outbound.protection.outlook.com ([40.107.80.113]:6115
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728987AbfDDD5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcBKGEBge9rtfJZgd3O+X0e0cAsbVUpeGaV1+Z6rdiA=;
 b=jqSvuIgpL71sC8OHzzW5D8VMNpnMfQIWI6WHlIHqlD8LpcziuWAndc3Ex9hEIKV6hDVuXvpWxY4FzlV8+BWXgq86ETgorvAS10wh2A57hP8m0n4zySR6aFTeSZRGEaJHDT0z5LkLU/siEO67fOAjSULzuVX6XlXY6DNdkGWpQNk=
Received: from BN6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:404:13e::27)
 by MWHPR13MB1406.namprd13.prod.outlook.com (2603:10b6:300:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.13; Thu, 4 Apr
 2019 03:57:35 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR13CA0041.outlook.office365.com
 (2603:10b6:404:13e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.6 via Frontend
 Transport; Thu, 4 Apr 2019 03:57:35 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.42)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.42 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.42; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.42) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1750.16 via Frontend Transport; Thu, 4 Apr 2019 03:57:34 +0000
Received: from JPYOKXHT107.jp.sony.com (117.103.191.54) by
 JPYOKXEG102.jp.sony.com (117.103.190.42) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 4 Apr 2019 03:57:32 +0000
Received: from JPYOKXMS103.jp.sony.com ([169.254.3.107]) by
 JPYOKXHT107.jp.sony.com ([117.103.191.54]) with mapi id 14.03.0439.000; Thu,
 4 Apr 2019 03:57:32 +0000
From:   <Kento.A.Kobayashi@sony.com>
To:     <stern@rowland.harvard.edu>
CC:     <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <Kento.A.Kobayashi@sony.com>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Topic: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
Thread-Index: AdTVjvFIkAhaIt3DQTSj1OrTHxvrsgAQFLsAAIWEBcAAQQqsgAB7RvcAAgdcBTAAAJSpAACOr4UQABH/lYAA3G8Q4AAdt7kAAE4ci4A=
Date:   Thu, 4 Apr 2019 03:57:31 +0000
Message-ID: <AE5419EAB4965843B3C0C1FE29F1FFE5891C86@JPYOKXMS103.jp.sony.com>
References: <AE5419EAB4965843B3C0C1FE29F1FFE58914EB@JPYOKXMS103.jp.sony.com>
 <Pine.LNX.4.44L0.1904021033470.1562-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904021033470.1562-100000@iolanthe.rowland.org>
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
X-Forefront-Antispam-Report: CIP:117.103.190.42;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(979002)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(189003)(199004)(26005)(7636002)(7736002)(8676002)(55846006)(6246003)(478600001)(4326008)(305945005)(246002)(6916009)(356004)(14444005)(426003)(436003)(76176011)(77096007)(102836004)(47776003)(486006)(336012)(446003)(72206003)(2171002)(107886003)(11346002)(186003)(476003)(86362001)(126002)(316002)(6116002)(5660300002)(106002)(37786003)(54906003)(229853002)(2486003)(33656002)(2906002)(7696005)(23676004)(2876002)(50466002)(86152003)(8936002)(55016002)(106466001)(2351001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1406;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg102.jp.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 331d8dc2-0ce6-447d-1bb3-08d6b8b1abd3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:MWHPR13MB1406;
X-MS-TrafficTypeDiagnostic: MWHPR13MB1406:
X-Microsoft-Antispam-PRVS: <MWHPR13MB1406A37AFAA29CBFAF1CA90DC9500@MWHPR13MB1406.namprd13.prod.outlook.com>
X-Forefront-PRVS: 0997523C40
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: sv0LB875ZpfOmZcYRG1Z5SJnGASs2Er4KKVkgyRRSL/qmgWIgsP4bFcSOLq2al1X31M3TK0rN+VL5uznalLY51UiFtX6Y4zbpThe7npS/TOTgEQ5GTSuI1Y8RSBYkrG9ca7JHbYaoKK3BN1KVKL4Wotjlt8X/rrNZh7YIoq/E7t7urD0YDbs5eH0QlJJoBQjAsPQzfu5Me4ReBK3wJAflm9ONPwOx8ZQpCbhbZjEmauHVbHIojhEEM7xe+2nxDjMGJusdFme3v63Mr6VnrwlNzOkJEWSjGe29vkLSjm0FziB4kRmNLS5+UHTWDBSQ2UPxWX9+n4QNYlxwJYUVWo3fl6yhgE8MONyzRImtop9vfNtY87fNMfNnW4d2enBFSY8sHeFeJnQM2nT2SfBLUuZjKFeoJMKnvzVoNkyvaLkbC0=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2019 03:57:34.5603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 331d8dc2-0ce6-447d-1bb3-08d6b8b1abd3
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.42];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+IFJvb3QgQ2F1c2UNCj4+IC0gQmxvY2sgbGF5ZXIgdGltZW91dCBoYXBwZW5zIGFm
dGVyIHBvd2VyIG9mZiBVQVMgVVNCIGRldmljZSB3aGljaCBpcyBhY2Nlc3NlZCBhcyByZXByb2R1
Y2Ugc3RlcC4gRHVyaW5nIHRpbWVvdXQgZXJyb3IgaGFuZGxlciBwcm9jZXNzLCBzY3NpIGhvc3Qg
c3RhdGUgYmVjb21lcyBTSE9TVF9DQU5DRUxfUkVDT1ZFUlkgdGhhdCBjYXVzZXMgSU8gaGFuZ3Mg
dXAgYW5kIGxvY2sgY2Fubm90IGJlIHJlbGVhc2VkLiBBbmQgaW4gZmluYWwsIHVzYiBzdWJzeXN0
ZW0gaGFuZ3MgdXAuDQo+PiBGb2xsb3cgaXMgZnVuY3Rpb24gY2FsbDoNCj4+IGJsa19tcV90aW1l
b3V0X3dvcmsgDQo+PiAgIOKApi0+c2NzaV90aW1lc19vdXQgICjigKYgbWVhbnMgc29tZSBmdW5j
dGlvbnMgYXJlIG5vdCBsaXN0ZWQgYmVmb3JlIHRoaXMgZnVuY3Rpb24uKQ0KPj4gICAgIOKApi0+
IHNjc2lfZWhfc2NtZF9hZGQoc2NzaV9ob3N0X3NldF9zdGF0ZSB0byBTSE9TVF9SRUNPVkVSWSkg
DQo+PiAgICAgICDigKYgLT4gc2NzaV9lcnJvcl9oYW5kbGVyDQo+PiAgICAgICAgIOKApi0+IHVh
c19laF9kZXZpY2VfcmVzZXRfaGFuZGxlcg0KPj4gICAgICAgICAgICAgLT4gdXNiX2xvY2tfZGV2
aWNlX2Zvcl9yZXNldCAgPC0gdGFrZSBsb2NrDQo+PiAgICAgICAgICAgICAgIC0+IHVzYl9yZXNl
dF9kZXZpY2UNCj4+ICAgICAgICAgICAgICAgICDigKYtPiByZWJpbmQgPSB1YXNfcG9zdF9yZXNl
dCAocmV0dXJuIDEgc2luY2UgRU5PREVWKSANCj4+ICAgICAgICAgICAgICAgICDigKYtPiB1c2Jf
dW5iaW5kX2FuZF9yZWJpbmRfbWFya2VkX2ludGVyZmFjZXMgKHJlYmluZD0xKQ0KPj4gICAgICAg
ICAgICAgICAgICAgIOKApi0+IHVhc19kaXNjb25uZWN0ICAoc2NzaV9ob3N0X3NldF9zdGF0ZSB0
byBTSE9TVF9DQU5DRUxfUkVDT1ZFUlkpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICDigKYg
LT4gc2NzaV9xdWV1ZV9ycQ0KPg0KPkhvdyBkb2VzIHNjc2lfcXVldWVfcnEgZ2V0IGNhbGxlZCBo
ZXJlPyAgQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhpcyBzaG91bGRuJ3QgaGFwcGVuLg0KDQpXZSBj
b25maXJtZWQgdGhlIGZ1bmN0aW9uIGNhbGwgcGF0aCBvbiBsaW51eCA0Ljkgd2hlbiB0aGlzIHBy
b2JsZW0gb2NjdXJlZCBzaW5jZSB3ZSBhcmUgd29ya2luZyBvbiBpdC4gSW4gbGludXggNC45LCB0
aGUgbGFzdCBmdW5jdGlvbiBpcyBzY3NpX3JlcXVlc3RfZm4gaW5zdGVhZCBvZiBzY3NpX3F1ZXVl
X3JxLiBJbiBzdGFnaW5nLmdpdCwgd2UgdGhpbmsgdGhlIHNjc2lfcXVldWVfcnEgaXMgY2FsbGVk
IGJ5IGZvbGxvdyBwYXRoLg0KdWFzX2Rpc2Nvbm5lY3QNCnwtIHNjc2lfcmVtb3ZlX2hvc3QNCiB8
LSBzY3NpX2ZvcmdldF9ob3N0DQogIHwtIF9fc2NzaV9yZW1vdmVfZGV2aWNlDQogICB8LSBkZXZp
Y2VfZGVsDQogICAgfC0gYnVzX3JlbW92ZV9kZXZpY2UNCiAgICAgfC0gZGV2aWNlX3JlbGVhc2Vf
ZHJpdmVyDQogICAgICB8LSBkZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwNCiAgICAgICB8
LSBfX2RldmljZV9yZWxlYXNlX2RyaXZlcg0KICAgICAgICB8LSBkcnYtPnJlbW92ZShkZXYpIChz
ZF9yZW1vdmUpICANCiAgICAgICAgIHwtIHNkX3NodXRkb3duDQogICAgICAgICAgfC0gc2Rfc3lu
Y19jYWNoZQ0KICAgICAgICAgICB8LSBzY3NpX2V4ZWN1dGUNCiAgICAgICAgICAgIHwtIF9fc2Nz
aV9leGVjdXRlDQogICAgICAgICAgICAgfC0gYmxrX2V4ZWN1dGVfcnENCiAgICAgICAgICAgICAg
fC0gYmxrX2V4ZWN1dGVfcnFfbm93YWl0DQogICAgICAgICAgICAgICB8LSBibGtfbXFfc2NoZWRf
aW5zZXJ0X3JlcXVlc3QNCiAgICAgICAgICAgICAgICB8LSBibGtfbXFfcnVuX2h3X3F1ZXVlDQog
ICAgICAgICAgICAgICAgIHwtIF9fYmxrX21xX2RlbGF5X3J1bl9od19xdWV1ZQ0KICAgICAgICAg
ICAgICAgICAgfC0gX19ibGtfbXFfcnVuX2h3X3F1ZXVlDQogICAgICAgICAgICAgICAgICAgfC0g
YmxrX21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzDQogICAgICAgICAgICAgICAgICAgIHwtIGJs
a19tcV9kaXNwYXRjaF9ycV9saXN0DQogICAgICAgICAgICAgICAgICAgICB8LSBxLT5tcV9vcHMt
PnF1ZXVlX3JxIChzY3NpX3F1ZXVlX3JxKQ0KDQo+PiBDb3VudGVybWVhc3VyZQ0KPj4gLSBNYWtl
IHVhc19wb3N0X3Jlc2V0IGRvZXNu4oCZdCByZXR1cm4gMSB3aGVuIEVOT0RFViByZXR1cm5zIGZy
b20gdWFzX2NvbmZpZ3VyZV9lbmRwb2ludHMgc2luY2UgdXNiX3VuYmluZF9hbmRfcmViaW5kX21h
cmRlZF9pbnRlcmZhY2VzIGRvZXNu4oCZdCBuZWVkIHRvIGRvIHVuYmluZC9yZWJpbmQgb3BlcmF0
aW9ucyBpbiB0aGlzIHNpdHVhdGlvbi4NCj4+IGJsa19tcV90aW1lb3V0X3dvcmsNCj4+ICAg4oCm
LT5zY3NpX3RpbWVzX291dCAgKOKApiBtZWFucyBzb21lIGZ1bmN0aW9ucyBhcmUgbm90IGxpc3Rl
ZCBiZWZvcmUgdGhpcyBmdW5jdGlvbi4pDQo+PiAgICAg4oCmLT4gc2NzaV9laF9zY21kX2FkZChz
Y3NpX2hvc3Rfc2V0X3N0YXRlIHRvIFNIT1NUX1JFQ09WRVJZKSANCj4+ICAgICAgIOKApiAtPiBz
Y3NpX2Vycm9yX2hhbmRsZXINCj4+ICAgICAgICDigKYtPiB1YXNfZWhfZGV2aWNlX3Jlc2V0X2hh
bmRsZXIgKCoxKQ0KPj4gICAgICAgICAgICAtPiB1c2JfbG9ja19kZXZpY2VfZm9yX3Jlc2V0ICA8
LSB0YWtlIGxvY2sNCj4+ICAgICAgICAgICAgICAtPiB1c2JfcmVzZXRfZGV2aWNlDQo+PiAgICAg
ICAgICAgICAgICAtPiB1c2JfcmVzZXRfYW5kX3ZlcmlmeV9kZXZpY2UgKHJldHVybiBFTk9ERVYg
YW5kIEZBSUxFRCB3aWxsIGJlIHJlcG9ydGVkIHRvICoxKQ0KPj4gICAgICAgICAgICAgICAgLT4g
dWFzX3Bvc3RfcmVzZXQgcmV0dXJucyAwIHdoZW4gRU5PREVWID0+IHJlYmluZD0wIA0KPj4gICAg
ICAgICAgICAgICAgLT4gdXNiX3VuYmluZF9hbmRfcmViaW5kX21hcmtlZF9pbnRlcmZhY2VzIChy
ZWJpbmQ9MCkNCj4NCj5UaGUgZGlmZmVyZW5jZSBpcyB0aGF0IHVhc19kaXNjb25uZWN0IHdhc24n
dCBjYWxsZWQgaGVyZS4gIEJ1dCB0aGF0IHJvdXRpbmUgc2hvdWxkIG5vdCBjYXVzZSBhbnkgcHJv
YmxlbXMgLS0geW91J3JlIGFsd2F5cyBzdXBwb3NlZCB0byBiZSBhYmxlIHRvIHVuYmluZCBhIGRy
aXZlciBmcm9tIGEgZGV2aWNlLiAgU28gaXQgbG9va3MgbGlrZSB0aGlzIGlzIG5vdCB0aGUgcmln
aHQgd2F5IHRvIHNvbHZlIHRoZSBwcm9ibGVtLg0KDQpXZSBjb25maXJtZWQgdXNiX2RyaXZlcl9y
ZWxlYXNlX2ludGVyZmFjZSB3aWxsIGNhbGwgdXNiX3VuYmluZF9pbnRlcmZhY2Ugd2hlbiB0aGlz
IHByb2JsZW0gb2NjdXJzLg0KU28gdXNiX3VuYmluZF9pbnRlcmZhY2Ugd2lsbCBjYWxsIGRyaXZl
ciBkaXNjb25uZWN0IGNhbGxiYWsuDQoNClJlZ2FyZHMsDQpLZW50byBLb2JheWFzaGkNCg==
