Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9005320811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fl6WMl23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCRMqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:46:20 -0400
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:30469
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727408AbfCRMqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+zI2yV/9gegfZQUlyNXNOhQoQyF1nnz4aL7Y62J5dY=;
 b=fl6WMl23vl7QIK7AFyc95d96UZK2hylzQn28nRc5CRxVwGr/wj5smk8uZtD1X+zErxMTBIG021P5o/He70mepFgRh0xIFz7LHj4dywd5k8VFLl9W8JymqxDfyWLI1PnPL9Zsn/pqAMpzQgPa2/+iX1+Ddh+YiBDOvz1IVpK+F1g=
Received: from MWHPR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:301:73::32) by BYAPR02MB4055.namprd02.prod.outlook.com
 (2603:10b6:a02:f9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Mon, 18 Mar
 2019 12:46:13 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR0201CA0055.outlook.office365.com
 (2603:10b6:301:73::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:46:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:46:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46946 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5ree-0005BN-4a; Mon, 18 Mar 2019 05:46:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5reZ-0004lL-0h; Mon, 18 Mar 2019 05:46:07 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICk1pA006780;
        Mon, 18 Mar 2019 05:46:01 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h5reT-0004iG-3M; Mon, 18 Mar 2019 05:46:01 -0700
Subject: Re: [PATCH] drivers: Defer probe if firmware is not ready
To:     Jolly Shah <jolly.shah@xilinx.com>, <ard.biesheuvel@linaro.org>,
        <mingo@kernel.org>, <gregkh@linuxfoundation.org>,
        <matt@codeblueprint.co.uk>, <sudeep.holla@arm.com>,
        <hkallweit1@gmail.com>, <keescook@chromium.org>,
        <dmitry.torokhov@gmail.com>, <michal.simek@xilinx.com>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1551741488-10226-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <117a7428-4435-b155-06f1-79deae894a40@xilinx.com>
Date:   Mon, 18 Mar 2019 13:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551741488-10226-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(189003)(199004)(36386004)(107886003)(6246003)(230700001)(65806001)(65956001)(4326008)(5660300002)(47776003)(478600001)(14444005)(5024004)(6666004)(356004)(31696002)(2201001)(81166006)(26005)(77096007)(305945005)(336012)(9786002)(64126003)(8676002)(81156014)(186003)(7416002)(126002)(76176011)(446003)(8936002)(426003)(2486003)(23676004)(44832011)(31686004)(486006)(229853002)(65826007)(106466001)(2906002)(36756003)(106002)(54906003)(110136005)(316002)(476003)(11346002)(63266004)(2616005)(58126008)(50466002)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4055;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 577ff7ae-c0b9-469c-824b-08d6ab9fb42f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR02MB4055;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4055:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB40555544431905D9DBDAD4D7C6470@BYAPR02MB4055.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UoczULpxtz2V9KPXgD+9e/i+WCPxBJtCcH/FfhoMGg6QMR5zMm8gKx3S+b8zzUPT1tSOCMVzV1yBBI30LylovAN8FA82nDJk4kmSRrSvtDg+nJWHMCzv9VdT+8u8xd6571q98n7byiOCEJBPUN3A2u1vd2w5AcZbbJRx4AW4dYp5rAWanW6JTuOHWhzf0kGIirg4yOWEw8EJ+Tic7djFnUD9oyvcW2GAYbIqV1aMEq1QOe9WRexUivfwPiWXSeI7odt4bRprBOgMSFBddxHjVWHrZ9nHG1wxfScl9bI5qipqlog3guU3blRd8Xont3rGmkj7/p5UR6xN/QUMy7mZE0XmWP8CyNBobL8UXr6hoSCiymjmd54i8L6wqBg3fE+gCaZdy5W76x5P2f8X2w14OlR2bwhAFSGyZ4ZtHwLZY54=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:46:12.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577ff7ae-c0b9-469c-824b-08d6ab9fb42f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 03. 19 0:18, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Driver needs ZynqMP firmware interface to call EEMI
> APIs. In case firmware is not ready, dependent drivers
> should wait until the firmware is ready.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  Documentation/xilinx/eemi.txt          |  4 ++--
>  drivers/clk/zynqmp/clkc.c              |  4 ++--
>  drivers/firmware/xilinx/zynqmp-debug.c |  3 ---
>  drivers/firmware/xilinx/zynqmp.c       | 11 ++++++++++-
>  drivers/nvmem/zynqmp_nvmem.c           | 10 +++++++---
>  drivers/reset/reset-zynqmp.c           |  8 ++++----
>  drivers/soc/xilinx/zynqmp_pm_domains.c | 18 ++++++++++--------
>  drivers/soc/xilinx/zynqmp_power.c      | 10 ++++++----
>  drivers/spi/spi-zynqmp-gqspi.c         |  5 +++++
>  include/linux/firmware/xlnx-zynqmp.h   |  2 +-
>  10 files changed, 47 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.txt
> index 0ab686c..5f39b4f 100644
> --- a/Documentation/xilinx/eemi.txt
> +++ b/Documentation/xilinx/eemi.txt
> @@ -41,8 +41,8 @@ Example of EEMI ops usage:
>  	int ret;
>  
>  	eemi_ops = zynqmp_pm_get_eemi_ops();
> -	if (!eemi_ops)
> -		return -ENXIO;
> +	if (IS_ERR(eemi_ops))
> +		return PTR_ERR(eemi_ops);
>  
>  	ret = eemi_ops->query_data(qdata, ret_payload);
>  
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index c13b014..1e34e3e 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -711,8 +711,8 @@ static int zynqmp_clock_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  
>  	eemi_ops = zynqmp_pm_get_eemi_ops();
> -	if (!eemi_ops)
> -		return -ENXIO;
> +	if (IS_ERR(eemi_ops))
> +		return PTR_ERR(eemi_ops);
>  
>  	ret = zynqmp_clk_setup(dev->of_node);
>  
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index 2771df6..a3aa76c 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -90,9 +90,6 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
>  	int ret;
>  	struct zynqmp_pm_query_data qdata = {0};
>  
> -	if (!eemi_ops)
> -		return -ENXIO;
> -
>  	switch (pm_id) {
>  	case PM_GET_API_VERSION:
>  		ret = eemi_ops->get_api_version(&pm_api_version);
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 98f9361..87a1d63 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -24,6 +24,8 @@
>  #include <linux/firmware/xlnx-zynqmp.h>
>  #include "zynqmp-debug.h"
>  
> +static const struct zynqmp_eemi_ops *eemi_ops_tbl;
> +
>  static const struct mfd_cell firmware_devs[] = {
>  	{
>  		.name = "zynqmp_power_controller",
> @@ -649,7 +651,11 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>   */
>  const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>  {
> -	return &eemi_ops;
> +	if (eemi_ops_tbl)
> +		return eemi_ops_tbl;
> +	else
> +		return ERR_PTR(-EPROBE_DEFER);
> +
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
>  
> @@ -694,6 +700,9 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>  	pr_info("%s Trustzone version v%d.%d\n", __func__,
>  		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
>  
> +	/* Assign eemi_ops_table */
> +	eemi_ops_tbl = &eemi_ops;
> +
>  	zynqmp_pm_api_debugfs_init();
>  
>  	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
> index 490c8fc..5893543 100644
> --- a/drivers/nvmem/zynqmp_nvmem.c
> +++ b/drivers/nvmem/zynqmp_nvmem.c
> @@ -16,6 +16,8 @@ struct zynqmp_nvmem_data {
>  	struct nvmem_device *nvmem;
>  };
>  
> +static const struct zynqmp_eemi_ops *eemi_ops;
> +
>  static int zynqmp_nvmem_read(void *context, unsigned int offset,
>  			     void *val, size_t bytes)
>  {
> @@ -23,9 +25,7 @@ static int zynqmp_nvmem_read(void *context, unsigned int offset,
>  	int idcode, version;
>  	struct zynqmp_nvmem_data *priv = context;
>  
> -	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> -
> -	if (!eemi_ops || !eemi_ops->get_chipid)
> +	if (!eemi_ops->get_chipid)
>  		return -ENXIO;
>  
>  	ret = eemi_ops->get_chipid(&idcode, &version);
> @@ -61,6 +61,10 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	eemi_ops = zynqmp_pm_get_eemi_ops();
> +	if (IS_ERR(eemi_ops))
> +		return PTR_ERR(eemi_ops);
> +
>  	priv->dev = dev;
>  	econfig.dev = dev;
>  	econfig.reg_read = zynqmp_nvmem_read;
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index 2ef1f13..99e75d9 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -79,11 +79,11 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, priv);
> -
>  	priv->eemi_ops = zynqmp_pm_get_eemi_ops();
> -	if (!priv->eemi_ops)
> -		return -ENXIO;
> +	if (IS_ERR(priv->eemi_ops))
> +		return PTR_ERR(priv->eemi_ops);
> +
> +	platform_set_drvdata(pdev, priv);
>  
>  	priv->rcdev.ops = &zynqmp_reset_ops;
>  	priv->rcdev.owner = THIS_MODULE;
> diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
> index 354d256..600f57c 100644
> --- a/drivers/soc/xilinx/zynqmp_pm_domains.c
> +++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
> @@ -23,6 +23,8 @@
>  /* Flag stating if PM nodes mapped to the PM domain has been requested */
>  #define ZYNQMP_PM_DOMAIN_REQUESTED	BIT(0)
>  
> +static const struct zynqmp_eemi_ops *eemi_ops;
> +
>  /**
>   * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
>   * @gpd:		Generic power domain
> @@ -71,9 +73,8 @@ static int zynqmp_gpd_power_on(struct generic_pm_domain *domain)
>  {
>  	int ret;
>  	struct zynqmp_pm_domain *pd;
> -	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  
> -	if (!eemi_ops || !eemi_ops->set_requirement)
> +	if (!eemi_ops->set_requirement)
>  		return -ENXIO;
>  
>  	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
> @@ -107,9 +108,8 @@ static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
>  	struct zynqmp_pm_domain *pd;
>  	u32 capabilities = 0;
>  	bool may_wakeup;
> -	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  
> -	if (!eemi_ops || !eemi_ops->set_requirement)
> +	if (!eemi_ops->set_requirement)
>  		return -ENXIO;
>  
>  	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
> @@ -160,9 +160,8 @@ static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
>  {
>  	int ret;
>  	struct zynqmp_pm_domain *pd;
> -	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  
> -	if (!eemi_ops || !eemi_ops->request_node)
> +	if (!eemi_ops->request_node)
>  		return -ENXIO;
>  
>  	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
> @@ -197,9 +196,8 @@ static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
>  {
>  	int ret;
>  	struct zynqmp_pm_domain *pd;
> -	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  
> -	if (!eemi_ops || !eemi_ops->release_node)
> +	if (!eemi_ops->release_node)
>  		return;
>  
>  	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
> @@ -266,6 +264,10 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
>  	struct zynqmp_pm_domain *pd;
>  	struct device *dev = &pdev->dev;
>  
> +	eemi_ops = zynqmp_pm_get_eemi_ops();
> +	if (IS_ERR(eemi_ops))
> +		return PTR_ERR(eemi_ops);
> +
>  	pd = devm_kcalloc(dev, ZYNQMP_NUM_DOMAINS, sizeof(*pd), GFP_KERNEL);
>  	if (!pd)
>  		return -ENOMEM;
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 771cb59..1b9d144 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -31,6 +31,7 @@ static const char *const suspend_modes[] = {
>  };
>  
>  static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
> +static const struct zynqmp_eemi_ops *eemi_ops;
>  
>  enum pm_api_cb_id {
>  	PM_INIT_SUSPEND_CB = 30,
> @@ -92,9 +93,8 @@ static ssize_t suspend_mode_store(struct device *dev,
>  				  const char *buf, size_t count)
>  {
>  	int md, ret = -EINVAL;
> -	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  
> -	if (!eemi_ops || !eemi_ops->set_suspend_mode)
> +	if (!eemi_ops->set_suspend_mode)
>  		return ret;
>  
>  	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
> @@ -120,9 +120,11 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>  	int ret, irq;
>  	u32 pm_api_version;
>  
> -	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +	eemi_ops = zynqmp_pm_get_eemi_ops();
> +	if (IS_ERR(eemi_ops))
> +		return PTR_ERR(eemi_ops);
>  
> -	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
> +	if (!eemi_ops->get_api_version || !eemi_ops->init_finalize)
>  		return -ENXIO;
>  
>  	eemi_ops->init_finalize();
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 9f83e1b..d07b6f9 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -138,6 +138,7 @@
>  
>  #define SPI_AUTOSUSPEND_TIMEOUT		3000
>  enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
> +static const struct zynqmp_eemi_ops *eemi_ops;
>  
>  /**
>   * struct zynqmp_qspi - Defines qspi driver instance
> @@ -1021,6 +1022,10 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct device *dev = &pdev->dev;
>  
> +	eemi_ops = zynqmp_pm_get_eemi_ops();
> +	if (IS_ERR(eemi_ops))
> +		return PTR_ERR(eemi_ops);
> +
>  	master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
>  	if (!master)
>  		return -ENOMEM;
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 642dab1..3533ee5 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -293,7 +293,7 @@ const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
>  #else
>  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENODEV);
>  }
>  #endif
>  
> 

Applied via zynqmp/soc tree.

Thanks,
Michal


