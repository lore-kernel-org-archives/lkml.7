Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C82C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DFD2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TvxB6PLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfDJKYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:24:06 -0400
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:34212
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfDJKYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwPi+p75LB8mPLUNTf60cHc0gCNLgwymkdR5uk6+jz4=;
 b=TvxB6PLWxJAm0RabUSkysm1rdtZX9uy3G4QrTq3+wVLOkvjDsqYiexFqTv0ag3lxtL36rvxvkaLXga9A8ORl/GvwRpmHVc7PYTSZKo8smk3VYpfWjhGHWE0uk4GKU8Z7a20dgOKpYVcAb6TPUJtFYC6z5XnG0NPWlj3OYU5Kb4E=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 10:24:03 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::50cc:3c60:7379:46b]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::50cc:3c60:7379:46b%2]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 10:24:03 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] point to right memory window index
Thread-Topic: [PATCH] point to right memory window index
Thread-Index: AQHU5iMklFxgu091o06fvBhkVIOkq6Y1QTxw
Date:   Wed, 10 Apr 2019 10:24:03 +0000
Message-ID: <MN2PR12MB3455BFCFE060E38FEDF686E1E52E0@MN2PR12MB3455.namprd12.prod.outlook.com>
References: <1553859137-4439-1-git-send-email-Sanju.Mehta@amd.com>
In-Reply-To: <1553859137-4439-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce1d6e8-b766-4e5c-c659-08d6bd9ea78f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB2911;
x-ms-traffictypediagnostic: MN2PR12MB2911:
x-microsoft-antispam-prvs: <MN2PR12MB2911A3962B07138135CC9E7BE52E0@MN2PR12MB2911.namprd12.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(53754006)(13464003)(189003)(199004)(316002)(25786009)(11346002)(6246003)(53936002)(229853002)(52536014)(476003)(14454004)(110136005)(33656002)(478600001)(256004)(186003)(54906003)(7696005)(446003)(6506007)(9686003)(486006)(14444005)(53546011)(86362001)(55016002)(26005)(2201001)(4326008)(102836004)(76176011)(2906002)(3846002)(99286004)(97736004)(7736002)(6116002)(81166006)(5660300002)(2501003)(71200400001)(72206003)(8676002)(8936002)(106356001)(105586002)(81156014)(74316002)(6436002)(305945005)(68736007)(66066001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2911;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1AAnrsIECbyRZ2LGSI/Z35Oa9lKQWDyaeW2v2gCN2oMCNB9K/RUYul7tMHLtzNq6bNJodClDADkFLB13njVHc0evYHaGFFWDaa/WQ04WIwan96vKnScNanA5zpUrzRDlNachxR0Mpib0VO5tuk6f+RqPyp1I29OCKs1TW4uKnS9a5soGwLcpKdEbDTN/A8JHVClcpjwfSTbtOHr2LVZvZp5cydeLy1KvCOo//Ao+SFumDKdNp4NjnVFFYZv2yNE6SGBfX/zJ6rcHNf+RgXb+OMAsq0s00aPhP5WaOoRs2yn2yWyqSSrY2CPtmlol0LjC3JmcupcXZ6fBEe5dyr9mZDsoE9jKKXsBJyn6UygyWEirOjnQm8e9PbvcKvPIY77Boxb9mSNh/FJTAnXU5jgyLc+vuKAELoUi6oqIAf9kN1g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce1d6e8-b766-4e5c-c659-08d6bd9ea78f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:24:03.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Any comments on below patch?

Thanks & Regards,
Sanjay Mehta

-----Original Message-----
From: Mehta, Sanju <Sanju.Mehta@amd.com>=20
Sent: Friday, March 29, 2019 5:03 PM
To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; jdmason@kudzu.us; dave.ji=
ang@intel.com; allenbh@gmail.com
Cc: linux-ntb@googlegroups.com; linux-kernel@vger.kernel.org; Mehta, Sanju =
<Sanju.Mehta@amd.com>
Subject: [PATCH] point to right memory window index

From: Sanjay R Mehta <sanju.mehta@amd.com>

second parameter of ntb_peer_mw_get_addr is pointing to wrong memory window=
 index by passing "peer gidx" instead of "local gidx".

For ex, "local gidx" value is '0' and "peer gidx" value is '1', then

on peer side ntb_mw_set_trans() api is used as below with gidx pointing to =
local side gidx which is '0', so memroy window '0' is chosen and XLAT '0'
will be programmed by peer side.

    ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx, peer->inbuf_xlat,
                    peer->inbuf_size);

Now, on local side ntb_peer_mw_get_addr() is been used as below with gidx p=
ointing to "peer gidx" which is '1', so pointing to memory window '1'
instead of memory window '0'.

    ntb_peer_mw_get_addr(perf->ntb,  peer->gidx, &phys_addr,
                        &peer->outbuf_size);

So this patch pass "local gidx" as parameter to ntb_peer_mw_get_addr().

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c inde=
x c7d1a48..08e18d7 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1381,7 +1381,7 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	int ret;
=20
 	/* Get outbound MW parameters and map it */
-	ret =3D ntb_peer_mw_get_addr(perf->ntb, peer->gidx, &phys_addr,
+	ret =3D ntb_peer_mw_get_addr(perf->ntb, perf->gidx, &phys_addr,
 				   &peer->outbuf_size);
 	if (ret)
 		return ret;
--
2.7.4

