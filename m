Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A8A216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="uKh2QezE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfG2PaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:30:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39390 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbfG2PaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:30:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so27696446pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zClkBN3lTS1+Q+JFzp+qXPFY9wwST6ib98450V0l434=;
        b=uKh2QezEkGVv+DpYW2qjVlLCa/B7ZJRmRmtB9hDESR/c/qhRIikFGdrPpODIN5vtHo
         BV7A/U71JXov8ytlkjvJRxAMlFM6FRcE4XQmnVEZAEIhdIuEvLjZ+7J9NTwVY5zzPmqh
         Mucd+ULNoW/BYk7iod4QAGLCHzJXyv7mwPgYaoWcImUvTX2Fra5PEkLTIQtM0wepLoQC
         4nyZZM+7MHjouKUz0Lb1MMXzIdiCmjZSrJbhqU56XtFCuN7JNUkIypXB1E6pFUfBB6XT
         mRvUk6l/zkQaeGrHn7uBNFGtLWDUrB5FbJLMwPgwmmGL4eJ80gGdhDrL2EHbpkSRzA0g
         jrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zClkBN3lTS1+Q+JFzp+qXPFY9wwST6ib98450V0l434=;
        b=lq16A4djte4dtRHNgsAmi1flAWAd6jWEtQv4zcjrV76smg4vUO7N1yl6zDxP2CdqmO
         U1GoYTAa98BXgNS4cFxcuZvsQh17VnvYKC7O6zwYVA+kZQxQU4G/buEXFZPtAijoOLhZ
         rp04fbrnN+a1umRfeeHsXQk4+ySuvkH7Fn2SUydK1q1stM5UIFbRPqUmT9dJAHeUkVAa
         SHN3j+EBFasdSHhPNucWTXtzVbxWgsSye5ZGWH9eURvloF3+n/4AGU0+ZNwrpoXeoaH7
         urJZD9fqOjxmVQAHTSvmbzTeblGNyhSxyomiedkfAGBgoLH5qEBKLIc3ScKkBSLfecIJ
         phRA==
X-Gm-Message-State: APjAAAWwrosyaNY9LmsEJ+5VXLtjFTcIjTTIlWA+3SY5xaiUMxw0llID
        rZxomEUWISjQWkwROMynFKY=
X-Google-Smtp-Source: APXvYqwPjhLMk1w3laF/wa+oxvfL2vmLWPsYqunR2ElWAj61hIcPl41JFwyRl5sNMmL/+D5zjXci9w==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr110768476plp.221.1564414200219;
        Mon, 29 Jul 2019 08:30:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:1811])
        by smtp.gmail.com with ESMTPSA id h13sm28484598pfn.13.2019.07.29.08.29.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:29:59 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:29:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jason Xing <kerneljasonxing@linux.alibaba.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        dennis@kernel.org, axboe@kernel.dk, lizefan@huawei.com,
        tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: get poll_work to run when calling poll syscall next
 time
Message-ID: <20190729152957.GA21958@cmpxchg.org>
References: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Jul 23, 2019 at 02:45:39PM +0800, Jason Xing wrote:
> Only when calling the poll syscall the first time can user
> receive POLLPRI correctly. After that, user always fails to
> acquire the event signal.
> 
> Reproduce case:
> 1. Get the monitor code in Documentation/accounting/psi.txt
> 2. Run it, and wait for the event triggered.
> 3. Kill and restart the process.
> 
> If the user doesn't kill the monitor process, it seems the
> poll_work works fine. After killing and restarting the monitor,
> the poll_work in kernel will never run again due to the wrong
> value of poll_scheduled. Therefore, we should reset the value
> as group_init() does after the last trigger is destroyed.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>

Good catch, and the fix makes sense to me. However, it was a bit hard
to understand how the problem occurs:

> ---
>  kernel/sched/psi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632..66f4385 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1133,6 +1133,12 @@ static void psi_trigger_destroy(struct kref *ref)
>  	if (kworker_to_destroy) {
>  		kthread_cancel_delayed_work_sync(&group->poll_work);
>  		kthread_destroy_worker(kworker_to_destroy);
> +		/*
> +		 * The poll_work should have the chance to be put into the
> +		 * kthread queue when calling poll syscall next time. So
> +		 * reset poll_scheduled to zero as group_init() does
> +		 */
> +		atomic_set(&group->poll_scheduled, 0);

The question is why we can end up with poll_scheduled = 1 but the work
not running (which would reset it to 0). And the answer is because the
scheduling side sees group->poll_kworker under RCU protection and then
schedules it, but here we cancel the work and destroy the worker. The
cancel needs to pair with resetting the poll_scheduled flag:

	if (kworker_to_destroy) {
		/*
		 * After the RCU grace period has expired, the worker
		 * can no longer be found through group->poll_kworker.
		 * But it might have been already scheduled before
		 * that - deschedule it cleanly before destroying it.
		 */
		kthread_cancel_delayed_work_sync(&group->poll_work);
		atomic_set(&group->poll_scheduled, 0);

		kthread_destroy_worker(kworker_to_destroy);
	}

With that change, please add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
