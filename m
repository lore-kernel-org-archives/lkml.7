Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C43AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6537B2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfLLPQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:16:47 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:41218 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729013AbfLLPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:16:46 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCF8WdN030734;
        Thu, 12 Dec 2019 15:16:14 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 2wuk54adxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 15:16:13 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id BA22C66;
        Thu, 12 Dec 2019 15:16:12 +0000 (UTC)
Received: from [16.116.160.152] (unknown [16.116.160.152])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id F0F604F;
        Thu, 12 Dec 2019 15:16:09 +0000 (UTC)
Subject: Re: [PATCH] x86/platform/uv: avoid unused variable warning
To:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
References: <20191212135815.4176658-1-arnd@arndb.de>
 <20191212145432.GA15634@infradead.org>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <192a2aa9-5c50-bb8d-4b0f-95eb87de48c0@hpe.com>
Date:   Thu, 12 Dec 2019 07:16:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191212145432.GA15634@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 12/12/2019 6:54 AM, Christoph Hellwig wrote:
> Instead of that maybe_unused mess please just use good old ifdefs.
> 
>>   	if (hubless)
>> -		proc_version_fops.open = proc_hubless_open;
>> +		proc_create_single("hubless", 0, pde, proc_hubless_show);
>>   	else
>> -		proc_version_fops.open = proc_hubbed_open;
>> +		proc_create_single("hubbed", 0, pde, proc_hubbed_show);
>>   }
> 
> Or someone could figure out what happens if we turn the
> proc_create_single stub into an inline function instead of the
> define.  That makes it used at a syntactic level, the big question is
> if the compiler is smart enough to optimize away the unused callback
> still.
> 

Yes, if CONFIG_PROC_FS is undefined, then this whole section can be 
removed since it's sole purpose is to set up the /proc/ interface. 
Something like this should suffice:

> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -1533,6 +1533,7 @@ static void check_efi_reboot(void)
>                 reboot_type = BOOT_ACPI;
>  }
> 
> +#ifdef CONFIG_PROC_FS
>  /* Setup user proc fs files */
>  static int proc_hubbed_show(struct seq_file *file, void *data)
>  {
> @@ -1595,6 +1596,14 @@ static __init void uv_setup_proc_files(i
>                 proc_version_fops.open = proc_hubbed_open;
>  }
> 
> +#else /* !CONFIG_PROC_FS */
> +
> +static __init void uv_setup_proc_files(int hubless)
> +{
> +}
> +
> +#endif /* !CONFIG_PROC_FS */
> +
>  /* Initialize UV hubless systems */
>  static __init int uv_system_init_hubless(void)
>  {
