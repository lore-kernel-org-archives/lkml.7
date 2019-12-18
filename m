Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16728218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qWnNhXn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfLROYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:24:43 -0500
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:9920
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbfLROYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:24:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhbfH0toYIhneTdD0SqijUi6A/y7CkEkHxxYoEGX3jXl8A4tO/dnxZ2Mt7ZVBAt5VtDmnRf9BcukMVCTmQH+4YxBVSgyYnS8g1r2r1BckUtKbC8STYJR/LlyS8tvA/pctQlVEdHnmYTygQuNhj8lkWufwk6aVDDh64spk8POC8EqtSkny/0sBF1n6xegMV6BQ3s73MJBkGQ7KTLZyo7beQ1YPrcV6gzRhuLfamjP2fzSrrrcw8rsQEARVu70xRN0X4yzmO8wKwjFqzL9lzI73LwOwU3styz0bc54rTttVDfdxuy1W+uRJewQyIi4C0/7wpnQGRrFzdpkb0lYGKR5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d9JgYY2PyaS5Ep1XQ+Eh/5BESJNn5J44iwGC0accXI=;
 b=lsDFmmb+5Vmac2186PSm3LMbkCAI/cnHKF0ibBLH3RnEFO6c46/YcsvyjzuSPGd7NHbC1paYrkG18zhyoRlNKpzY0VHcA7+R0hbU1KzAwQBm5KIFCmCV1naEM3oW25r1RBEj7GcbF5kA3J89UzWNaA0FluX0o8UEmBSpkxJTJOH/GGN898eDaqQWPpVBUo+Fasp7LVmwV/uDOPH3FV2d7N36KT8rF6qxJUA34x/osspwVk9sToxg89bXWw5H+t6KDDi/G10jxrwZ+shmqdiaPj3yCkouUecAtFykbEJnp35iAvPad2GnKATp4F2ahJ2E9eZ/ueGwZPAmuIhaXqspMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d9JgYY2PyaS5Ep1XQ+Eh/5BESJNn5J44iwGC0accXI=;
 b=qWnNhXn85jtKF2DR646gFZHrmeUdgPwz31vLq+zljN335IQJg2dFVCzPZRDTxRoQrJAyHFC1sHZxsDLH0HwLUHp2Y4xPM83zwXvUMwzeW+fF0gu4+YmnRGWXJAMRZdSQFz74V8IiDuuC8CCIOkRG/OmJe+p9zS1psoJoiDFHQ2A=
Received: from DM6PR14CA0061.namprd14.prod.outlook.com (2603:10b6:5:18f::38)
 by CY4PR02MB3191.namprd02.prod.outlook.com (2603:10b6:910:7c::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.19; Wed, 18 Dec
 2019 14:24:39 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::86) by DM6PR14CA0061.outlook.office365.com
 (2603:10b6:5:18f::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Wed, 18 Dec 2019 14:24:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Wed, 18 Dec 2019 14:24:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihaFi-0001Da-7G; Wed, 18 Dec 2019 06:24:38 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihaFc-0005xI-Nm; Wed, 18 Dec 2019 06:24:32 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ihaFZ-0005w9-Hf; Wed, 18 Dec 2019 06:24:29 -0800
Subject: Re: [PATCH 3/5] firmware: xilinx: Add system shutdown API interface
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
References: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
 <1575502159-11327-4-git-send-email-jolly.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2270666b-5fd7-950f-9943-39f1ce2f2065@xilinx.com>
Date:   Wed, 18 Dec 2019 15:24:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575502159-11327-4-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(199004)(189003)(426003)(5660300002)(31696002)(44832011)(7416002)(2906002)(336012)(4326008)(8676002)(31686004)(36756003)(2616005)(6666004)(81166006)(356004)(498600001)(9786002)(26005)(8936002)(70206006)(81156014)(70586007)(186003)(107886003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB3191;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3162b1e-093b-4b59-290d-08d783c603ea
X-MS-TrafficTypeDiagnostic: CY4PR02MB3191:
X-Microsoft-Antispam-PRVS: <CY4PR02MB3191BE6CD93E61ACC85CF493C6530@CY4PR02MB3191.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkKYPTJp+VSk081g8bYYBs9nGLqeKNDRjMmxOLirLDUoIkdREgI0u0LxDlEr2DCkQb5ucQswcnNBjJ4bqE/5Ba+pOfPfgsb/zEAhsPbkQHzUEIlY4Rr056jEvErE1hCsuAqE0V1l0A8VDNM3EoBoMavN+CgBELWxTIasdOmLaLgWMp5hFXMcjrqXQtElfOhLRVDmK/xyPSoWNxhT3YnPbbYGWtDkr49gep0YCgYSPQddeHMwc1N55UAlQ1CsIigFHr94fIO1fQqM9Im+TGIt4feWd6hqZe01U6Sr/hn+L5c2tjsCo4kZefx0v8VApStxMFrr4JMcoh+pRKm/K2mPJyHbyhoDXQkdGCj1h/lgWvlCCvJqfrodbg1Ag9ltp/97zyyO83suL0FhqdVCIJn+gYHR3vD4w5J6t62WtRhdGlahnb7F1M6HRv7PDfB4PZJ0ezMYdQ2HsA8nWag1AAA2eaDh5WkocDVZoC4wcI8syTRK3ILElMKf+t01Vd9K2Ihx
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 14:24:38.6944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3162b1e-093b-4b59-290d-08d783c603ea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 12. 19 0:29, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add system shutdown API interface which asks firmware to
> perform system shutdown/restart.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  4 +++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 9836174..8dcf5a4 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -690,6 +690,19 @@ static int zynqmp_pm_config_reg_access(u32 register_access_id, u32 address,
>  				   address, mask, value, out);
>  }
>  
> +/**
> + * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
> + * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
> + * @subtype:	Specifies which system should be restarted or shut down
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
> +{
> +	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
> +				   0, 0, NULL);
> +}
> +
>  static const struct zynqmp_eemi_ops eemi_ops = {
>  	.get_api_version = zynqmp_pm_get_api_version,
>  	.get_chipid = zynqmp_pm_get_chipid,
> @@ -714,6 +727,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>  	.fpga_load = zynqmp_pm_fpga_load,
>  	.fpga_get_status = zynqmp_pm_fpga_get_status,
>  	.register_access = zynqmp_pm_config_reg_access,
> +	.system_shutdown = zynqmp_pm_system_shutdown,
>  };
>  
>  /**
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index bf6e9db..b96ea5d 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -61,7 +61,8 @@
>  
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
> -	PM_REQUEST_NODE = 13,
> +	PM_SYSTEM_SHUTDOWN = 12,
> +	PM_REQUEST_NODE,
>  	PM_RELEASE_NODE,
>  	PM_SET_REQUIREMENT,
>  	PM_RESET_ASSERT = 17,
> @@ -322,6 +323,7 @@ struct zynqmp_eemi_ops {
>  			       const enum zynqmp_pm_request_ack ack);
>  	int (*register_access)(u32 register_access_id, u32 address,
>  			       u32 mask, u32 value, u32 *out);
> +	int (*system_shutdown)(const u32 type, const u32 subtype);
>  };
>  
>  int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
> 

This looks good to me.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

