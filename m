Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CA5C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 07:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DC620844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 07:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Qewou9T2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfHDHDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 03:03:48 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:49309
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfHDHDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 03:03:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScGAQqJjMvPo21+LyNFdS1LuQeQkZavOm/IkFVQOJI84Yea4bytDE/fnlX8Kh/eSJd1ia0a0mX4AkVTH9AP3ByD8IAvxDJkQg5PIGtKeaV5INL1akC7JENdSt7tQYjyecO5k1fbOhAsR3XlWn3THIHWxkstMMNBmE+dSvdUZ1YtJAjlCpTHO4HqEOhDUb1oGO5S+zoyR02OluTKyYecD49DQeZWp6Q9MkHhA+qL55p+riLPUasmGpJ43v0xDBgYZvXaqBylPrxLQK4HTIiRrjEW/n28fntX+10koyLL4isI7T3hRoqfcu+iOG+JFrxj9SB61LJWz+QX9n9Kd7o0IQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/QIQaadQ8rK+66eblRdh+jqVsiBcKMvRpv8Z1UGqV4=;
 b=afVjw3zzyLk4wubd98w23tL0pMnhuf1WpnAXSIDwTk8PPCipD6y07UMxj8fJNoU5CiNFfet/dUZjYEGrRYcb3X4FJbNMjpw8gGgXbzp7E9r225nXzBi7H8aBx/IJSR2OOl8+MshPHKdCQJtE4NRulIiQ+tdoSOEYH+HGipVm2y2PGB30HxInqzokDNcniZC5/RX06t0FSROICPDmXgVQA5zo2UhN3Dcn8Y1SBvQGk6SRSMeQmMYlS2mLh40LAzURJ3DZN2sRh8vtHT41LUlkxqGoWkJItYw3cJx3x3fQg6euZh5zfgHWNuWufmJdWSclRhYv0zQcns/SsU6CPsjFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/QIQaadQ8rK+66eblRdh+jqVsiBcKMvRpv8Z1UGqV4=;
 b=Qewou9T2QJw2ILa+8cZKiqhOD6iFN0Mr8Im88fFECnG3XpvwWOS7OPKVMeMrP9PEtuqwVjwhIk1BZhbYJThBeDq3+PYs7FhRi8S+QF2BI6Tkk+zGdWRVuqchVDZ2YwiYMbhG+l3YBIB68OdpnkrqlQmE6+/P5oaXo8bb8ssIY4g=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB5181.eurprd02.prod.outlook.com (20.178.13.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Sun, 4 Aug 2019 07:03:41 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f%4]) with mapi id 15.20.2136.010; Sun, 4 Aug 2019
 07:03:41 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Update DRAM consumption on context tear down
Thread-Topic: [PATCH] habanalabs: Update DRAM consumption on context tear down
Thread-Index: AQHVSpK/pkG6NBkDVk+M/sFkvBsgqw==
Date:   Sun, 4 Aug 2019 07:03:41 +0000
Message-ID: <20190804070329.14503-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::16) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee91ff1-1ea3-4eb8-e293-08d718a9e1cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB5181;
x-ms-traffictypediagnostic: VI1PR02MB5181:
x-microsoft-antispam-prvs: <VI1PR02MB51819451062BEEB56AE5A8C3D2DB0@VI1PR02MB5181.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0119DC3B5E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39830400003)(189003)(199004)(66556008)(66476007)(66946007)(3846002)(64756008)(15650500001)(6116002)(2351001)(2501003)(66446008)(14454004)(2906002)(50226002)(6506007)(386003)(305945005)(81166006)(81156014)(8676002)(36756003)(8936002)(7736002)(1361003)(6436002)(99286004)(186003)(5640700003)(316002)(25786009)(4326008)(476003)(2616005)(486006)(53936002)(6512007)(68736007)(4744005)(86362001)(6916009)(1076003)(6486002)(478600001)(26005)(52116002)(5660300002)(102836004)(71200400001)(256004)(14444005)(66066001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5181;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: esd/OFgIe0boTBCvNKUTXtO7/PkZucGMyhX8vAmn4C6FmKi76jT3mbXIHBUJNLLcEeF35UvdVAx/SSquyf7iP+MCp8GHdKffFl88jPHnPIS1kIAaRmHiXH/UeJmNis5AxHeciUKxpnnf3KvtHkJeuIuIddgNf0FbMAQ7WF7dFWKalbPEX1HwVdAnEvPLNiShbJx22Ufb8C5PslOv++xbqgrnUOOZmw0VVELOQAmcUJ9TCw8iRYnnNfzaYhwp1bh91PaSKkTEXKip6dmUM0x9O39UVCVLIinuLGOZZkEdW9AQNDa+kgIB4YN72jYug2NMyVwrI8jSJJg2gm5NMlVWggEYXajns7aPDDSvkJ90MJmqTwXJQXzwUdS69dRce5ANId1h3t2CtdGWW7jbaNs8oLI9smfSxPTpztlsSAck66U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee91ff1-1ea3-4eb8-e293-08d718a9e1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2019 07:03:41.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a missing update of the DRAM memory consumption, when a
context is being torn down without an organized release of the allocated
memory.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index 42d237cae1dc..365fb0cb8dff 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1629,6 +1629,8 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 			dev_dbg(hdev->dev,
 				"page list 0x%p of asid %d is still alive\n",
 				phys_pg_list, ctx->asid);
+			atomic64_sub(phys_pg_list->total_size,
+					&hdev->dram_used_mem);
 			free_phys_pg_pack(hdev, phys_pg_list);
 			idr_remove(&vm->phys_pg_pack_handles, i);
 		}
--=20
2.17.1

