Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04797C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1021217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ET2bm4PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfC2Lcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:32:54 -0400
Received: from mail-eopbgr810047.outbound.protection.outlook.com ([40.107.81.47]:12931
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727675AbfC2Lcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIZa0gGXWYtnYNV9WwjgV7EZWCgffQvkG91JW5NRy8k=;
 b=ET2bm4PF3OY6qzctBn8N9oyIz4qgt9oPbr9+bTyO7In+6Kecsx0SNRHqwQWoF9wIVYpVq1ki/pwAewUxwXaXw6ynvIwuPf6T0RPraj123SOszYSsOT4BwwC3yS/TQikT65ukYZ9kqE/eJMTVddoRsJeSaamJqOvMudhQaqroD04=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3359.namprd12.prod.outlook.com (20.178.241.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 11:32:51 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::50cc:3c60:7379:46b]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::50cc:3c60:7379:46b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 11:32:50 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH] point to right memory window index
Thread-Topic: [PATCH] point to right memory window index
Thread-Index: AQHU5iMklFxgu091o06fvBhkVIOkqw==
Date:   Fri, 29 Mar 2019 11:32:50 +0000
Message-ID: <1553859137-4439-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c145c7a-bddc-4bc2-79f6-08d6b43a46a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3359;
x-ms-traffictypediagnostic: MN2PR12MB3359:
x-microsoft-antispam-prvs: <MN2PR12MB33596CA026065999744B4B78E55A0@MN2PR12MB3359.namprd12.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(50226002)(14454004)(478600001)(186003)(316002)(476003)(2616005)(5660300002)(36756003)(72206003)(110136005)(54906003)(81156014)(81166006)(486006)(71200400001)(71190400001)(68736007)(8676002)(26005)(2501003)(305945005)(3846002)(7736002)(6116002)(2906002)(2201001)(52116002)(6512007)(99286004)(386003)(25786009)(6506007)(4326008)(256004)(106356001)(86362001)(53936002)(14444005)(102836004)(6436002)(66066001)(97736004)(6486002)(105586002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3359;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8jbqL75cLR61QqT3FH5re+AMK+e6cHaJglFVNWHRDyHjWtCYUB9s3yHZaCaFDuIeqgh94ONLBzscWBGySAaJSrv9WqWoRpk+yWJfdwDNJdBKpJONyV1M8xaUVNJAj/No4Xcaiy1il66gqXZRfwmK7RCBHFfN6qVWnmGbfSDFLx2tTg3MPIe2Pl/+Bk1Wa1tR5Sk1kae6Ns2uox2NjwbZPNQ0KVR9n5FTBzb0AKUezZvz0UqWb0zev9+kqVe6upw2xaHEN7G95SCxRbgl1WasgiZkY9kCab41iX7IKUXhPPg/yyH/wAJBLBMWxMWX/2PHYEWFR47i+bYKaBRR03T2/oLq067xY6qmrlWGMZMPURNHBLktsyGxr1NIRbBn8gPOKodQ0UevxfxV4AjAMqiiieMd+4OmNqzlclVwcRcYEPA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c145c7a-bddc-4bc2-79f6-08d6b43a46a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:32:50.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

second parameter of ntb_peer_mw_get_addr is pointing to wrong memory
window index by passing "peer gidx" instead of "local gidx".

For ex, "local gidx" value is '0' and "peer gidx" value is '1', then

on peer side ntb_mw_set_trans() api is used as below with gidx pointing to
local side gidx which is '0', so memroy window '0' is chosen and XLAT '0'
will be programmed by peer side.

    ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx, peer->inbuf_xlat,
                    peer->inbuf_size);

Now, on local side ntb_peer_mw_get_addr() is been used as below with gidx
pointing to "peer gidx" which is '1', so pointing to memory window '1'
instead of memory window '0'.

    ntb_peer_mw_get_addr(perf->ntb,  peer->gidx, &phys_addr,
                        &peer->outbuf_size);

So this patch pass "local gidx" as parameter to ntb_peer_mw_get_addr().

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index c7d1a48..08e18d7 100644
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
--=20
2.7.4

