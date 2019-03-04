Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E7420449
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DKF5aDuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCDKd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:33:57 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:55072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfCDKd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfgBUub3BOrRwpuQIdMIePIxdp+Bf6bCLGsM+Wqmi5Y=;
 b=DKF5aDuwhf1NyfOctWGBzjHCA6kQEdotEyRM/56AJfVWQ0PjjV0Ni2bq0xpsHZ+VV5qOaJgZQOFkAvlZjohPYNemRrAERKtk66k0nHulOa80SzZTD8MlZYYxu2zYvxkhO+lWPMTj3GeB7ck6G8RYqXLplk0Zux53uU0C0w1dbUk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5476.eurprd04.prod.outlook.com (20.178.115.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Mon, 4 Mar 2019 10:33:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 10:33:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] perpcu: correct pcpu_find_block_fit comments
Thread-Topic: [PATCH 1/2] perpcu: correct pcpu_find_block_fit comments
Thread-Index: AQHU0nXCD5AKhUIPbU2zUP7D5ZNbSg==
Date:   Mon, 4 Mar 2019 10:33:52 +0000
Message-ID: <20190304104541.25745-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:36::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 591e3ba3-b072-4fab-609c-08d6a08ce527
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5476;
x-ms-traffictypediagnostic: AM0PR04MB5476:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5476;23:xPjEGb8K6mmlvvCQcIDHIT47qc75WSDktrE2LxS?=
 =?iso-8859-1?Q?ccfEYatAZtYQEFoaft5OQ0hWVT9s/6aQhiKFPom0jHsy2fAlr2LlQpZ7NH?=
 =?iso-8859-1?Q?p/L2//mXmy7Ws0pjrDVFXfatEwEUQfrlxLE+JPMBTQIL1AF7VtQZlz0WYI?=
 =?iso-8859-1?Q?p8WbZ2kLxUSBJkWHEBIsvybduOCCD16YR4OpH/Tbdolq702ylaNL0raJm0?=
 =?iso-8859-1?Q?A8Jn9SZEPOazhqF7c9a0BjILie0y6GOmKgs4guFAaQJhwdC90s34jeYG7i?=
 =?iso-8859-1?Q?dP2BDbye2Hf7WCVHZBDq3VJXq9rhBu7h8fpNMw7ZnAXwIIFfxGL7R5QQsv?=
 =?iso-8859-1?Q?vLXlVwlJhAPxnqWrwHWR3XM8KbvjCW8XO9Yw3AZJ61ArSYRDwjwOVdMjjr?=
 =?iso-8859-1?Q?M1bw0k29HrZryZExRECbaaJ47lz2jamIWzUg1HD0m99Tm+LdIQL7mb/gUu?=
 =?iso-8859-1?Q?YhbO/TQIInheLctcPFXBAbzQEW2rvCeaBB8l5wXTQZViyOmpXbeHlXUrCY?=
 =?iso-8859-1?Q?oaA7DIcqmzTtK7KYjMGRH874SjDklb7y7e6UOTo4L0HXIQMWSKbceEWjkB?=
 =?iso-8859-1?Q?96bQasyOtJVpDBaHwwMIqG76bVuI5YSSAIyfEgjfXVBjzNK7JSLLLGoYee?=
 =?iso-8859-1?Q?NPnenKKEa1/y+mJCd0J2dA5ZROcehe+qfmmzakvnwkTdRJzIovtxhIeVcz?=
 =?iso-8859-1?Q?vOVj7otzCl0P8tRGj0dit5daxbDAHl+S8obsiSiRQLxIVhNbMluBm7Biaw?=
 =?iso-8859-1?Q?e4D9Ad2BSRH/bQP/M5RLvcVVO5/Fh/K6vInWGc6yIOLOkg7EtqlVjet9Gk?=
 =?iso-8859-1?Q?F6uvbSZtGP2MBUoZQqkDU90+4mrOYRvvmtec/AsiWMFd3VLcQvn/2YnBX1?=
 =?iso-8859-1?Q?iVYlrW6zYUrVjNnTgKBRGQ/bX2EiKfxOq+P3ZIjuUIReSTqZ2nvI0Ko58o?=
 =?iso-8859-1?Q?Wkn2vLSVHRKDmgePvv2JseX6BVi2MZALmY/ji5capyQOT9TGotLbbWM6Vx?=
 =?iso-8859-1?Q?8gAsd3PYfC8xbGjFdH96BVEUcAs4K4Eo62mduDxfnoMTaMalI6FHj7n+g0?=
 =?iso-8859-1?Q?F+SDbGwAe1S+UQ8ap7eIxXQCz53t+pUUqVJ2nOV3niHEM8XPqulbQ1uPYG?=
 =?iso-8859-1?Q?Vb1r9G4AhNUaJDwh3ieLrwHCk39GaJzk8WYg3WTJjuOK42gsnjuQMnA9nJ?=
 =?iso-8859-1?Q?FZPBS2hHV6l8mkFVQwOevwOdmu50HxB84W//1RGJGzrJi2VlPrtGphfzdY?=
 =?iso-8859-1?Q?AHhxXYza/RxM6LQU5YqeOvzUUN12VzTg6vbsWWYQ0A7F+1ZiWuL21LAd4y?=
 =?iso-8859-1?Q?yOptqbbfF45aO8pM4MITAGh/zRf07eZxo82RCFTRVYfVg=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5476A99F7ED91457FCDCA3FC88710@AM0PR04MB5476.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(6512007)(6306002)(102836004)(186003)(2501003)(386003)(6506007)(99286004)(71200400001)(71190400001)(4744005)(476003)(68736007)(36756003)(2906002)(1076003)(486006)(6436002)(5660300002)(6486002)(66066001)(26005)(53936002)(2616005)(14444005)(256004)(44832011)(52116002)(106356001)(478600001)(7736002)(105586002)(25786009)(305945005)(4326008)(86362001)(97736004)(966005)(14454004)(8936002)(2201001)(316002)(50226002)(81166006)(81156014)(54906003)(110136005)(3846002)(6116002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5476;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z6Gcvi6hmTv6Nr04slcinS2sdoCjk/3y/Wvo5xXf52RZrixOZLc1f33UqbfsSrSrM1olFrTha/nz0QH8lHTV3BIyi2KnUH7fJ20+4BhFALLojD4AjwiRERC6ncEmOwpKKYWDUHgULy6kXE9RAsXyz+kyYpzOEqKSz+qqCXJS9uDXhHaVzBIsgaZVJ9MUyWx6G3xaCMM3NAVfZGU5zzJqxm+91eP/KKUXTCvh6IRqoJkDtedDjo9Jos8bqL+bkbI5lYZEAXnDg6AxS29lzo4Be40+1UCRui5tv5zDX/rFK6gQaGktzgGj41aS0Co/v3v0ds0D2RalESz/n0LsPEUyvBbqV/hKVqmONUZk/fXayuQI2Tp8mtlUGFCasjQS4sd3BFXsd6Wdnx1Wywf4GdUVxqc95sKcvvZc0DAHfVT320A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591e3ba3-b072-4fab-609c-08d6a08ce527
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 10:33:52.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcpu_find_block_fit is not find block index, it is to find
the bitmap off in a chunk.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
  Based on https://patchwork.kernel.org/cover/10832459/ applied linux-next

 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 7f630d5469e8..5ee90fc34ea3 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1061,7 +1061,7 @@ static bool pcpu_is_populated(struct pcpu_chunk *chun=
k, int bit_off, int bits,
 }
=20
 /**
- * pcpu_find_block_fit - finds the block index to start searching
+ * pcpu_find_block_fit - finds the offset in chunk bitmap to start searchi=
ng
  * @chunk: chunk of interest
  * @alloc_bits: size of request in allocation units
  * @align: alignment of area (max PAGE_SIZE bytes)
--=20
2.16.4

