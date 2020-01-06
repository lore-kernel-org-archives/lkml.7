Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BCFC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA6A20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="iCBsvElw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgAFU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:29:45 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:27638 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgAFU3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:29:45 -0500
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006KOuff026044;
        Mon, 6 Jan 2020 20:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=g3jFfRX8VLF8NGFNdux4zzSUSvSfRj0I7rTfEgZDFok=;
 b=iCBsvElwCxpdNWS5nF2Ll0HqTG/CQiRD9/0fZtAdEN+TPJ1Nas25sNAAWT27Ku242Nm1
 W8vdEbCvBeLLSLkwZlDs11vROMvkLIVrfK2NkGF6KyU4l00CkpB2B16+HfmymKSba0d5
 Xrw4FcootC19YPiKpek9YQpb1c+5J6IJPO0S3mGfUeaNqzZpGJhSkoAGQPDQLNQRFFoY
 cTtozqkUp7cogQRXl48L18xsbtishjfJhyMCMHaB2VTAPG5HIq048QqP5j5MdQED4JL8
 BASlj5Ibs2J5oNV9cvOBvP1zt5MDIg+dpHjAn+liNUP4Y5c14yXFsMGcy5fg7mlnp0Pp fA== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2xakmngj4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 20:29:39 +0000
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 006KHPCX002910;
        Mon, 6 Jan 2020 15:29:38 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2xapwy9154-1;
        Mon, 06 Jan 2020 15:29:37 -0500
Received: from [172.28.3.71] (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 979BD2BDA8;
        Mon,  6 Jan 2020 20:29:37 +0000 (GMT)
Subject: Re: [PATCH] fs/epoll: rework safewake for CONFIG_DEBUG_LOCK_ALLOC
To:     Davidlohr Bueso <dave@stgolabs.net>, rpenyaev@suse.de
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        normalperson@yhbt.net, viro@zeniv.linux.org.uk,
        Davidlohr Bueso <dbueso@suse.de>
References: <76f656dc7ac92f92682641e22e1c44c4@suse.de>
 <20200106193830.27224-1-dave@stgolabs.net>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <9f9763eb-d326-1ea0-5d50-1f5f481f2dc5@akamai.com>
Date:   Mon, 6 Jan 2020 15:28:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106193830.27224-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060169
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_06:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for looking at this.

On 1/6/20 2:38 PM, Davidlohr Bueso wrote:
> Some comments on:
> 
>       f6520c52084 (epoll: simplify ep_poll_safewake() for CONFIG_DEBUG_LOCK_ALLOC)
> 
> For one this does not play nice with preempt_rt as disabling irq and
> then taking a spinlock_t is a no no; the critical region becomes
> preemptible. This is particularly important as -rt is being mainlined.
> 

hmmm, but before the spinlock is taken there is a preempt_disable() call.

> Secondly, it is really ugly compared to what we had before - albeit not
> having to deal with all the ep_call_nested() checks, but I doubt this
> overhead matters at all with CONFIG_DEBUG_LOCK_ALLOC.
> 

Yes, the main point of the patch is to continue to remove dependencies
on ep_call_nested(), and then eventually to remove it completely.

> While the current logic avoids nesting by disabling irq during the whole
> path, this seems like an overkill under debug. This patch proposes using
> this_cpu_inc_return() then taking the irq-safe lock - albeit a possible
> irq coming in the middle between these operations and messing up the
> subclass. If this is unacceptable, we could always revert the patch,
> as this was never a problem in the first place.

I personally don't want to introduce false positives. But I'm not quite
sore on that point - the subclass will still I think always increase on
nested calls it just may skip some numbers. I'm not sure offhand if that
messes up lockdep. perhaps not?


Thanks,

-Jason


> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> 
> This is pretty much untested - I wanted to see what is the best way to
> address the concerns first.
> 
> XXX: I don't think we need get/put_cpu() around the call, this was intended
> only for ep_call_nested() tasks_call_list checking afaict.
> 
>  fs/eventpoll.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 67a395039268..97d036deff3e 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -558,16 +558,17 @@ static void ep_poll_safewake(wait_queue_head_t *wq)
>  	unsigned long flags;
>  	int subclass;
>  
> -	local_irq_save(flags);
> -	preempt_disable();
> -	subclass = __this_cpu_read(wakeup_nest);
> -	spin_lock_nested(&wq->lock, subclass + 1);
> -	__this_cpu_inc(wakeup_nest);
> +	subclass = this_cpu_inc_return(wakeup_nest);
> +	/*
> +	 * Careful: while unlikely, an irq can occur here and mess up
> +	 * the subclass. The same goes for right before the dec
> +	 * operation, but that does not matter.
> +	 */
> +	spin_lock_irqsave_nested(&wq->lock, flags, subclass + 1);
>  	wake_up_locked_poll(wq, POLLIN);
> -	__this_cpu_dec(wakeup_nest);
> -	spin_unlock(&wq->lock);
> -	local_irq_restore(flags);
> -	preempt_enable();
> +	spin_unlock_irqrestore(&wq->lock, flags);
> +
> +	this_cpu_dec(wakeup_nest);
>  }
>  
>  #else
> 
