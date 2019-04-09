Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94240C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C66213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LBbM7iLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDICmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:42:42 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:19014
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfDICml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc0H0ZxkhZoAO+xY7zVlI2uvABjt5xbnRdF8HStKoiA=;
 b=LBbM7iLtZFAktoNuTKuCrT7BhH90dge04BjmkKyEF0QXGTW7FGVVW+dKO/xCtq5Q4Rf+btYFknLGwfzWbW52em42DEbAgNk4Rok6m5xTWbbJZxwVUOLDvTO1fFQm/YmrqVNhzDJDM3NQzTdqaCE3iBW+qz59iax5YKgRxtltPkM=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2883.eurprd04.prod.outlook.com (10.175.42.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 02:42:36 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d017:34d9:4a70:bb8]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d017:34d9:4a70:bb8%11]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 02:42:36 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RESEND: How to configure kernel to support USB device mode (gadget)
 UASP feature
Thread-Topic: RESEND: How to configure kernel to support USB device mode
 (gadget) UASP feature
Thread-Index: AdTufd58kSdKurHGSPyGyCxQvanJMA==
Date:   Tue, 9 Apr 2019 02:42:35 +0000
Message-ID: <AM5PR0402MB2865EEBA2F9CDCB01A58D8D2F12D0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f379fca9-2cae-4a0e-ddb6-08d6bc950656
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2883;
x-ms-traffictypediagnostic: AM5PR0402MB2883:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM5PR0402MB2883EA779054B7A697C1BBE5F12D0@AM5PR0402MB2883.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(305945005)(71200400001)(68736007)(5660300002)(256004)(8676002)(8936002)(14454004)(4326008)(7736002)(52536014)(4744005)(478600001)(71190400001)(74316002)(81166006)(81156014)(53936002)(9686003)(86362001)(55016002)(2171002)(6306002)(6436002)(110136005)(99286004)(6506007)(476003)(33656002)(6116002)(2906002)(26005)(186003)(486006)(66066001)(3846002)(97736004)(106356001)(316002)(25786009)(105586002)(102836004)(54906003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2883;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P6xGojXw9/i1VWGrmcbeuVEUIoNtf5lJANyzwa4gDemDIH172Vn2JfXM+zWxVV3vqfHztHw5qCJmCnV1rDFHzWMpduWWWwz4qYtOWoqIfHFeAf7cK4pyiqtvrJKa4p5vEnY6egyd0mLMCk9s6UMgN9JGTU1AzBm8ZhA6DmP8duLScx9fF9rOT49FeTopjqejJl99V5nMDuJsYBydTUxSnoWSm6SPhcl9iXB8Mslq7x0q/xv/fm2tnNyg/ZNmofN/J3yWjIrN8SJaAv7ENC2YPxYCiTqo53SSbcOU0yl8PSioiPd7up3I9jJIjRQl9VobSJPuV7AFjHwGpZSdQgeoipNj48RJW0l4ACDArfDyqqLLjBqgqSH5mbUJfspkWalpR+mC7jZE6FXfNS+gbUdI5ZAKxKQzHupWCnfnvh2iuGA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f379fca9-2cae-4a0e-ddb6-08d6bc950656
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:42:36.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU2lycywNCg0K44CAV2XigJlkIGxpa2UgdG8gZW5hYmxlIFVBU1AgZmVhdHVyZSBvZiBV
U0IgZGV2aWNlIG1vZGUNCihnYWRnZXQpIG9uIExheWVyc2NhcGUgcGxhdGZvcm0gd2hpY2ggaW50
ZWdyYXRpbmcgRFdDMw0KSVAgYWxyZWFkeS4gDQoNCsKgwqDCoCBCdXQgbm90IHN1cmUgaG93IHRv
IGNvbmZpZ3VyZSBLY29uZmlnIGluIGtlcm5lbC4NCkNvdWxkIHlvdSBwbGVhc2Ugc2hvdyBtZSB3
aGVyZSBJIGNhbiBmaW5kIHJlbGF0ZWQgZ3VpZGUvZG9jPw0K44CADQrjgIBUaGUgb25seSBjbHVl
IEkgY2FuIGZpbmQgaXMgYSBwb3N0IDoNCihodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9s
aW51eC11c2IvbXNnNTUzNjYuaHRtbCkNCmJ1dCBzZWVtcyBpdCBkb2VzbuKAmXQgZXhpc3QgaW4g
Y3VycmVudCBtYWlubGluZS4NCuOAgFRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNClJlZ2FyZHMsDQpS
YW4NCg==
