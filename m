Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F1C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB16B205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfHSM4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:56:38 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:15920 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbfHSM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:56:38 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JCu9K9030104;
        Mon, 19 Aug 2019 12:56:13 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ufstss30v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 12:56:13 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 6A1D65D;
        Mon, 19 Aug 2019 12:56:12 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 824F04A;
        Mon, 19 Aug 2019 12:56:11 +0000 (UTC)
Date:   Mon, 19 Aug 2019 07:56:11 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     sivanich@hpe.com, jhubbard@nvidia.com, jglisse@redhat.com,
        ira.weiny@intel.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de,
        inux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH v6 1/2] sgi-gru: Convert put_page()
 to put_user_page*()
Message-ID: <20190819125611.GA5808@hpe.com>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>

On Mon, Aug 19, 2019 at 01:08:54AM +0530, Bharath Vedartham wrote:
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel-mentees@lists.linuxfoundation.org
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 4b713a8..61b3447 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
>  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
>  		return -EFAULT;
>  	*paddr = page_to_phys(page);
> -	put_page(page);
> +	put_user_page(page);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
