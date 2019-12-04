Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52A6C432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32DD2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h7d2D8DD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLDCdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:33:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfLDCdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KEvl8E2uqYzHXXBcWxExEanjkQOayE/IO/ACRjvE+vk=; b=h7d2D8DDkM4aY5V970X2F32Wt
        XYLmNR6BcaCV/zpo0sxeqEN3Ogl0N9JjO4hS7WplSX8z9qhvTYS2adrRqOQym2ZWt+zMfHD7nHWGM
        1FQd4U3M44atyYGl36B3+tJXwbHjTbdF7Qezv41U7P1+hejdPlu2TZJ7+ktsRczuJFwHP8zy2wlGq
        gdiEU3FG3mOD38i35RvphKQrEcdS71RMkzxF9VA+RAdFD5a0GwliNP/l4UWB6ZBrtDD0cm9wXsO4s
        i/OKq3AxhgY6HyJ/oszTumKybPWYqxKc4zkr7xSgBxjpkDLWHimU5Q3zTg9O6WgTsDrtISrfU3UOs
        Z+76RA0eQ==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icKTT-0001ej-Ge; Wed, 04 Dec 2019 02:33:13 +0000
Subject: Re: [PATCH v3 1/2] sched/numa: introduce per-cgroup NUMA locality
 info
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <2398e8a4-a3ad-3660-3aba-298730d209b2@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5f109b8-be26-c025-1d6d-ec3b3354c4b1@infradead.org>
Date:   Tue, 3 Dec 2019 18:33:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <2398e8a4-a3ad-3660-3aba-298730d209b2@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/19 10:00 PM, 王贇 wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 4d8d145c41d2..9c086f716a6d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>  	  machine.
> 
> +config CGROUP_NUMA_LOCALITY
> +	bool "The per-cgroup NUMA Locality"

I would drop "The".

> +	default n
> +	depends on CGROUP_SCHED && NUMA_BALANCING
> +	help
> +	  This option enable the collection of per-cgroup NUMA locality info,

	              enables

> +	  to tell whether NUMA Balancing is working well for a particular
> +	  workload.
> +
>  menuconfig CGROUPS
>  	bool "Control Group support"
>  	select KERNFS


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
