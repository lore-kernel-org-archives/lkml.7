Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27532C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9952087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564733894;
	bh=M9Qf34aSZeVC+o3uT6RLeI/FX0v7TbxBw6sAGR+jbXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AOSPZyar9QJXiyi7l5vS534YJjdlTiR+hLq/Sug0/8tc5xVbxy5HWpqdPqnaITg1a
	 Eu1yxWUUGX0nBqx6sQKc/g+ZhOk492fUldsEutx+C7WJ4mqN3mD3lqAKFYvrNxqOXr
	 Owa2CaTxgd5wt7PyvsLH5zzajnps/BjNgvwiKQkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404075AbfHBISN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:18:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727622AbfHBISM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:18:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3349AFF1;
        Fri,  2 Aug 2019 08:18:10 +0000 (UTC)
Date:   Fri, 2 Aug 2019 10:18:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Masoud Sharbiani <msharbiani@apple.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190802081808.GB6461@dhcp22.suse.cz>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190801181952.GA8425@kroah.com>
 <7EE30F16-A90B-47DC-A065-3C21881CD1CC@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EE30F16-A90B-47DC-A065-3C21881CD1CC@apple.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Hillf, your email client or workflow mangles emails. In this case you
are seem to be reusing the message id from the email you are replying to
which confuses my email client to assume your email is a duplicate.]

On Fri 02-08-19 16:08:01, Hillf Danton wrote:
[...]
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2547,8 +2547,12 @@ retry:
>  	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
>  						    gfp_mask, may_swap);
>  
> -	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> -		goto retry;
> +	if (mem_cgroup_margin(mem_over_limit) >= nr_pages) {
> +		if (nr_retries--)
> +			goto retry;
> +		/* give up charging memhog */
> +		return -ENOMEM;
> +	}

Huh, what? You are effectively saying that we should fail the charge
when the requested nr_pages would fit in. This doesn't make much sense
to me. What are you trying to achive here?
-- 
Michal Hocko
SUSE Labs
