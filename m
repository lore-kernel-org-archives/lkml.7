Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03390C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4CF20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="jGcWj7Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKKGBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:01:39 -0500
Received: from mail-eopbgr40139.outbound.protection.outlook.com ([40.107.4.139]:24958
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbfKKGBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:01:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHmK2kjDK52VKMtj/XbFxGCAfxlxKLAVZ15a7sfOWmpirZvZPIfIYHZaQe/ScPDnhoNjoJwqBUf3uZ8jJH00ityg+fqWqLuvoejVDZ2/oxSPLju/hCfEsGzgkVPJ6gjVnLbMwK25HS61S6HKIAPZxawdBmtWnAheGT9kd4PvE+wT1DpbIB0oiX+viRbfVGnZPnNDn5qx4bFbU8ry2eZjMaMxJJFCEsHr6rwMSqJshpPU6FIHhQP45Izzo00zjZH4qMSMchCNTvj65nK9kWn7/Val6MlDgjKsBUOd9HHvKz5HCf/yJoZBGla4dZipM3aZIdzlIJfmpHPKfXl4q/NTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrKz/JGeAMcYogAV+kTxwDp31ubUPX8FuiXIAOlBpbY=;
 b=CI56fMdYU7bRbO8S59wIXD7YpIpoDwFOP/XkEFTIMoEsC9wSlsKSQoXSng3xw82Yh0QsV2u7umzVUMSWR6qaG84u/qiLHFxbd1I6lW7ET+UCDMfKbxUTKnlWF919DOyJLg3Xt9DZxB5q1LnWTlS+v6ZgDcMV6pFA0ArJPkWLDLHVSxhTBIyRTas+q40MP4tHZXFjoWrSPLjXTtxNzHOmXjM0H7xzWv/HLTTliONycLZpBWNwm+kZTVeKPgP35G8rxXIEuHw6bSVoF/rbfApPM0QMRPKU3OLtatwvRCxlflpqOhVXeZLkSpbTtCf77n7iGF7j1yRkvbcCy/FGj3/dXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrKz/JGeAMcYogAV+kTxwDp31ubUPX8FuiXIAOlBpbY=;
 b=jGcWj7OszBWY4HgJnkXu/NpuAAU1l1TT7t4JC+tKCHDc9sjbUaMGNUPim98tST/QXK/74MsoU5OnUUGQ8cM9lo80P4yIODc9yMI2YklMd1/9l0VtoQVAtpQYRKCkBKebVUR1Ufg8LyKL+vvcqdqNljW51rlEpaYMJkzdp9e7gJM=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3368.eurprd02.prod.outlook.com (52.133.10.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 06:01:32 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 06:01:32 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 3/6] habanalabs: set ETR as non-secured
Thread-Topic: [PATCH 3/6] habanalabs: set ETR as non-secured
Thread-Index: AQHVmBGXX2drukS2bEWeUYrNJGMNgqeFeouQ
Date:   Mon, 11 Nov 2019 06:01:32 +0000
Message-ID: <AM6PR0202MB3382576D2A8E491F80446F70B8740@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
 <20191110215533.754-3-oded.gabbay@gmail.com>
In-Reply-To: <20191110215533.754-3-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.8.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0bb4e77-b39f-4e08-9259-08d7666c9a61
x-ms-traffictypediagnostic: AM6PR0202MB3368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB3368F9B177662643AFF5C4A2B8740@AM6PR0202MB3368.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39840400004)(376002)(136003)(189003)(199004)(476003)(11346002)(26005)(229853002)(7696005)(66066001)(4326008)(256004)(186003)(102836004)(6436002)(446003)(6246003)(5660300002)(86362001)(52536014)(9686003)(6636002)(486006)(55016002)(71200400001)(71190400001)(53546011)(6506007)(76176011)(74316002)(305945005)(7736002)(66946007)(2906002)(66556008)(76116006)(33656002)(3846002)(66476007)(6116002)(66446008)(81156014)(8936002)(81166006)(8676002)(2501003)(478600001)(558084003)(99286004)(25786009)(64756008)(110136005)(14454004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3368;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Br4I1agntw4RC2oBOx91CH5hJVdF6Mk3mph7kIKhnviW1ipxzqOvfmqr+Z+PbM0xQqDRPUo5UgcpPVSswfyhvRmSZU8Bzr1k1GKMSinjs8F9LwtxpcQ7eKT82C75NNkin8BXs8HC46NAvDCNuFJEhqqsdwPkXkMvHEx9NP3lWmFwLrTbhM9PatgfjeN/aQsruFkW6RY0u8qOwYT+4b+9ysNaXAhSlr6nu/KIxAMlLLMY+zvbw4HlqhHGmm8aKNBXTBxasz9V2cfQoaqCuvMdYYUiq5LV05yBQ0pWNO59Pi0s55HgbDVPN+/zo75IUKL4ivVYmg9pG7an/NF2ASfNJQhGyGQqYVOjVTHKKl3Io2P/AduQFmYJUEz0YcQg1P2rWxtgYMB1bEt/EoAwej547WjIsqZMCnRpceYSu5Gvsn5GSem1UWFGs+QldZitaL8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bb4e77-b39f-4e08-9259-08d7666c9a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:01:32.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfI8A6eZqcxc92RdOxgC8pXzAFNc896gYQxRolZ6WPWDi8cCLVW9lIoyUWKjhIHTVKtlxLQ9Z1gCc3rhVVeWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBOb3YgMTAsIDIwMTkgYXQgMTE6NTYgUE0gT2RlZCBHYWJiYXkgd3JvdGU6DQo+IEVU
UiBzaG91bGQgYWx3YXlzIGJlIG5vbi1zZWN1cmVkIGFzIGl0IGlzIHVzZWQgYnkgdGhlIHVzZXJz
IHRvIHJlY29yZA0KPiBwcm9maWxpbmcvdHJhY2UgZGF0YS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVy
IFNocGlnZWxtYW4gPG9zaHBpZ2VsbWFuQGhhYmFuYS5haT4NCg0K
