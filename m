Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA9C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826D220989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbrZi8/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfEJJvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:51:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41345 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfEJJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:51:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so574432plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WijcaE3HINJiVGwwC+CuKRETdmWZ9/FSRZJjUi9mXvc=;
        b=RbrZi8/drM2Z3J/7bvD3it5wOe9OYIlwzWVRzah1vdnnjxnw1pWiT/EL8ywiDx3/3T
         hD1SX5GOJw5pmnlOEg4AsFB1RD6woBtAxX3cum9CFIgoVoKKP5prptRtsK9i/JMy8usn
         fK60N3wYQVvUGMog9NsnQCcdq4IpAix4ac+Ub0p0aKJk+llvHfg1JRivPbfsbFP3mHc6
         2oNzJaNR8blxqsAmqjodFCeUw/lyYhYidkRDek7P7OO1vjxp/OHIsHDz5zYhJCZMCARl
         QY/29FW2x9TeGDjMsokEi7yX7N6TbnrD5isB1wqHa30PlHXxddA10WZFfcb2M72MPpKv
         W6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WijcaE3HINJiVGwwC+CuKRETdmWZ9/FSRZJjUi9mXvc=;
        b=bJbx7bUW1ueFxiJcpoUmO0LxNi/HvmtFHBNzDbd2FAcJ4DXfOLjBZmyMD9CeIJhlJz
         UwCn5h1T6uOGT5fkJMjyzQvcrpDaYcx+5tBvh7TMg3U55oRT9xCpzWQDhRysYOIPcxTu
         QXTSrg1d7MIeuWRYg1s1rTG+MR1s3TsFwksXv39J3/UDQ/BjELC31sNq/ykizGDiog0g
         JHjRtAx6Onn4+QeTregiNBO7TWGWpkesFdTb2vuvzc2OWKKkIFdwYX6+fFZrZPYD8bkN
         MS6tymlX4W6kmbDnU0QrlAPLQXe7JvsdfrhvXopTqVs6hZYNBMVMSBlWoiR4z0ZlRnsf
         60NA==
X-Gm-Message-State: APjAAAXatChjknYYhfhUMYgEwqVOoXQb8PBClwm1Q2iEtNZQWjR+F4qk
        QV15vOzDvdr6wucCvGB1H9k=
X-Google-Smtp-Source: APXvYqwVWxL8kHDRGOAqch3VmtI11JCYWCJUvbPGv/TKxmR4JMfuugbUzDmjDo0v0wtIrw042BKPog==
X-Received: by 2002:a17:902:2cc1:: with SMTP id n59mr12098147plb.22.1557481905657;
        Fri, 10 May 2019 02:51:45 -0700 (PDT)
Received: from localhost ([39.7.15.25])
        by smtp.gmail.com with ESMTPSA id s6sm6368853pfb.128.2019.05.10.02.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 02:51:44 -0700 (PDT)
Date:   Fri, 10 May 2019 18:51:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
Message-ID: <20190510095141.GA32171@jagdpanzerIV>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509145620.2pjqko7copbxuzth@pathway.suse.cz>
 <CAKMK7uFTsr1F8nFExTvC7nWFQMcZ7ejh+k_X6E8EcMUaP3e29A@mail.gmail.com>
 <20190510091537.44e3aeb7gcrcob76@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510091537.44e3aeb7gcrcob76@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/10/19 11:15), Petr Mladek wrote:
[..]
>  arch/x86/kernel/smp.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -124,7 +124,8 @@ static bool smp_no_nmi_ipi = false;
>   */
>  static void native_smp_send_reschedule(int cpu)
>  {
> -	if (unlikely(cpu_is_offline(cpu))) {
> +	if (unlikely(cpu_is_offline(cpu) &&
> +		     atomic_read(&stopping_cpu) < 0)) {
>  		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
>  		return;
>  	}

I think we need to remove CPU which we IPI_STOP from
idle_cpus_mask. So then scheduler won't pick up stopped
CPUs (cpumask_first(nohz.idle_cpus_mask)) and attempt
rescheduling to them. It seems that currently
native_stop_other_cpus() doesn't do that.

	-ss
