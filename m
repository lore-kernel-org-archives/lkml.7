Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB35C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B66213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="OraEtrIF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="H1g2TaIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbfFYPUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:20:17 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8096 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728199AbfFYPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:20:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PFIMTk016751;
        Tue, 25 Jun 2019 08:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=8j7BmmHW6DBHa+2mgobfd7aWkcdZyhbrBwu0MaW6p1M=;
 b=OraEtrIFDofYWUt/x7MFmZ8SDdmSTR57qtf7Zhr9WJ5XzBMxDtm50OH4Nmw/oPBaAyEo
 hVriMICcsnt+Mst6CJa20YMjiPJN0NzP/KAxc27vipf0z4tE+bta3mwV0gGz1BDGarqM
 zDTgj4JJh85lRFNYZuKhxjsNNzNEIOZrBu0BTMzbfh9eeXgsFsr5InZjU0NPYFP9nTm6
 zEjTjPSGl1UQrT5iHJi7TlRPoEvZoUY5b3f/K4A9jG8hPRfAsPSFvzPp6PnPVlvLK/Hr
 K+s/8ye0A31vrahJpCdjQ6WV5pbbn6KQ/22Dpc7vE6zjo/KisIaP/7kWshRXcm9oP0p8 Yg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2t9gvsd5vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 08:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j7BmmHW6DBHa+2mgobfd7aWkcdZyhbrBwu0MaW6p1M=;
 b=H1g2TaIEPHg6mueKL3VUoPpViHBHRz5BOiS3BHcu/anbOakw+XSPdAvNjCn5ki0KVyWfEy/DUw+Z1MKcYv7zZD39YOchZkbcpBTzPUKNZYmm74j2VsSpcZ+jWI7d2rQlNQj1RxksXlXkf63KZHHZkLKeTovtqPfJrAHhLWDBLx8=
Received: from DM6PR07CA0026.namprd07.prod.outlook.com (20.176.74.39) by
 BYAPR07MB6821.namprd07.prod.outlook.com (20.179.89.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Tue, 25 Jun 2019 15:19:34 +0000
Received: from CO1NAM05FT003.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by DM6PR07CA0026.outlook.office365.com
 (2603:10b6:5:94::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 15:19:34 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT003.mail.protection.outlook.com (10.152.96.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.6 via Frontend Transport; Tue, 25 Jun 2019 15:19:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x5PFJShK000783
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 08:19:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Jun 2019 17:19:27 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Jun 2019 17:19:27 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x5PFJRoc018428;
        Tue, 25 Jun 2019 16:19:27 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x5PFJLw9018275;
        Tue, 25 Jun 2019 16:19:21 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        <linux-mtd@lists.infradead.org>, Piotr Sroka <piotrs@cadence.com>
Subject: [v4 0/2] mtd: nand: Add Cadence NAND controller driver
Date:   Tue, 25 Jun 2019 16:15:59 +0100
Message-ID: <20190625151559.15270-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(36092001)(26826003)(50466002)(426003)(2906002)(70206006)(70586007)(336012)(48376002)(4326008)(47776003)(2351001)(76130400001)(36756003)(7416002)(246002)(6666004)(2616005)(356004)(86362001)(51416003)(316002)(8936002)(486006)(478600001)(50226002)(16586007)(6916009)(107886003)(87636003)(42186006)(26005)(186003)(476003)(7636002)(305945005)(5660300002)(8676002)(54906003)(1076003)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6821;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ee5bfb-e38c-467f-ead4-08d6f9808760
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BYAPR07MB6821;
X-MS-TrafficTypeDiagnostic: BYAPR07MB6821:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6821D8C78359CCAEC6C513CEDDE30@BYAPR07MB6821.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: eBFzqGqJkGzQWE5yIWpOCHSgj7wSvHcJ5SYNYC/3vmgLGOn3FfbE/V40PDTlpfnQWWMHNxPbywNB7aezlmh0vQthnp1cf/j/aS/fFH84m3KuRHKK1SrpWLigtD5rMS2S2TM6y8+oDnlaJY0nub973FGw2Q8TAIkDCQXaypmSTCAQ+JhwtVhwhunrwclQPLOFvk9A1Yk0pxoDa//0P+XQjy+QnqN5yXt7C9FCLUBNgaRsr3mW35wfMUajly9u6C6oGtuTfj4tP9ObysdPhEPjj3XW7/lx8ZoMupDioqptj4mKH5xPHL/aNu7OUv/SVeb9GzzLZCDee/3nvYW3jP4KCLW9C5E4fZ9uk3A+YUN4CzgVHEO82A2nfFPTFDn7N8DJIpN0euIC3mWPIPnHOmkrpWN+TTxd453MTMS4Vu7xzU0=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 15:19:33.7636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ee5bfb-e38c-467f-ead4-08d6f9808760
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6821
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250117
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

 .../bindings/mtd/cadence-nand-controller.txt       |   51 +
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/cadence-nand-controller.c     | 3109 ++++++++++++++++++++
 4 files changed, 3168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 create mode 100644 drivers/mtd/nand/raw/cadence-nand-controller.c

-- 
2.15.0

