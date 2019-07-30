Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42031C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEF820657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfG3Qzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfG3Qzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:55:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34F23307D90D;
        Tue, 30 Jul 2019 16:55:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 598BA19C5B;
        Tue, 30 Jul 2019 16:55:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jul 2019 18:55:41 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:55:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190730165538.GE18501@redhat.com>
References: <20190729163355.4530-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729163355.4530-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 30 Jul 2019 16:55:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Adrian Reber wrote:
>
> @@ -186,12 +187,26 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
>  			pid_min = RESERVED_PIDS;
>  
> +		if (set_tid) {
> +			if ((set_tid >= pid_max) || ((set_tid != 1) &&
> +				(idr_get_cursor(&tmp->idr) <= 1))) {

I think the

	(set_tid != 1) && idr_get_cursor() <= 1

check needs a comment...

> +				spin_unlock_irq(&pidmap_lock);
> +				retval = -EINVAL;
> +				goto out_free;
> +			}
> +			min_p = set_tid;
> +			max_p = set_tid + 1;
> +			set_tid = 0;
> +		} else {
> +			min_p = pid_min;
> +			max_p = pid_max;
> +		}
>  		/*
>  		 * Store a null pointer so find_pid_ns does not find
>  		 * a partially initialized PID (see below).
>  		 */
> -		nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -				      pid_max, GFP_ATOMIC);
> +		nr = idr_alloc_cyclic(&tmp->idr, NULL, min_p,
> +				      max_p, GFP_ATOMIC);

do we really want _cyclic() which updates idr->idr_next if set_tid?

perhaps idr_alloc() makes more sense?

Oleg.

