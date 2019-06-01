Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A2C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251D5271D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfFAKVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 06:21:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfFAKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 06:21:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x51AHBmw093251
        for <linux-kernel@vger.kernel.org>; Sat, 1 Jun 2019 06:21:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sunw2tb9h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 06:21:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 1 Jun 2019 11:21:09 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Jun 2019 11:21:07 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x51AL68J48234544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Jun 2019 10:21:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ABC142042;
        Sat,  1 Jun 2019 10:21:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F253942041;
        Sat,  1 Jun 2019 10:21:05 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  1 Jun 2019 10:21:05 +0000 (GMT)
Date:   Sat, 1 Jun 2019 12:21:04 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     xiaolinkui <xiaolinkui@kylinos.cn>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: s390: use struct_size() in kmalloc()
References: <1558077317-12201-1-git-send-email-xiaolinkui@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558077317-12201-1-git-send-email-xiaolinkui@kylinos.cn>
X-TM-AS-GCONF: 00
x-cbid: 19060110-0012-0000-0000-000003218158
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060110-0013-0000-0000-0000215A5618
Message-Id: <20190601102104.GA3600@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=44 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=874 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906010076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 03:15:17PM +0800, xiaolinkui wrote:
> Use the new struct_size() helper to keep code simple.
> 
> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
> ---
>  arch/s390/include/asm/idals.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
> index 15578fd..6fb7ace 100644
> --- a/arch/s390/include/asm/idals.h
> +++ b/arch/s390/include/asm/idals.h
> @@ -122,8 +122,7 @@ idal_buffer_alloc(size_t size, int page_order)
> 
>  	nr_ptrs = (size + IDA_BLOCK_SIZE - 1) >> IDA_SIZE_LOG;
>  	nr_chunks = (4096 << page_order) >> IDA_SIZE_LOG;
> -	ib = kmalloc(sizeof(struct idal_buffer) + nr_ptrs*sizeof(void *),
> -		     GFP_DMA | GFP_KERNEL);
> +	ib = kmalloc(struct_size(ib, data, nr_ptrs), GFP_DMA | GFP_KERNEL);
>  	if (ib == NULL)
>  		return ERR_PTR(-ENOMEM);
>  	ib->size = size;

Applied, thanks.

