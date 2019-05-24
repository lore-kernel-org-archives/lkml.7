Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C8BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587BA217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zAMh4vLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbfEXTxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:53:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfEXTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:53:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OJnMJ0064336;
        Fri, 24 May 2019 19:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=aD5lIz4S5DcWGmDB5gw9KrDZWimDr6bYMSbzU7GZoAI=;
 b=zAMh4vLLGP04GUagKaWof9gdEM7JeK5pQFj3XVLfNFiAk46Go/Z0QOvYixJS1BRAUu4d
 BOv5HcQ2XndYyFCcSVMDGdKOq6ymaF5hoFsR4iShCrIKwmzwb5y36X+gIax24i0qgrFE
 957fzrZ2WgpmCH5j5EN1pFO0nKd5LcriArR277W3xFDTXF1HVO7De9UKoq72W6jpiWzO
 xdSSWgnEPdMoaGHpCa6TRCU7iqIYVg+uoHeqgfxhVum6TAX6THS1VPsDg9HfmRGBTvnn
 R+iM6znGpGWj8TeAUyvVXhK8N5AelLhvVbZg8xs2HoRpufnp250GfUmuSFe3/X2H09Ql 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2smsk5k52q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 19:52:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OJpjUu010094;
        Fri, 24 May 2019 19:52:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2smsgu2jhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 May 2019 19:52:47 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4OJqlqd011608;
        Fri, 24 May 2019 19:52:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2smsgu2jhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 19:52:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4OJqi9V020054;
        Fri, 24 May 2019 19:52:45 GMT
Received: from [10.159.247.224] (/10.159.247.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 19:52:44 +0000
Subject: Re: [Ocfs2-devel] [PATCH V3 2/2] ocfs2: add locking filter debugfs
 file
To:     Gang He <ghe@suse.com>
Cc:     jlbec@evilplan.org, mark@fasheh.com, jiangqi903@gmail.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20190523104047.14794-1-ghe@suse.com>
 <20190523104047.14794-2-ghe@suse.com>
 <da93442d-3333-5bd6-ce0a-edb66a58109d@oracle.com>
 <5CE753AB020000F900067E5D@prv1-mh.provo.novell.com>
From:   Wengang Wang <wen.gang.wang@oracle.com>
Organization: Oracle Corporation
Message-ID: <bcdefc65-7173-8911-3ba1-197b064b5fa5@oracle.com>
Date:   Fri, 24 May 2019 12:52:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5CE753AB020000F900067E5D@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

OK, I was thinking you are dumping the new last access time field too.

thanks,
wengang

On 2019/5/23 19:15, Gang He wrote:
> Hello Wengang,
>
> This patch is used to add a filter attribute(the default value is 0), the kernel module can use this attribute value to filter the lock resources dumping.
> By default(the value is 0), the kernel module does not filter any lock resources dumping, the behavior is like before.
> If the user set a value(N) of this attribute, the kernel module will only dump the latest N seconds active lock resources, this will avoid dumping lots of inactive lock resources.
>
> Thanks
> Gang
>
>>>> On 2019/5/24 at 0:43, in message
> <da93442d-3333-5bd6-ce0a-edb66a58109d@oracle.com>, Wengang
> <wen.gang.wang@oracle.com> wrote:
>> Hi Gang,
>>
>> Could you paste an example of outputs before patch VS that after patch?
>> I think that would directly show what the patch does.
>>
>> thanks,
>> wengang
>>
>> On 05/23/2019 03:40 AM, Gang He wrote:
>>> Add locking filter debugfs file, which is used to filter lock
>>> resources dump from locking_state debugfs file.
>>> We use d_filter_secs field to filter lock resources dump,
>>> the default d_filter_secs(0) value filters nothing,
>>> otherwise, only dump the last N seconds active lock resources.
>>> This enhancement can avoid dumping lots of old records.
>>> The d_filter_secs value can be changed via locking_filter file.
>>>
>>> Compared with v2, ocfs2_dlm_init_debug() returns directly with
>>> error when creating locking filter debugfs file is failed, since
>>> ocfs2_dlm_shutdown_debug() will handle this failure perfectly.
>>> Compared with v1, the main change is to add CONFIG_OCFS2_FS_STATS
>>> macro definition judgment.
>>>
>>> Signed-off-by: Gang He <ghe@suse.com>
>>> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>>> ---
>>>    fs/ocfs2/dlmglue.c | 36 ++++++++++++++++++++++++++++++++++++
>>>    fs/ocfs2/ocfs2.h   |  2 ++
>>>    2 files changed, 38 insertions(+)
>>>
>>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>>> index dccf4136f8c1..fbe4562cf4fe 100644
>>> --- a/fs/ocfs2/dlmglue.c
>>> +++ b/fs/ocfs2/dlmglue.c
>>> @@ -3006,6 +3006,8 @@ struct ocfs2_dlm_debug *ocfs2_new_dlm_debug(void)
>>>    	kref_init(&dlm_debug->d_refcnt);
>>>    	INIT_LIST_HEAD(&dlm_debug->d_lockres_tracking);
>>>    	dlm_debug->d_locking_state = NULL;
>>> +	dlm_debug->d_locking_filter = NULL;
>>> +	dlm_debug->d_filter_secs = 0;
>>>    out:
>>>    	return dlm_debug;
>>>    }
>>> @@ -3104,11 +3106,33 @@ static int ocfs2_dlm_seq_show(struct seq_file *m,
>> void *v)
>>>    {
>>>    	int i;
>>>    	char *lvb;
>>> +	u32 now, last = 0;
>>>    	struct ocfs2_lock_res *lockres = v;
>>> +	struct ocfs2_dlm_debug *dlm_debug =
>>> +			((struct ocfs2_dlm_seq_priv *)m->private)->p_dlm_debug;
>>>    
>>>    	if (!lockres)
>>>    		return -EINVAL;
>>>    
>>> +	if (dlm_debug->d_filter_secs) {
>>> +		now = ktime_to_timespec(ktime_get()).tv_sec;
>>> +#ifdef CONFIG_OCFS2_FS_STATS
>>> +		if (lockres->l_lock_prmode.ls_last >
>>> +		    lockres->l_lock_exmode.ls_last)
>>> +			last = lockres->l_lock_prmode.ls_last;
>>> +		else
>>> +			last = lockres->l_lock_exmode.ls_last;
>>> +#endif
>>> +		/*
>>> +		 * Use d_filter_secs field to filter lock resources dump,
>>> +		 * the default d_filter_secs(0) value filters nothing,
>>> +		 * otherwise, only dump the last N seconds active lock
>>> +		 * resources.
>>> +		 */
>>> +		if ((now - last) > dlm_debug->d_filter_secs)
>>> +			return 0;
>>> +	}
>>> +
>>>    	seq_printf(m, "0x%x\t", OCFS2_DLM_DEBUG_STR_VERSION);
>>>    
>>>    	if (lockres->l_type == OCFS2_LOCK_TYPE_DENTRY)
>>> @@ -3258,6 +3282,17 @@ static int ocfs2_dlm_init_debug(struct ocfs2_super
>> *osb)
>>>    		goto out;
>>>    	}
>>>    
>>> +	dlm_debug->d_locking_filter = debugfs_create_u32("locking_filter",
>>> +						0600,
>>> +						osb->osb_debug_root,
>>> +						&dlm_debug->d_filter_secs);
>>> +	if (!dlm_debug->d_locking_filter) {
>>> +		ret = -EINVAL;
>>> +		mlog(ML_ERROR,
>>> +		     "Unable to create locking filter debugfs file.\n");
>>> +		goto out;
>>> +	}
>>> +
>>>    	ocfs2_get_dlm_debug(dlm_debug);
>>>    out:
>>>    	return ret;
>>> @@ -3269,6 +3304,7 @@ static void ocfs2_dlm_shutdown_debug(struct
>> ocfs2_super *osb)
>>>    
>>>    	if (dlm_debug) {
>>>    		debugfs_remove(dlm_debug->d_locking_state);
>>> +		debugfs_remove(dlm_debug->d_locking_filter);
>>>    		ocfs2_put_dlm_debug(dlm_debug);
>>>    	}
>>>    }
>>> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
>>> index 8efa022684f4..f4da51099889 100644
>>> --- a/fs/ocfs2/ocfs2.h
>>> +++ b/fs/ocfs2/ocfs2.h
>>> @@ -237,6 +237,8 @@ struct ocfs2_orphan_scan {
>>>    struct ocfs2_dlm_debug {
>>>    	struct kref d_refcnt;
>>>    	struct dentry *d_locking_state;
>>> +	struct dentry *d_locking_filter;
>>> +	u32 d_filter_secs;
>>>    	struct list_head d_lockres_tracking;
>>>    };
>>>    
