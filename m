Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E4C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 07:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0212071E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 07:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Y4FIQWH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfLZH1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 02:27:13 -0500
Received: from mail-eopbgr70114.outbound.protection.outlook.com ([40.107.7.114]:22813
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfLZH1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 02:27:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=borCk4CZgoRnPGU83cDwqoxAu/8uMCxWjoutSCO25ZG6XKS+u3L1xy6NePCvWFzZCeFP/5PIASa2XpIHoSBhWTa2hKvlh+lSuN37OdOtumcmf6fK++tcLCc1sx4k8ygpZ//ufjegwb8GutDPhiSsJCSGwL2pugJcpPrp3DGjCK54XkIM82oLTgGgS20DABtDiHBI961xiedMTlqX4/BKIwxlOBUOsacjHHvL42KBo1wclqywCakf+CvtlCalVZdvtVIcF32x6bgV/1PGvEpgdi0RbBoJhvuGNokGhf3d+czPtuRQzfEUNHKgbqwDT4mMw0YCE7rl4Ql8pSzj7B0y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HKBQkI+ASZBT97QkfLkOH6LYuLobynpue4xD78EYz8=;
 b=Cj0clq7WiOAux90jWPEjt/mqdgpxNXNJW4VFK/VGLYN8THqiW8dw4wY7IXI3rjOAUfmTRRR9TgnVHp+P6OfCDhLT/1Nea/q/uiV222u/iN2IugB4iEDpZFVOMNX5qSXbK5+zis189WNQ0jNSCVu0UUz/6zkY1adC9ysZkWHTd06RE415B3/qbn/bT6Gj0S9ipfOFDoZtuHmCSo8zlru5qglehZcSikzq0nbHMB7eH0/O9RHJ8ube5lrZ1esQcRROb981KSkd2vs0yP5I4vuoNR2GWkeXiGiA77ESfzFbo6SpKeq9Di0a3duHQu4fgvWGIm+Jwnki4ynJpIjG+dnDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HKBQkI+ASZBT97QkfLkOH6LYuLobynpue4xD78EYz8=;
 b=Y4FIQWH9vha3LpO+tGFpig4T76tmxDwmz2hRcofCb5wAsl4XoZOrY2q8GWLyc8DQUQWUc1i2GJjzX7jm9aAwM2wUlE26UpWLzcoJ8AKnzBrmlfYylZVzKBhAaEmevvcr970TMqUAQ19ooYafRPGowVyA+O1i541cMjqo9zPf+l4=
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com (10.170.242.32) by
 HE1PR02MB3195.eurprd02.prod.outlook.com (10.170.246.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 07:27:03 +0000
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::a03a:3c1:12d5:bc54]) by HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::a03a:3c1:12d5:bc54%7]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 07:27:03 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: halt the engines before hard-reset
Thread-Topic: [PATCH] habanalabs: halt the engines before hard-reset
Thread-Index: AQHVuyXuwy9rol3iAkaVMDkf925rxKfMBPKQ
Date:   Thu, 26 Dec 2019 07:27:02 +0000
Message-ID: <HE1PR02MB3258F126865E63268ECF9CF8D22B0@HE1PR02MB3258.eurprd02.prod.outlook.com>
References: <20191225131921.15343-1-oded.gabbay@gmail.com>
In-Reply-To: <20191225131921.15343-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18cf6861-315f-41d0-d0c9-08d789d500d1
x-ms-traffictypediagnostic: HE1PR02MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR02MB31953FCF1144DA749B1F6333D22B0@HE1PR02MB3195.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(5660300002)(2906002)(110136005)(52536014)(71200400001)(316002)(7696005)(4326008)(6636002)(6506007)(53546011)(81166006)(26005)(55016002)(9686003)(558084003)(64756008)(8676002)(33656002)(478600001)(81156014)(8936002)(86362001)(66946007)(66476007)(66446008)(76116006)(66556008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR02MB3195;H:HE1PR02MB3258.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pbW15Sar+6GS4+lMOgnQ7bPrSf67usYSd1q+cbyzkmCPGVeqPJQ+iqkvGyxEsGfRLuYAYKh4BvsBCV4W+zinoknf26hI8fDJ2oUsiLabEskw/nSGcgiWAclZM3y1vys/kjeZI4zEx/kzxlUl4oYOEwNmxc9JLbDOKVXarxKjgewMi6NzJfu6s6AHNI6y7yXCMkC4Sj8+MnwX9nz5XruaYJa6sasoNox+diEz9FSJWFcywriYhlOp+zdRkQJFDd4vomhl7CMzKirXA37PhoxkDW1dVf/7wYCjINF1Vs/IMEsa6sXqCFJQ0GFyrYSfus7UcMoxdL9YJ1PTUBlkXIceh0WTE5WldxhAYZFRZTKJWLe/WDIOnevseITs7eGr5gWlJD/cAzDn+gQR8OnQt2GdEmhGvnafQ2g7nTuYUaGaNKvG+3OEWnFn9vUNZpjTQp0c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cf6861-315f-41d0-d0c9-08d789d500d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 07:27:02.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syRDdX5oWcIWfRnaf0IeChWDfley49vmyhDqzI8n2eQDgzXUxqBri+sel5BkWXeP6jKpOHm/Ixn5/Yi5uIj5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR02MB3195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 15:19, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> The driver must halt the engines before doing hard-reset, otherwise the
> device can go into undefined state. There is a place where the driver
> didn't do that and this patch fixes it.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
