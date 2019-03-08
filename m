Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B91C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB5320811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCHHJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:09:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfCHHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:09:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x28798j6121609
        for <linux-kernel@vger.kernel.org>; Fri, 8 Mar 2019 02:09:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r3g6hf9na-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 02:09:08 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 8 Mar 2019 07:08:52 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Mar 2019 07:08:50 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2878nNH31719442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 07:08:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B66A0A405C;
        Fri,  8 Mar 2019 07:08:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8483FA4054;
        Fri,  8 Mar 2019 07:08:49 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.166.171])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Mar 2019 07:08:49 +0000 (GMT)
Date:   Fri, 8 Mar 2019 08:08:47 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Joe Perches <joe@perches.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)
In-Reply-To: <d81a9133ad20d478dc8c14fbc8d1bacf4c8ffe94.camel@perches.com>
References: <d81a9133ad20d478dc8c14fbc8d1bacf4c8ffe94.camel@perches.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030807-0016-0000-0000-0000025F640F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030807-0017-0000-0000-000032B9F56F
Message-Id: <20190308080847.70910d18@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903080051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019 15:51:45 -0800
Joe Perches <joe@perches.com> wrote:

> IS_ENABLED should generally use CONFIG_ prefaced symbols and
> it doesn't appear as if there is a BLK_DEV_INITRD define.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/boot/mem_detect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/mem_detect.c b/arch/s390/boot/mem_detect.c
> index 4cb771ba13fa..5d316fe40480 100644
> --- a/arch/s390/boot/mem_detect.c
> +++ b/arch/s390/boot/mem_detect.c
> @@ -25,7 +25,7 @@ static void *mem_detect_alloc_extended(void)
>  {
>  	unsigned long offset = ALIGN(mem_safe_offset(), sizeof(u64));
> 
> -	if (IS_ENABLED(BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
>  	    INITRD_START < offset + ENTRIES_EXTENDED_MAX)
>  		offset = ALIGN(INITRD_START + INITRD_SIZE, sizeof(u64));
> 
> 

With more than the 255 embedded entries and a initrd that sits in the
wrong location that would have resulted in a corrupted ramdisk.
Nice catch, thanks. I'll add the patch to my queue.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

