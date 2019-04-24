Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFA920811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KXIpJa9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfDXO3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:29:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59116 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDXO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:29:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OEORte068948;
        Wed, 24 Apr 2019 14:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=oY1ord+Lme18r5cTWR+elxrt0Fz3inO6k/ATmNNr7Uc=;
 b=KXIpJa9ub20F5bqyCnAs8cxsTRjRMLjy9i/6Nd0k0ihE+apuO1ACmBzSXnqMf/gRuWjf
 mW1eG4ogCcIqfj4MOAF4yCmS7peDp9vOszFETqP9C0TejXzzl2JLYuV2+4GvizcwTolj
 9eZemNscdH/8PzhJYNT4h0QICwwJ9bc7F+/wij5sG/CCUbf2YqRS2qlzsu05FaeejvsS
 LBu+FQzGpFTJgCeUWUXyTU6mr1A1PO7p1PdgfheBa1IBLeZXZ5YqPJ0tEg5YLrgWqEBL
 RbgcC499v8RTBGG9H4O/T09rGvn8TIe3L4sUqO2bC7dLmKY6OZ4pGbaVN2KpZYQnI/1v Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ryrxd2xbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:28:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OESj3l181472;
        Wed, 24 Apr 2019 14:28:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s0dwevfqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:28:45 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3OESdQW024688;
        Wed, 24 Apr 2019 14:28:39 GMT
Received: from kadam (/196.111.187.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 07:28:38 -0700
Date:   Wed, 24 Apr 2019 17:28:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oscar Gomez Fuente <oscargomezf@gmail.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        arve@android.com, joel@joelfernandes.org, maco@android.com,
        sumit.semwal@linaro.org, christian@brauner.io
Subject: Re: [PATCH] staging: ion: solve warning symbol was not declared
Message-ID: <20190424142817.GD14798@kadam>
References: <1555958967-29149-1-git-send-email-oscargomezf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555958967-29149-1-git-send-email-oscargomezf@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904240113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 08:49:27PM +0200, Oscar Gomez Fuente wrote:
> These changes solve warning symbol was not declared in the functions:
> ion_carveout_heap_create and ion_chunk_heap_create
> 
> Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
> ---
>  drivers/staging/android/ion/ion_carveout_heap.c | 2 +-
>  drivers/staging/android/ion/ion_chunk_heap.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
> index bb9d614..3f359ae 100644
> --- a/drivers/staging/android/ion/ion_carveout_heap.c
> +++ b/drivers/staging/android/ion/ion_carveout_heap.c
> @@ -103,7 +103,7 @@ static struct ion_heap_ops carveout_heap_ops = {
>  	.unmap_kernel = ion_heap_unmap_kernel,
>  };
>  
> -struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size)
> +static inline struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size)

Why are you making it inline?  Btw, normally we just leave it for the
compiler to choose which functions to make inline.

regards,
dan carpenter

