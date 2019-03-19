Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2562217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCSUjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:39:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726914AbfCSUjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:39:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JKYT39114232
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:39:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb5qvdqdb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:39:21 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 19 Mar 2019 20:39:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 20:39:14 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JKdFOQ48496670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 20:39:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D93D0AE051;
        Tue, 19 Mar 2019 20:39:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC7ECAE045;
        Tue, 19 Mar 2019 20:39:14 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Mar 2019 20:39:14 +0000 (GMT)
Date:   Tue, 19 Mar 2019 22:39:12 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH] sh: mm: make use of new memblocks_present() helper
References: <20190319180930.8231-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319180930.8231-1-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031920-0012-0000-0000-00000304DB9F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031920-0013-0000-0000-0000213BEC1B
Message-Id: <20190319203912.GA17966@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=809 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:09:30PM -0600, Logan Gunthorpe wrote:
> Cleanup the open coded for_each_memblock() loop that is equivalent
> to the new memblocks_present() helper.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/sh/mm/init.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> This is just a resend
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index a8e5c0e00fca..dc0ff41d602d 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -234,12 +234,7 @@ static void __init do_init_bootmem(void)
> 
>  	plat_mem_setup();
> 
> -	for_each_memblock(memory, reg) {
> -		int nid = memblock_get_region_node(reg);
> -
> -		memory_present(nid, memblock_region_memory_base_pfn(reg),
> -			memblock_region_memory_end_pfn(reg));
> -	}
> +	memblocks_present();
>  	sparse_init();
>  }
> 
> --
> 2.19.0
> 

-- 
Sincerely yours,
Mike.

