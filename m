Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49048C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DA5207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EhwretCb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="2F1heR2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407556AbfIYQ7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:59:47 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:56178 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407129AbfIYQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:59:46 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PGt6oI002740;
        Wed, 25 Sep 2019 09:58:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=Hr+o5aEJRyDB+3xP7mBorrmrFUAKZFEm3YYTm2ArMJs=;
 b=EhwretCbLHC54A9yhl0Kd0teSl5oxBrwivFiFcDUqZg4WFCH8CNAotpWCf+lwcHFy9jd
 k3Z/amRvcWL/2y8B1lHwpbtNRovOKBmqMNL7GUh0t/fkgOuN7VkpF75chxx3FODUxc5l
 uRX1GAXG/kvCb4zf26WxLMB3ocdDf9xoJ+V6qZ4xEOKmsYqMxh79QSX76VWQ3OY7+QEk
 mZ94cj07ZPmhi/ywjPLfLGH1k2woCwa+3OTu70CInOosbqozRS+PJJ9NpfqeBhuYfIZp
 n8HAaW0jvhaMKTeZ1ZYeqi6FckpFC/AO6WOah01RrsL1G5s8Zg9+ZjZXL4Z9GsCeKKZz 2A== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2051.outbound.protection.outlook.com [104.47.32.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2v5fews6tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 09:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwpYnywhcU2CiBXnTASodER3+I0qAYbO29iP0a7vV0ye1OlBz9EpuCfJaYZqxql6iQfOjL+HHCP7Yhn3xLN0eYtLJVAHyweswgdv0BsqLZJT+q9TAuiIXCtyaw8kt+IVXqEhK7qnhQY/cLY7zJRizSQql4X5KnlQ01I7L30jy4k9eW8Z8AnXZlvbpafLGz8OyrIuk6+0MNqPCsyFcQz6Yu+alu5dFk3ziLw3NyBqIcuHFUYiERVTjnsB9qybYGMBMNbqA9bzfHzOk3s1Stdj06CxDBzjy8SJJeIgcu6hdQXba7En21fDjHonCr4CDNVuHhOKBmZpR6FGZIiaskpJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr+o5aEJRyDB+3xP7mBorrmrFUAKZFEm3YYTm2ArMJs=;
 b=TrD/nt7jrP+Sdqk8lJB3RBrJjiSkNNHOCTEIOJpTn3h9hEbzadyKpy27ffALjafSqKKA1pREpum6kyu+J84Oe6MNu2petFNkDTWDX1nLe2ojPtVJobVIJhcfoYQ3YgXfp81LsQ4a5RE7oFw+QwFTwHpHVpRi665RFSXfZXcdfZxYB+Qhgiq+Haqh5MWQNvAWz1teuQWaMEobm1Gt5/ck6GpnkLZB+TErgmmi3+bJNz1XOSD0wTjaVckLEDmFc2fWbtb+f2dfPk7lszrX2CgCC4nZyo3l4P9My/XB+DfH3kG997J9yDOAsYoG2DfNkHLGtfOHhhLMVoYJ9Amzr93OPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr+o5aEJRyDB+3xP7mBorrmrFUAKZFEm3YYTm2ArMJs=;
 b=2F1heR2Ni6Wz9QMVCG99/8xJ+zKzFe9Z+C9gOdXXkxd4f8uHJfyjLwuv3oTsGZjh/38vNJczb869/Y7BWculIRR4QOUhheq2WV1Lj2u2oCGeUAGOCcIvmN61qvj9Y2EQWowCzo/7i9IPQaJ0mDlL2lYMWEb2g90ZGwEiXeKLe74=
Received: from CY1PR07CA0003.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::13) by MWHPR0701MB3676.namprd07.prod.outlook.com
 (2603:10b6:301:7e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Wed, 25 Sep
 2019 16:58:22 +0000
Received: from BY2NAM05FT061.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::206) by CY1PR07CA0003.outlook.office365.com
 (2a01:111:e400:c60a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Wed, 25 Sep 2019 16:58:22 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT061.mail.protection.outlook.com (10.152.100.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 25 Sep 2019 16:58:21 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x8PGwHGR006716
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 25 Sep 2019 09:58:18 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Sep 2019 09:58:13 -0700
Date:   Wed, 25 Sep 2019 17:58:07 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Julia Lawall <julia.lawall@lip6.fr>, <kbuild-all@01.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [v7 1/2] mtd: rawnand: Add new Cadence NAND driver to MTD
 subsystem (fwd)
Message-ID: <20190925165805.GA23093@global.cadence.com>
References: <alpine.DEB.2.21.1909182103550.2753@hadrien>
 <20190925101740.725e2cb6@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190925101740.725e2cb6@xps13>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(36092001)(199004)(189003)(6306002)(426003)(58126008)(23676004)(7636002)(386003)(2486003)(26826003)(6916009)(478600001)(86362001)(50466002)(53416004)(966005)(316002)(7736002)(8936002)(30864003)(55016002)(76176011)(54906003)(66574012)(3846002)(6246003)(33656002)(186003)(7696005)(305945005)(8676002)(26005)(6116002)(5660300002)(2870700001)(16526019)(5024004)(956004)(2906002)(7416002)(246002)(446003)(336012)(11346002)(476003)(126002)(229853002)(486006)(1076003)(6286002)(70206006)(76130400001)(4326008)(66066001)(47776003)(70586007)(356004)(6666004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3676;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c40f546f-1d5c-444a-9c33-08d741d992a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR0701MB3676;
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3676:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <MWHPR0701MB36764D3A234FA54EEDAD87F2DD870@MWHPR0701MB3676.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 01713B2841
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: o/KTmXsU5fIFvVU/sSWPfT1xc5vex2srrEA+WVYPGCehSPRQpBh4zc3WoCnDjEhakmIe1H0gHCuoeYlX4cZ+yvjGe0qloocODShSjtVyRPBWV7BsbIOj0l1AsXPtvDwzab96bsQIMj6QJENAL+t0ok0eeH0UAb3YbX55swol1YJoIxgG1LN3OOf+Ce/VpV7YeHw0BigG1jzmb6Y3hXz97U0iFnUMRQll5i9ddvlKEuxfvLrAWWajopyBc7ttc8DDV76Ct9wboWeVxIFlHqA//qb0/E2w36VqeSk/JIKvZnCpVK2+v1LIXUzUC0rb/vXDCQ3ssYlxJnBOzpi28dr29fZAJ4RClcqeCOhtPnksZexHZyYqtsEHWDU/3Y1dhuLNAEJFlOyzkuWbrzDi+IJ2w5B4QeDQyurmabUbX1dZQEpItyPaLsizoYajpnDEN537IJW2cg7aL5YKyX30KLgV4g==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 16:58:21.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c40f546f-1d5c-444a-9c33-08d741d992a7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3676
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_08:2019-09-25,2019-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909250152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel

Sure I will do it this week.

Thanks
Piotr

The 09/25/2019 10:17, Miquel Raynal wrote:
>EXTERNAL MAIL
>
>
>Hi Piotr,
>
>Can you fix the below issue reported by Julia? Either convert the
>structure parameter to a signed parameter or use an intermediate
>variable.
>
>Thanks,
>Miquèl
>
>Julia Lawall <julia.lawall@lip6.fr> wrote on Wed, 18 Sep 2019 21:04:37
>+0200 (CEST):
>
>> ---------- Forwarded message ----------
>> Date: Wed, 18 Sep 2019 23:17:29 +0800
>> From: kbuild test robot <lkp@intel.com>
>> To: kbuild@01.org
>> Cc: Julia Lawall <julia.lawall@lip6.fr>
>> Subject: Re: [v7 1/2] mtd: rawnand: Add new Cadence NAND driver to MTD subsystem
>>
>> CC: kbuild-all@01.org
>> In-Reply-To: <20190918123115.30510-1-piotrs@cadence.com>
>> References: <20190918123115.30510-1-piotrs@cadence.com>
>> TO: Piotr Sroka <piotrs@cadence.com>
>> CC: Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Piotr Sroka <piotrs@cadence.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Boris Brezillon <boris.brezillon@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Paul Cercueil <paul@crapouillou.net>, Arnd Bergmann <arnd@arndb.de>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Liang Yang <liang.yang@amlogic.com>, Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
>>
>> Hi Piotr,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on linus/master]
>> [cannot apply to v5.3 next-20190917]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_0day-2Dci_linux_commits_Piotr-2DSroka_mtd-2Drawnand-2DAdd-2Dnew-2DCadence-2DNAND-2Ddriver-2Dto-2DMTD-2Dsubsystem_20190918-2D204505&d=DwIFaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=TGZtNfZu5Cjhu2K8A0Qhsot4HlKpSJ0Xmyc_L8hPwSI&m=mgwNQ1SA26JWmty5PuDLavsJlIOFJvmPqnwJa6yPWMA&s=NawctdULcP90SHk2dQOe0pKiQerhjWFPA6n5lT8EFxY&e=
>> :::::: branch date: 3 hours ago
>> :::::: commit date: 3 hours ago
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>>
>> >> drivers/mtd/nand/raw/cadence-nand-controller.c:2644:5-28: WARNING: Unsigned expression compared with zero: cdns_chip -> corr_str_idx < 0
>>
>> # https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_0day-2Dci_linux_commit_3235ae79d58b8d95b44d5d3773f59065f04d4f00&d=DwIFaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=TGZtNfZu5Cjhu2K8A0Qhsot4HlKpSJ0Xmyc_L8hPwSI&m=mgwNQ1SA26JWmty5PuDLavsJlIOFJvmPqnwJa6yPWMA&s=Mx7SXvJoMz9s4OjGbntC5eTU-djHxf6cpfehouD_uFI&e=
>> git remote add linux-review https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_0day-2Dci_linux&d=DwIFaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=TGZtNfZu5Cjhu2K8A0Qhsot4HlKpSJ0Xmyc_L8hPwSI&m=mgwNQ1SA26JWmty5PuDLavsJlIOFJvmPqnwJa6yPWMA&s=aKS20tAkXcvBbq1SBp9yJSghFIfIuFqSNAL_Fq5uCI4&e=
>> git remote update linux-review
>> git checkout 3235ae79d58b8d95b44d5d3773f59065f04d4f00
>> vim +2644 drivers/mtd/nand/raw/cadence-nand-controller.c
>>
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2584
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2585  int cadence_nand_attach_chip(struct nand_chip *chip)
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2586  {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2587  	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2588  	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2589  	u32 ecc_size = cdns_chip->sector_count * chip->ecc.bytes;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2590  	struct mtd_info *mtd = nand_to_mtd(chip);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2591  	u32 max_oob_data_size;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2592  	int ret;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2593
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2594  	if (chip->options & NAND_BUSWIDTH_16) {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2595  		ret = cadence_nand_set_access_width16(cdns_ctrl, true);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2596  		if (ret)
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2597  			goto free_buf;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2598  	}
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2599
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2600  	chip->bbt_options |= NAND_BBT_USE_FLASH;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2601  	chip->bbt_options |= NAND_BBT_NO_OOB;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2602  	chip->ecc.mode = NAND_ECC_HW;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2603
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2604  	chip->options |= NAND_NO_SUBPAGE_WRITE;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2605
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2606  	cdns_chip->bbm_offs = chip->badblockpos;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2607  	if (chip->options & NAND_BUSWIDTH_16) {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2608  		cdns_chip->bbm_offs &= ~0x01;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2609  		cdns_chip->bbm_len = 2;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2610  	} else {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2611  		cdns_chip->bbm_len = 1;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2612  	}
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2613
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2614  	ret = nand_ecc_choose_conf(chip,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2615  				   &cdns_ctrl->ecc_caps,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2616  				   mtd->oobsize - cdns_chip->bbm_len);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2617  	if (ret) {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2618  		dev_err(cdns_ctrl->dev, "ECC configuration failed\n");
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2619  		goto free_buf;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2620  	}
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2621
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2622  	dev_dbg(cdns_ctrl->dev,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2623  		"chosen ECC settings: step=%d, strength=%d, bytes=%d\n",
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2624  		chip->ecc.size, chip->ecc.strength, chip->ecc.bytes);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2625
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2626  	/* Error correction configuration. */
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2627  	cdns_chip->sector_size = chip->ecc.size;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2628  	cdns_chip->sector_count = mtd->writesize / cdns_chip->sector_size;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2629
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2630  	cdns_chip->avail_oob_size = mtd->oobsize - ecc_size;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2631
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2632  	max_oob_data_size = MAX_OOB_SIZE_PER_SECTOR;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2633
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2634  	if (cdns_chip->avail_oob_size > max_oob_data_size)
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2635  		cdns_chip->avail_oob_size = max_oob_data_size;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2636
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2637  	if ((cdns_chip->avail_oob_size + cdns_chip->bbm_len + ecc_size)
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2638  	    > mtd->oobsize)
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2639  		cdns_chip->avail_oob_size -= 4;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2640
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2641  	cdns_chip->corr_str_idx =
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2642  		cadence_nand_get_ecc_strength_idx(cdns_ctrl,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2643  						  chip->ecc.strength);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18 @2644  	if (cdns_chip->corr_str_idx < 0)
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2645  		return -EINVAL;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2646
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2647  	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2648  					1000000,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2649  					CTRL_STATUS_CTRL_BUSY, true))
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2650  		return -ETIMEDOUT;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2651
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2652  	cadence_nand_set_ecc_strength(cdns_ctrl,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2653  				      cdns_chip->corr_str_idx);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2654
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2655  	cadence_nand_set_erase_detection(cdns_ctrl, true,
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2656  					 chip->ecc.strength);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2657
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2658  	/* Override the default read operations. */
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2659  	chip->ecc.read_page = cadence_nand_read_page;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2660  	chip->ecc.read_page_raw = cadence_nand_read_page_raw;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2661  	chip->ecc.write_page = cadence_nand_write_page;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2662  	chip->ecc.write_page_raw = cadence_nand_write_page_raw;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2663  	chip->ecc.read_oob = cadence_nand_read_oob;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2664  	chip->ecc.write_oob = cadence_nand_write_oob;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2665  	chip->ecc.read_oob_raw = cadence_nand_read_oob_raw;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2666  	chip->ecc.write_oob_raw = cadence_nand_write_oob_raw;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2667
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2668  	if ((mtd->writesize + mtd->oobsize) > cdns_ctrl->buf_size) {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2669  		cdns_ctrl->buf_size = mtd->writesize + mtd->oobsize;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2670  		kfree(cdns_ctrl->buf);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2671  		cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2672  		if (!cdns_ctrl->buf) {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2673  			ret = -ENOMEM;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2674  			goto free_buf;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2675  		}
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2676  	}
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2677
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2678  	/* Is 32-bit DMA supported? */
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2679  	ret = dma_set_mask(cdns_ctrl->dev, DMA_BIT_MASK(32));
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2680  	if (ret) {
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2681  		dev_err(cdns_ctrl->dev, "no usable DMA configuration\n");
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2682  		goto free_buf;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2683  	}
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2684
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2685  	mtd_set_ooblayout(mtd, &cadence_nand_ooblayout_ops);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2686
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2687  	return 0;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2688
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2689  free_buf:
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2690  	kfree(cdns_ctrl->buf);
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2691
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2692  	return ret;
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2693  }
>> 3235ae79d58b8d Piotr Sroka 2019-09-18  2694
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.01.org_pipermail_kbuild-2Dall&d=DwIFaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=TGZtNfZu5Cjhu2K8A0Qhsot4HlKpSJ0Xmyc_L8hPwSI&m=mgwNQ1SA26JWmty5PuDLavsJlIOFJvmPqnwJa6yPWMA&s=8djj9innc5sA2QdJOJ9zWF38QVrWSWiIC6i1JaZv_GE&e=                    Intel Corporation
>

-- 
--
Piotr Sroka
