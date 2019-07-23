Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D1FC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EDE223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="J66yV23R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfGWOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:55:15 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:55267
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbfGWOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9lRMUDODlAS4XYl4VNQ289MAp6jY/9tgkG41FzuRVFmkIvsPVLsQNQwRx7awRyTAe6DoK8tmkxySeluyszoROAbDoiCk4k6ZbizDmWn475CMi4cgRFJ9pCy2gUJ2EbZzzZsmi1plkxvCu51lqspZyVHfq0/CirL47EZuyBjdR25hqIUbcXs7sJY+1gWPJLBvnWM2nre2rk8Mt8Afhphq0tPFiY3yVx8dCbc6pnd3j30GwsDAMJA2i3idmthsEuDkJmkR/SCPHuJ7V8hz4b3fzCDX1YMktEpMaC/xmXDCblsDVTTXTHbkppZM4WuHk1wmWDmoEDfk/cZ6+2DPQ8k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmavxUOco/R1TXry10N00+5Umm6D+n0p9fRLXD49D5o=;
 b=FOUtAIsTvxedxJkTJ5mWbb+GhUqLucNPPwwAGICUH0aECjc9Zxnmvc7KZje9UTspkl4tzHDqeWAzhrFHlIUKyn1Xoz49AYQVRH1WEVAnHxA/MwQeeaqt2pFKvIgq2xyXSNcLfYDmKdBqYuDKxMPFtceoSkLqWFZkVVRdHpEVY+vpNHDkWvnQz83k40SGjhHt9D8xgsQ8qwmRTiwiwuxeHXwkk0H9VMekAhYLxaFwsy+CuOkmZZ2RLCJb4SR7M41ZSVP1DxLjX/ydfelXqdkbfjBYB1dOiZ6slHOvD6L+yQYNFImeFlbvONeTjWbssV1MiH5oaQw2V+eoe2/ysGwm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmavxUOco/R1TXry10N00+5Umm6D+n0p9fRLXD49D5o=;
 b=J66yV23R95DW8vxedlM/uvZTtf2UFG7Y9TcCp2R4eLkY0SyUJGORCJkJeOcpoGBvxaBVOdMea675uRDZACrhw5lg1s8gF7oT311slynDDMiEjRZpZN7zpoz55Vis871J/vAK8ylZ5BwVNV67dl8UOK7IuDQXgk9dFEfGWzM0dpg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3311.eurprd05.prod.outlook.com (10.170.238.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Tue, 23 Jul 2019 14:55:10 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 14:55:10 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] mm: move hmm_vma_range_done and hmm_vma_fault to
 nouveau
Thread-Topic: [PATCH 2/6] mm: move hmm_vma_range_done and hmm_vma_fault to
 nouveau
Thread-Index: AQHVQHITSjZL0YJcikqGnA6nJMGubKbYTFYA
Date:   Tue, 23 Jul 2019 14:55:10 +0000
Message-ID: <20190723145506.GJ15331@mellanox.com>
References: <20190722094426.18563-1-hch@lst.de>
 <20190722094426.18563-3-hch@lst.de>
In-Reply-To: <20190722094426.18563-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:208:fc::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e1510a-9cc2-4812-8d13-08d70f7dc267
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3311;
x-ms-traffictypediagnostic: VI1PR05MB3311:
x-microsoft-antispam-prvs: <VI1PR05MB33110C115415E8D90BDE4379CFC70@VI1PR05MB3311.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(71200400001)(71190400001)(256004)(8676002)(6116002)(3846002)(64756008)(76176011)(14454004)(6916009)(316002)(6506007)(86362001)(478600001)(6436002)(229853002)(5660300002)(6486002)(386003)(4744005)(99286004)(11346002)(25786009)(446003)(66066001)(1076003)(54906003)(7736002)(102836004)(52116002)(53936002)(305945005)(4326008)(476003)(2616005)(68736007)(66556008)(66476007)(8936002)(66946007)(81156014)(81166006)(33656002)(6512007)(486006)(2906002)(26005)(186003)(66446008)(36756003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3311;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oZNCEU5446B3GEa6OLWkGnHxiqDkPkKXmfogpj029SkBrJQuOdEJvTbky12FShA2UnL137o98hcX/HWqrFgkkOs7zZq0Ru8Z5XpHNhTlq2rbaYZgKjUfLHym6WBm8BBd1w6JkOIjatbbu+UTfgphmJnoL9Sghu9a2gGJDhLJJF3lISjwzTI/AbKxHRe1//fdOg+r/Vrf5Dh+WCEqUk8ordc0nNxSCqvU1Wga31NnAxDKg3+OfRHEN5TLSZN0MxmsBWuGuQaM3nDmau5MxUzidPB/2vL15RE+21ouBkV4soq9+UJGwbiDKiVd4U80IJ6GAdOLJNHZdM2n+/ay6oOhrBRIox1beCTC5yfGCPXF9UvIjCXkvSkNwt43siwVrHrsvso06V/bwMqlNa2aWtSB10HtVOYjE4vAqzJv5sC6PeQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3FB3BADA1123924E9A7FB81AD9C8BC58@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e1510a-9cc2-4812-8d13-08d70f7dc267
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 14:55:10.3938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:44:22AM +0200, Christoph Hellwig wrote:
> These two functions are marked as a legacy APIs to get rid of, but seem
> to suit the current nouveau flow.  Move it to the only user in
> preparation for fixing a locking bug involving caller and callee.
> All comments referring to the old API have been removed as this now
> is a driver private helper.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 45 +++++++++++++++++++++-
>  include/linux/hmm.h                   | 54 ---------------------------
>  2 files changed, 43 insertions(+), 56 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
