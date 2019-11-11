Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD95C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECD6206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="jxTcWH+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKF4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:56:43 -0500
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:17374
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbfKKF4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:56:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCnbUk5zWrWj8frUaJWbnAvLe6Pd0YxPshSqwXZjuxQdwoXNzay7+W1Maa4I8vqxCTHWhgvDRmIOs7nw1cBoHac7lN5AF2awo37MsZO0Im9DTY54JkK0sdh0ko7so9dWDcBt9foBh/lE3SknKiU6NmtNMbn3GOyNIuXK4cGwTw0nLdb2d9VX6579bsqI/V/fbAiVdP+GzkEFIePyrRHhs8L+MrylMsMW5Fsx3pA01d2YUkDBNFiTA4IklezzSDd/DYC+vCauyAhV+VQNmO3Cpz+DlxSLNnTqQd1UG0tWUurJOJxXPOSZaj25/EkviiX6UkkV+Bc9kMCvjqsRCKraVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTanvysErjlPykOYxsVeU7snAgASjzK8p8HVvNB3iMM=;
 b=fpe0S0YMkM2Bo3QYps1Iy+eK3mkn5OhUbwVcYwiQH+CbI0B21ofG2/Ax25yIl2hLjE1FJe7+50pe+sPJhEC8w5StEsly0xFqtkI39bcrei2e25BWBGeePjmZeK8ghUyroidIoxDxI/7MB6KTSwzDXmpIpcxj+hENbJJsa8Is0SlDAm07svCAVE2iDOimkuG2njEqeOZwAHW73AaK2B+tSZcUieTwUGqmble5w1xmqIsE6sNkb0DcD9ZwYT51gkd1q3cI1uAwInjIUMUFjQRk1ljJXS/G8lgJaC/rrwiEvq0jh19ZEncGU23vXa3iaXmJ/o2fIRXuqfkMRwu2/izENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTanvysErjlPykOYxsVeU7snAgASjzK8p8HVvNB3iMM=;
 b=jxTcWH+oVzBH5WXAvTiNEKaRlR4hfIeZnEGojix2cnfTwIh3dzi2OwfJsOEfis9RybYlN7MVAQGD6xey54bTxnSTO+W845nM9K+VHrpsGAQVMQwHahbkm6G+va+PSx0tgiwf+AYsmgrGNhIlBQXrvs+1K0PwK1MFNk2hAigB3rc=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3430.eurprd02.prod.outlook.com (52.133.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 05:56:37 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 05:56:37 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/6] habanalabs: read F/W versions before failure
Thread-Topic: [PATCH 1/6] habanalabs: read F/W versions before failure
Thread-Index: AQHVmBGWQcrMWULcskGh9FVc+drcy6eFeHPg
Date:   Mon, 11 Nov 2019 05:56:37 +0000
Message-ID: <AM6PR0202MB3382EBAF43BAA8B26B6AF9CCB8740@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
In-Reply-To: <20191110215533.754-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.8.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38dd3e6e-913c-4e7a-52e7-08d7666bea34
x-ms-traffictypediagnostic: AM6PR0202MB3430:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB3430002AD16A3991D0FC18ABB8740@AM6PR0202MB3430.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(346002)(136003)(396003)(366004)(189003)(199004)(76116006)(2501003)(2906002)(558084003)(305945005)(486006)(186003)(33656002)(6436002)(26005)(476003)(446003)(66446008)(64756008)(66556008)(66476007)(110136005)(99286004)(86362001)(6636002)(25786009)(11346002)(6116002)(3846002)(229853002)(74316002)(66946007)(316002)(6246003)(256004)(8936002)(81166006)(81156014)(14454004)(52536014)(8676002)(5660300002)(4326008)(9686003)(76176011)(478600001)(7696005)(55016002)(7736002)(6506007)(102836004)(66066001)(71190400001)(71200400001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3430;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJAWeYB9S/qmW71sQnz0WHbhzOHvRKZL18ZgfTdqAcmFRRykAr1pdmvkrklb2+g4R0BIXvtInsTTm92DW/bNdEDhNXFD4bo+c3+qhj/N/HTG9XYeblwfv3/GY+T9MVh4cDa3PNwh02LckvcfQZP+gi4eWc8xPAKop09cvlV/X1Bx7z7EnZETbYDJ9DpdVqrvOWAY4fHnLkwSfPC7ts05mTda0oYPMHw1U4dXv0vGKylMQjNz1iTamktvPzhNLYwWSZgewdpW6CqxN2PIZwTqhHm32WefG1d8cmxn9myTgIjcuWMPxU0H9Lb/qLQCizTa9BFsSR6ItuRvzpekHA2DXtXFaMws9QqDElEfkkveI6TzSAD8NboYz+P51Ir/VF2czO2YsZjux3mmBzl7vkL1m6vcz73KbjyQpAtc1FVJIkTKmZiSx61MFlLDHzFCG+4p
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dd3e6e-913c-4e7a-52e7-08d7666bea34
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 05:56:37.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msrl0L6zOUdbZUhulK9lc57/W8ueGvlb4dEDR+qi7YyQjgj64jv33DFUBOpz3Wvw9c5BIepinltrnA7pjQsvvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBOb3YgMTAsIDIwMTkgYXQgMTE6NTUgUE0gT2RlZCBHYWJiYXkgd3JvdGU6DQo+IE1v
dmUgdGhlIHJlYWQgb2YgdGhlIEYvVyBib290IHZlcnNpb25zIGJlZm9yZSBleGl0aW5nIG9uIHBv
c3NpYmxlIGZhaWx1cmVzDQo+IG9mIHRoZSBGL1cgYm9vdC4gVGhpcyB3aWxsIGhlbHAgZGVidWcg
Ym9vdCBmYWlsdXJlcyBhcyB3ZSB3aWxsIGJlIGFibGUgdG8ga25vdw0KPiB0aGUgRi9XIGJvb3Qg
dmVyc2lvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBn
bWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVyIFNocGlnZWxtYW4gPG9zaHBpZ2VsbWFuQGhh
YmFuYS5haT4NCg==
