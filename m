Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8584C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B2E206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LfStJc7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfG3SCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:02:42 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:3078
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728234AbfG3SCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:02:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl1mA3uNlHUpUnbzapeKpVbJRP6c0LbopMs+4/LNg/cQaGnZSbsIuiVirs/W1AJ2DKVJ/UX0H/LgE5mwJ7JsLUwTKKtxAArBmtqHYcENZaZTTucFqqlVuhztZYwqSBEGw21s6CC4QDs+q9Q27eYQAB/ZkNYK1yC4BEZ1+NAi1hNkSmE5kbSojOBjSKBlC7cXP2mLAfQWjlyIm4iaaMhNxtkVOVdqm/dcFe02a8r6i3Qj8rM55AJECeaEpXJRNy5B/69VuQJGYF0bvA5phdUQhAg9IH9UJZ4FBlXwYLRcewjsv+DgseaPWikhAU12phRxvNyVwLlygNyNihW4JBXuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86td7gtxGwZHmqL38iFkr/3U2gj63shWGOAF/jyySUo=;
 b=T+jE+pPAcfIcjapesIXfNnu7jS+DUNbdlFMACxxAJ3sJaIxbfUeK8iglM/Vd5a3JEsaEOfMzI9XQp8EnWs7i/zbgiwz/CdLA1b8ZlODiZt7ITiaKO4fgE8xgHtMkvxgL6zmYcEGyDPO/Jd3tN6qhALGOcol9hFxIMji6WorKTi09IgEEBDfih4bXY1cMqDi/3TkH8JY6ZRa73cLzi6b7mwIb51iVL3OH6AI9qh5Y6gX+vbwWWCZB5MUyrNQmgd8ttku/MOMGBFrckC+XIia3HRsXYI56f7jTEQ9N8Z1rH4MaxVvri5wwymZ1GeYXcVb7NijzyEtJJFvMnPRtZNO4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86td7gtxGwZHmqL38iFkr/3U2gj63shWGOAF/jyySUo=;
 b=LfStJc7zP4j76ltGCmjEdfWi2RW1U8rIwq3mhldd6hSrXrx4fRo14rR6XcyJzsD1R68lWcsmTputV0Wa+BJefhuKCvMnm7ANnZ3rAJgAA2wpkNujmksGBQCWxHMZ8Gk9DMU6jgYqvAcXzeik2B8rPoCYkGtOAorYqlBskwLckao=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5728.eurprd05.prod.outlook.com (20.178.121.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 18:02:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 18:02:39 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/13] mm: only define hmm_vma_walk_pud if needed
Thread-Topic: [PATCH 10/13] mm: only define hmm_vma_walk_pud if needed
Thread-Index: AQHVRpsEkWG1VeUz70SUodCacmdZDabjdLcA
Date:   Tue, 30 Jul 2019 18:02:39 +0000
Message-ID: <20190730180234.GP24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-11-hch@lst.de>
In-Reply-To: <20190730055203.28467-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c04c5d1-e0c9-4289-414e-08d715181c0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5728;
x-ms-traffictypediagnostic: VI1PR05MB5728:
x-microsoft-antispam-prvs: <VI1PR05MB572854993F992D7C21936E12CFDC0@VI1PR05MB5728.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(6116002)(3846002)(68736007)(2616005)(71200400001)(71190400001)(2906002)(11346002)(14454004)(386003)(102836004)(26005)(446003)(486006)(256004)(305945005)(6506007)(5660300002)(476003)(52116002)(186003)(76176011)(7736002)(66066001)(86362001)(81156014)(6916009)(6486002)(6512007)(6436002)(25786009)(4326008)(36756003)(7416002)(4744005)(99286004)(66946007)(478600001)(1076003)(8676002)(81166006)(8936002)(316002)(54906003)(66476007)(33656002)(66446008)(66556008)(64756008)(6246003)(53936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5728;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s1DSES32VM7Ml8RL94F6VAbjnUtZT5rVsfLaIGzoWK6+LFQgWrmvb/qMjUyHKUY59AaiMIyaMZpxnhxk5CYTkmI5BVj+Q4w7YRi+siT0EUhxSxaC5Uc7IJstLEl7RjAcafewZkk0UgiP7xXxURjA+oRrEc7BK3AyTotV17AP4AXwttUEmSruM9TszVVISisNUtJWtxmViJvsH14CxISYTLI1SJ4ztl15/78tFNEuB1RkOCk04K3HPJjYAPbFqkGLYdaynmOyjJO6o8ENlcFG45ez+PBVUkMoMrIPnvrODFTMknSolk0xs/biDI6H9IoHa1/6LHr3Rd/xgzktZhhGUAJYyqWTv8S9Gi0mADk2q7uTCGQxE+y8dBu8gdrFZiaWgvVa/+LJph4OjE2uz+XRHlUKzh488NNb7qY2Xrc2SiI=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8AED26FB1F585E4DA3EAA28F935E5D83@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c04c5d1-e0c9-4289-414e-08d715181c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 18:02:39.2042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:52:00AM +0300, Christoph Hellwig wrote:
> We only need the special pud_entry walker if PUD-sized hugepages and
> pte mappings are supported, else the common pagewalk code will take
> care of the iteration.  Not implementing this callback reduced the
> amount of code compiled for non-x86 platforms, and also fixes compile
> failures with other architectures when helpers like pud_pfn are not
> implemented.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
