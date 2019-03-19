Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E54C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257EC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552984401;
	bh=jjSqJUBachI3OkoOnRR731pkIsic5VXZ2MyMB0BSh8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C7Nh2n3bh4a7amZR1cKirnxhZIOfUrXxaIxBjYyjIA27CEDtnfciHcBSb6Xo4T2Tm
	 I0/qxhO1gGiLKHBDBh3cKRjqh2DCnOBxlyZ6Np66fpthcY5MpTlCLYFwbTny8K/kkX
	 3+q4Tq5tJieA5jrxddSAH3W66/wv2y+KXEgPjUWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCSIdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:33:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:32962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCSIdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43236AFDF;
        Tue, 19 Mar 2019 08:33:18 +0000 (UTC)
Date:   Tue, 19 Mar 2019 09:33:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aristeu Rozanski <aris@redhat.com>,
        "Serge E . Hallyn" <serge.hallyn@ubuntu.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] device_cgroup: fix RCU imbalance in error case
Message-ID: <20190319083316.GQ8924@dhcp22.suse.cz>
References: <20190319013659.86199-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319013659.86199-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-03-19 02:36:59, Jann Horn wrote:
> When dev_exception_add() returns an error (due to a failed memory
> allocation), make sure that we move the RCU preemption count back to where
> it was before we were called. We dropped the RCU read lock inside the loop
> body, so we can't just "break".
> 
> sparse complains about this, too:
> 
> $ make -s C=2 security/device_cgroup.o
> ./include/linux/rcupdate.h:647:9: warning: context imbalance in
> 'propagate_exception' - unexpected unlock
> 
> Fixes: d591fb56618f ("device_cgroup: simplify cgroup tree walk in propagate_exception()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

FWIW looks good to me.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

> ---
> Compile-tested only.
> 
> I'm not entirely sure who's supposed to be the maintainer for this thing.
> The sign-offs on the commits to this file come from Tejun, but MAINTAINERS
> claims it's part of security/, so I'm just sending this to both the
> security folks and the cgroup folks, you can figure out whose tree you want
> to take this through. :P
> If the cgroup folks feel responsible for this file, maybe you could fix up
> MAINTAINERS?
> 
>  security/device_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index cd97929fac66..dc28914fa72e 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -560,7 +560,7 @@ static int propagate_exception(struct dev_cgroup *devcg_root,
>  		    devcg->behavior == DEVCG_DEFAULT_ALLOW) {
>  			rc = dev_exception_add(devcg, ex);
>  			if (rc)
> -				break;
> +				return rc;
>  		} else {
>  			/*
>  			 * in the other possible cases:
> -- 
> 2.21.0.225.g810b269d1ac-goog

-- 
Michal Hocko
SUSE Labs
