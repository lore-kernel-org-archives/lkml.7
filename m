Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDFAC4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D073421D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404884AbfIYLlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:41:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404639AbfIYLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:41:49 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8PBapR8004142
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 07:41:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v861ykpt8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 07:41:48 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Wed, 25 Sep 2019 12:41:46 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Sep 2019 12:41:40 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8PBfdjS42991868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 11:41:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 272FF11C04A;
        Wed, 25 Sep 2019 11:41:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F69E11C04C;
        Wed, 25 Sep 2019 11:41:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Sep 2019 11:41:38 +0000 (GMT)
Received: from [9.81.212.159] (unknown [9.81.212.159])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CF9EAA01BD;
        Wed, 25 Sep 2019 21:41:23 +1000 (AEST)
Subject: Re: [PATCH 1/5] powerpc: Add OPAL calls for LPC memory alloc/release
To:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190917014307.30485-1-alastair@au1.ibm.com>
 <20190917014307.30485-2-alastair@au1.ibm.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Wed, 25 Sep 2019 13:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917014307.30485-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092511-0020-0000-0000-000003716B51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092511-0021-0000-0000-000021C73120
Message-Id: <70d4372d-b421-893b-091d-c00ee7cce4b1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/9/19 3:42 am, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Add OPAL calls for LPC memory alloc/release
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

This needs rebasing, but apart from that.

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
>   arch/powerpc/include/asm/opal-api.h        | 4 +++-
>   arch/powerpc/include/asm/opal.h            | 3 +++
>   arch/powerpc/platforms/powernv/opal-call.c | 2 ++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 383242eb0dea..c58161cd7cfb 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -208,7 +208,9 @@
>   #define OPAL_HANDLE_HMI2			166
>   #define	OPAL_NX_COPROC_INIT			167
>   #define OPAL_XIVE_GET_VP_STATE			170
> -#define OPAL_LAST				170
> +#define OPAL_NPU_MEM_ALLOC			171
> +#define OPAL_NPU_MEM_RELEASE			172
> +#define OPAL_LAST				172
>   
>   #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>   #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 57bd029c715e..8c957a003be4 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -39,6 +39,9 @@ int64_t opal_npu_spa_clear_cache(uint64_t phb_id, uint32_t bdfn,
>   				uint64_t PE_handle);
>   int64_t opal_npu_tl_set(uint64_t phb_id, uint32_t bdfn, long cap,
>   			uint64_t rate_phys, uint32_t size);
> +int64_t opal_npu_mem_alloc(uint64_t phb_id, uint32_t bdfn,
> +			uint64_t size, uint64_t *bar);
> +int64_t opal_npu_mem_release(uint64_t phb_id, uint32_t bdfn);
>   int64_t opal_console_write(int64_t term_number, __be64 *length,
>   			   const uint8_t *buffer);
>   int64_t opal_console_read(int64_t term_number, __be64 *length,
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 29ca523c1c79..09a280446507 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -287,3 +287,5 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
>   OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
>   OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
>   OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
> +OPAL_CALL(opal_npu_mem_alloc,			OPAL_NPU_MEM_ALLOC);
> +OPAL_CALL(opal_npu_mem_release,			OPAL_NPU_MEM_RELEASE);
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

