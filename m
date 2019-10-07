Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692FFECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408452173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570459806;
	bh=oWc5xK1y+xZRbVDdLDr9f32Jf8TFQA/JnTekh/Csnvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JdpbqyPylzVD9LUCQkb5FTHS+AkaVrV2rr8yWT7A1ii3P4Li+HlIgG5ck2f3XbWR+
	 rqu4b93sQjQ184LQT2ZfokhugeWMHbcarJ5s4vjUnWgtEvkGa5Rql9RuB3orBSPfJR
	 M5N8mFat3F6+1gL7lq3YRVNw/5RKur5cf+OVyc9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfJGOuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:50:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46834 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfJGOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so15622754wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1dSA+SmdtisGu5FvnubDfiZYtTOdvCNLpWjAeop5PWM=;
        b=NY8Xdb2ENlkzoJiW5PfDLGVYgGYdgNXK+IbonkVtqUPW/pzgaekJMC0r9d1t9BRglK
         ZkLuJZknhOk7P8pwkwxjiLjYPXtP8xcTXdkF+8jCVX7w+H/2Vgwp1ynXNJT1cTOfESPT
         GlxUW1wVfpPTCZc77iP2oFYsrKHJofNIUyVcf+XQW4LW7OQnDNuinCCVjzmZtg6iths7
         YdN6n+XP4ZWSS+gngqtK1i+IjCHuPYCOX7EdYh/IPt+b7Jo0qniQx8XsK1LKToS1W2Ya
         OaIiLyaedb5+UbjEAdh9MCCE4qnzyQFW8kPxslW/Yv5bk5tWUH9mfowPKvYp6E/sG3u1
         Vddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1dSA+SmdtisGu5FvnubDfiZYtTOdvCNLpWjAeop5PWM=;
        b=ROv0eVEKUWLess2APpjgvEgplpkwjS7EV2ycSG+7Z/lz/RR28Qd2G9tasoHCmlYW+V
         E5JZ+/EMcakHA5FGES8q6A+w2SM7yNiGeQ4tHyImaydsYmAH/eAxSngaVT2oCMrXNy4d
         NazO3HclM6GHDeV3MvWDYm/eCbd3xNlQXgaddMJpLmtyuD2ZJzZDKhGi7rKPKuOPZmTr
         BNFGRKDdTw59oRLoPsUdmuuwIcRX/gMVAM1OURqlvBAAsltYW78ObTWo1G6M6bsSLjod
         +8Vq4Ys77w9ABZXOXyKDH5HEpiLxV/Okrt3sSUz8GL6k2U+sIhNHTOJkb65LkTpJuq0H
         bTWQ==
X-Gm-Message-State: APjAAAUYBHVKQds8BBtVlP6CYo7skVjZym8FXbn3KjKt/6QxiCKLf5id
        ++QR8o1/RndOALoNqGReOso=
X-Google-Smtp-Source: APXvYqxnjVycBya9OcagKu5r/lYVAHREqMIN0OHFlE91rLh+HzE+DyCFddjRTujDUYIyZ/CViOk83Q==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr23871392wro.300.1570459796728;
        Mon, 07 Oct 2019 07:49:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q124sm26948893wma.5.2019.10.07.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 07:49:56 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:49:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix inheritance of aux_output groups
Message-ID: <20191007144954.GA88143@gmail.com>
References: <20191004125729.32397-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004125729.32397-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:

> Commit
> 
>   b43762ef010 ("perf: Allow normal events to output AUX data")

Missing 'a', the proper SHA1 is:

    ab43762ef010 ("perf: Allow normal events to output AUX data")

:-)

> forgets to configure aux_output relation in the inherited groups, which
> results in child PEBS events forever failing to schedule.
> 
> Fix this by setting up the AUX output link in the inheritance path.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  kernel/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f5bb2557d5f6..761995f21b30 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12024,6 +12024,10 @@ static int inherit_group(struct perf_event *parent_event,
>  					    child, leader, child_ctx);
>  		if (IS_ERR(child_ctr))
>  			return PTR_ERR(child_ctr);
> +
> +		if (sub->aux_event == parent_event &&
> +		    !perf_get_aux_event(child_ctr, leader))
> +			return -EINVAL;

Could this explain weird 'perf top' failures I'm seeing on my desktop, 
which I was just about to debug and report?

Thanks,

	Ingo
