Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B41C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C6D2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQhpJMN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfJOKO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:14:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53468 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfJOKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:14:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so20192430wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J5yheL3IX266IN4jIyIMkFBu6ny3nuvQCGjA15FGlFU=;
        b=rQhpJMN3ETeGNYnGr6vKkJKi7/DA5qObaGMMZkRqGfUA/TXNqB7gnUXRSaEIhs/oP1
         uBs5HNSCYCKf8DHC8Qz2MeD4hxTpAXJVmh/uKWA/vj1yT7eMRzMBOaDw1Hj9L9zWw4Tk
         nMyVHNVUErOQvAFnU7YMkgZ0F5MmUgYN9qb4E3rTQfNQh2Oys9F+gR1bNgEzft+C8QvX
         xPWESH5IaPS4X3X439h2I9VJPtbP5WSfsVTyF8ZPCfrQPDrBwYe+WAXqWOx7LXI3g5fl
         Q0IZqK5tKW9a9JfPC2UQ7fDWblOi9SXTNPeBwRLlnjmk4Q9p9V28zhcY7DdQWw280WtX
         p7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J5yheL3IX266IN4jIyIMkFBu6ny3nuvQCGjA15FGlFU=;
        b=uBqCuUv6vuTwNYwrFwDg0zAEMvajeC4/bzuc79MJhAwcrp3NbJTTJmKmg6DltLKYvF
         DoRHzVFTyjPWJBWsgQfHFwEpNLFqe6+dAtL97ruYsDRUDEAJQHlkaTcpA1NFw1MhAVqN
         AqO9h2LX0dJyNh0mV0BgAqZosNTK0PgUcxZYtUZZErqa7ctGwM3I6yI0evG+dT9pV5Iw
         ceqXkuu1bO39CBr2j4Jn1knuKp4wOp9DICpLO3EooEGOhY3pUrY/FKt7QAqOvg9D2Wma
         f98SvLZvXpsNBHBqV5/0rbPOzJFyHwT3ISvb3aRninP8Ebnma1LkjVk4PzEb9Wzz1AeH
         cvxA==
X-Gm-Message-State: APjAAAXXE20XEQtUfjOSyuISOv7+dAOw6DafzaU+Jlu25HugNU1bq3Pg
        AP4AYBkmeN7UZ13HvgiWn1s70KuUJzM=
X-Google-Smtp-Source: APXvYqz0pv0H+Y9eUwb32v4iTi2lMLvABj1J8BLrlKfp2niRN/7soST5GX/H0y67X1/1anVb83ON4g==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr19932536wmc.150.1571134496655;
        Tue, 15 Oct 2019 03:14:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id s13sm21971318wmc.28.2019.10.15.03.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 03:14:55 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:14:52 +0100
From:   Quentin Perret <qperret@google.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        daniel.lezcano@linaro.org
Subject: Re: [Patch v3 7/7] sched: thermal: Enable tuning of decay period
Message-ID: <20191015101452.GA237548@google.com>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
 <1571014705-19646-8-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571014705-19646-8-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Sunday 13 Oct 2019 at 20:58:25 (-0400), Thara Gopinath wrote:
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 00fcea2..5056c08 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -376,6 +376,13 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname	= "sched_thermal_decay_coeff",
> +		.data		= &sysctl_sched_thermal_decay_coeff,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,

Perhaps change this for 'sched_proc_update_handler' with min and max
values ? Otherwise userspace is allowed to write nonsensical values
here. And since sysctl_sched_thermal_decay_coeff is used to shift, this
can lead to an undefined behaviour.

Also, could we take this sysctl out of SCHED_DEBUG ? I expect this to be
used/tuned on production devices where SCHED_DEBUG should theoretically
be off.

Thanks,
Quentin
