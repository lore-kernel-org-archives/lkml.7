Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB39C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0321E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfHGO0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57177 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbfHGO0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:26:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B14E30BA08F;
        Wed,  7 Aug 2019 14:26:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 13958600CC;
        Wed,  7 Aug 2019 14:26:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Aug 2019 16:26:12 +0200 (CEST)
Date:   Wed, 7 Aug 2019 16:26:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807142609.GC24112@redhat.com>
References: <20190806191551.22192-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806191551.22192-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 07 Aug 2019 14:26:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Adrian Reber wrote:
>
> +struct pid *alloc_pid(struct pid_namespace *ns, int set_tid)
>  {
>  	struct pid *pid;
>  	enum pid_type type;
> @@ -186,12 +186,35 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
>  			pid_min = RESERVED_PIDS;
>  
> -		/*
> -		 * Store a null pointer so find_pid_ns does not find
> -		 * a partially initialized PID (see below).
> -		 */
> -		nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -				      pid_max, GFP_ATOMIC);
> +		if (set_tid) {
> +			/*
> +			 * Also fail if a PID != 1 is requested
> +			 * and no PID 1 exists.
> +			 */
> +			if ((set_tid >= pid_max) || ((set_tid != 1) &&
> +				(idr_is_empty(&tmp->idr)))) {

too many parentheses ;) this is purely cosmetic, up to you, but to me

			if (set_tid >= pid_max ||
			   (set_tid != 1 && idr_is_empty(&tmp->idr))) {

looks a bit more readable.


> +				spin_unlock_irq(&pidmap_lock);
> +				retval = -EINVAL;
> +				goto out_free;

This doesn't look right, you need idr_preload_end() before goto out_free.

But I'd suggest to simply do

			nr = -EINVAL;
			if (set_tid < pid_max &&
			   (set_tid != 1 || idr_is_empty(&tmp->idr)))
				nr = idr_alloc(&tmp->idr, NULL, set_tid,
						set_tid + 1, GFP_ATOMIC);

			...

this is more robust.

Oleg.


