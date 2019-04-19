Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C55C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EBB2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o27F+/c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfDSXUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:20:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfDSXUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:20:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3JNDjbC179039;
        Fri, 19 Apr 2019 23:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BNAxCP6a8V/4iwmHgRTMO53ujJDTIVgc2c3SBMgPDcI=;
 b=o27F+/c8AGokVwK3C3jJjfyf/ENldbyUrrOlOgwvzl2g0fbPb0W6TDigUuxe0fCmQKT/
 k/foe60KBkaOdrk6HsVexLKO0Jh0TgFRvEEW7QjO4ThtYRr8SKp4uXF4QQ2M/INqOagS
 qm7SHiMHuavZ0aifRlq5rIgbackPjMQNdVFI7O4hDx/HDCAdqz4+YTw/kwYw8COijcrw
 qQg261x5bCY9Yhw2MuHu7Zcvse8YGu68xkJasfvCgGJul/R4WqeT8P6qnt/Io7sJz4DV
 qMdnYIhvDEsJO9eDY1hAGBwUzW5h/jChWRrCxbmLwIS8vThzE8JwlofriDkZW+BdZHpG KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ryjv90uy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 23:19:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3JNJ7MW039776;
        Fri, 19 Apr 2019 23:19:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ryjurksy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 23:19:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3JNJmOa008620;
        Fri, 19 Apr 2019 23:19:48 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Apr 2019 23:19:47 +0000
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <20190218173514.667598558@infradead.org>
 <1554835135-11814-1-git-send-email-jdesfossez@digitalocean.com>
 <3514bb97-33bc-3a14-3f15-767682b2f035@oracle.com>
 <20190419084027.GA16074@gmail.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <2ee47140-d527-290f-c8bc-4c4ebcf49f50@oracle.com>
Date:   Fri, 19 Apr 2019 16:16:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190419084027.GA16074@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9232 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904190160
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9232 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904190160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/19 1:40 AM, Ingo Molnar wrote:
> * Subhra Mazumdar <subhra.mazumdar@oracle.com> wrote:
>
>> I see similar improvement with this patch as removing the condition I
>> earlier mentioned. So that's not needed. I also included the patch for the
>> priority fix. For 2 DB instances, HT disabling stands at -22% for 32 users
>> (from earlier emails).
>>
>>
>> 1 DB instance
>>
>> users  baseline   %idle    core_sched %idle
>> 16     1          84       -4.9% 84
>> 24     1          76       -6.7% 75
>> 32     1          69       -2.4% 69
>>
>> 2 DB instance
>>
>> users  baseline   %idle    core_sched %idle
>> 16     1          66       -19.5% 69
>> 24     1          54       -9.8% 57
>> 32     1          42       -27.2%        48
> So HT disabling slows down the 2DB instance by -22%, while core-sched
> slows it down by -27.2%?
>
> Would it be possible to see all the results in two larger tables (1 DB
> instance and 2 DB instance) so that we can compare the performance of the
> 3 kernel variants with each other:
>
>   - "vanilla +HT": Hyperthreading enabled,  vanilla scheduler
>   - "vanilla -HT": Hyperthreading disabled, vanilla scheduler
>   - "core_sched":  Hyperthreading enabled,  core-scheduling enabled
>
> ?
>
> Thanks,
>
> 	Ingo
Following are the numbers. Disabling HT gives improvement in some cases.

1 DB instance

users  vanilla+HT   core_sched vanilla-HT
16     1            -4.9% -11.7%
24     1            -6.7% +13.7%
32     1            -2.4% +8%

2 DB instance

users  vanilla+HT   core_sched vanilla-HT
16     1            -19.5% +5.6%
24     1            -9.8% +3.5%
32     1            -27.2%        -22.8%
