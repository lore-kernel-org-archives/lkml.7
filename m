Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7489C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F89321902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bs1Fc+qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfCWAJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:09:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59632 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCWAJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 20:09:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2N03d89186726;
        Sat, 23 Mar 2019 00:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JsewR+rEQJNLkaOGejcRRSalWo9h9s6Sg2idHE53oB4=;
 b=bs1Fc+qn7wL9BdWvPgAV+6w35J6Ui8EqhVRTfyQjmNHbjGjLgUCRmLJnlQ+WO9PXNvUD
 NpvvWQoWUZApf+Sa2e4adQ8xMB2f9p+hJbodGcFNMgVe9cFkd6z2ZBPeOu7NKpS60Z2D
 VvtkU1QgZ7CfpGGwn/HcqD6yk3Z3foiwLXfIhFrtahFqT+M1eacEOMdbVUzPtT+kqgIo
 svmvC7Z7L6FciANKE4SYyLTwBVcwBB+R+7avnIHBuBNnuxWMcvnKJ8RA9wo2IsixUCfD
 05YZlC75WT+4Jv+YI2aiDCFLNp9P/8W/XEvuMzb2WHBgQQ5Hd2JT7+ROjBXYWCd64bpO Wg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r8rjv8m0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Mar 2019 00:09:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2N098pq020674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Mar 2019 00:09:08 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2N097aQ004724;
        Sat, 23 Mar 2019 00:09:07 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Mar 2019 17:09:07 -0700
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
References: <15f3f7e6-5dce-6bbf-30af-7cffbd7bb0c3@oracle.com>
 <1553203217-11444-1-git-send-email-jdesfossez@digitalocean.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
Date:   Fri, 22 Mar 2019 17:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553203217-11444-1-git-send-email-jdesfossez@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9203 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903220172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/19 2:20 PM, Julien Desfossez wrote:
> On Tue, Mar 19, 2019 at 10:31 PM Subhra Mazumdar <subhra.mazumdar@oracle.com>
> wrote:
>> On 3/18/19 8:41 AM, Julien Desfossez wrote:
>>
> On further investigation, we could see that the contention is mostly in the
> way rq locks are taken. With this patchset, we lock the whole core if
> cpu.tag is set for at least one cgroup. Due to this, __schedule() is more or
> less serialized for the core and that attributes to the performance loss
> that we are seeing. We also saw that newidle_balance() takes considerably
> long time in load_balance() due to the rq spinlock contention. Do you think
> it would help if the core-wide locking was only performed when absolutely
> needed ?
>
Is the core wide lock primarily responsible for the regression? I ran 
upto patch
12 which also has the core wide lock for tagged cgroups and also calls
newidle_balance() from pick_next_task(). I don't see any regression.  Of 
course
the core sched version of pick_next_task() may be doing more but 
comparing with
the __pick_next_task() it doesn't look too horrible.
