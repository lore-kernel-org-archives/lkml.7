Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A3C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCC020645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="rjb5AnI1";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qQL+R7Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfFFQFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:05:37 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37686 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729595AbfFFQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:05:35 -0400
X-Greylist: delayed 2661 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 12:05:34 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56FBUQW032060;
        Thu, 6 Jun 2019 08:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=xazkZUmcURrxWnY0Wsk9msgx5a/Ca0tNrgM26icNgaI=;
 b=rjb5AnI1n2ez43lb/MZ437L9coio6V5I4KQM6eoU/Q48+fo3UoCJAVjQ3ahwqLJrxQhh
 EzTTFMkVDn9SS/XrM1ZCfN99HDWvOYQejwteJxOfKU6AFZ9FudLBNcQpWs5xuMJp5hkQ
 /s8Z3UNsxtUnWKqGCwyqhkDtCsCyz6WVVB4HQEtXLtALDu8IvnwuJPEHQFEpkmZ7dvoc
 DttuVFABnDHmqCpy8UNjFiHpLhijFusmcVYNAl3gpDFYzeUHbWb3tZANVZAi2oKcaSCo
 fYusA+xM8nYZx/7gHO7+ZNQHtRpvHD5DbzyRgiNhb89Vlz1YkTuzU5qq3I6RIZJa/BAf ig== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2052.outbound.protection.outlook.com [104.47.32.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2sxp9ukkfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 08:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xazkZUmcURrxWnY0Wsk9msgx5a/Ca0tNrgM26icNgaI=;
 b=qQL+R7XolhSUpTggu/JjAqnaCWlakn878eyiT3ZTL/qL1KTGX0KDO0IUcdji19f5H2IeVGic5M/zzVYzxNnIQZjyPaJShaqT0GgekGMJA0ng6NeEqfn0zH7+2VWnCbtBmOEICKFjr3Ze/Gx2Mq02SgSSfdOl8CMzZaN+i6H1CAc=
Received: from DM5PR07CA0078.namprd07.prod.outlook.com (2603:10b6:4:ad::43) by
 MN2PR07MB6830.namprd07.prod.outlook.com (2603:10b6:208:11d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Thu, 6 Jun
 2019 15:20:13 +0000
Received: from CO1NAM05FT061.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by DM5PR07CA0078.outlook.office365.com
 (2603:10b6:4:ad::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Thu, 6 Jun 2019 15:20:12 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT061.mail.protection.outlook.com (10.152.96.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1987.5 via Frontend Transport; Thu, 6 Jun 2019 15:20:10 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x56FK20W010169
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Jun 2019 11:20:04 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 08:19:58 -0700
Date:   Thu, 6 Jun 2019 16:19:51 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190606151948.GA10565@global.cadence.com>
References: <20190219161406.4340-1-piotrs@cadence.com>
 <20190219161823.22466-1-piotrs@cadence.com>
 <20190305190954.6c38d681@xps13>
 <20190321093356.GA19577@global.cadence.com>
 <20190512142426.11453a6c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190512142426.11453a6c@xps13>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39840400004)(136003)(2980300002)(189003)(199004)(36092001)(426003)(486006)(336012)(47776003)(26005)(8936002)(5660300002)(76130400001)(50466002)(126002)(476003)(956004)(186003)(11346002)(446003)(16526019)(1076003)(66574012)(14444005)(5024004)(7416002)(30864003)(70586007)(70206006)(7736002)(305945005)(53936002)(66066001)(55016002)(229853002)(7696005)(33656002)(23676004)(6286002)(6116002)(69596002)(356004)(53416004)(2486003)(2870700001)(76176011)(386003)(86362001)(6666004)(2906002)(58126008)(8676002)(3846002)(4326008)(54906003)(6916009)(81156014)(81166006)(6246003)(67846002)(478600001)(26826003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6830;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8fa1742-e31e-49b3-6436-08d6ea9277b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR07MB6830;
X-MS-TrafficTypeDiagnostic: MN2PR07MB6830:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6830607AF057B04183F09DBBDD170@MN2PR07MB6830.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /CZk3nLJdjOrJa0skarX2tYHMFDJGquWpwwzOiPIqqi3BnV1sUKktQn+rWzx3LjKVuMH2enVYU206l5VclNz2u93d0vStpH7TI+JhRm5ymG4GCDKrt4M1dhOkBylZKYjH4av1cQW+wcIAKawavIUNmwpG30LIq7mGV5VmNv7X4kpdG/cRBALzKQpIb5jdr4IdKKqSHMgG4DLM0U4Ehq+k0aeDu8LeLCIAyoroXsOTUYw42h9dmPHpjBsa0Qh6v4tVUPPBbbMEEHHm3cXWnJw8tUnOsgQNs/xEp11nXrVmLLGxqxIbDq4vu32DdqJGb1TvbgvpIvjmDUMMUHGkv2J/i55KH9DgdPIs63nbsZEOVsAPtb4bz12TRBJjzh1+pZGISCC8zRziCrc8+fLHlr/NwKUpUfPy86gYsPCogF3mU4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 15:20:10.8699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fa1742-e31e-49b3-6436-08d6ea9277b3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6830
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel


The 05/12/2019 14:24, Miquel Raynal wrote:
>EXTERNAL MAIL
>
>
>EXTERNAL MAIL
>
>
>Hi Piotr,
>
>Sorry for de delay.
>
>Piotr Sroka <piotrs@cadence.com> wrote on Thu, 21 Mar 2019 09:33:58
>+0000:
>
>> The 03/05/2019 19:09, Miquel Raynal wrote:
>> >EXTERNAL MAIL
>> >
>> >
>> >Hi Piotr,
>> >
>> >Piotr Sroka <piotrs@cadence.com> wrote on Tue, 19 Feb 2019 16:18:23
>> >+0000:
>> >
>> >> This patch adds driver for Cadence HPNFC NAND controller.
>> >>
>> >> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>> >> ---
>> >> Changes for v2:
>> >> - create one universal wait function for all events instead of one
>> >>   function per event.
>> >> - split one big function executing nand operations to separate
>> >>   functions one per each type of operation.
>> >> - add erase atomic operation to nand operation parser
>> >> - remove unnecessary includes.
>> >> - remove unused register defines
>> >> - add support for multiple nand chips
>> >> - remove all code using legacy functions
>> >> - remove chip dependents parameters from dts bindings, they were
>> >>   attached to the SoC specific compatible at the driver level
>> >> - simplify interrupt handling
>> >> - simplify timing calculations
>> >> - fix calculation of maximum supported cs signals
>> >> - simplify ecc size calculation
>> >> - remove header file and put whole code to one c file
>> >> ---
>> >>  drivers/mtd/nand/raw/Kconfig                   |    8 +
>> >>  drivers/mtd/nand/raw/Makefile                  |    1 +
>> >>  drivers/mtd/nand/raw/cadence-nand-controller.c | 3288 ++++++++++++++++++++++++
>> >
>> >This driver is way too massive, I am pretty sure it can shrink a
>> >little bit more.
>> >[...]
>> >
>> I will try to make it shorer but it will be difucult to achive. It is because - there are a lot of calculation needed for PHY      - ECC are interleaved with data (like on marvell-nand or gpmi-nand).
>>    Therefore:    + RAW mode is complicated    + protecting BBM increases number of lines of source code
>> - need to support two DMA engines internal and external (slave) We will see on next patch version what is the result.      That page layout looks:
>
>Maybe you don't need to support both internal and external DMA?
>
>I am pretty sure there are rooms for size reduction.

I describe how it works in general and maybe you help me chose better solution.

HW controller can work in 3 modes. 
PIO - can work in master or slave DMA
CDMA - needs Master DMA for accessing command descriptors.
Generic mode - can use only Slave DMA.

Generic mode is neccessery to implement functions other than page
program, page read, block erase. So it is essential. I cannot avoid
to use Slave DMA.

I change CDMA mode to PIO mode. Then I can use only slave DMA. 
But CDMA has a feature which is not present in PIO mode. The feature
gives possibility to point DMA engine two buffers to transfer. It is
used to point data buffer and oob bufer. In PIO mode I would need to
copy data buffer and oob buffer to third buffer. Next transfer data from
third buffer.
In that solution we need to copy all data by CPU and then use DMA.  
Controller needs always transfer oob because of HW ECC restrictions. 
Such change will decrease performce for all data transfers.
I think performance is more important in that case. What is your
opinion? 

[...]
>> >
>> >What is this for?
>> Fucntions enables/disables hardware detection of erased data
>> pages. >
>
>Ok, the name is not very explicit , maybe you could tell this with a
>comment.
>
Ok.

>> >> +
>> >> +/* hardware initialization */
>> >> +static int cadence_nand_hw_init(struct cdns_nand_ctrl *cdns_ctrl)
>> >> +{
>> >> +	int status = 0;
>> >> +	u32 reg;
>> >> +
>> >> +	status = cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
>> >> +					     1000000,
>> >> +					     CTRL_STATUS_INIT_COMP, false);
>> >> +	if (status)
>> >> +		return status;
>> >> +
>> >> +	reg = readl(cdns_ctrl->reg + CTRL_VERSION);
>> >> +
>> >> +	dev_info(cdns_ctrl->dev,
>> >> +		 "%s: cadence nand controller version reg %x\n",
>> >> +		 __func__, reg);
>> >> +
>> >> +	/* disable cache and multiplane */
>> >> +	writel(0, cdns_ctrl->reg + MULTIPLANE_CFG);
>> >> +	writel(0, cdns_ctrl->reg + CACHE_CFG);
>> >> +
>> >> +	/* clear all interrupts */
>> >> +	writel(0xFFFFFFFF, cdns_ctrl->reg + INTR_STATUS);
>> >> +
>> >> +	cadence_nand_get_caps(cdns_ctrl);
>> >> +	cadence_nand_read_bch_cfg(cdns_ctrl);
>> >
>> >No, you cannot rely on the bootloader's configuration. And I suppose
>> >this is what the first call to read_bch_cfg does?
>> I do not realy on boot loader. Just read NAND flash
>> controller configuration from read only capabilities registers.
>
>Ok, if these are RO registers, it's fine. But maybe don't call the
>function "read bch config" which suggest that this is something you can
>change.
>
ok.

>>
>>
>> >> +
>> >> +#define TT_OOB_AREA		1
>> >> +#define TT_MAIN_OOB_AREAS	2
>> >> +#define TT_RAW_PAGE		3
>> >> +#define TT_BBM			4
>> >> +#define TT_MAIN_OOB_AREA_EXT	5
>> >> +
>> >> +/* prepare size of data to transfer */
>> >> +static int
>> >> +cadence_nand_prepare_data_size(struct nand_chip *chip,
>> >> +			       int transfer_type)
>> >> +{
>> >> +	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
>> >> +	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
>> >> +	u32 sec_size = 0, last_sec_size, offset = 0, sec_cnt = 1;
>> >> +	u32 ecc_size = chip->ecc.bytes;
>> >> +	u32 data_ctrl_size = 0;
>> >> +	u32 reg = 0;
>> >> +
>> >> +	if (cdns_ctrl->curr_trans_type == transfer_type)
>> >> +		return 0;
>> >> +
>> >> +	switch (transfer_type) {
>> >
>> >Please turn the controller driver as dumb as possible. You should not
>> >care which part of the OOB area you are accessing.
>> It is a bit confusing for me how accessing OOB should be implemented.
>> I know that read_oob function is called to check BBM value when BBT is
>> initialized. It is also a bit confusing for me why the raw version is
>> not used for that purpose.    In current implementation if you write oob by write_page function next
>> read oob by read_oob function then data will be the same.
>> If I implement dump functions read_oob and write_oob then
>> 1. ECC must be disabled for these functions
>> 2. oob data accessing by write_page/read_page will be different
>>    (different offsets) that the data accessing by read_oob/write_oob
>>    functions
>
>No, I fear this is not acceptable.
>
>> If  above described "functionalities" are acceptable I will change implementation of write_oob and read_oob functions.
>> The write_page and read_page must be implemented in that way as it is now.    Let me know which solution is preffered.
>
>If this is too complicated to just write the oob, why not fallback on
>read/write_page (with oob_required and a dummy data buffer)?

I considered it. Actually, it would simplify the code. The disadvantage
of using the same function is that the each write/read oob will cause full page
read/write. In current version only last sector is read/write together
with oob. 
This will affect the performance degradation of oob write/read function. 
So I do not know what is more important. 1. OOB functions performance,
2. simplier code. 

>>
>> >> +	case TT_OOB_AREA:
>> >> +		offset = cdns_chip->main_size - cdns_chip->sector_size;
>> >> +		ecc_size = ecc_size * (offset / cdns_chip->sector_size);
>> >> +		offset = offset + ecc_size;
>> >> +		sec_cnt = 1;
>> >> +		last_sec_size = cdns_chip->sector_size
>> >> +			+ cdns_chip->avail_oob_size;
>> >> +		break;
>> >> +	case TT_MAIN_OOB_AREA_EXT:
>> >> +		sec_cnt = cdns_chip->sector_count;
>> >> +		last_sec_size = cdns_chip->sector_size;
>> >> +		sec_size = cdns_chip->sector_size;
>> >> +		data_ctrl_size = cdns_chip->avail_oob_size;
>> >> +		break;
>> >> +	case TT_MAIN_OOB_AREAS:
>> >> +		sec_cnt = cdns_chip->sector_count;
>> >> +		last_sec_size = cdns_chip->sector_size
>> >> +			+ cdns_chip->avail_oob_size;
>> >> +		sec_size = cdns_chip->sector_size;
>> >> +		break;
>> >> +	case TT_RAW_PAGE:
>> >> +		last_sec_size = cdns_chip->main_size + cdns_chip->oob_size;
>> >> +		break;
>> >> +	case TT_BBM:
>> >> +		offset = cdns_chip->main_size + cdns_chip->bbm_offs;
>> >> +		last_sec_size = 8;
>> >> +		break;
>> >> +	default:
>> >> +		dev_err(cdns_ctrl->dev, "Data size preparation failed\n");
>> >> +		return -EINVAL;
>> >> +	}
>> >> +
>> >> +	reg = 0;
>> >> +	reg |= FIELD_PREP(TRAN_CFG_0_OFFSET, offset);
>> >> +	reg |= FIELD_PREP(TRAN_CFG_0_SEC_CNT, sec_cnt);
>> >> +	writel(reg, cdns_ctrl->reg + TRAN_CFG_0);
>> >> +
>> >> +	reg = 0;
>> >> +	reg |= FIELD_PREP(TRAN_CFG_1_LAST_SEC_SIZE, last_sec_size);
>> >> +	reg |= FIELD_PREP(TRAN_CFG_1_SECTOR_SIZE, sec_size);
>> >> +	writel(reg, cdns_ctrl->reg + TRAN_CFG_1);
>> >> +
>> >> +	reg = readl(cdns_ctrl->reg + CONTROL_DATA_CTRL);
>> >> +	reg &= ~CONTROL_DATA_CTRL_SIZE;
>> >> +	reg |= FIELD_PREP(CONTROL_DATA_CTRL_SIZE, data_ctrl_size);
>> >> +	writel(reg, cdns_ctrl->reg + CONTROL_DATA_CTRL);
>> >> +
>> >> +	cdns_ctrl->curr_trans_type = transfer_type;
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
[...] 
>> >> +
>> [...] >> +	/*
>> >> +	 * the idea of those calculation is to get the optimum value
>> >> +	 * for tRP and tRH timings if it is NOT possible to sample data
>> >> +	 * with optimal tRP/tRH settings the parameters will be extended
>> >> +	 */
>> >> +	if (sdr->tRC_min <= clk_period &&
>> >> +	    sdr->tRP_min <= (clk_period / 2) &&
>> >> +	    sdr->tREH_min <= (clk_period / 2)) {
>> >
>> >Will this situation really happen?
>> I think yes for follwing values trc_min  20000 ps
>> trp_min  10000 ps
>> treh_min 7000  ps
>> clk_period 20000 ps
>
>Ok, you may add a comment stating that this may be the case in EDO mode
>5.
I did not anwer clearly last time. It was just an example. 
The result of that "if" depends on NAND flash device timing mode and NAND 
flash controller clock. Minumum value of clk is 20MHz (50ns). 
So it may be a case for Asynchronous Mode 1 if
NAND flash controller clock is 20MHz. I will add this info in comment.
>> [...]
>> >> +	}
>> >> +
>> >> +	if (cdns_ctrl->caps2.is_phy_type_dll) {
>> >
>> >Is the else part allowed?
Register accessed in this block does not exists if is_phy_type_dll is 0. 
So they are preveted to be accessed. the else is not needed.
>> >
>> following register does not exist if caps2.is_phy_type_dll is 0 >> +		u32 tpre_cnt = calc_cycl(tpre, clk_period);
>> >> +		u32 tcdqss_cnt = calc_cycl(tcdqss + if_skew, clk_period);
>> >> +		u32 tpsth_cnt = calc_cycl(tpsth + if_skew, clk_period);
>> >> +
>> >> +		u32 trpst_cnt = calc_cycl(trpst + if_skew, clk_period) + 1;
>> >> +		u32 twpst_cnt = calc_cycl(twpst + if_skew, clk_period) + 1;
>> >> +		u32 tcres_cnt = calc_cycl(tcres + if_skew, clk_period) + 1;
>> >> +		u32 tcdqsh_cnt = calc_cycl(tcdqsh + if_skew, clk_period) + 5;
>> >> +
>> >> +		tcr_cnt = calc_cycl(tcr + if_skew, clk_period);
>> >> +		/*
>> >> +		 * skew not included because this timing defines duration of
>> >> +		 * RE or DQS before data transfer
>> >> +		 */
>> >> +		tpsth_cnt = tpsth_cnt + 1;
>> >> +		reg = FIELD_PREP(TOGGLE_TIMINGS0_TPSTH, tpsth_cnt);
>> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCDQSS, tcdqss_cnt);
>> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TPRE, tpre_cnt);
>> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCR, tcr_cnt);
>> >> +		t->toggle_timings_0 = reg;
>> >> +		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_0_SDR\t%x\n", reg);
>> >> +
>> >> +		//toggle_timings_1 - tRPST,tWPST
>> >> +		reg = FIELD_PREP(TOGGLE_TIMINGS1_TCDQSH, tcdqsh_cnt);
>> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TCRES, tcres_cnt);
>> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TRPST, trpst_cnt);
>> >> +		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TWPST, twpst_cnt);
>> >> +		t->toggle_timings_1 = reg;
>> >> +		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_1_SDR\t%x\n", reg);
>> >> +	}
>> [...] >
>> >This function is so complicated !!! How can this even work? Really, it
>> >is hard to get into the code and follow, I am sure you can do
>> >something.
>> Yes it is complicated but works, I will try to simplify it...   [...]
>
>Yes please!
>
>> >> +				"CS %d already assigned\n", cs);
>> >> +			return -EINVAL;
>> >> +		}
>> >> +
>> >> +		cdns_chip->cs[i] = cs;
>> >> +	}
>> >> +
>> >> +	chip = &cdns_chip->chip;
>> >> +	chip->controller = &cdns_ctrl->controller;
>> >> +	nand_set_flash_node(chip, np);
>> >> +
>> >> +	mtd = nand_to_mtd(chip);
>> >> +	mtd->dev.parent = cdns_ctrl->dev;
>> >> +
>> >> +	/*
>> >> +	 * Default to HW ECC engine mode. If the nand-ecc-mode property is given
>> >> +	 * in the DT node, this entry will be overwritten in nand_scan_ident().
>> >> +	 */
>> >> +	chip->ecc.mode = NAND_ECC_HW;
>> >> +
>> >> +	/*
>> >> +	 * Save a reference value for timing registers before
>> >> +	 * ->setup_data_interface() is called.
>> >> +	 */
>> >> +	cadence_nand_get_timings(cdns_ctrl, &cdns_chip->timings);
>> >
>> >You cannot rely on the Bootloader's configuration. This driver should
>> >derive it.
>> I do not relay on the Bootloader's configuration in any part. I just
>> init timings structure base on current values of registers to do not
>>   have rubish in timing structure. Values will be calculated by driver when
>> setup_data_interface is called. In case set_timings is called before
>> setup_data_interface
>
>Does this really happens? I am pretty sure it is taken care of by the
>core. I don't think you should rely on what's in the registers at boot
>time.
Ok I will check it one more time and remove if not needed.

>
>
>> then we write the same valus to timing registers
>> which are preset in registres. To be shorter timing registers will stay
>> unchanged.  >> +	ret = nand_scan(chip, cdns_chip->nsels);
>> >> +	if (ret) {
>> >> +		dev_err(cdns_ctrl->dev, "could not scan the nand chip\n");
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	ret = mtd_device_register(mtd, NULL, 0);
>> >> +	if (ret) {
>> >> +		dev_err(cdns_ctrl->dev,
>> >> +			"failed to register mtd device: %d\n", ret);
>> >> +		nand_release(chip);
>> >
>> >I think you should call nand_cleanup instead of nand_release here has
>> >the mtd device is not registered yet.
ok

>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	list_add_tail(&cdns_chip->node, &cdns_ctrl->chips);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int cadence_nand_chips_init(struct cdns_nand_ctrl *cdns_ctrl)
>> >> +{
>> >> +	struct device_node *np = cdns_ctrl->dev->of_node;
>> >> +	struct device_node *nand_np;
>> >> +	int max_cs = cdns_ctrl->caps2.max_banks;
>> >> +	int nchips;
>> >> +	int ret;
>> >> +
>> >> +	nchips = of_get_child_count(np);
>> >> +
>> >> +	if (nchips > max_cs) {
>> >> +		dev_err(cdns_ctrl->dev,
>> >> +			"too many NAND chips: %d (max = %d CS)\n",
>> >> +			nchips, max_cs);
>> >> +		return -EINVAL;
>> >> +	}
>> >> +
>> >> +	for_each_child_of_node(np, nand_np) {
>> >> +		ret = cadence_nand_chip_init(cdns_ctrl, nand_np);
>> >> +		if (ret) {
>> >> +			of_node_put(nand_np);
>> >> +			return ret;
>> >> +		}
>> >
>> >If nand_chip_init() fails on another chip than the first one, there is
>> >some garbage collection to do.
ok

>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
>> >> +{
>> >> +	dma_cap_mask_t mask;
>> >> +	int ret = 0;
>> >> +
>> >> +	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
>> >> +						  sizeof(*cdns_ctrl->cdma_desc),
>> >> +						  &cdns_ctrl->dma_cdma_desc,
>> >> +						  GFP_KERNEL);
>> >> +	if (!cdns_ctrl->dma_cdma_desc)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	cdns_ctrl->buf_size = 16 * 1024;
>> >
>> >s/1024/SZ_1K/
>> >
>> >> +	cdns_ctrl->buf = kmalloc(cdns_ctrl->buf_size, GFP_KERNEL);
>> >
>> >If you use kmalloc here then this buffer will always be DMA-able,
>> >right?
>> Right I have seen such solution in another driver.
>>
>>
>> Thanks for revieving this patch. Please answer on my question how write_oob
>> and read_oob functions should be implemented.
>>
>> >
>> >
>> >Thanks,
>> >Miquèl
>>
>>   Thanks
>> Piotr Sroka
>
>Thanks,
>Miquèl

Thanks
Piotr
