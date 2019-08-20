Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0683C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8795522DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EPfWbdLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfHTNeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:34:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34292 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfHTNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:34:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id q4so6000439qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xkla8yZpkWsn7BQhjD5NVqgPEeC/v8sq4Q+tGQW7NAA=;
        b=EPfWbdLDIn9vYVNO92ekXg+Aqpk0N5AXlzR+0ptOOJgqHA7T2kwzvvGoWZuIvAfr/3
         0teKv2tf6kXm8zvOpJTZOgVyZgQEWvFiIxWu2cHJekpwmLDQC47QSg31UJZq5zb6Zu2R
         2IMDu+hVU12h9dIC7m/oQKnPEg4M1wIExBMafHRztS8uRKUSSBuZoFGd+3SaDkI6kpo9
         vvV6E/GjnRwfaJI3KJtUSJ1QIWuQ+GlNO4j01Dn9gcdYYIUQ/8xiMeu1LW4OuDyU/Q+B
         Nol5QsZWTj23vCJ3rkWepIYMWSEfA+1YPrUaB+2ZG3+Rn8BlPBDbWfse0wb2WYK0ODxI
         VHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xkla8yZpkWsn7BQhjD5NVqgPEeC/v8sq4Q+tGQW7NAA=;
        b=GjRJPDZX+i1pOoomiBbK+ksGNVFlUwJ91xwTXGCoTSw0lQ+Md7623VBz7Db6lyzdrX
         LtekCSJnd+99YqpaxFpqwgriAyg1fsR/Mlqn6IK22wecbXm5guQDQG7ipIaiy+RZjAC1
         G5ucXfbtiXi9HqtboH53ybOTGFWuS9ihGME9FzFocbVQEPYGE3tpYnz+xBLv8qQRVb25
         FLu2e0dYU2QLilUEO5TeyWRfKFoUFcCBdf6w0vQSUxHFFbn/GjlqrPhQStnDJB8EoiBF
         SPPyk0n7Mn2KlK3Ov2z6GwrHUdZYWLXsfMegiG+74ziCzQUbfOfyjGutmCpbCS4VXZbx
         ZA+g==
X-Gm-Message-State: APjAAAWYGEgjHD62ouoMVBxYEShb1CJl9xE7NxXyw8Km2jDukro08ygp
        wOH9RCwrgp4rHvhSbLKQpcElJQ==
X-Google-Smtp-Source: APXvYqwFrEe87m5OQXGPINdZ2bSNi3jP/uT5gUvqjHoY/CkByObbCPrlNUFCkrMtjbnMymplA2SbCQ==
X-Received: by 2002:ac8:53d3:: with SMTP id c19mr26516722qtq.225.1566308058877;
        Tue, 20 Aug 2019 06:34:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a23sm2037193qtj.5.2019.08.20.06.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 06:34:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i04HC-0000ct-4x; Tue, 20 Aug 2019 10:34:18 -0300
Date:   Tue, 20 Aug 2019 10:34:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190820133418.GG29246@ziepe.ca>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820081902.24815-5-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:19:02AM +0200, Daniel Vetter wrote:
> We need to make sure implementations don't cheat and don't have a
> possible schedule/blocking point deeply burried where review can't
> catch it.
> 
> I'm not sure whether this is the best way to make sure all the
> might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> But it gets the job done.
> 
> Inspired by an i915 patch series which did exactly that, because the
> rules haven't been entirely clear to us.
> 
> v2: Use the shiny new non_block_start/end annotations instead of
> abusing preempt_disable/enable.
> 
> v3: Rebase on top of Glisse's arg rework.
> 
> v4: Rebase on top of more Glisse rework.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>  mm/mmu_notifier.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 538d3bb87f9b..856636d06ee0 100644
> +++ b/mm/mmu_notifier.c
> @@ -181,7 +181,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
>  		if (mn->ops->invalidate_range_start) {
> -			int _ret = mn->ops->invalidate_range_start(mn, range);
> +			int _ret;
> +
> +			if (!mmu_notifier_range_blockable(range))
> +				non_block_start();
> +			_ret = mn->ops->invalidate_range_start(mn, range);
> +			if (!mmu_notifier_range_blockable(range))
> +				non_block_end();

If someone Acks all the sched changes then I can pick this for
hmm.git, but I still think the existing pre-emption debugging is fine
for this use case.

Also, same comment as for the lockdep map, this needs to apply to the
non-blocking range_end also.

Anyhow, since this series has conflicts with hmm.git it would be best
to flow through the whole thing through that tree. If there are no
remarks on the first two patches I'll grab them in a few days.

Regards,
Jason
