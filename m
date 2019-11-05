Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D125ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E25206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572934203;
	bh=W/wYEcEhUMj9+LuKP3n/2z3db2n/GhMcWPGKV0mdCGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HEG72Dh5MKJeYpAXgE0jAssBF3b2XjFaSb/ETdytvChYgYaUv9C3Sw7hPpDdeZrQi
	 doXrdo17oWOLOPMvk1te37bel309xwzaXJCLviyWgue5ehwg9zv+iRn2r5TrK3IZBz
	 +e+VPQqubBM12gDZ3NmYtKtKVeTLRZVmOZPITHMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfKEGKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:10:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:39870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387454AbfKEGKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:10:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75FB4B160;
        Tue,  5 Nov 2019 06:10:00 +0000 (UTC)
Date:   Tue, 5 Nov 2019 07:09:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
Message-ID: <20191105060959.GA22672@dhcp22.suse.cz>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157270779336.1961.6528158720593572480.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02-11-19 18:16:33, Konstantin Khlebnikov wrote:
> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
> charge path") memcg invokes oom killer not only for user page-faults.
> This means 0-order allocation will either succeed or task get killed.
> 
> Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")

Is this really appropriate? 8e675f7af507 was correct at the time. It was
29ef680ae7c2 that hasn't updated the documentation. I would just drop
the Fixes tag.

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5361ebec3361..eb47815e137b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
>  
>  		Failed allocation in its turn could be returned into
>  		userspace as -ENOMEM or silently ignored in cases like
> -		disk readahead.  For now OOM in memory cgroup kills
> -		tasks iff shortage has happened inside page fault.
> +		disk readahead.
> +
> +		Before 4.19 OOM in memory cgroup killed tasks iff

I would go with Kernels between 3.12 and 4.19 invoked the oom killer
only if shortage has happened inside page fault.

> +		shortage has happened inside page fault, random
> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
> +		failed memory cgroup allocation invokes oom killer and
> +		keeps retrying until it succeeds.
>  
>  		This event is not raised if the OOM killer is not
>  		considered as an option, e.g. for failed high-order

-- 
Michal Hocko
SUSE Labs
