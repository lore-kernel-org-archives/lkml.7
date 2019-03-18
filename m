Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81746C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5261620863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552909627;
	bh=UNj0ID1P9P3VWOSaET/bSL+3sKAy8bliV2jeGPBdViI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QYNPFcFnRL5zTSVwcDayPS4P8L6XOlxUnSUCJwhjg+BIYN6bVJKY60VWS+h2fUp6t
	 vSHfs3dq41U54TUr+JcapfucjFjkRC8zoY4yt4rrySsk5Z/G+ck1FlJ9FtjhHvYeSs
	 m1gDx4mf9MA5rOBh9FlHQkkOlTmNqToiuwrFbdKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfCRLrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:47:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:51670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfCRLrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 614FCAECD;
        Mon, 18 Mar 2019 11:47:04 +0000 (UTC)
Date:   Mon, 18 Mar 2019 12:47:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Richard Biener <rguenther@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Kernel bug with MPX?
Message-ID: <20190318114703.GE8924@dhcp22.suse.cz>
References: <alpine.LSU.2.20.1903060944550.7898@zhemvz.fhfr.qr>
 <ba1d2d3c-e616-611d-3cff-acf6b8aaeb66@intel.com>
 <20190308071249.GJ30234@dhcp22.suse.cz>
 <20190308073949.GA5232@dhcp22.suse.cz>
 <ec2110b1-abae-4df5-fcd7-244620634a00@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2110b1-abae-4df5-fcd7-244620634a00@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-03-19 09:51:42, Dave Hansen wrote:
[...]
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> MPX is being removed from the kernel due to a lack of support
> in the toolchain going forward (gcc).
> 
> The first thing we need to do is remove the userspace-visible
> ABIs so that applications will stop using it.  The most visible
> one are the enable/disable prctl()s.  Remove them first.
> 
> This is the most minimal and least invasive patch needed to
> start removing MPX.

Is this something we _want_ to push to stable trees?
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/include/uapi/linux/prctl.h |    2 +-
>  b/kernel/sys.c               |   16 ++--------------
>  2 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff -puN include/uapi/linux/prctl.h~mpx-remove-apis include/uapi/linux/prctl.h
> --- a/include/uapi/linux/prctl.h~mpx-remove-apis	2019-01-04 14:40:06.853514089 -0800
> +++ b/include/uapi/linux/prctl.h	2019-01-04 14:40:06.860514089 -0800
> @@ -181,7 +181,7 @@ struct prctl_mm_map {
>  #define PR_GET_THP_DISABLE	42
>  
>  /*
> - * Tell the kernel to start/stop helping userspace manage bounds tables.
> + * No longer implemented, but left here to ensure the numbers stay reserved:
>   */
>  #define PR_MPX_ENABLE_MANAGEMENT  43
>  #define PR_MPX_DISABLE_MANAGEMENT 44
> diff -puN kernel/sys.c~mpx-remove-apis kernel/sys.c
> --- a/kernel/sys.c~mpx-remove-apis	2019-01-04 14:40:06.857514089 -0800
> +++ b/kernel/sys.c	2019-01-04 14:40:06.860514089 -0800
> @@ -103,12 +103,6 @@
>  #ifndef SET_TSC_CTL
>  # define SET_TSC_CTL(a)		(-EINVAL)
>  #endif
> -#ifndef MPX_ENABLE_MANAGEMENT
> -# define MPX_ENABLE_MANAGEMENT()	(-EINVAL)
> -#endif
> -#ifndef MPX_DISABLE_MANAGEMENT
> -# define MPX_DISABLE_MANAGEMENT()	(-EINVAL)
> -#endif
>  #ifndef GET_FP_MODE
>  # define GET_FP_MODE(a)		(-EINVAL)
>  #endif
> @@ -2448,15 +2442,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
>  		up_write(&me->mm->mmap_sem);
>  		break;
>  	case PR_MPX_ENABLE_MANAGEMENT:
> -		if (arg2 || arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		error = MPX_ENABLE_MANAGEMENT();
> -		break;
>  	case PR_MPX_DISABLE_MANAGEMENT:
> -		if (arg2 || arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		error = MPX_DISABLE_MANAGEMENT();
> -		break;
> +		/* No longer implemented: */
> +		return -EINVAL;
>  	case PR_SET_FP_MODE:
>  		error = SET_FP_MODE(me, arg2);
>  		break;
> _


-- 
Michal Hocko
SUSE Labs
