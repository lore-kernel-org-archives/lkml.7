Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E039A206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fX6yzDXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfB1N7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:20 -0500
Received: from mail-eopbgr740071.outbound.protection.outlook.com ([40.107.74.71]:31168
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730687AbfB1N7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEUD/uHUIWzVCnQcGgJ3wqRyy8ZSoIkAJfkYV89OCkQ=;
 b=fX6yzDXa8mBSP8/nF6MyRTczt+M2eI4YWNEFIZpWy/MPGTr2d7pXvtt+wmu8jRbeqJna6lhmZxuNtKBYFGaz/y9+A5+9AbN0t0kfoTEU0crm88MCoEzuBomWdPayK51k3v6Q+YTMxr1Tw5XWLC1fWtihIt9wVPriH7ptyHSK5aQ=
Received: from SN6PR02CA0028.namprd02.prod.outlook.com (2603:10b6:805:a2::41)
 by SN1PR02MB1309.namprd02.prod.outlook.com (2a01:111:e400:583d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.15; Thu, 28 Feb
 2019 13:59:17 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by SN6PR02CA0028.outlook.office365.com
 (2603:10b6:805:a2::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.16 via Frontend
 Transport; Thu, 28 Feb 2019 13:59:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 28 Feb 2019 13:59:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gzMDU-0003cA-3t; Thu, 28 Feb 2019 05:59:16 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gzMDO-0001cN-VF; Thu, 28 Feb 2019 05:59:11 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1SDx9Ff029864;
        Thu, 28 Feb 2019 05:59:09 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gzMDN-0001cB-4T; Thu, 28 Feb 2019 05:59:09 -0800
Subject: Re: [PATCH] firmware: xilinx: fix debugfs write handler
To:     Jann Horn <jannh@google.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190218214309.29985-1-jannh@google.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <33ebe841-924e-2494-b11d-15be405fccb5@xilinx.com>
Date:   Thu, 28 Feb 2019 14:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218214309.29985-1-jannh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(189003)(199004)(81166006)(81156014)(126002)(44832011)(446003)(54906003)(58126008)(36756003)(77096007)(110136005)(186003)(65806001)(65956001)(26005)(31696002)(230700001)(2486003)(478600001)(76176011)(106002)(476003)(23676004)(486006)(2616005)(47776003)(4326008)(2906002)(426003)(5660300002)(11346002)(336012)(8936002)(356004)(63266004)(31686004)(50466002)(305945005)(316002)(9786002)(65826007)(8676002)(229853002)(14444005)(36386004)(6246003)(106466001)(64126003)(42866002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1309;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 098e4c03-3202-4f65-003b-08d69d84eda1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN1PR02MB1309;
X-MS-TrafficTypeDiagnostic: SN1PR02MB1309:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1309;20:Wvso+0eAfc1vJLGLMewZ4g/aIzKzzFeQ8XoBofW36fFTyMTFSIVQ3oxb6e6byZeG+X8Kzf5B8MqVviIp2m0aS/uUVkGaxmeEfYFkWI6kxxQkDNuKY0Kvu97aO1VLCmK4NviLadEX+lyZx1I4sw1Z+7vcseGUy/BYzASwp3BqVuI2MBuJwheEz/fZ0R1v7JcLPwEsL4WrA+XfUWh1w4pRdN4+RMB9cPWf4W0s+qUXV/bfURwXvRW+2l0MrJRriHEsrDZR5x/JGFRRwLQ3AKvyjuKpVMmBHPJVHI/bbcZ6pOaFlZK4ER2SgSC37iRA2zqtdF6umVmZkc+mAdSFQX3dP2X+h+yaXsRH5zDu8REMKSjkE8tf/b1xSKNHgaD2joz3NFxQpxzGPrYUK/3ocrgnjdvPu2BCsIsqocFG1W2l1JpUO2ZaqoLGThQzIs9c9yjf3FI2eh6BYOM+dZ8ARzneKrax39y8yd8mPm6olrX+89kLpFo+ErJp4hjVsCTwNnmz
X-Microsoft-Antispam-PRVS: <SN1PR02MB1309F253AF9ABA32D5B6BE42C6750@SN1PR02MB1309.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0962D394D2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjAyTUIxMzA5OzIzOmVkd0gvNXk1eWNKR01zVGJlTnYycW1JN0hD?=
 =?utf-8?B?MXBqV01jN1hia1kyeUp3bW04b1hkSW1CVmovY2QyMWtmT1lrL25FemFyTjcw?=
 =?utf-8?B?Vm1NK2Y2dDRwa21aS3RMbkpVQUZsUmVORjlUVC9MQW5zT1hZV1k2VTFIMEVm?=
 =?utf-8?B?VnlZeVBjalQ4YjQzTFgza1ZQR1I0YWtRNmpCZVhSUlBrZXkxMThleDB6bE1H?=
 =?utf-8?B?ZUpqbXFwK0dTdFpSVUZoVGJmRHVVY3RLMUR2eVgvSFpYSlh4aE9nWFlFUEZ6?=
 =?utf-8?B?TXlxQXdUaWx1VWJVajBib29odXZQeUh6dlJnaFYrVzJlcEN1MDdhYlNKSnlh?=
 =?utf-8?B?SldFSnhqdmQ3VnBlUFIyWnUzemhyY0Q5YW44L0tCRHR4TEZTa1FOdEs0aXd6?=
 =?utf-8?B?V1RPaGY4UXZaNUNRWHp0WVJTQm16VTdvOGFYNlZKd1ZJQ0tWOHU0L0tzUmNM?=
 =?utf-8?B?bmU3VjE3WFVUNnM1K2xFbU5rZVBUZDVad0FVK25kaGlnOG52aFExNy94Rmd4?=
 =?utf-8?B?QzlOZE5BN3poVTU0Z21OYUZYMkZVY1Z5Z0xwRWMvQUhPWFo1TGRqbk1CYmZS?=
 =?utf-8?B?T01Da3lQWE8xQUNsVHRtUHdKcWZPMkdPbUpYM3BncW9tNUx1bThRQlI3WWZU?=
 =?utf-8?B?TklQNkdDRDd0WXhlZmFNSlZCOFhRditzVmxMZzE1ZTlqN3BqWlVZTWdJZXhk?=
 =?utf-8?B?a2xvSnFaMHZCV2Z3NGlKQkgxYk9JcEN2M2Jpd0JYUWZxYWxCZExGMXlhd3BS?=
 =?utf-8?B?ZW1JTkRkS1JJY2FkZnF6L1FRRWczWmRVUXN1cUtDU3pBYkJTVUJ1djNHaldQ?=
 =?utf-8?B?UkpmQVVEUXRLKzhaZzhoWGMwNUM0MUZVcjQ0SWlaR3RKb1JneHNGaUNTeWFu?=
 =?utf-8?B?cFdDVlVOMGJkTVFISkg3ZllDd2RnM1pkU2YxWG5Obk5vMG1XaUkwSFVMRWZr?=
 =?utf-8?B?YVNvM3FiTzJuNzJnN2VzeC8vMitjNWNxQzE2OWx6ZkI4UU9rT1Z5U0xINjVt?=
 =?utf-8?B?ZGtKVHptSVVWai9kaVd0ZHV4UlJWY09JTDRPOTNjbG1Ibk4vVk80d0QxMWxG?=
 =?utf-8?B?MFZpMUx5ZmZBS05kbDdwQUJMbzd2UDlkckllM1YwSG5tZ1R5QzlYQUVFYjVG?=
 =?utf-8?B?MWtmUkJYNVJiMFB4NTN6SUhXdGp4Wm9PVTFYQllzU0xZeG9rVEVBY2lxK3k3?=
 =?utf-8?B?VzZpZXc0TzZmZnpzN3BrYlc5RjdpdFVHa2dJNG8zS3JocmIrZEJhNW12eUNK?=
 =?utf-8?B?WUd0MEpVcTQ1QThBRFlZc25pK2dwWGV4ZEpHTXM3bkpjMW92emw0SmsyR1hW?=
 =?utf-8?B?VWwyVS9JUGdycjZnQ1lDQ05yWHdOYnhZSWVZc09KaldUczNUVUpyWnQwQ1FS?=
 =?utf-8?B?Zit0dEhqeDBmN3FsVzZadDJVUXNxSnpscUVPNWlES0JOQmZIeW5Xd2dGcGNS?=
 =?utf-8?B?VW9HQitvSTdKUXNhanlGTjJoTWE2R0RZSldONkdBMEJnTjRXRUxCdE45MkVZ?=
 =?utf-8?B?RXJhdzhKenhoMStZeXgwWWtrRVpuaGkyUWJHRlRpSXNGRklCVTFFZ3M2aUxy?=
 =?utf-8?B?Rk8vNnVUQU5JeTJ2ZktsQTFTM1I5dnlxMmljWHQ2c3BuVVpJVlNqMlFDUXg2?=
 =?utf-8?B?TjhYZlpJZ1h1bGdHVUNGNTh0YTNSU0d3RlYydk45VGJHK2JOTzVZcWJZWng5?=
 =?utf-8?Q?nZkvMWNtWl+Y7T7UX5Qg3dFCC2iLhfvn1DwZdEA?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: E6H8i7xGM2EzsgI9agYBd6hCJSEkmwjXa7g6+J1tbYb1YnFrM/nRki3IM72WOHr3DEt63YTdRSg8nEDvXUIx2w9tlwiEi3O6WVAfSUmSI9yt9AWpMmeTZxJHEkVqUZKG4NYcEuCfmEwCh8yADYeJ1GyjC+lcYtnT0ggWorxsTqwbraqGi3IrCo2Dim/4foNYBSvO5xaF+UTAypdvQqmUR3znOBnPPN6EweeKYp6gtTGqGVHHVyL7N7CPmzKv5G+GbkDsjrXWQj2U/azGCkfatZEgecovjzfnVfguRwxOVZqsR8DLEom4wAvWfrKpGAYmezMtk8tRdknoSgagdDgYZttZpACGD7d5RxyEtiF/j3F07owWf6XvNt6M5lQ9dmmTOogLxtGvmceTWYsHkc9n0eFVihSdZ4qyK4lVWclPVCc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2019 13:59:16.5397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098e4c03-3202-4f65-003b-08d69d84eda1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 02. 19 22:43, Jann Horn wrote:
>  - Userspace wants to write a string with `len` bytes, not counting the
>    terminating NULL, so we should allocate `len+1` bytes. It looks like the
>    current code relied on having a nullbyte directly behind `kern_buff`,
>    which happens to work reliably as long as `len` isn't one of the kmalloc
>    size classes.
>  - strncpy_from_user() is completely wrong here; userspace is giving us a
>    (not necessarily null-terminated) buffer and its length.
>    strncpy_from_user() is for cases in which we don't know the length.
>  - Don't let broken userspace allocate arbitrarily big kmalloc allocations.
> 
> Just use memdup_user_nul(), which is designed precisely for things like
> this.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> WARNING: completely untested patch
> 
> drivers/firmware/xilinx/zynqmp-debug.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index 2771df6df379..90b66cdbfd58 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -163,21 +163,14 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
>  
>  	strcpy(debugfs_buf, "");
>  
> -	if (*off != 0 || len == 0)
> +	if (*off != 0 || len <= 1 || len > PAGE_SIZE - 1)
>  		return -EINVAL;
>  
> -	kern_buff = kzalloc(len, GFP_KERNEL);
> -	if (!kern_buff)
> -		return -ENOMEM;
> -
> +	kern_buff = memdup_user_nul(ptr, len);
> +	if (IS_ERR(kern_buff))
> +		return PTR_ERR(kern_buff);
>  	tmp_buff = kern_buff;
>  
> -	ret = strncpy_from_user(kern_buff, ptr, len);
> -	if (ret < 0) {
> -		ret = -EFAULT;
> -		goto err;
> -	}
> -
>  	/* Read the API name from a user request */
>  	pm_api_req = strsep(&kern_buff, " ");
>  
> 

Jolly: Can you please retest it and ACK?

Thanks,
Michal

