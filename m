Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BFFC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B955A2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aNDp1czR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfJLIin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 04:38:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59660 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbfJLIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 04:36:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9C8Xvku036482;
        Sat, 12 Oct 2019 08:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=qG0XA2QNSQPw/WQBaemuXkNN8ScZn5BFYAgIJV3+FNA=;
 b=aNDp1czRwwdReQq095SL210Z+nRMwpNdK34phCF2hb3xFrD6ScFc/5sYIVRCb2mVvni2
 x2UhbjxXZ1RydIIZf3Y//XPpHeoRPP/2o96ow32sF/2mSL66mb/lyeXaF+yruARXDWwV
 7u0/giFk19fOY9iQkWNKOA4uXDaG+4CH0WljU1yHChv4ZAJUSCzRatXG06skIBUR48u9
 HMEVqjHeBwqqhb4k8x/OV0B71UrycUCpaNTynQ3HXC3fzWi0ucjStFYme8HT6J6AeRza
 YP5CXAh+ov0nxmMQh/Zh8iggBXzA0ivpwjWGlGVqQMY0RETYjVB03jP/nP2f1lWlanjp cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68u0rff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Oct 2019 08:35:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9C8XgXJ147032;
        Sat, 12 Oct 2019 08:35:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vk3xw8nw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Oct 2019 08:35:51 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9C8ZlrL026844;
        Sat, 12 Oct 2019 08:35:48 GMT
Received: from [10.191.25.133] (/10.191.25.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 12 Oct 2019 08:35:47 +0000
Subject: Re: [PATCH] acpi: Mute gcc warning
To:     linux-kernel@vger.kernel.org
Cc:     Josh Boyer <jwboyer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
References: <1569719633-32164-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <de8c201d-8a73-2b3f-fe1f-19d40e2ca77d@oracle.com>
Date:   Sat, 12 Oct 2019 16:35:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1569719633-32164-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910120080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910120080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while on this patch，still see this warning in daily build.
Will anybody be willing to review it? :)

Thanks
Zhenzhong

On 2019/9/29 9:13, Zhenzhong Duan wrote:
> When build with "EXTRA_CFLAGS=-Wall" gcc warns:
>
> arch/x86/boot/compressed/acpi.c:29:30: warning: get_cmdline_acpi_rsdp defined but not used [-Wunused-function]
>
> Fixes: 41fa1ee9c6d6 ("acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Josh Boyer <jwboyer@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>   arch/x86/boot/compressed/acpi.c | 48 ++++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 149795c..25019d4 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -21,30 +21,6 @@
>   struct mem_vector immovable_mem[MAX_NUMNODES*2];
>   
>   /*
> - * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
> - * digits, and '\0' for termination.
> - */
> -#define MAX_ADDR_LEN 19
> -
> -static acpi_physical_address get_cmdline_acpi_rsdp(void)
> -{
> -	acpi_physical_address addr = 0;
> -
> -#ifdef CONFIG_KEXEC
> -	char val[MAX_ADDR_LEN] = { };
> -	int ret;
> -
> -	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
> -	if (ret < 0)
> -		return 0;
> -
> -	if (kstrtoull(val, 16, &addr))
> -		return 0;
> -#endif
> -	return addr;
> -}
> -
> -/*
>    * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
>    * ACPI_TABLE_GUID are found, take the former, which has more features.
>    */
> @@ -298,6 +274,30 @@ acpi_physical_address get_rsdp_addr(void)
>   }
>   
>   #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
> +/*
> + * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
> + * digits, and '\0' for termination.
> + */
> +#define MAX_ADDR_LEN 19
> +
> +static acpi_physical_address get_cmdline_acpi_rsdp(void)
> +{
> +	acpi_physical_address addr = 0;
> +
> +#ifdef CONFIG_KEXEC
> +	char val[MAX_ADDR_LEN] = { };
> +	int ret;
> +
> +	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
> +	if (ret < 0)
> +		return 0;
> +
> +	if (kstrtoull(val, 16, &addr))
> +		return 0;
> +#endif
> +	return addr;
> +}
> +
>   /* Compute SRAT address from RSDP. */
>   static unsigned long get_acpi_srat_table(void)
>   {
