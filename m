Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C928BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E453227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pKrvngjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfLRO2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:33 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:42803
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbfLRO2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:28:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4SA/i3nUo70ykR3mGlams0DlbHEtfHfpw4vuBY6hlusbl3OYo5NLIV0dfbNFjC+g/6Fzl/3+u5fWN8n1Qm9ZEPNEi0YMjCdTgR+CERl7dyu2cO92MbbQEED8dxXtliEpangkgk8FdwJY6BhtxQuyubmc9fx6prqtnv/3CCIqrotiFQ5bsujKXtxXBHkHfiv1R8IxRpnDWs0aovtyO6cmyiWWRQo5eysJKF3MFkSWeQBgvoRvtpU7n9Hcc53sqh8uxTo5s6gw6dfMogYTh4KtPw05XfFyqxNSFPXjV7SFUXGwsSSSF1/ZNvb/iWy5MJ8oixLlk9tVMIkWNALcONQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtm2HB33wPhwka6MgphYjm6GowceMzYhvZqA6tU3AkM=;
 b=R78DW2Z/jOYldYqPxnzC0bjICXV+7hzV86/MwFltinELohmQAwmtes9wYjM30TPrpjyVYqbIxr9xBqbFgMxRfBSVcLTqfX9yrHgdLTZgmFROiI6SnUFDYjoLn7syhRmcT2caBiMivozUPpjcpXpZwojj+rb7+7RSHbvaOSx4d2l7y8kTfQJCcb2ir8CsptlWuBdJWX+7WGiIOBcV2GLGp9MnkB1JGX3J6+JsQ0LR6U6XV90kOuyuX9ayaYu9nfjPQA1cUmpAL9VVOtb5jrk90MDFfXXl3B2lSFKXo17thbmh8IS4NyoyRoXNKueVBhmkG+XTM704MxesD5IFvuaqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtm2HB33wPhwka6MgphYjm6GowceMzYhvZqA6tU3AkM=;
 b=pKrvngjtaWS6WY2VKFIOKUFFgr1I4erQ4JYHWeArA09m1cw058asuuzXGOwYbLTtCHB6Va3TOxXJGaUaQr7daun0qChzsqpz/0QN7mpZw+YqO1DebUCJJsG1MvBWWBpFmiSnNQWWP6XdH+64zbimV1moH2REYGWZtA+f9Rj9Ks4=
Received: from DM6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:40::17) by
 DM6PR02MB6559.namprd02.prod.outlook.com (2603:10b6:5:1bc::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 14:28:29 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::ae) by DM6PR03CA0004.outlook.office365.com
 (2603:10b6:5:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13 via Frontend
 Transport; Wed, 18 Dec 2019 14:28:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Wed, 18 Dec 2019 14:28:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihaJQ-0001E6-VG; Wed, 18 Dec 2019 06:28:28 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihaJL-0006go-Fb; Wed, 18 Dec 2019 06:28:23 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBIESK2E013452;
        Wed, 18 Dec 2019 06:28:20 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ihaJH-0006fn-Oo; Wed, 18 Dec 2019 06:28:19 -0800
Subject: Re: [PATCH 5/5] firmware: xilinx: Add sysfs and IOCTL to set boot
 health status
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
References: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
 <1575502159-11327-6-git-send-email-jolly.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <51ff29cd-3ac5-7d45-cb26-946252bcf622@xilinx.com>
Date:   Wed, 18 Dec 2019 15:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575502159-11327-6-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(316002)(70206006)(9786002)(107886003)(70586007)(426003)(356004)(8676002)(8936002)(26005)(2616005)(336012)(2906002)(81156014)(81166006)(5660300002)(31696002)(478600001)(31686004)(186003)(6666004)(7416002)(4326008)(44832011)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6559;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf221d2-c94d-4398-9da9-08d783c68d5d
X-MS-TrafficTypeDiagnostic: DM6PR02MB6559:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6559A351882B8D4BC3383A8DC6530@DM6PR02MB6559.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYFhj+Vfjzi79hZ4oyztrnPfwZAu8al7WnonvevrImwYcvEd4+t+8za0QV4bAFdilfF2yMAp1b66dm3zJr/jh2zzO2qQv8W+Uf2TFmSxD8i98E374KF1uq0xvJPZHHXfTSqaW5WBEKg6wFZ0noA7iSkTggEiUbaTInSEBIpAWEgSx2rm7ipyC5R7wcQFSHSrc1QlIpGLZhaIgGhBoqKPCBgKN9PaCXnk0GDOjBtBUBEEaoWoQraIeBSeQYMB4PnvYCfFWj+Y7FAkLE2/uibWc3B5ZjvEJ8I2lnngsVYGaG3ZALXLRyEdxUvMDpcDX7bEtIKupJ3YYX31Px/1UviBb4dzxWTDw0tRiI8KgS4lJA3V7B+Zj/jnW5IfLMI7u/STg87wbIhErZsk5A30iHPZLmp+RDPGRLNjtrX4+aOAERss79Ht95hXC9VDrhkvcUiPlp9Rb5l576PzjylKcnCRfV9UBPMBju1yCw61Ro2jkWYEhRwLOPXruM32au26IPB2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 14:28:29.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf221d2-c94d-4398-9da9-08d783c68d5d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 12. 19 0:29, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add sysfs interface to set boot health status from userspace.
> Add IOCTL ID used by this interface to communicate with firmware.
> 
> If PMUFW is compiled with CHECK_HEALTHY_BOOT, it will check the
> healthy bit on FPD WDT expiration. If healthy bit is set by a user
> application running in Linux, PMUFW will do APU only restart. If
> healthy bit is not set during FPD WDT expiration, PMUFW will do
> system restart.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>

Rajan should be the first.

> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  Documentation/ABI/stable/sysfs-firmware-zynqmp | 21 +++++++++++++
>  drivers/firmware/xilinx/zynqmp.c               | 42 ++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h           |  2 ++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-firmware-zynqmp b/Documentation/ABI/stable/sysfs-firmware-zynqmp
> index 13e4fd2..eeae291 100644
> --- a/Documentation/ABI/stable/sysfs-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-firmware-zynqmp
> @@ -80,3 +80,24 @@ Description:
>  		# echo "subsystem" > /sys/firmware/zynqmp/shutdown_scope
>  
>  Users:		Xilinx
> +
> +What:		/sys/firmware/zynqmp/health_status
> +Date:		April 2018
> +KernelVersion:	4.14.0

ditto

> +Contact:	"Rajan Vaja" <rajanv@xilinx.com>
> +Description:
> +		This sysfs interface allows to set the health status. If PMUFW
> +		is compiled with CHECK_HEALTHY_BOOT, it will check the healthy
> +		bit on FPD WDT expiration. If healthy bit is set by a user
> +		application running in Linux, PMUFW will do APU only restart. If
> +		healthy bit is not set during FPD WDT expiration, PMUFW will do
> +		system restart.
> +
> +		Usage:
> +		Set healty bit

healthy

> +		# echo 1 > /sys/firmware/zynqmp/health_status
> +
> +		Unset healty bit

ditto.

> +		# echo 0 > /sys/firmware/zynqmp/health_status
> +
> +Users:		Xilinx
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index b23bda4..4e497a3 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -479,6 +479,7 @@ static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
>  	case IOCTL_READ_GGS:
>  	case IOCTL_WRITE_PGGS:
>  	case IOCTL_READ_PGGS:
> +	case IOCTL_SET_BOOT_HEALTH_STATUS:
>  		return 1;
>  	default:
>  		return 0;
> @@ -886,6 +887,46 @@ static struct kobj_attribute zynqmp_attr_shutdown_scope =
>  						__ATTR_RW(shutdown_scope);
>  
>  /**
> + * health_status_store - Store health_status sysfs attribute
> + * @kobj:	Kobject structure
> + * @attr:	Kobject attribute structure
> + * @buf:	User entered health_status attribute string
> + * @count:	Buffer size
> + *
> + * User-space interface for setting the boot health status.
> + * Usage: echo <value> > /sys/firmware/zynqmp/health_status
> + *
> + * Value:
> + *	1 - Set healthy bit to 1
> + *	0 - Unset healthy bit
> + *
> + * Return:	count argument if request succeeds, the corresponding error
> + *		code otherwise
> + */
> +static ssize_t health_status_store(struct kobject *kobj,
> +				   struct kobj_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned int value;
> +
> +	ret = kstrtouint(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret = zynqmp_pm_ioctl(0, IOCTL_SET_BOOT_HEALTH_STATUS, value, 0, NULL);
> +	if (ret) {
> +		pr_err("unable to set healthy bit value to %u\n", value);
> +		return ret;
> +	}
> +
> +	return count;
> +}
> +
> +static struct kobj_attribute zynqmp_attr_health_status =
> +						__ATTR_WO(health_status);

ditto.

> +
> +/**
>   * config_reg_store - Write config_reg sysfs attribute
>   * @kobj:	Kobject structure
>   * @attr:	Kobject attribute structure
> @@ -1011,6 +1052,7 @@ static struct kobj_attribute zynqmp_attr_config_reg =
>  
>  static struct attribute *attrs[] = {
>  	&zynqmp_attr_shutdown_scope.attr,
> +	&zynqmp_attr_health_status.attr,
>  	&zynqmp_attr_config_reg.attr,
>  	NULL,
>  };
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 54061de..c6f3c50 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -107,6 +107,8 @@ enum pm_ioctl_id {
>  	IOCTL_READ_GGS,
>  	IOCTL_WRITE_PGGS,
>  	IOCTL_READ_PGGS,
> +	/* Set healthy bit value*/

<space>*/

> +	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
>  };
>  
>  enum pm_query_id {
> 


M
