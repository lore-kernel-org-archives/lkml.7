Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF1FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B302238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hz4ZObUN";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="XcxcBnbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfGYPAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:00:32 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30192 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388913AbfGYPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:00:30 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PEvjlO001791;
        Thu, 25 Jul 2019 07:59:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=eLltd09AZLnnfOw2WrA/G1QDSh/+zspsDr0BDSLPhBQ=;
 b=hz4ZObUNiC2u7psSw+/euweRuI/h6QxXcD5dqOi29G7Me3yqcPYS056hLNor0PNCQC7q
 kAbxXwOSNk4XfCDENTrRbgoSYeqhe4h4t/wFNUxxO9irNmfMA51zfEVVvVfMJoqRIRjc
 Ko4J7kC54k1+SH0nUXEF1njTSoEb0yiwdnb2xLCIM4Eec0Qpd2ty+kcb45tLZNFY6ncW
 6vuREWJ0QNAZm9gguiHJyjA6BfiD3HjrOyt26t8ydFQzOkqJAflapVDFWn29Y6CYDD7R
 huRByhfi3CvEcsQkByADohlRuxABJj3lmgViCHOgpu3OVXsumrR/W7SZx2Gapj7R3pHQ hg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ty9h4h4vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jul 2019 07:59:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbU9CvGnMty/kNpBYTFGn8Qrloqy6FW0sA8qkKJAJDoXanmK6NTSbzG08ygnitjC5mZkyrnAtd12E/wguJskeqp+/Dy9M9c410W0uDLs7+tol8bNITXJB++ZQhIVRGJmHpvdVjhOEZRI6nQu+TrDzOHtHj2SwASPA0vPyPq8vmiZ3d0PSVnQTdzWGfkvQaNk+3jLstbDlCiNHwRUMuCUJBbRw5Hhbn2cEuq6P4jq9C8befk0K1vEEZOK/vuFB5GhT/91isqwC+QVTmNHR2Z0YQxD5S5yuRUBdZ6+rFuujWZtjeAkaRBrhGSXEpzP5S+CXpxQEQ4NMZwZvhnDXCz/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLltd09AZLnnfOw2WrA/G1QDSh/+zspsDr0BDSLPhBQ=;
 b=g/W6BT+hEsI8F25gmcx0n0tBv6F3Tf6/nnVm5JV1zERCC1cURrpf/Icx+lPE7DPj+3YMqSexTupfAtuPcg1nnqDo1aP6qjKKnOj2Wi3hEemAW5RiaYiA3sLCmAEJQy47jpRQ5BZ/LyQb5NgvzjRs8BAorEu/Fa+DS4QKBYcTi4mqtrIgv8HdVKHN+WV6/S0b7Byx17UJ8DjhuO1b5VIO/U6V/NGzTNWaRo9WMw8yE1Xtkrj3mTUF4zOG4W8SrGWsbm0Yy4+JNR+kemVyea70Qkg/HiSja2t1nNlSMKyCEOMJ9L4Z2UUxwT7+y4rA3/LcglebiDS++bEbghrU05rR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 158.140.1.28) smtp.rcpttodomain=infradead.org
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLltd09AZLnnfOw2WrA/G1QDSh/+zspsDr0BDSLPhBQ=;
 b=XcxcBnbwzgHnGD6F97+H3KvyrhozSET3kY3XDfDfvVXm1C3hs5QCzNds+PMKI8yg/e1iKaTH8g1hERIo8ThmaiJHrQxE+9jx20yVPa8RqwaE2J3EIgCRP4D+wgYu1vqqknbluE5ty3lqQIgHyIBSClUV6clqN1+20hyu8tdtOpo=
Received: from BN8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:408:ac::49)
 by BN8PR07MB6817.namprd07.prod.outlook.com (2603:10b6:408:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Thu, 25 Jul
 2019 14:59:35 +0000
Received: from BY2NAM05FT041.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by BN8PR07CA0036.outlook.office365.com
 (2603:10b6:408:ac::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.13 via Frontend
 Transport; Thu, 25 Jul 2019 14:59:35 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT041.mail.protection.outlook.com (10.152.100.178) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.7 via Frontend Transport; Thu, 25 Jul 2019 14:59:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x6PExTRm024674
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 25 Jul 2019 07:59:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 25 Jul 2019 16:59:28 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 25 Jul 2019 16:59:27 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x6PExS3Z012639;
        Thu, 25 Jul 2019 15:59:28 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x6PExN34012572;
        Thu, 25 Jul 2019 15:59:23 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        <linux-mtd@lists.infradead.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>
Subject: [v5 0/2] mtd: nand: Add Cadence NAND controller driver
Date:   Thu, 25 Jul 2019 15:58:04 +0100
Message-ID: <20190725145804.8886-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(36092001)(189003)(199004)(36756003)(47776003)(42186006)(70206006)(7636002)(26005)(51416003)(305945005)(316002)(16586007)(5660300002)(8936002)(336012)(50466002)(50226002)(76130400001)(48376002)(107886003)(86362001)(2906002)(1076003)(70586007)(486006)(246002)(54906003)(426003)(6916009)(2351001)(4326008)(478600001)(26826003)(87636003)(476003)(2616005)(186003)(8676002)(6666004)(7416002)(356004)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR07MB6817;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1076296b-91dc-4ada-d8e8-08d71110b4eb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN8PR07MB6817;
X-MS-TrafficTypeDiagnostic: BN8PR07MB6817:
X-Microsoft-Antispam-PRVS: <BN8PR07MB6817CD2083D88F73390B6961DDC10@BN8PR07MB6817.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0109D382B0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7iu/bsVckLe7H5CZaRpSL9/jRzadflnWmOZiofIwq86g9clE+Sj102XX7qoDm65MMpO6FHs1a6sEYzrUbGAtVL8BsC6xzG7ZbiPmx+lkw2C0rEkS1c4Y2Bu/d7i+QJnidzDgGKm9cCZGOqLEl3Bwe1Vp1ffc7BFNAd86PkKL6fqI8ENy3LpJCH6gNLtjj9jBETzeWAgCyNteWHy+4ULaa/ChP6JmG9v2yTzLpKenQxi9zG4zPua76vnBNOak5QmAMkUHVAKUCaPf0d+nKKvgEECqQEQLz5l+aS6f9cXwvp4L7x13+AwXA+pJS64CpE3JTi2Qd7Od9IanznRfMgMpGyeKqySogMHSJWPHqxiOWT8ScdN6a4OSvktvFbEWiq+W8h49A5rzztetAsmTyH3ZDQGmOPeep66pO1sRuFcqljA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2019 14:59:34.7838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1076296b-91dc-4ada-d8e8-08d71110b4eb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6817
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250175
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

 .../bindings/mtd/cadence-nand-controller.txt       |   50 +
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/cadence-nand-controller.c     | 3021 ++++++++++++++++++++
 4 files changed, 3079 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 create mode 100644 drivers/mtd/nand/raw/cadence-nand-controller.c

-- 
2.15.0

