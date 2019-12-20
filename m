Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10748C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D956524679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="L8piFv2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLTIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:52:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41347 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfLTIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:52:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so6419030lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 00:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g03ME6LX9KEN3IFVuuupNP5PRF69RImvglEaCDyvn4Q=;
        b=L8piFv2jXTgyf37AUsgJbT+vRxxhfXwa1XtvokoLW8ljNtFaYvPIhBWVTWrm6MDYhp
         CLdY76bFrcehyLxGzbN+lD8REveRtyYJxQZyF+EdoaNnq1ptE0WuZICOemuP3lxHAP4N
         4hL6/q6SUgCJjZeNV/OXhDyAYzWflvcS27+GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g03ME6LX9KEN3IFVuuupNP5PRF69RImvglEaCDyvn4Q=;
        b=Bz9Fx7vz/4yVF4bxYAL/Wdo9H6Y15s1/IrNUGARIYXOoUFBfTFo93+Vg5Y0FSmukaQ
         Ww7tA/CWkzXNQ9aTdrbfGmLFDlL4yVzw0qb+0ms+d1dqIcYXbkHKQounPRHIv2CdpLu1
         LMemou2HIqZL58Yguh7ePgejL1JtlXsUcRXzqH5e/NFtaJ+T63OXzdIj4NIap/cjagmA
         k2wzOex61ZodhDmu5mLLXjKpatyGwCiBeDKrzyzr7bPtgTDOmkfxzUo8XMWXP/Wa6kU5
         7z+xnuadqOH3x7LWBzGmsHv9M7ui/cU1bgkcF/P0wRLC4wt4CBgNAfTgH6VFPSU9YuiR
         YLnQ==
X-Gm-Message-State: APjAAAUJv0fynIUlu1SI3yGUtNDKfmkPasspGLEJdo2S5+gW4F/mcft5
        J4LWRJudJvuV1cBOP4yqbEfM2A==
X-Google-Smtp-Source: APXvYqznNTvnhGkEIhhiSp5Zto0IhwSchlODlt5vxp/Vw9tC8vXqMMj+dVieuUyAjH9SiFDvNBNPrA==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr8448862lfa.70.1576831959430;
        Fri, 20 Dec 2019 00:52:39 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a12sm3961148ljk.48.2019.12.20.00.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 00:52:39 -0800 (PST)
Subject: Re: [RFC][PATCH 1/4] sched: Force the address order of each sched
 class descriptor
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191219214451.340746474@goodmis.org>
 <20191219214558.510271353@goodmis.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0a957e8d-7af8-613c-11ae-f51b9b241eb7@rasmusvillemoes.dk>
Date:   Fri, 20 Dec 2019 09:52:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191219214558.510271353@goodmis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 22.44, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> In order to make a micro optimization in pick_next_task(), the order of the
> sched class descriptor address must be in the same order as their priority
> to each other. That is:
> 
>  &idle_sched_class < &fair_sched_class < &rt_sched_class <
>  &dl_sched_class < &stop_sched_class
> 
> In order to guarantee this order of the sched class descriptors, add each
> one into their own data section and force the order in the linker script.

I think it would make the code simpler if one reverses these, see other
reply.

> +/*
> + * The order of the sched class addresses are important, as they are
> + * used to determine the order of the priority of each sched class in
> + * relation to each other.
> + */
> +#define SCHED_DATA				\
> +	*(__idle_sched_class)			\
> +	*(__fair_sched_class)			\
> +	*(__rt_sched_class)			\
> +	*(__dl_sched_class)			\
> +	STOP_SCHED_CLASS
> +
>  /*
>   * Align to a 32 byte boundary equal to the
>   * alignment gcc 4.5 uses for a struct
> @@ -308,6 +326,7 @@
>  #define DATA_DATA							\
>  	*(.xiptext)							\
>  	*(DATA_MAIN)							\
> +	SCHED_DATA							\
>  	*(.ref.data)							\

Doesn't this make the structs end up in .data (writable) rather than
.rodata?

Rasmus
