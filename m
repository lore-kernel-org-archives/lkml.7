Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3558C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A0420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNo8gYj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfCFHcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:32:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35098 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfCFHcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:32:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x267So1M061784;
        Wed, 6 Mar 2019 07:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6Znb0plCkzY9WefoMZi7sUrmh49dgexVTHFeb/yTavc=;
 b=PNo8gYj2xX9Cd503/Yo527SwPW/to1whpN7J6Y5B9fxgFkX+VHrULFoWaxfnBo4xErmD
 Xhe2u/6WnVZgFeOqEpDxXzJ93OiZC49y2reBki9ulNRU0Tmztod4cDSTbicAl+POYdoQ
 nLyYPLugfS4+/6q2GUXgUg7oPUfmfojjQ7LnGsJcxbzuu83HpvHf9FxhgCHT7hGLCbE4
 iGuWEddPJXN3tLIhmcVDgSxcDRhv9gyy7NCXLoJPQtYyq2ENnIXZ9iHHk6TreSi0IkfA
 vkbUwhFuTSsnClwiV43D4tB1NZv6BevRfzL7Z0gdQPGiNKnJ1rLVyxUEgKUxDms4EloQ Dg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qyjfrhxbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 07:31:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x267Vwev012028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 07:31:58 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x267VvLN021433;
        Wed, 6 Mar 2019 07:31:57 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Mar 2019 23:31:57 -0800
Subject: Re: [Xen-devel] [PATCH v4.9 1/1] jiffies: use jiffies64_to_nsecs() to
 fix 100% steal usage for xen vcpu hotplug
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     stable@vger.kernel.org
Cc:     jgross@suse.com, herbert.van.den.bergh@oracle.com,
        sstabellini@kernel.org, sboyd@kernel.org, frederic@kernel.org,
        joe.jin@oracle.com, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, tglx@linutronix.de
References: <1551772744-524-1-git-send-email-dongli.zhang@oracle.com>
Message-ID: <15c804c0-eeb1-2adb-9cbf-4a28d39983a0@oracle.com>
Date:   Wed, 6 Mar 2019 15:35:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1551772744-524-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9186 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Joe Jin's reminding, this patch is applicable to mainline linux
kernel, although there is no issue due to this kind of bug in mainline kernel.

Therefore, can I first submit this patch to mainline kernel and then backport it
to stable linux with more detailed explanation how the issue is reproduced on xen?

This would help synchronize stable with mainline better.

Thank you very much!

Dongli Zhang

On 3/5/19 3:59 PM, Dongli Zhang wrote:
> [ Not relevant upstream, therefore no upstream commit. ]
> 
> To fix, use jiffies64_to_nsecs() directly instead of deriving the result
> according to jiffies_to_usecs().
> 
> As the return type of jiffies_to_usecs() is 'unsigned int', when the return
> value is more than the size of 'unsigned int', the leading 32 bits would be
> discarded.
> 
> Suppose USEC_PER_SEC=1000000L and HZ=1000, below are the expected and
> actual incorrect result of jiffies_to_usecs(0x7770ef70):
> 
> - expected  : jiffies_to_usecs(0x7770ef70) = 0x000001d291274d80
> - incorrect : jiffies_to_usecs(0x7770ef70) = 0x0000000091274d80
> 
> The leading 0x000001d200000000 is discarded.
> 
> After xen vcpu hotplug and when the new vcpu steal clock is calculated for
> the first time, the result of this_rq()->prev_steal_time in
> steal_account_process_tick() would be far smaller than the expected
> value, due to that jiffies_to_usecs() discards the leading 32 bits.
> 
> As a result, the diff between current steal and this_rq()->prev_steal_time
> is always very large. Steal usage would become 100% when the initial steal
> clock obtained from xen hypervisor is very large during xen vcpu hotplug,
> that is, when the guest is already up for a long time.
> 
> The bug can be detected by doing the following:
> 
> * Boot xen guest with vcpus=2 and maxvcpus=4
> * Leave the guest running for a month so that the initial steal clock for
>   the new vcpu would be very large
> * Hotplug 2 extra vcpus
> * The steal time of new vcpus in /proc/stat would increase abnormally and
>   sometimes steal usage in top can become 100%
> 
> This was incidentally fixed in the patch set starting by
> commit 93825f2ec736 ("jiffies: Reuse TICK_NSEC instead of NSEC_PER_JIFFY")
> and ended with
> commit b672592f0221 ("sched/cputime: Remove generic asm headers").
> 
> This version applies to the v4.9 series.
> 
> Link: https://lkml.org/lkml/2019/2/28/1373
> Suggested-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  include/linux/jiffies.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> index 734377a..94aff43 100644
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -287,13 +287,13 @@ extern unsigned long preset_lpj;
>  extern unsigned int jiffies_to_msecs(const unsigned long j);
>  extern unsigned int jiffies_to_usecs(const unsigned long j);
>  
> +extern u64 jiffies64_to_nsecs(u64 j);
> +
>  static inline u64 jiffies_to_nsecs(const unsigned long j)
>  {
> -	return (u64)jiffies_to_usecs(j) * NSEC_PER_USEC;
> +	return jiffies64_to_nsecs(j);
>  }
>  
> -extern u64 jiffies64_to_nsecs(u64 j);
> -
>  extern unsigned long __msecs_to_jiffies(const unsigned int m);
>  #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
>  /*
> 
