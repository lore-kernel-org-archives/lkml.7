Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230CBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8C02070D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Utg/ObYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfEWQop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:44:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43046 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfEWQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:44:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4NGdNaA130756;
        Thu, 23 May 2019 16:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wFYuHv7CedBy3XdWoyhYc9mb6Paut9BcOFnjkADVXQU=;
 b=Utg/ObYContxtSeTc8itGdN6S3xIdmG4c0zsB2NyjPtSn2ywrj4hLpWXs3Y+n+b7XjAs
 aZVNNrt5oPmUgeqcdQzKvV+ZYgBhqUjBAmXkW70v3fkNYkiZpzvx68Esfz6jzgSrXO0J
 b1doAXWNN2tSqTefpol8p3Y6jSCFokMyBWfWZfISbRThg54KDULhtjMaQmfHQrCWCnfU
 IGFuAAwBuJMe5Y/xOqbMEBRlZT+2740yrgfdhoXmWjqsPP3Gpnvr3hD8aUOLAW1pcl6U
 EMdSrTa6uZ0MJJSgqQgK5ehGP2yc80OgSZeZ8bqt9sKLpBoIOa2dTM1yDLH9LtVFc0ki wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2smsk5kq7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 16:44:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4NGgjoc016653;
        Thu, 23 May 2019 16:44:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 2smsh2c2mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 May 2019 16:44:02 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4NGhmCw019364;
        Thu, 23 May 2019 16:44:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2smsh2c2mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 16:44:01 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4NGhxd9014214;
        Thu, 23 May 2019 16:44:00 GMT
Received: from wengwanwork.cn.oracle.com (/10.211.52.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 May 2019 16:43:59 +0000
Subject: Re: [Ocfs2-devel] [PATCH V3 2/2] ocfs2: add locking filter debugfs
 file
To:     Gang He <ghe@suse.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, jiangqi903@gmail.com,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20190523104047.14794-1-ghe@suse.com>
 <20190523104047.14794-2-ghe@suse.com>
From:   Wengang <wen.gang.wang@oracle.com>
Message-ID: <da93442d-3333-5bd6-ce0a-edb66a58109d@oracle.com>
Date:   Thu, 23 May 2019 09:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190523104047.14794-2-ghe@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905230113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

Could you paste an example of outputs before patch VS that after patch?
I think that would directly show what the patch does.

thanks,
wengang

On 05/23/2019 03:40 AM, Gang He wrote:
> Add locking filter debugfs file, which is used to filter lock
> resources dump from locking_state debugfs file.
> We use d_filter_secs field to filter lock resources dump,
> the default d_filter_secs(0) value filters nothing,
> otherwise, only dump the last N seconds active lock resources.
> This enhancement can avoid dumping lots of old records.
> The d_filter_secs value can be changed via locking_filter file.
>
> Compared with v2, ocfs2_dlm_init_debug() returns directly with
> error when creating locking filter debugfs file is failed, since
> ocfs2_dlm_shutdown_debug() will handle this failure perfectly.
> Compared with v1, the main change is to add CONFIG_OCFS2_FS_STATS
> macro definition judgment.
>
> Signed-off-by: Gang He <ghe@suse.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>   fs/ocfs2/dlmglue.c | 36 ++++++++++++++++++++++++++++++++++++
>   fs/ocfs2/ocfs2.h   |  2 ++
>   2 files changed, 38 insertions(+)
>
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index dccf4136f8c1..fbe4562cf4fe 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -3006,6 +3006,8 @@ struct ocfs2_dlm_debug *ocfs2_new_dlm_debug(void)
>   	kref_init(&dlm_debug->d_refcnt);
>   	INIT_LIST_HEAD(&dlm_debug->d_lockres_tracking);
>   	dlm_debug->d_locking_state = NULL;
> +	dlm_debug->d_locking_filter = NULL;
> +	dlm_debug->d_filter_secs = 0;
>   out:
>   	return dlm_debug;
>   }
> @@ -3104,11 +3106,33 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>   {
>   	int i;
>   	char *lvb;
> +	u32 now, last = 0;
>   	struct ocfs2_lock_res *lockres = v;
> +	struct ocfs2_dlm_debug *dlm_debug =
> +			((struct ocfs2_dlm_seq_priv *)m->private)->p_dlm_debug;
>   
>   	if (!lockres)
>   		return -EINVAL;
>   
> +	if (dlm_debug->d_filter_secs) {
> +		now = ktime_to_timespec(ktime_get()).tv_sec;
> +#ifdef CONFIG_OCFS2_FS_STATS
> +		if (lockres->l_lock_prmode.ls_last >
> +		    lockres->l_lock_exmode.ls_last)
> +			last = lockres->l_lock_prmode.ls_last;
> +		else
> +			last = lockres->l_lock_exmode.ls_last;
> +#endif
> +		/*
> +		 * Use d_filter_secs field to filter lock resources dump,
> +		 * the default d_filter_secs(0) value filters nothing,
> +		 * otherwise, only dump the last N seconds active lock
> +		 * resources.
> +		 */
> +		if ((now - last) > dlm_debug->d_filter_secs)
> +			return 0;
> +	}
> +
>   	seq_printf(m, "0x%x\t", OCFS2_DLM_DEBUG_STR_VERSION);
>   
>   	if (lockres->l_type == OCFS2_LOCK_TYPE_DENTRY)
> @@ -3258,6 +3282,17 @@ static int ocfs2_dlm_init_debug(struct ocfs2_super *osb)
>   		goto out;
>   	}
>   
> +	dlm_debug->d_locking_filter = debugfs_create_u32("locking_filter",
> +						0600,
> +						osb->osb_debug_root,
> +						&dlm_debug->d_filter_secs);
> +	if (!dlm_debug->d_locking_filter) {
> +		ret = -EINVAL;
> +		mlog(ML_ERROR,
> +		     "Unable to create locking filter debugfs file.\n");
> +		goto out;
> +	}
> +
>   	ocfs2_get_dlm_debug(dlm_debug);
>   out:
>   	return ret;
> @@ -3269,6 +3304,7 @@ static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
>   
>   	if (dlm_debug) {
>   		debugfs_remove(dlm_debug->d_locking_state);
> +		debugfs_remove(dlm_debug->d_locking_filter);
>   		ocfs2_put_dlm_debug(dlm_debug);
>   	}
>   }
> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
> index 8efa022684f4..f4da51099889 100644
> --- a/fs/ocfs2/ocfs2.h
> +++ b/fs/ocfs2/ocfs2.h
> @@ -237,6 +237,8 @@ struct ocfs2_orphan_scan {
>   struct ocfs2_dlm_debug {
>   	struct kref d_refcnt;
>   	struct dentry *d_locking_state;
> +	struct dentry *d_locking_filter;
> +	u32 d_filter_secs;
>   	struct list_head d_lockres_tracking;
>   };
>   

