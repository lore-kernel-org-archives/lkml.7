Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7183BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A79218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCVHnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:43:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfCVHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:42:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2M7fDdJ145257
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:42:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rcu6egueq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:42:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Fri, 22 Mar 2019 07:42:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 07:42:45 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2M7gqe758654926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 07:42:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DA28A4051;
        Fri, 22 Mar 2019 07:42:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3B7FA404D;
        Fri, 22 Mar 2019 07:42:51 +0000 (GMT)
Received: from [9.145.3.179] (unknown [9.145.3.179])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 07:42:51 +0000 (GMT)
Subject: Re: [PATCH 13/38] vfs: Convert cxl to fs_context
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
 <155257984031.13720.1656009200478611751.stgit@warthog.procyon.org.uk>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Fri, 22 Mar 2019 08:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <155257984031.13720.1656009200478611751.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032207-4275-0000-0000-0000031DF369
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032207-4276-0000-0000-0000382C7DFC
Message-Id: <33d93ba3-166f-abe0-253d-a3e81e697563@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/03/2019 à 17:10, David Howells a écrit :
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Frederic Barrat <fbarrat@linux.ibm.com>
> cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> cc: linuxppc-dev@lists.ozlabs.org
> ---

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


> 
>   drivers/misc/cxl/api.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 750470ef2049..395e9a88e6ba 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -13,6 +13,7 @@
>   #include <misc/cxl.h>
>   #include <linux/module.h>
>   #include <linux/mount.h>
> +#include <linux/fs_context.h>
>   #include <linux/sched/mm.h>
>   #include <linux/mmu_context.h>
>   
> @@ -41,17 +42,16 @@ static const struct dentry_operations cxl_fs_dops = {
>   	.d_dname	= simple_dname,
>   };
>   
> -static struct dentry *cxl_fs_mount(struct file_system_type *fs_type, int flags,
> -				const char *dev_name, void *data)
> +static int cxl_fs_init_fs_context(struct fs_context *fc)
>   {
> -	return mount_pseudo(fs_type, "cxl:", NULL, &cxl_fs_dops,
> -			CXL_PSEUDO_FS_MAGIC);
> +	return vfs_init_pseudo_fs_context(fc, "cxl:", NULL, NULL,
> +					  &cxl_fs_dops, CXL_PSEUDO_FS_MAGIC);
>   }
>   
>   static struct file_system_type cxl_fs_type = {
>   	.name		= "cxl",
>   	.owner		= THIS_MODULE,
> -	.mount		= cxl_fs_mount,
> +	.init_fs_context = cxl_fs_init_fs_context,
>   	.kill_sb	= kill_anon_super,
>   };
>   
> 

