Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F80DC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5637D2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="TSXHE2l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLDIBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:01:22 -0500
Received: from mail-eopbgr30095.outbound.protection.outlook.com ([40.107.3.95]:46833
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfLDIBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:01:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKRy3CQN7hcc7nw2q48a5v983hsH8EjbkdglEM/yD4dBFzgEbr6iT+nlXxqOR6kCXve9GS8dUVnjFixwZ7h6PnQUMls7x9csVfvQFVhDJhbE1v9vvr1FGka5+o1JenxZJi0UlGJPS0YcseQReVOBkvllfnoDW6XYxYYnq51fXR3sRUU8ce+sqxbQi8wwWJFkB3KdLIJKo4M3DDTfBuj8SsF3grd3GaDYa70UnccISbaXhHFavbZGDYhsQxjHmr5xuxkFHd/55CfkhG029W+71TcjDsg3IY5O7fZy+BFrFUdIwNbaks7pumGgmopw80oLloUX4zNrkIaZtY2IIVvQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0yz5/jE4M1nIRvENs4Ba+fYNQnxZ/vxcr26vXwfNTY=;
 b=EmOMkGl16LElTzV+SJwgjQT3nLu6nuh6R5qs5TwCFL4Zi+AYprzrIy8KB9uBrP3eF+2AwHXJoPCDVGgPChv3UZI7UbYVGHpCQiM8q62na5dcH9rceyAEFDf7bIgkGmSiULlB6BXVeaIG2ru4LdoRPDOGE45c4lW8gUtTly4IzO55XpYXdcDjVuAp1PGf+i1nhGPYlZIqS8Hu8W0j+lyBFzwFaLnIfGNCyfIUkzwrHW8zmRbWPq3V6j4TurkqHiIYCApHtlNDVFSrpMcnaUVq1XXQ89ftB3Y7JvrU1kdZPUD30n1ZBpUVzAF+Mh0e/S+8juhC5wDfV+gN/wgNocZyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0yz5/jE4M1nIRvENs4Ba+fYNQnxZ/vxcr26vXwfNTY=;
 b=TSXHE2l8nTIIW8QXk68WQRrK1sacvc/QI7hT4mPpQgwar957xjLKQZErCGMYn0OP32NDu1iCF9jPF5GoyJsndTXANXlzbtwubB6njVLC0qamPp4BC431aN7naxho0uXWHZpCTRVoumzHxFk62MdFitQfMxuWurSw1lIyh2fYc1E=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.175.244.155) by
 VI1PR02MB5197.eurprd02.prod.outlook.com (20.178.80.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 08:01:17 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78f1:dc96:ee1a:bccd]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78f1:dc96:ee1a:bccd%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 08:01:17 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: rate limit error msg on waiting for CS
Thread-Topic: [PATCH] habanalabs: rate limit error msg on waiting for CS
Thread-Index: AQHVqhgl8B9dKNMjIkGYpb/62LwdIKepm1Aw
Date:   Wed, 4 Dec 2019 08:01:17 +0000
Message-ID: <VI1PR02MB305448F610A65F0BD205737DD25D0@VI1PR02MB3054.eurprd02.prod.outlook.com>
References: <20191203202750.9498-1-oded.gabbay@gmail.com>
In-Reply-To: <20191203202750.9498-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51f6c6b0-5522-48d5-3557-08d778902441
x-ms-traffictypediagnostic: VI1PR02MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR02MB51971E4FAEE5177E2996C0C0D25D0@VI1PR02MB5197.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39840400004)(136003)(189003)(199004)(76176011)(7696005)(256004)(102836004)(186003)(11346002)(55016002)(53546011)(26005)(6506007)(2906002)(6116002)(6436002)(33656002)(4326008)(3846002)(5660300002)(6246003)(446003)(2501003)(76116006)(4744005)(52536014)(66476007)(66946007)(86362001)(66556008)(64756008)(71200400001)(71190400001)(9686003)(66446008)(305945005)(99286004)(7736002)(25786009)(74316002)(81166006)(14454004)(229853002)(478600001)(110136005)(316002)(8936002)(81156014)(8676002)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5197;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/yFgSDREeE57b1jLPXXA11LqDrxpp2zs2OppcwiuPH/QrYIpoZoxAu+DzPpAfgXWSV8X4kf0I5cNEObGDRxOVLk9/iJ0u/Tho43Djj++NsJP2eq07D4ThMHu46tolgcxOhTkBSysw6dyRxxbHuty48/5Kd0TqsvmmgqEQ+3SOFqBh0YM/u+hwpkkPOTHEYr399/OEftFcHVk2WS+UCz7r/HOteM3XfbFo5iiwjk+VfktylwiQgVd50tTlJK8YUNtsfqWRfKU+XeFpUWAOSqg5NRukp3JizELRp2OQ4bFCB0U/dj0q5Uo47152Ddl0iwlTCYTgmOSu1Qs1sI7VQSnRU5DqjFH4RVqEsQ5hZlvsrYtszZ0+ZkItxvS6Kw6+gN2PQHZp0Q2Bdlq8Z8tzizvRKTOMQeDPGUgVCFfcb0ALCBmxEiptkgzTtQhQ8cKFY4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f6c6b0-5522-48d5-3557-08d778902441
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 08:01:17.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwkHND9ZZwET0lG7yC1fzJCaF+H4XdgErjBEg0lBSDbGa1CdOCwGtrVCdenD4/Pn+DjlomZ2uJbCzAbeNCWQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 22:28, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> In case a user submits a CS, and the submission fails, and the user doesn=
't
> check the return value and instead use the error return value as a valid
> sequence number of a CS and ask to wait on it, the driver will print an
> error and return an error code for that wait.
>=20
> The real problem happens if now the user ignores the error of the wait, a=
nd
> try to wait again and again. This can lead to a flood of error messages
> from the driver and even soft lockup event.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
