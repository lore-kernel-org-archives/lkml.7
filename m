Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9148CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C7B214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jabil.com header.i=@jabil.com header.b="hWQVnkxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfJ1L2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:28:36 -0400
Received: from mail-eopbgr730129.outbound.protection.outlook.com ([40.107.73.129]:32924
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731363AbfJ1L2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:28:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAmy57oZDrVxeLh5ycmUeAc4yJqg8dwMHdldl7ayDLtpHFaZqRvt+7sYo2mSditDC3g+0+sf4xmeu3rzVWYd3FWCZoYAf3jwRlqShY1x3ItK8qrab2JYTTKgV1CIJt7KubinMDpWGP7OGpa0GcSc8XYeL9tHF92Iz8hgI//CBgt3SitHxuvR4pdZ7FvveRcm2yjef0a/JobP2qtv1X46uW27pE/qF3JG+3CK+4Ccy4jeDk/UDS0hwBgVaVylQsjG+wPkRP6JAhv9CQ/fQz8McpYeQYPhR1IrI9TesTbR9uYHicwXGdjjw0MITU86PBcEsS/or6lwZsWs3GZG71RL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxdWwXCV66HRfa3ftUp4/VX+1IwuBsnSWVfzKcnmBvI=;
 b=kFujXKifS8IzvfvncsKG14SjYST5Bb5Y7zOigG5oqHrn/3KpZYMSMrrl+ttjfvIu4iMkreqRVTLIBpju4QszSTNSegg0z66XB5zVUN91gdKoYKlXguSHfyUzhe528gROz6Z6BYwuxYjrBTKsoqWRJnD1FEx/aYB2SMl0cJfByHza2Oe/KfbImf3XXr4tqAuumr2XJk41gM6UZ0dFOMU3kaJzIPxrN2aokE0zN8gTic9GaFVpulBkpUMHR/BzcZrkkGhNzRZjiem/14VcKSjS9vSzvRGnqHo7oP2IEs1wOljnJnKkNWNrKBEj5aTw60xG4umkaRtzNrpOLpwcxI9XFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxdWwXCV66HRfa3ftUp4/VX+1IwuBsnSWVfzKcnmBvI=;
 b=hWQVnkxnRmNpi9jbLlz4b2pZ53ixpzfRfhcaQ5fa3720DtYnM6COO0TCuQF0X1Q/9g1iIAte2SYO0YHzND37I8iqxPNw6XJmaJ8OWVieRR8LxwRiLilwSFvWNKK5ueo60J304CXJP2QvJaDrnw8m5BhKTdkPHxPHnL2gz5/WSe4=
Received: from MN2PR02MB6703.namprd02.prod.outlook.com (52.135.48.83) by
 MN2PR02MB6224.namprd02.prod.outlook.com (10.255.7.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 11:28:27 +0000
Received: from MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177]) by MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177%5]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 11:28:27 +0000
From:   Rain Wang <Rain_Wang@Jabil.com>
To:     Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lm75: add lm75b detection
Thread-Topic: [PATCH] lm75: add lm75b detection
Thread-Index: AQHVjYLRP5bazFFZW0uheBeWYa5nXg==
Date:   Mon, 28 Oct 2019 11:28:27 +0000
Message-ID: <20191028112819.GA10006@rainw-fedora28-jabil.corp.jabil.org>
Reply-To: Rain Wang <Rain_Wang@Jabil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.230.226]
x-clientproxiedby: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To MN2PR02MB6703.namprd02.prod.outlook.com
 (2603:10b6:208:1d2::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rain_Wang@Jabil.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 659bb041-5722-47d6-6422-08d75b99f3b5
x-ms-traffictypediagnostic: MN2PR02MB6224:
x-microsoft-antispam-prvs: <MN2PR02MB6224614484847523485070548D660@MN2PR02MB6224.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(25786009)(66946007)(64756008)(80792005)(66476007)(478600001)(66446008)(5660300002)(99286004)(66556008)(86362001)(66066001)(6116002)(110136005)(7736002)(186003)(103136001)(43066004)(3846002)(476003)(305945005)(6506007)(71190400001)(71200400001)(386003)(2906002)(1076003)(26005)(8676002)(14454004)(52116002)(102836004)(33656002)(3450700001)(81166006)(4326008)(6246003)(6486002)(256004)(6436002)(14444005)(229853002)(8936002)(4744005)(6512007)(316002)(9686003)(486006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR02MB6224;H:MN2PR02MB6703.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: Jabil.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUtutkH21o0Ql4KG88nswu3oMvVLxIjspW7QnA0iYqpFNS33XsjKLTRj+oePY/JNFO+3wf7rmon3ek81I/V08OGp17mEX0Yx+NOGUc7fcFXEHbu2n4F2FQ6TLadjEbs71WIIO6w7UUjay6hJO/esZHlaEsZMMunE9bkRUKOnxc5qWA1BiubaS4SyM+AMh9fPEXXdiSjnIBCTl43RyM3oO/9DAD9pDbuQb/z3tZNhalpfhMsJ0hcX8s3vJF495DkI2nVWgGu80IcvEVBgoFtpEH7B9tGlKLWzWxosftgKYSw1KaNTbfP63xaGkJRXhF8q9Idii275ogxN5P4tBqFWklt3L54K1R30tax8vO6AL/TAYJME2UyR6IRYgHSdLsr2FUS0RFA3fpGQ8UCXpFDwgLUslfJP3NRLtt0nGUbOqM7EW+5Z8ylXgzOC5HlqC7mG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <171B795BB89CE249BE2EB5B2A333654A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659bb041-5722-47d6-6422-08d75b99f3b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 11:28:27.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8+EOtgYhQPsNyFsQ/HMdEdk8FT9fyCv3ftRlss9HW9sx7/Zge5nnUIU3a2UorCs0j/NQOxpHpjPhcwyWJra2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am quite hesitant to touch the detect function for this chip.
> Each addition increases the risk for false positives. What is the
> use case ?

we just have one board design of Intel Rangeley C2516 SoC with LM75B sensor=
.
only making the detection pass could we make the sensor working on standard
Linux distribution like Ubuntu.
