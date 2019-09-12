Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A530C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA5C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfILQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbfILQvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:51:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 165FC3B464;
        Thu, 12 Sep 2019 16:51:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id 504FD5D712;
        Thu, 12 Sep 2019 16:51:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 12 Sep 2019 18:51:15 +0200 (CEST)
Date:   Thu, 12 Sep 2019 18:51:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3] fork: check exit_signal passed in clone3() call
Message-ID: <20190912165110.GA719@redhat.com>
References: <cover.1568223594.git.esyr@redhat.com>
 <4b38fa4ce420b119a4c6345f42fe3cec2de9b0b5.1568223594.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b38fa4ce420b119a4c6345f42fe3cec2de9b0b5.1568223594.git.esyr@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 12 Sep 2019 16:51:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11, Eugene Syromiatnikov wrote:
>
> @@ -2562,6 +2564,15 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  	if (copy_from_user(&args, uargs, size))
>  		return -EFAULT;
>  
> +	/*
> +	 * Two separate checks are needed, as valid_signal() takes unsigned long
> +	 * as an argument, and struct kernel_clone_args uses int type
> +	 * for the exit_signal field.
> +	 */
> +	if (unlikely((args.exit_signal > UINT_MAX) ||
> +		     !valid_signal(args.exit_signal)))
> +		return -EINVAL;

OK, I equally agree with this version. Although I'd simply do

	if (args.exit_signal > _NSIG)
		return -EINVAL;

but this is cosmetic.

Acked-by: Oleg Nesterov <oleg@redhat.com>

