Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8684C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824EA2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="drfYbCky";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Cw9QLvi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfFYNDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:03:50 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:46698 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729846AbfFYNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:03:50 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PCw7db023869;
        Tue, 25 Jun 2019 06:02:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=proofpoint;
 bh=6/L280bG7WbLlAFBA0tCA+XXFTRNq1fQ85feTolBYYA=;
 b=drfYbCkytdDUujoemcr5LVxad7NAb4J5BxGka6DJypNY/lsVMJ11sgFdh6dFbZLYez+I
 TXKRrBoW+onxgGg/uFRaqSRzJWF5rwzTElgrgu0rMhEDN3HCN74REIK66KqPdFES8oqW
 06rlKZQCBpYIWQLb2B0GVNAGsiHctrhZtg1kdAGlj/WiTu/OZzHfvaCnKyfwPz32rlqn
 8b9/9jJOOnMJGCSz8XvKT54FesMwQpkLqnJujZGQTmv/MnSC6guGRUEpkS2Ex6bjzEkZ
 ElgzF7Ck24Ozu5VspuKkrjtgpLOpLynAc1KlsQFQa1ywbuE1VzjbaMa7kk0+xUsgnI8I Lw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2t9gvscm3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 06:02:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/L280bG7WbLlAFBA0tCA+XXFTRNq1fQ85feTolBYYA=;
 b=Cw9QLvi4J4IZwKTfNO6PfAjtqSPFL34gEe0uo710PIdzmIIhf0UAfKs4eoMbo8zCQQ+mN3ucbNvrCSnHrkMyuY5jrZMugtHguwV5v1sapmqHZPCaTpphfhcVU35tUxjzyYPsanXDFylyYAV0i9yM3/nWMLJKAErhzVLdyTYhHDI=
Received: from CY1PR07CA0017.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::27) by SN2PR07MB2496.namprd07.prod.outlook.com
 (2603:10b6:804:11::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 13:02:52 +0000
Received: from CO1NAM05FT022.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by CY1PR07CA0017.outlook.office365.com
 (2a01:111:e400:c60a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 13:02:52 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT022.mail.protection.outlook.com (10.152.96.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.6 via Frontend Transport; Tue, 25 Jun 2019 13:02:50 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x5PD2hti000451
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 09:02:44 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Jun 2019 06:02:39 -0700
Date:   Tue, 25 Jun 2019 14:02:33 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Paul Burton" <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [v3 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190625130231.GA31865@global.cadence.com>
References: <20190614150638.28383-1-piotrs@cadence.com>
 <20190614150956.31244-1-piotrs@cadence.com>
 <dd96bd1b-e944-e95d-31c9-6dd1d0b5720f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd96bd1b-e944-e95d-31c9-6dd1d0b5720f@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj6.global.cadence.com (158.140.32.112) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(199004)(189003)(36092001)(8936002)(6116002)(81156014)(67846002)(126002)(81166006)(356004)(33656002)(6286002)(3846002)(4326008)(68736007)(6246003)(86362001)(26826003)(53936002)(55016002)(76130400001)(476003)(8676002)(70586007)(1411001)(5660300002)(58126008)(478600001)(2870700001)(54906003)(336012)(1076003)(26005)(16526019)(229853002)(7416002)(70206006)(316002)(6666004)(69596002)(186003)(53416004)(2486003)(47776003)(7696005)(23676004)(66066001)(2906002)(305945005)(956004)(50466002)(386003)(14444005)(6916009)(7736002)(446003)(426003)(11346002)(486006)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2496;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cf982eb-e2a7-42e5-95d3-08d6f96d6deb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN2PR07MB2496;
X-MS-TrafficTypeDiagnostic: SN2PR07MB2496:
X-Microsoft-Antispam-PRVS: <SN2PR07MB24967DB816663F52C418C181DDE30@SN2PR07MB2496.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1zX0Px24ccs2Z41Hnv8wZfa5QYv1WDtlMG9NX70MHWSmodfI57yEQUglBn3C2egt7FEDSA67qvTyTgFwjDgF4IXIaxeQf12LwKICEIZlao+hNtjyO+HveoiDWfF6bI6GlWlvqWEztuurz5WqrGl8MDKmsD0IIFL92uku01Tm4RdulUb47oPRA/9qtsbPsAOccaiKTvv3i+0madqptwEx6vLd5BQZzGLtAjisPVJ1X5g+B6ahdDnjXnQwZG9FZZ5rK11ioewPDObzRI1DdIS8+4RWdog0PI9prLKbvKdYuFup4pZHa+h/6H2+fltNa7Z+76h9k3sDxk6II9xvMmNObYYHbfHAmErdROnvvMB4g+dR7vteddfvNVTpqWfMfKHyIiV5B7Kxe4B8/uKfCAG4lYmlsQkuRk0k2BywZJSweX8=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 13:02:50.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf982eb-e2a7-42e5-95d3-08d6f96d6deb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2496
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

The 06/16/2019 16:42, Dmitry Osipenko wrote:
>EXTERNAL MAIL
>
>
>14.06.2019 18:09, Piotr Sroka пишет:
>
>Commit description is mandatory.
>
>> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>> ---
>
>[snip]
>
>> +
>> +/* Cadnence NAND flash controller capabilities get from driver data. */
>> +struct cadence_nand_dt_devdata {
>> +	/* Skew value of the output signals of the NAND Flash interface. */
>> +	u32 if_skew;
>> +	/* It informs if aging feature in the DLL PHY supported. */
>> +	u8 phy_dll_aging;
>> +	/*
>> +	 * It informs if per bit deskew for read and write path in
>> +	 * the PHY is supported.
>> +	 */
>> +	u8 phy_per_bit_deskew;
>> +	/* It informs if slave DMA interface is connected to DMA engine. */
>> +	u8 has_dma;
>
>There is no needed to dedicate 8 bits to a variable if you only care about a single
>bit. You may write this as:
>
>bool has_dma : 1;
I modified it locally but it looks that checkpatch does not like such
notation
"WARNING: Avoid using bool as bitfield.  Prefer bool bitfields as
unsigned int or u<8|16|32>"
So maybe I will leave it as is.

>[snip]
>
>> +static struct
>> +cdns_nand_chip *to_cdns_nand_chip(struct nand_chip *chip)
>> +{
>> +	return container_of(chip, struct cdns_nand_chip, chip);
>> +}
>> +
>> +static struct
>> +cdns_nand_ctrl *to_cdns_nand_ctrl(struct nand_controller *controller)
>> +{
>> +	return container_of(controller, struct cdns_nand_ctrl, controller);
>> +}
>
>It's better to inline explicitly such cases because they won't get inlined with some
>kernel configurations, like enabled ftracing for example.
>
>> +static bool
>> +cadence_nand_dma_buf_ok(struct cdns_nand_ctrl *cdns_ctrl, const void *buf,
>> +			u32 buf_len)
>> +{
>> +	u8 data_dma_width = cdns_ctrl->caps2.data_dma_width;
>> +
>> +	return buf && virt_addr_valid(buf) &&
>> +		likely(IS_ALIGNED((uintptr_t)buf, data_dma_width)) &&
>> +		likely(IS_ALIGNED(buf_len, data_dma_width));
>> +}
>> +
>> +static int cadence_nand_wait_for_value(struct cdns_nand_ctrl *cdns_ctrl,
>> +				       u32 reg_offset, u32 timeout_us,
>> +				       u32 mask, bool is_clear)
>> +{
>> +	u32 val;
>> +	int ret = 0;
>> +
>> +	ret = readl_poll_timeout(cdns_ctrl->reg + reg_offset,
>> +				 val, !(val & mask) == is_clear,
>> +				 10, timeout_us);
>
>Apparently you don't care about having memory barrier here, hence
>readl_relaxed_poll_timeout().
ok I will update it.
>
>> +	if (ret < 0) {
>> +		dev_err(cdns_ctrl->dev,
>> +			"Timeout while waiting for reg %x with mask %x is clear %d\n",
>> +			reg_offset, mask, is_clear);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int cadence_nand_set_ecc_enable(struct cdns_nand_ctrl *cdns_ctrl,
>> +				       bool enable)
>> +{
>> +	u32 reg;
>> +
>> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
>> +					1000000,
>> +					CTRL_STATUS_CTRL_BUSY, true))
>> +		return -ETIMEDOUT;
>> +
>> +	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
>> +
>> +	if (enable)
>> +		reg |= ECC_CONFIG_0_ECC_EN;
>> +	else
>> +		reg &= ~ECC_CONFIG_0_ECC_EN;
>> +
>> +	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);
>
>And here.. looks like there is no need for the memory barries, hence use the relaxed
>versions of readl/writel. Same for the rest of the patch.
>
ok
>> +	return 0;
>> +}
>> +
>> +static void cadence_nand_set_ecc_strength(struct cdns_nand_ctrl *cdns_ctrl,
>> +					  u8 corr_str_idx)
>> +{
>> +	u32 reg;
>> +
>> +	if (cdns_ctrl->curr_corr_str_idx == corr_str_idx)
>> +		return;
>> +
>> +	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
>> +	reg &= ~ECC_CONFIG_0_CORR_STR;
>> +	reg |= FIELD_PREP(ECC_CONFIG_0_CORR_STR, corr_str_idx);
>> +	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);
>> +
>> +	cdns_ctrl->curr_corr_str_idx = corr_str_idx;
>> +}
>> +
>> +static u8 cadence_nand_get_ecc_strength_idx(struct cdns_nand_ctrl *cdns_ctrl,
>> +					    u8 strength)
>> +{
>> +	u8 i, corr_str_idx = 0;
>> +
>> +	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
>> +		if (cdns_ctrl->ecc_strengths[i] == strength) {
>> +			corr_str_idx = i;
>> +			break;
>> +		}
>> +	}
>
>Is it a error case when i == BCH_MAX_NUM_CORR_CAPS?
Yes it is an error but it could appear only if ECC capability registers
have wrong values. I will handle that error anyway.

>> +	return corr_str_idx;
>> +}
>> +
>> +static int cadence_nand_set_skip_marker_val(struct cdns_nand_ctrl *cdns_ctrl,
>> +					    u16 marker_value)
>> +{
>> +	u32 reg = 0;
>> +
>> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
>> +					1000000,
>> +					CTRL_STATUS_CTRL_BUSY, true))
>> +		return -ETIMEDOUT;
>> +
>> +	reg = readl(cdns_ctrl->reg + SKIP_BYTES_CONF);
>> +	reg &= ~SKIP_BYTES_MARKER_VALUE;
>> +	reg |= FIELD_PREP(SKIP_BYTES_MARKER_VALUE,
>> +		    marker_value);
>> +
>> +	writel(reg, cdns_ctrl->reg + SKIP_BYTES_CONF);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cadence_nand_set_skip_bytes_conf(struct cdns_nand_ctrl *cdns_ctrl,
>> +					    u8 num_of_bytes,
>> +					    u32 offset_value,
>> +					    int enable)
>> +{
>> +	u32 reg = 0;
>> +	u32 skip_bytes_offset = 0;
>
>Please don't initialize variables if not necessary. You could also write this in a
>single line.
>
>	u32 skip_bytes_offset, reg;
>
>Same for the rest of the patch.
>
Ok to I will change it.
>> +	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
>> +					1000000,
>> +					CTRL_STATUS_CTRL_BUSY, true))
>> +		return -ETIMEDOUT;
>> +
>> +	if (!enable) {
>> +		num_of_bytes = 0;
>> +		offset_value = 0;
>> +	}
>> +
>> +	reg = readl(cdns_ctrl->reg + SKIP_BYTES_CONF);
>> +	reg &= ~SKIP_BYTES_NUM_OF_BYTES;
>> +	reg |= FIELD_PREP(SKIP_BYTES_NUM_OF_BYTES,
>> +		    num_of_bytes);
>> +	skip_bytes_offset = FIELD_PREP(SKIP_BYTES_OFFSET_VALUE,
>> +				       offset_value);
>> +
>> +	writel(reg, cdns_ctrl->reg + SKIP_BYTES_CONF);
>> +	writel(skip_bytes_offset, cdns_ctrl->reg + SKIP_BYTES_OFFSET);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Fucntions enables/disables hardware detection of erased data */
>
>s/Fucntions/Function/, please use spellchecker. I'd also recommend to start all
>single-line comments with a lower case (and without a dot in the end) because it is a
>more common style in the kernel and is a bit easier for the eyes.
Ok  I will do it. 
>
>[snip]
  
Thanks
Piotr Sroka
