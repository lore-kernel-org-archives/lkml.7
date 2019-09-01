Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E910AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882D121897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mnMPIAZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfIAGte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 02:49:34 -0400
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:48210
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfIAGte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 02:49:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGOTCJmvigNV7nn58hoXk72yMOCSNjLm1Yu1n4XPVqr1UZqO43+x5d77s/ajkty6c2NcytwxgDuQmjJHzsFDEix8Ou1ArrR6dXWiCQagAGnIyt/r3YhiMhKt5Zz96/b0Hprh9BuofVv0K8s2lbKb14B6aaBrndwu1B+2BTDpmRT+XJEhNcYT/nn1frb0PlCN9gHuVnLjmIP6D4Sq9D4S6/Va8SPT3s4xWo9YjN64ff3fZ7dp3UGSNmFs+aJgmTTaYFz0uvKk3RwWQxCmHqJgFLS6Fem12LtSlSLtwic5W03G7ygamRYOG496EsgHtb8Wj2GeIq1BAPpMmOrtwXE2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/19qz3gSoZ/11j8o+7XfvRYUPQ4kkly/v6/uTp+UTMw=;
 b=WgZXehfA2vYcOUM2rQtzc1KpVAaNK7YvIwXnvu3qjCHGITROCv3wwiyf6SuUKoDsocZ+kXICXVjgJaXDGjthsKfQs6InxWcaysO7Wc6w1ETFYLMvftVAW9/7kYC+t66vIijZ9aeD5uuIJuKtIfBtzs/IoMSBIsdpt+b33jLDeQObuMCe2rwJ/s0vtJxjJagtuwxpPsVsWCg/COmQN6939lo4df8ADRyy3krSfdHI6cTSwBCl5HjZn7jQVUzd4a/2VB4pYgIh5Tywye+KOwX9zQsxLkTftuVzqPlI3a3u8vjTMfgGpntQG+7TP/NhxDypeLzFi+yDGWxEdVC1MAfq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/19qz3gSoZ/11j8o+7XfvRYUPQ4kkly/v6/uTp+UTMw=;
 b=mnMPIAZffO+7U99WGkfm6I7LnqEHWdfdNEzmiwjT/F12MLIpsWWcd/Wz/REYp44B+uupLQcMcztRq7dIcmrGN/nIG8vIuTe2pyOdXWofEt9qxTp3Pu8LOhWm6/fxAt7f7y+CPSGb1b6wo/Wsc15lK11BPAMp9LbEUXb1qvwL9OA=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3457.eurprd05.prod.outlook.com (10.170.126.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Sun, 1 Sep 2019 06:49:29 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f%7]) with mapi id 15.20.2199.021; Sun, 1 Sep 2019
 06:49:29 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH RESEND] arch/microblaze: add support for get_user() of
 size 8 bytes
Thread-Topic: [PATCH RESEND] arch/microblaze: add support for get_user() of
 size 8 bytes
Thread-Index: AQHVYHb3amFpSC8cAkqXFCi9L5Ag/6cWYdwA
Date:   Sun, 1 Sep 2019 06:49:29 +0000
Message-ID: <20190901064926.GL12611@unreal>
References: <99f83474-3e71-4325-ddff-cf23a172b984@infradead.org>
In-Reply-To: <99f83474-3e71-4325-ddff-cf23a172b984@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0086.eurprd02.prod.outlook.com
 (2603:10a6:208:154::27) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eda840e-f208-47c4-817c-08d72ea88944
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3457;
x-ms-traffictypediagnostic: AM4PR05MB3457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3457EF7D051229F8B31F860AB0BF0@AM4PR05MB3457.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0147E151B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(346002)(136003)(376002)(366004)(39850400004)(199004)(189003)(8676002)(99286004)(33716001)(14454004)(5660300002)(81166006)(102836004)(478600001)(26005)(6506007)(386003)(8936002)(81156014)(6116002)(3846002)(52116002)(256004)(6916009)(316002)(229853002)(54906003)(71190400001)(1076003)(66556008)(66476007)(6512007)(9686003)(4326008)(53936002)(11346002)(6486002)(446003)(76176011)(486006)(71200400001)(186003)(66066001)(6436002)(476003)(33656002)(7736002)(86362001)(305945005)(66446008)(64756008)(66946007)(2906002)(25786009)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3457;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0VzeKDe+45KmzaPF6NyKX6EIOgQYwefMOSqi8oYa9Ms13MH/XbcAQtmQA6OmG6/Va82mxysC21Z0zhfqxl/zcE6A9klaB++DbU5K5S0I1j5p95Q+EiS8J3/wkWBMNsIMSovS11jNeTtGWRUXLpunZV98CIyEvgnEXVeLj7cKR6qTt5S+FQ78guWL7WF5q9Lo4Gp+/h2r5fs3qQ49vW51SqsYIuNi0TTYZK+xfIfnuH8AUErpwwc7tM+YkXwxel5Q9+beYWtdG07EQRbYf5Z4odcz8pCO7qFFQ0/+03meq3BYmzFIdEXsKg6gRvgvyd/3wMIhzVlMNwiTu6kPOWBvNSs/7kiSYmPDJluwW9veM7lbKpVnIbtsonwYjHK1y1wnUkFUz0S0AV+tUC3QFC+XHHcrnHCvWMx5wHe+9g81pnE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29FD2ADDCFBEC44384AA2E3E38695ABB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eda840e-f208-47c4-817c-08d72ea88944
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 06:49:29.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUB/dnM6A+3MQMTLrbTMGgcxHM48nZV6vHoEEHFe8EsjFZTsGNYKYPtxt8tM1kGieaUdJOEXCQdDsPHyQJ6NHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 08:40:05PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> arch/microblaze/ is missing support for get_user() of size 8 bytes,
> so add it by using __copy_from_user().
>
> Fixes these build errors:
>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
>    drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefine=
d reference to `__user_bad'
>    drivers/android/binder.o: In function `binder_thread_write':
>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference t=
o `__user_bad'
>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea7=
8): more undefined references to `__user_bad' follow
>
> 'make allmodconfig' now builds successfully for arch/microblaze/.
>
> Fixes: 538722ca3b76 ("microblaze: fix get_user/put_user side-effects")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Steven J. Magnani <steve@digidescorp.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> What is a reasonable path for having this patch merged?
> Leon Romanovsky <leonro@mellanox.com> has tested it.

I tested it for compilation only, we (RDMA) don't work on
arch/microblaze/ at all and care about kbuild failures only.

Thanks
