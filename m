Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19985C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CD720717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfDYWR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:17:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfDYWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:17:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PMBndP122053
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 18:17:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s3kq2bt29-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 18:17:56 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Thu, 25 Apr 2019 23:17:56 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 23:17:52 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PMHpNj18088082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 22:17:51 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32938AC0AD;
        Thu, 25 Apr 2019 22:17:51 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA857AC0AC;
        Thu, 25 Apr 2019 22:17:49 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.155.229])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Apr 2019 22:17:49 +0000 (GMT)
Subject: Re: [PATCH v2] powerpc/pseries: Use correct event modifier in
 rtas_parse_epow_errlog()
To:     Yue Haibing <yuehaibing@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        npiggin@gmail.com, ganeshgr@linux.ibm.com, anton@samba.org,
        ruscur@russell.cc
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190423143533.26952-1-yuehaibing@huawei.com>
 <20190424021739.20916-1-yuehaibing@huawei.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Thu, 25 Apr 2019 15:17:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190424021739.20916-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042522-0040-0000-0000-000004E72284
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010995; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01194360; UDB=6.00626185; IPR=6.00975189;
 MB=3.00026600; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-25 22:17:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042522-0041-0000-0000-000008F322B9
Message-Id: <48912eeb-1c5b-f401-fd12-ed568bc371ea@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2019 07:17 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> rtas_parse_epow_errlog() should pass 'modifier' to
> handle_system_shutdown, because event modifier only use
> bottom 4 bits.
> 
> Fixes: 55fc0c561742 ("powerpc/pseries: Parse and handle EPOW interrupts")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>

> v2: fix compile issue by 'event_modifier'-->'modifier'
> ---
>  arch/powerpc/platforms/pseries/ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index c97d153..744604d 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -285,7 +285,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>  		break;
> 
>  	case EPOW_SYSTEM_SHUTDOWN:
> -		handle_system_shutdown(epow_log->event_modifier);
> +		handle_system_shutdown(modifier);
>  		break;
> 
>  	case EPOW_SYSTEM_HALT:
> 

