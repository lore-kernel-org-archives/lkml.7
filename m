Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEE72067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfGaRlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:41:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfGaRlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:41:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4B1EC049E32;
        Wed, 31 Jul 2019 17:41:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4EB3660922;
        Wed, 31 Jul 2019 17:41:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 Jul 2019 19:41:39 +0200 (CEST)
Date:   Wed, 31 Jul 2019 19:41:36 +0200
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
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190731174135.GA30225@redhat.com>
References: <20190731161223.2928-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731161223.2928-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 31 Jul 2019 17:41:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, Adrian Reber wrote:
>
> Extending clone3() to support CLONE_SET_TID makes it possible restore a
> process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> race free (as long as the desired PID/TID is available).

I personally like this... but please see the question below.

> +struct pid *alloc_pid(struct pid_namespace *ns, int set_tid)
>  {
>  	struct pid *pid;
>  	enum pid_type type;
> @@ -186,12 +186,28 @@ struct pid *alloc_pid(struct pid_namespace *ns)
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
> +				(idr_get_cursor(&tmp->idr) <= 1)))
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ah, I forgot to mention... this should work but only because
RESERVED_PIDS > 0. How about idr_is_empty() ?


But the main question is how it can really help if ns->level > 0, unlikely
CRIU will ever need to clone the process with the same pid_nr == set_tid
in the ns->parent chain.

So may be kernel_clone_args->set_tid should be pid_t __user *set_tid_array?
Or I missed something ?

Oleg.

