Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4076C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E4720811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cCbFQOZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCRMpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:45:06 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:54614
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfCRMpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czgg+JbSUmR31e3OvhrUpfotHEwZEblDP2xx68gjZV8=;
 b=cCbFQOZmX4DkPTwN40+zjhSelz26UAhb+4hkG/Jhfbq3BbZzzKQtfv3TiFqX1ovclPpqpgrOtzBDiXE/SAIghgPXRnvTbp5JjFASA+aTIX7cQ24Bq4E8UO/ls+2y1MisMz5YFFxZP1ePNk0aX+6HF5Ik+PKyR7z4o7Xca9LhQTE=
Received: from SN4PR0201CA0004.namprd02.prod.outlook.com
 (2603:10b6:803:2b::14) by MWHPR02MB2845.namprd02.prod.outlook.com
 (2603:10b6:300:108::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Mon, 18 Mar
 2019 12:45:03 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN4PR0201CA0004.outlook.office365.com
 (2603:10b6:803:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:45:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:45:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44532 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5rdV-0005An-QO; Mon, 18 Mar 2019 05:45:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5rdQ-0004G0-Mh; Mon, 18 Mar 2019 05:44:56 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICipeO006219;
        Mon, 18 Mar 2019 05:44:51 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h5rdL-0004Fa-Hg; Mon, 18 Mar 2019 05:44:51 -0700
Subject: Re: [PATCH] firmware: xilinx: fix debugfs write handler
To:     Jann Horn <jannh@google.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190218214309.29985-1-jannh@google.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0cb22dd7-0bb2-5181-4019-ad8561ccdefb@xilinx.com>
Date:   Mon, 18 Mar 2019 13:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
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
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(199004)(189003)(36386004)(336012)(478600001)(9786002)(229853002)(356004)(64126003)(486006)(446003)(11346002)(316002)(126002)(76176011)(476003)(2616005)(110136005)(44832011)(58126008)(426003)(305945005)(65956001)(65806001)(36756003)(6246003)(47776003)(31696002)(5660300002)(81166006)(81156014)(31686004)(8676002)(63266004)(106466001)(50466002)(14444005)(54906003)(4326008)(2906002)(8936002)(77096007)(23676004)(2486003)(26005)(230700001)(186003)(65826007)(106002)(42866002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2845;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61150cda-4f8c-4513-fd7d-08d6ab9f8a25
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MWHPR02MB2845;
X-MS-TrafficTypeDiagnostic: MWHPR02MB2845:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB284552986D99DCD5909CE6CEC6470@MWHPR02MB2845.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Upa7FMCzz985p1lK5W28mscOCTLYe6moiqpQvBIwu/oZSAN4xOv1r4ruwL0lw5wZBNMu9xeodW95DlP5ONP6IaaUl0gCWDKaIu2GMEC5ofMgOSFYsg3HKJLbdLdcVgakfnW1BpWRnCwegqiQXA3t/tFyC6FLmN/kqwlMfwkqfNAinG+6H9VpejBE5BoPRq6uZ6gmUgG7yjBEXnyotErj9OBw3h6hlMQHJSw+1ILP4+BjJ6JI1CGgLukph0rv05nt6Y7TQ4w2kAUuU+/iiHLBQh+1GCO6l31AiEd/1y+gsoX00PnjEEY8tfjihwIgaCwRc+4lKUY/mu264GMXEatthtJBLBXbSHH32VxJJ3k8PBxyPyCMja8OwkMDvLPQVss0ANhE3cZ51Lw4XTU9aDD6Xo0/YY/KQQ97pyMvbEDqRPw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:45:02.3667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61150cda-4f8c-4513-fd7d-08d6ab9f8a25
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2845
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

applied with Jolly's ack.

Thanks,
Michal
