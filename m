Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBFBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ADF2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfCSOxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:53:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727468AbfCSOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:53:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JEovRQ015075
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:53:41 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rb1yvj9yg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:53:40 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mrochs@linux.ibm.com>;
        Tue, 19 Mar 2019 14:53:39 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 14:53:36 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JErZpd24314100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 14:53:35 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBC1B6E050;
        Tue, 19 Mar 2019 14:53:35 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AFCF6E04E;
        Tue, 19 Mar 2019 14:53:35 +0000 (GMT)
Received: from p8tul1-build.aus.stglabs.ibm.com (unknown [9.3.141.206])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Mar 2019 14:53:34 +0000 (GMT)
Date:   Tue, 19 Mar 2019 09:53:29 -0500
From:   "Matthew R. Ochs" <mrochs@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, "Manoj N. Kumar" <manoj@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/38] vfs: Convert ocxlflash to fs_context
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
 <155257984771.13720.11148732281013314260.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155257984771.13720.11148732281013314260.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19031914-8235-0000-0000-00000E6F96B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010786; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176643; UDB=6.00615460; IPR=6.00957330;
 MB=3.00026052; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-19 14:53:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031914-8236-0000-0000-000044D54914
Message-Id: <20190319145329.GA64258@p8tul1-build.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 04:10:47PM +0000, David Howells wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "Manoj N. Kumar" <manoj@linux.ibm.com>
> cc: "Matthew R. Ochs" <mrochs@linux.ibm.com>
> cc: Uma Krishnan <ukrishn@linux.ibm.com>
> cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> cc: linux-scsi@vger.kernel.org

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

> ---
> 
>  drivers/scsi/cxlflash/ocxl_hw.c |   21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> index 37b8dc60f5f6..a8d2cc6390c7 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -16,6 +16,7 @@
>  #include <linux/idr.h>
>  #include <linux/module.h>
>  #include <linux/mount.h>
> +#include <linux/fs_context.h>
>  #include <linux/poll.h>
>  #include <linux/sched/signal.h>
>  
> @@ -39,27 +40,17 @@ static const struct dentry_operations ocxlflash_fs_dops = {
>  	.d_dname	= simple_dname,
>  };
>  
> -/*
> - * ocxlflash_fs_mount() - mount the pseudo-filesystem
> - * @fs_type:	File system type.
> - * @flags:	Flags for the filesystem.
> - * @dev_name:	Device name associated with the filesystem.
> - * @data:	Data pointer.
> - *
> - * Return: pointer to the directory entry structure
> - */
> -static struct dentry *ocxlflash_fs_mount(struct file_system_type *fs_type,
> -					 int flags, const char *dev_name,
> -					 void *data)
> +static int ocxlflash_fs_init_fs_context(struct fs_context *fc)
>  {
> -	return mount_pseudo(fs_type, "ocxlflash:", NULL, &ocxlflash_fs_dops,
> -			    OCXLFLASH_FS_MAGIC);
> +	return vfs_init_pseudo_fs_context(fc, "ocxlflash:",
> +					  NULL, NULL,
> +					  &ocxlflash_fs_dops, OCXLFLASH_FS_MAGIC);
>  }
>  
>  static struct file_system_type ocxlflash_fs_type = {
>  	.name		= "ocxlflash",
>  	.owner		= THIS_MODULE,
> -	.mount		= ocxlflash_fs_mount,
> +	.init_fs_context = ocxlflash_fs_init_fs_context,
>  	.kill_sb	= kill_anon_super,
>  };
>  
> 

