Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB2C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CEC206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFEWkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:40:04 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44789 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbfFEWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:40:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TTWMlNH_1559774400;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTWMlNH_1559774400)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jun 2019 06:40:01 +0800
Subject: Re: [PATCH] ocfs2/dlm: use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190605204926.GA24467@embeddedor>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <9bee6ee0-ba29-ea0d-d5d2-f8c09158a1cf@linux.alibaba.com>
Date:   Thu, 6 Jun 2019 06:40:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605204926.GA24467@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/6/6 04:49, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct dlm_migratable_lockres 
> {
> i	...
>         struct dlm_migratable_lock ml[0];  // 16 bytes each, begins at byte 112
> };
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following form:
> 
> sizeof(struct dlm_migratable_lockres) + (mres->num_locks * sizeof(struct dlm_migratable_lock))
> 
> with:
> 
> struct_size(mres, ml, mres->num_locks)
> 
> Notice that, in this case, variable sz is not necessary, hence it
> is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlm/dlmrecovery.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
> index e22d6a115220..064ce5bbc3f6 100644
> --- a/fs/ocfs2/dlm/dlmrecovery.c
> +++ b/fs/ocfs2/dlm/dlmrecovery.c
> @@ -1109,7 +1109,7 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
>  {
>  	u64 mig_cookie = be64_to_cpu(mres->mig_cookie);
>  	int mres_total_locks = be32_to_cpu(mres->total_locks);
> -	int sz, ret = 0, status = 0;
> +	int ret = 0, status = 0;
>  	u8 orig_flags = mres->flags,
>  	   orig_master = mres->master;
>  
> @@ -1117,9 +1117,6 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
>  	if (!mres->num_locks)
>  		return 0;
>  
> -	sz = sizeof(struct dlm_migratable_lockres) +
> -		(mres->num_locks * sizeof(struct dlm_migratable_lock));
> -
>  	/* add an all-done flag if we reached the last lock */
>  	orig_flags = mres->flags;
>  	BUG_ON(total_locks > mres_total_locks);
> @@ -1133,7 +1130,8 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
>  
>  	/* send it */
>  	ret = o2net_send_message(DLM_MIG_LOCKRES_MSG, dlm->key, mres,
> -				 sz, send_to, &status);
> +				 struct_size(mres, ml, mres->num_locks),
> +				 send_to, &status);
>  	if (ret < 0) {
>  		/* XXX: negative status is not handled.
>  		 * this will end up killing this node. */
> 
