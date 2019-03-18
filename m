Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0660C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CD020811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fsmFguGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfCRMsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:48:39 -0400
Received: from mail-eopbgr760079.outbound.protection.outlook.com ([40.107.76.79]:20814
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbfCRMsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGkuQqwoJSdFFfL5XYN9sHkoGVOv0PoaTZ6BXL4mSI0=;
 b=fsmFguGV2ql1pXvkB/yVlYiAbGUTg5owfCSWvjJn5YXwVMvk6ngXzOFFVlmG33/qDpqjTpO6jPsdfHuU5iUZAeeND+DxIOlchzRocmGUgXoB/5p6kyrPAQRWfN8F4ASoAqV5yQOjy+kPbk/LQ/wCsawfheFiQNb5EuNOAH+61XY=
Received: from CY4PR02CA0005.namprd02.prod.outlook.com (10.169.188.15) by
 BYAPR02MB4054.namprd02.prod.outlook.com (20.176.248.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 12:48:34 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by CY4PR02CA0005.outlook.office365.com
 (2603:10b6:903:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:48:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:48:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49661 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5rgu-0005Cm-KM; Mon, 18 Mar 2019 05:48:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5rgp-0005Ft-Gb; Mon, 18 Mar 2019 05:48:27 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICmLms019092;
        Mon, 18 Mar 2019 05:48:21 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h5rgi-0005DH-M8; Mon, 18 Mar 2019 05:48:21 -0700
Subject: Re: [PATCH] drivers: clk: Update clock driver to handle clock
 attribute
To:     Jolly Shah <jolly.shah@xilinx.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1551741550-10315-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f09ba7a2-6379-cebe-e803-b7b67686fa6e@xilinx.com>
Date:   Mon, 18 Mar 2019 13:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551741550-10315-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(189003)(199004)(65956001)(47776003)(65806001)(106466001)(31696002)(6246003)(2201001)(107886003)(2616005)(11346002)(126002)(476003)(446003)(486006)(8676002)(5660300002)(106002)(186003)(305945005)(230700001)(478600001)(336012)(426003)(50466002)(31686004)(81166006)(63266004)(229853002)(44832011)(81156014)(36756003)(64126003)(26005)(65826007)(77096007)(23676004)(2486003)(8936002)(110136005)(356004)(76176011)(6666004)(4326008)(2906002)(58126008)(54906003)(9786002)(36386004)(316002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4054;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96ceec8c-99e0-4c31-ce26-08d6aba007d9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR02MB4054;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4054:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4054FB089F8E03EE11FBDAD3C6470@BYAPR02MB4054.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hQXZY6B96mHvw3PbqJ5iqWNE5VLjmOD8gHIM9Elq1xlN3bN9/0ZSyRYADY/W3Ln87aFmyMzZlYP62vjiHogSdp/2mE6uA1Y/A7u9wX0sOSsYfoVs3/9wfPF9Pu1/zthIv1vFZmCV2eSkRGMYi/WnOYlLoOLe01uKSxMkHvwvexR7Of2RmTtuxsCv1hxDdWjWTiL9QsD5p0O2dflz1PoSjNtOsobV9FlrvvbIX3BarMC15w0z27+s/uIuUQ/mN4uMG1aLsD0O2bnpeDlDdgHlfzGOeoIX0T5uf90pBFbjiAySsTj6MVtvwsIB6VrPQA8g91xtSgpKfzG40F7+xXXrcwaFq+cRA9cLp6gJI6B98OUpDZW0aM9bGEiyuuqDPEAh7ESrTkLYrzFBj0HwyTNIJ/GKE9Iqk80OOdlHRDjOgfY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:48:33.1923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ceec8c-99e0-4c31-ce26-08d6aba007d9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 03. 19 0:19, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Versal EEMI APIs uses clock device ID which is combination of class,
> subclass, type and clock index (e.g. 0x8104006 in which 0-13 bits are
> for index(6 in given example), 14-19 bits are for clock type (i.e pll,
> out or ref, 1 in given example), 20-25 bits are for subclass which is
> nothing but clock type only), 26-32 bits are for device class, which
> is clock(0x2) for all clocks) while zynqmp firmware uses clock ID
> which is index only (e.g 0, 1, to n, where n is max_clock id).
> 
> To use zynqmp clock driver for versal platform also, extend use
> of QueryAttribute API to fetch device class, subclass and clock type
> to create clock device ID. In case of zynqmp this attributes would be
> 0 only, so there won't be any effect on clock id as it would use
> clock index only.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/clk/zynqmp/clkc.c | 42 +++++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index f65cc0f..c13b014 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -53,6 +53,10 @@
>  #define RESERVED_CLK_NAME		""
>  
>  #define CLK_VALID_MASK			0x1
> +#define NODE_CLASS_SHIFT		26U
> +#define NODE_SUBCLASS_SHIFT		20U
> +#define NODE_TYPE_SHIFT			14U
> +#define NODE_INDEX_SHIFT		0U
>  
>  enum clk_type {
>  	CLK_TYPE_OUTPUT,
> @@ -80,6 +84,7 @@ struct clock_parent {
>   * @num_nodes:		Number of nodes present in topology
>   * @parent:		Parent of clock
>   * @num_parents:	Number of parents of clock
> + * @clk_id:		Clock id
>   */
>  struct zynqmp_clock {
>  	char clk_name[MAX_NAME_LEN];
> @@ -89,6 +94,7 @@ struct zynqmp_clock {
>  	u32 num_nodes;
>  	struct clock_parent parent[MAX_PARENT];
>  	u32 num_parents;
> +	u32 clk_id;
>  };
>  
>  static const char clk_type_postfix[][10] = {
> @@ -396,7 +402,8 @@ static int zynqmp_clock_get_topology(u32 clk_id,
>  
>  	*num_nodes = 0;
>  	for (j = 0; j <= MAX_NODES; j += 3) {
> -		ret = zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
> +		ret = zynqmp_pm_clock_get_topology(clock[clk_id].clk_id, j,
> +						   pm_resp);
>  		if (ret)
>  			return ret;
>  		ret = __zynqmp_clock_get_topology(topology, pm_resp, num_nodes);
> @@ -459,7 +466,8 @@ static int zynqmp_clock_get_parents(u32 clk_id, struct clock_parent *parents,
>  	*num_parents = 0;
>  	do {
>  		/* Get parents from firmware */
> -		ret = zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
> +		ret = zynqmp_pm_clock_get_parents(clock[clk_id].clk_id, j,
> +						  pm_resp);
>  		if (ret)
>  			return ret;
>  
> @@ -528,13 +536,14 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
>  						   const char **parent_names)
>  {
>  	int j;
> -	u32 num_nodes;
> +	u32 num_nodes, clk_dev_id;
>  	char *clk_out = NULL;
>  	struct clock_topology *nodes;
>  	struct clk_hw *hw = NULL;
>  
>  	nodes = clock[clk_id].node;
>  	num_nodes = clock[clk_id].num_nodes;
> +	clk_dev_id = clock[clk_id].clk_id;
>  
>  	for (j = 0; j < num_nodes; j++) {
>  		/*
> @@ -551,13 +560,14 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
>  		if (!clk_topology[nodes[j].type])
>  			continue;
>  
> -		hw = (*clk_topology[nodes[j].type])(clk_out, clk_id,
> +		hw = (*clk_topology[nodes[j].type])(clk_out, clk_dev_id,
>  						    parent_names,
>  						    num_parents,
>  						    &nodes[j]);
>  		if (IS_ERR(hw))
> -			pr_warn_once("%s() %s register fail with %ld\n",
> -				     __func__, clk_name, PTR_ERR(hw));
> +			pr_warn_once("%s() 0x%x: %s register fail with %ld\n",
> +				     __func__,  clk_dev_id, clk_name,
> +				     PTR_ERR(hw));
>  
>  		parent_names[0] = clk_out;
>  	}
> @@ -621,20 +631,26 @@ static int zynqmp_register_clocks(struct device_node *np)
>  static void zynqmp_get_clock_info(void)
>  {
>  	int i, ret;
> -	u32 attr, type = 0;
> +	u32 attr, type = 0, nodetype, subclass, class;
>  
>  	for (i = 0; i < clock_max_idx; i++) {
> -		zynqmp_pm_clock_get_name(i, clock[i].clk_name);
> -		if (!strcmp(clock[i].clk_name, RESERVED_CLK_NAME))
> -			continue;
> -
>  		ret = zynqmp_pm_clock_get_attributes(i, &attr);
>  		if (ret)
>  			continue;
>  
>  		clock[i].valid = attr & CLK_VALID_MASK;
> -		clock[i].type = attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
> -							CLK_TYPE_OUTPUT;
> +		clock[i].type = ((attr >> CLK_TYPE_SHIFT) & 0x1) ?
> +				CLK_TYPE_EXTERNAL : CLK_TYPE_OUTPUT;
> +		nodetype = (attr >> NODE_TYPE_SHIFT) & 0x3F;
> +		subclass = (attr >> NODE_SUBCLASS_SHIFT) & 0x3F;
> +		class = (attr >> NODE_CLASS_SHIFT) & 0x3F;
> +
> +		clock[i].clk_id = (class << NODE_CLASS_SHIFT) |
> +				  (subclass << NODE_SUBCLASS_SHIFT) |
> +				  (nodetype << NODE_TYPE_SHIFT) |
> +				  (i << NODE_INDEX_SHIFT);
> +
> +		zynqmp_pm_clock_get_name(clock[i].clk_id, clock[i].clk_name);
>  	}
>  
>  	/* Get topology of all clock */
> 

Stephen: Do you want to take this via your tree?

Thanks,
Michal

