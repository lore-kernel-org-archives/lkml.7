Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31058C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8F522CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="QzlpTTpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfICJZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:25:48 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com ([40.107.8.97]:24374
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728094AbfICJZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK9daENn2E6s3P0MpsUsgyJsxKfQO34FjMX8BC6wr2BMU9zOFtn2YVfTStPP59y8PBDvcZEjWH+wB2DGbVbCZvnr5qeq8tzztQ7WkFqFh/GfrPo0IZAtt78WekTnwRHnMnUfRRt+B972VIDomQqTJukamDYQSpOZ3OkJvsvCRgC77ga9BwlKnFA73K8cX2jzBstXrazsUEPkA1XKzaIRvRyuAS/mDUdhnvWzqc63ggA8RM4ki7xq4RyAGgzBA1OMH9iWBThLEnQflANdbmJ2PKkQDjhFkAx8UdgC69bi4GexjlASf3TnXibFurbbTZPFcR6WzDzW9zNInmA93HodYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qosIkU05rekAHgOaHQyp8FlUe/j8YDFX9xhrfPU3NEM=;
 b=Zn9mTmpQCmkAWXLPSkgs7QuOtDRJSqHL+K4+aSJoJvNvjmyBC23xgHmT4axUvBjdoZjdW8HeFcCnmvT2azuMFtzfEunTaXf/sdJXuMP1eNMG6x6BvqcsLXK5gQEJuHSGS3FXGNhj13GMSwmfYCBUiqLuUSeLAHLASKhSfvACW+b9G9KUIRqUyElry2gIJ7n9L38sStVcaSjGJYXajuXCSiHqPCst1wCN6KZu4RnUAJ7Qp3o2rbohffdGPu0wDzQM1A9eDwRgQuKeeFA+8yzqOFWjlffEvwDfJ33Ge4lgGJ8nky2hq+SDWxDGWmYqNqx3yitZGA+03lNwHdhRtu+glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qosIkU05rekAHgOaHQyp8FlUe/j8YDFX9xhrfPU3NEM=;
 b=QzlpTTpR7Irg0opNTxA3nl/sNNuAIXTheBPxbBetGah8vHEtZTq/ggObJzVpHFXd8KngpxhdlGg6Ll+IJAigRtMvg4LoJI5oAUFCgAiYpLj/bPyXiq65xPDURwHj97epz9+fUNPTu+RLzNGQwUjphkioskZu2cVn8OBUpem9oDo=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB4269.eurprd02.prod.outlook.com (20.177.60.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 3 Sep 2019 09:25:43 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::7515:8be7:5f4:7392]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::7515:8be7:5f4:7392%7]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 09:25:43 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: correctly cast variable to __le32
Thread-Topic: [PATCH] habanalabs: correctly cast variable to __le32
Thread-Index: AQHVYjZpM0BfRuC7IEihsHUqzT9nIqcZrfAQ
Date:   Tue, 3 Sep 2019 09:25:43 +0000
Message-ID: <VI1PR02MB3054BF3CD9B742390581526DD2B90@VI1PR02MB3054.eurprd02.prod.outlook.com>
References: <20190903090306.11724-1-oded.gabbay@gmail.com>
In-Reply-To: <20190903090306.11724-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46c99ca5-6863-4d11-5018-08d73050b1c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB4269;
x-ms-traffictypediagnostic: VI1PR02MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR02MB42690923977EF6B149D6C58ED2B90@VI1PR02MB4269.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(229853002)(66066001)(186003)(256004)(6506007)(476003)(9686003)(7696005)(66476007)(66556008)(64756008)(3846002)(6116002)(66946007)(316002)(76116006)(110136005)(76176011)(66446008)(55016002)(4326008)(25786009)(26005)(6246003)(6436002)(2501003)(102836004)(71200400001)(53936002)(71190400001)(305945005)(558084003)(5660300002)(8676002)(86362001)(7736002)(11346002)(486006)(14454004)(52536014)(478600001)(81156014)(81166006)(446003)(74316002)(8936002)(99286004)(6636002)(2906002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4269;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vPO0xhJGC6SNjk2kkdLc3+dZCUfCNItTv3Ofw+aY3egP//Xj2dBSJPQoKtC+3cbpsmqJmqoXLxY8PCaj/o5pXCiD7O+j3tjPqTxc68xtdPHTYi23ylu7mL7aRoMC4aerA2iphwZTSMsvMmGjm85bD2Pwiot16qGb64PERSzzmT3tWG4KJ2jafQ/bjIXlBRAQXuo9uKhIDfdhH/8Cb2znJe4+KD8ZhkAJtHsIlOtF9AOR7nJeiJFgvQnXNT5YHMwInN311GhFVgogBxmSdPiOizLZj2dT9LSb4y0oLVVOF4rCsUp8/wSfjTqX0f2epB2qQIMavuVSQg1G29K+/Z9JXG7oU86la04mDpv5L7bbXHY15qP6ubp0/xpsRhYvKzoMv45s0FyxzqEL8566/bbR5n71gMO6XohmnKp8vc5C1QI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c99ca5-6863-4d11-5018-08d73050b1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 09:25:43.3189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyJMY4kWRTAI2QYdWIIechJ2Qqt6pkws16fpueYk1trP2UO7TYJL4zx42eGznEbqI0TRIGnNzZPWuVGG2ODqyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <oded.gabbay@gmail.com>
Sent: Tuesday, 3 September 2019 12:03
> When using the macro le32_to_cpu(x), we need to correctly convert x to be
> __le32 in case it is defined as u32 variable.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>

