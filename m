Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A9C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67A4222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="L0r1r3pS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Q7+qZkTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfIZIMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:12:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59114 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfIZIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:12:38 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8Q8BjPo024013;
        Thu, 26 Sep 2019 01:11:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=xAjC8cEgAP8Za/kG87SWnHZaVYVHLBKJzlxHvZCVTrU=;
 b=L0r1r3pSxv3HtOwt+yWVAOrFGEYvpZvD8fiqqw981kJBKaUdj9LM8ipXdockWTMgaa5b
 1cSWnG0JLanR6c2DvNx29xU7hkUazJmO7V+AclcLDxtgnGHTRYnpzhr/2O6PI5WpVBiS
 x/VGSdAi+2B/oHWwMb46kqPsobjOWkONcSZuyYd3qUDlhT/CayzO9qdveUAeBjGqtUs3
 rc1FxtAqTQUeQm9yYIL5pjDH6uz6wlbH8xHRWAml4D7W/RLZp+8Ey/OwWSppoJdmsPVg
 /fbjFk2T/P96h74czRfZ+3OF/0XN91SaNm/JsMBJ5aiNqAv2mTahbjERKYZhUaGihT6o hg== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2v5ge0kj0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 01:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGP9wKdi/l7XVW9AVyf0pWmTqAEZXg9bBIpZriwKxRYJ8Idf5aCTJnn6SI+mHBAQ8HGsh1pMMJVVadhBKVYtoVr+QqHl/qhCZAzwkoQbUvBAxC65RIQToNGh1Br0AP1w/0RHKWjOAwmf5RXozYsAmW+U6hBXSfICZmUHet10pQziWLQDw1xY8pZt2TV9qSfKklGoAdsopexKJttMJ3rYMrX+chbVssrb3xv6Q26k4lkyWlooSvYNQOBvtiuifvKzpLTJXlyYP9yQEUQjiLvYpdLddrfeOs63lBOGd0tSHbnMjl/xFluGWkt5ki7ymkcq/GUBGEGVWTxZj2N7Vc+02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAjC8cEgAP8Za/kG87SWnHZaVYVHLBKJzlxHvZCVTrU=;
 b=M53e2AYiB4SBevEf0r+AKORtslCStMO+ZsRfRmayJ9B0lVYKCHkXl+FFJIwCaEBXTaq41nxmvRaWORCTnmev7hbfswLHGin7NGHxNnbi1E7xNxPC84WNbHRGCjupbQ4Fz4TFT434V4CPImNKWDv01jUM9wyPkyLLPWXRtPeNk44JqF/qXaMqDMZzADQQ7zPb3vXpxDoVrQPbHUjsJ5zy0Vpti8/c0H8X8p7JhHuKVCWxCHhBMXPAAA7aNkvioB5kPoaBrN3fGxsPZyOvwCb6UK/zhAnCUXjShnZdkY92Pi7NinTkCceusS0ib+l+Zs719aEix291FvP1umaFAaZS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAjC8cEgAP8Za/kG87SWnHZaVYVHLBKJzlxHvZCVTrU=;
 b=Q7+qZkTIyLb4y/4BvDtdbtKChC7Z6GRtFmbx/D8Szq3BGlymQsOfc364HG/UGAi9zd5vt66fEgdWSSKw2KuslUzoCsjZbol/BwZhVIlJwOWAUxFqmTn5fyaXvu5n4Ogw9A0DaIeqGhMG3HP0K9/68ijEyOwwmZW4Sp5Y6+6sR0o=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 BYAPR07MB5656.namprd07.prod.outlook.com (2603:10b6:a03:98::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 08:11:46 +0000
Received: from DM3NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 26 Sep 2019 08:11:46 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 64.207.220.243 as permitted sender)
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 DM3NAM05FT006.mail.protection.outlook.com (10.152.98.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7 via Frontend Transport; Thu, 26 Sep 2019 08:11:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id x8Q8BUXB179783
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 01:11:32 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 26 Sep 2019 10:11:30 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 26 Sep 2019 10:11:30 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x8Q8BTx1022311;
        Thu, 26 Sep 2019 09:11:29 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x8Q8BQRA022269;
        Thu, 26 Sep 2019 09:11:26 +0100
From:   Piotr Sroka <piotrs@cadence.com>
CC:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [v8 0/2] mtd: rawnand: Add Cadence NAND controller driver
Date:   Thu, 26 Sep 2019 09:08:41 +0100
Message-ID: <20190926080924.19220-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(36092001)(476003)(81156014)(81166006)(1076003)(54906003)(26005)(16586007)(36756003)(36906005)(8676002)(1671002)(48376002)(316002)(305945005)(2906002)(42186006)(8936002)(50226002)(2616005)(478600001)(87636003)(6666004)(356004)(7416002)(5660300002)(86362001)(47776003)(70206006)(109986005)(70586007)(4326008)(50466002)(51416003)(336012)(426003)(126002)(486006)(186003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5656;H:wcmailrelayl01.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 945733ea-bf01-4647-706b-08d742592bf6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328);SRVR:BYAPR07MB5656;
X-MS-TrafficTypeDiagnostic: BYAPR07MB5656:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5656A4C6D2E8E3EDFD5C2261DD860@BYAPR07MB5656.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 82TwS3vPah76qyNCnfOyogGoNHMwJ5tlPMtTL+mEJ1INVFrnkznIEVWw67QWvCuhM4DYHV6N9wDeZvowd1kIB6yt1gpRJ5ZIXngv/DtdOuoeSJ5HQ93pZbksLfpxh0pFRsygeioZcjZwfC8r5YGk+osYb17Kl1rQabzowjese/BpXBHZxRudoHouTbK1n56Ix/dswYFkCydHrdW+vUDLKBN21EUUDPubgZXmUq64Bh042qXqyiGFeXY9osBvM2M/PZr5Q04w1kqqXLwe1uNYNwy5xgdXzEpUHiCCjf2ixJfvrRnqGEY4fjtb+pbYw8RcI6aiDY5aU9khBfQDUJg8pERBKJeNJnn4xiywvpByneCeoAD2OXJYVAefad+94SC2O5oPXQ8r9zUU3CbjVLBwM2yWOTslawFT5VAq4+bhRnA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 08:11:45.1846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945733ea-bf01-4647-706b-08d742592bf6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5656
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_03:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260080
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for Cadence HPNFC NAND flash controller.

HW DMA interface
Page write and page read operations are executed in Command DMA mode.
Commands are defined by DMA descriptors.
In CDMA mode controller own DMA engine is used (Master DMA mode).
Other operations defined by nand_op_instr are executed in "Generic" mode.
In that mode data can be transferred only in by Slave DMA interface.
Slave DMA interface can be connected directly to AXI or to an external
DMA engine.

HW ECC support
Cadence NAND controller supports HW BCH correction.
 ECC is transparent from SW point of view. It means that ECC codes
are calculated and written to flash. In read operation ECC codes 
are removed from user data and correction is made if necessary.

Controller data layout with ECC enabled:
 -------------------------------------------------------------------------
|Sec 1 | ECC | Sec 2 | ECC ...... | Sec n | OOB (32B) | ECC | unused data |
 -------------------------------------------------------------------------

Last sector is extended by a out-bound data. Tha maximum size of
"extra data" is 32 bytes. The oob data are protected by ECC. If we need to 
read only oob data the whole last sector must be read. It is because 
oob data are part of last sector. Reading oob function always reads 
whole sector and writing oob function always writes whole last sector.
Written data are interleaved with the ECC therefore part of the 
last sector is located on oob area and the BBM is overwritten.

SKIP BYTES feature
To protect BBM the "skip byte" HW feature is used. 
Write page function copies BBM value from first byte of oob data to 
BBM offset defined by manufacturer. Read page functions always takes 
BBM from flash manufacturer offset. It causes that for not written 
pages the proper value of BBM marker is used.

ECC size calculation
Information about supported ECC steps and ECC strengths are read 
from controller registers. ECC sector size and ECC strength can be
configurable. Size of ECC depends on maximum supported sector size 
it not depends on selected sector size. Therefore there is a separate
function for calculating ECC size for each of possible 
sector size/step size.

Piotr Sroka (2):
  Add new Cadence NAND driver to MTD subsystem
  Add Cadence NAND controller driver

 .../bindings/mtd/cadence-nand-controller.txt       |   53 +
 MAINTAINERS                                        |    7 +
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/cadence-nand-controller.c     | 3031 ++++++++++++++++++++
 5 files changed, 3099 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 create mode 100644 drivers/mtd/nand/raw/cadence-nand-controller.c

-- 
2.15.0

