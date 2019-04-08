Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3E2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A9120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YwrsB7fu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JUDazDB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfDHHET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:04:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:04:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F7C4608A5; Mon,  8 Apr 2019 07:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554707057;
        bh=yDhFdOPTIGsSQ5beLZQARocxgBVZtNJmzPaYsdb+Q/o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YwrsB7fuLjluqJEzO+fn5NnYwR/ahDgjlAOm5Qfm9hInZKAQZtGtzt52SoDbXxhVe
         0mnLLH07ZFBel/Ae0FwTPONwQKZNbjLjynhHY3ggFhPbY+4RHJWOEvCnsmBPbolC30
         8L6+Wer5E76FgELfruguiPcnR7xPagkIrgGLVqcQ=
Received: from [10.201.2.76] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E54D6110F;
        Mon,  8 Apr 2019 07:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554707053;
        bh=yDhFdOPTIGsSQ5beLZQARocxgBVZtNJmzPaYsdb+Q/o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JUDazDB9RRWCBwpOuMhPmYxiTvKxqoSCa4dOGv7GCcrSnG+UctIzqvWVDOzw20a/i
         aclcba2d8q1ThI9zjjuP7zg55fwiv0R4DrbcACyGZ+D5p5S4bRE26zg8+ygjjmJJFN
         hrJlw49uq5zgLkdUg0M6U1hQAaeyn0YRgBDUpVh4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E54D6110F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [RFC PATCH 2/9] cpufreq: qcom: Re-organise kryo cpufreq to use it
 for other nvmem based qcom socs
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-3-niklas.cassel@linaro.org>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <b181bf13-fb47-433a-f870-297e7e50cdf4@codeaurora.org>
Date:   Mon, 8 Apr 2019 12:34:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404050931.9812-3-niklas.cassel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 4/4/2019 10:39 AM, Niklas Cassel wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

 Thanks for reposting this patch again. Sorry, got completely lost track
 on this. Please let me know if you are planning to rework etc or anything
 you need from me on this.

Regards,
 Sricharan
 





>  ...ryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} |  16 +--
>  drivers/cpufreq/Kconfig.arm                   |   4 +-
>  drivers/cpufreq/Makefile                      |   2 +-
>  ...om-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} | 124 +++++++++++-------
>  4 files changed, 85 insertions(+), 61 deletions(-)
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (97%)
>  rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (69%)
> 
> diff --git a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> similarity index 97%
> rename from Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> rename to Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index c2127b96805a..f4a7123730c3 100644
> --- a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -1,13 +1,13 @@
> -Qualcomm Technologies, Inc. KRYO CPUFreq and OPP bindings
> +Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
>  ===================================
>  
> -In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> -that have KRYO processors, the CPU ferequencies subset and voltage value
> -of each OPP varies based on the silicon variant in use.
> +In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
> +the CPU frequencies subset and voltage value of each OPP varies based on
> +the silicon variant in use.
>  Qualcomm Technologies, Inc. Process Voltage Scaling Tables
>  defines the voltage and frequency value based on the msm-id in SMEM
>  and speedbin blown in the efuse combination.
> -The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> +The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
>  to provide the OPP framework with required information (existing HW bitmap).
>  This is used to determine the voltage and frequency value for each OPP of
>  operating-points-v2 table when it is parsed by the OPP framework.
> @@ -19,7 +19,7 @@ In 'cpus' nodes:
>  
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +	- 'operating-points-v2-qcom-cpu' for apq8096 and msm8996.
>  - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>  		efuse registers that has information about the
>  		speedbin that is used to select the right frequency/voltage
> @@ -127,7 +127,7 @@ Example 1:
>  	};
>  
>  	cluster0_opp: opp_table0 {
> -		compatible = "operating-points-v2-kryo-cpu";
> +		compatible = "operating-points-v2-qcom-cpu";
>  		nvmem-cells = <&speedbin_efuse>;
>  		opp-shared;
>  
> @@ -338,7 +338,7 @@ Example 1:
>  	};
>  
>  	cluster1_opp: opp_table1 {
> -		compatible = "operating-points-v2-kryo-cpu";
> +		compatible = "operating-points-v2-qcom-cpu";
>  		nvmem-cells = <&speedbin_efuse>;
>  		opp-shared;
>  
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 179a1d302f48..2e4aefa0f34d 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -110,8 +110,8 @@ config ARM_OMAP2PLUS_CPUFREQ
>  	depends on ARCH_OMAP2PLUS
>  	default ARCH_OMAP2PLUS
>  
> -config ARM_QCOM_CPUFREQ_KRYO
> -	tristate "Qualcomm Kryo based CPUFreq"
> +config ARM_QCOM_CPUFREQ_NVMEM
> +	tristate "Qualcomm nvmem based CPUFreq"
>  	depends on ARM64
>  	depends on QCOM_QFPROM
>  	depends on QCOM_SMEM
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 689b26c6f949..8e83fd73bd2d 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -63,7 +63,7 @@ obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
> -obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_NVMEM)	+= qcom-cpufreq-nvmem.o
>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> similarity index 69%
> rename from drivers/cpufreq/qcom-cpufreq-kryo.c
> rename to drivers/cpufreq/qcom-cpufreq-nvmem.c
> index dd64dcf89c74..652a1de2a5d4 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -9,7 +9,7 @@
>   * based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
>   * defines the voltage and frequency value based on the msm-id in SMEM
>   * and speedbin blown in the efuse combination.
> - * The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> + * The qcom-cpufreq driver reads the msm-id and efuse value from the SoC
>   * to provide the OPP framework with required information.
>   * This is used to determine the voltage and frequency value for each OPP of
>   * operating-points-v2 table when it is parsed by the OPP framework.
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> @@ -42,9 +43,9 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> -static struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
> +static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
>  
> -static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
> +static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  {
>  	size_t len;
>  	u32 *msm_id;
> @@ -73,34 +74,68 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>  	return version;
>  }
>  
> -static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> +static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
> +					  struct nvmem_cell *speedbin_nvmem,
> +					  u32 *versions)
>  {
> -	struct opp_table **opp_tables;
> +	size_t len;
> +	u8 *speedbin;
>  	enum _msm8996_version msm8996_version;
> +
> +	msm8996_version = qcom_cpufreq_get_msm_id();
> +	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> +		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> +		return -ENODEV;
> +	}
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	switch (msm8996_version) {
> +	case MSM8996_V3:
> +		*versions = 1 << (unsigned int)(*speedbin);
> +		break;
> +	case MSM8996_SG:
> +		*versions = 1 << ((unsigned int)(*speedbin) + 4);
> +		break;
> +	default:
> +		BUG();
> +		break;
> +	}
> +
> +	kfree(speedbin);
> +	return 0;
> +}
> +
> +static int qcom_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct opp_table **opp_tables;
> +	int (*get_version)(struct device *cpu_dev,
> +			   struct nvmem_cell *speedbin_nvmem,
> +			   u32 *versions);
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
>  	unsigned cpu;
> -	u8 *speedbin;
>  	u32 versions;
> -	size_t len;
> +	const struct of_device_id *match;
>  	int ret;
>  
>  	cpu_dev = get_cpu_device(0);
>  	if (!cpu_dev)
>  		return -ENODEV;
>  
> -	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
> -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> +	match = pdev->dev.platform_data;
> +	get_version = match->data;
> +	if (!get_version)
>  		return -ENODEV;
> -	}
>  
>  	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>  	if (!np)
>  		return -ENOENT;
>  
> -	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
> +	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
>  	if (!ret) {
>  		of_node_put(np);
>  		return -ENOENT;
> @@ -115,23 +150,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  		return PTR_ERR(speedbin_nvmem);
>  	}
>  
> -	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	ret = get_version(cpu_dev, speedbin_nvmem, &versions);
>  	nvmem_cell_put(speedbin_nvmem);
> -	if (IS_ERR(speedbin))
> -		return PTR_ERR(speedbin);
> -
> -	switch (msm8996_version) {
> -	case MSM8996_V3:
> -		versions = 1 << (unsigned int)(*speedbin);
> -		break;
> -	case MSM8996_SG:
> -		versions = 1 << ((unsigned int)(*speedbin) + 4);
> -		break;
> -	default:
> -		BUG();
> -		break;
> -	}
> -	kfree(speedbin);
> +	if (ret)
> +		return ret;
>  
>  	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
>  	if (!opp_tables)
> @@ -174,7 +196,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
> +static int qcom_cpufreq_remove(struct platform_device *pdev)
>  {
>  	struct opp_table **opp_tables = platform_get_drvdata(pdev);
>  	unsigned int cpu;
> @@ -189,18 +211,20 @@ static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_driver qcom_cpufreq_kryo_driver = {
> -	.probe = qcom_cpufreq_kryo_probe,
> -	.remove = qcom_cpufreq_kryo_remove,
> +static struct platform_driver qcom_cpufreq_driver = {
> +	.probe = qcom_cpufreq_probe,
> +	.remove = qcom_cpufreq_remove,
>  	.driver = {
> -		.name = "qcom-cpufreq-kryo",
> +		.name = "qcom-cpufreq",
>  	},
>  };
>  
> -static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
> -	{ .compatible = "qcom,apq8096", },
> -	{ .compatible = "qcom,msm8996", },
> -	{}
> +static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> +	{ .compatible = "qcom,apq8096",
> +	  .data = qcom_cpufreq_kryo_name_version },
> +	{ .compatible = "qcom,msm8996",
> +	  .data = qcom_cpufreq_kryo_name_version },
> +	{},
>  };
>  
>  /*
> @@ -209,7 +233,7 @@ static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
>   * which may be defered as well. The init here is only registering
>   * the driver and the platform device.
>   */
> -static int __init qcom_cpufreq_kryo_init(void)
> +static int __init qcom_cpufreq_init(void)
>  {
>  	struct device_node *np = of_find_node_by_path("/");
>  	const struct of_device_id *match;
> @@ -218,32 +242,32 @@ static int __init qcom_cpufreq_kryo_init(void)
>  	if (!np)
>  		return -ENODEV;
>  
> -	match = of_match_node(qcom_cpufreq_kryo_match_list, np);
> +	match = of_match_node(qcom_cpufreq_match_list, np);
>  	of_node_put(np);
>  	if (!match)
>  		return -ENODEV;
>  
> -	ret = platform_driver_register(&qcom_cpufreq_kryo_driver);
> +	ret = platform_driver_register(&qcom_cpufreq_driver);
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	kryo_cpufreq_pdev = platform_device_register_simple(
> -		"qcom-cpufreq-kryo", -1, NULL, 0);
> -	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
> +	cpufreq_pdev = platform_device_register_data(NULL, "qcom-cpufreq",
> +						     -1, match, sizeof(*match));
> +	ret = PTR_ERR_OR_ZERO(cpufreq_pdev);
>  	if (0 == ret)
>  		return 0;
>  
> -	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> +	platform_driver_unregister(&qcom_cpufreq_driver);
>  	return ret;
>  }
> -module_init(qcom_cpufreq_kryo_init);
> +module_init(qcom_cpufreq_init);
>  
> -static void __exit qcom_cpufreq_kryo_exit(void)
> +static void __exit qcom_cpufreq_exit(void)
>  {
> -	platform_device_unregister(kryo_cpufreq_pdev);
> -	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> +	platform_device_unregister(cpufreq_pdev);
> +	platform_driver_unregister(&qcom_cpufreq_driver);
>  }
> -module_exit(qcom_cpufreq_kryo_exit);
> +module_exit(qcom_cpufreq_exit);
>  
> -MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. CPUfreq driver");
>  MODULE_LICENSE("GPL v2");
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
