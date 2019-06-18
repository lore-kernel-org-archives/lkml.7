Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20871C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1D120873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="sGZA352w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfFRQlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:41:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40536 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:41:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so3957370wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/9WPnwDs6vWyGGIV0ZU0O19QmFJGO7b/u3NuHDRcr/U=;
        b=sGZA352weKhrdLLfesdqJofGJKNOj4XHPdoIe53SrTjsIqtk4mqdDgEMsqW6t6TvLz
         p5JcyZVCHjBWf90ZzgSY/R8x4J8RZVymPqFr1uK8+HaHAr+aHZP4dYy/Lp64gx0rf6io
         v3MjJVXdbQxDFzWcl9IzizQjd7J3L7C8bjsp/WeYFGhxg9BqiVxLXzPg9LTxWU65Y5VC
         lM0tzTP8eul9ppIdj0OjeFd2wjPG2YlTNHO8zCaC654CpN3o3bL9cYD6ecSuIqqGyau1
         2pxiBoQXCYXYicxpgTbuiiMWBo5xWW0opYWsLURZsalCiDZejNG+JS5K/vveYult3lHA
         GZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9WPnwDs6vWyGGIV0ZU0O19QmFJGO7b/u3NuHDRcr/U=;
        b=a7CVN47U2i2MGF/nxpsF185OQbrZitGRcKO+eNe/VpwZ5pKDm0ljTv9io+xlpR5nSR
         IzS+keX4Wve6toYDr2iBqdIckCXL6APIJ4VR1AV97z8Y6kRfCahg78Vwwi82L/W06hnb
         7KEWAT1Kwx6I8jw8Lj4kgKtb6imU96nnQEbj2FWVh2khdp5rdvudSkqLH7L3Qh3b/LL8
         yS1lxHra5EGVlqqSuZQBJJ1H6C24PKheJZnPyhxSFiMU0M4SBnTmNnDH7+L2BbZv0sJA
         hAsto9ADb0XEegr50jCWv7RZ3B1kxriIfUxoapTwtLiZ7GIKMdIXYpYS8N5jBsl5C3vG
         OHbw==
X-Gm-Message-State: APjAAAVZTwmjU0NQdxN+f20YT7HfD7jrKZ8I4kmhiFqa7hO0JwOOxchc
        3CiRbFdnf7EoFqyu/FwUcO/PtQ==
X-Google-Smtp-Source: APXvYqw+WEkXeZglwFOJhRG7aWRo/6GuKbXu43lAOCD1nW4ClKyUR/NaFPcrRHQxzd/etQwW2xePeA==
X-Received: by 2002:a05:600c:2149:: with SMTP id v9mr4370443wml.141.1560876093692;
        Tue, 18 Jun 2019 09:41:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:203:fc05:dec:5003:37b1])
        by smtp.gmail.com with ESMTPSA id n3sm10963364wro.59.2019.06.18.09.41.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 09:41:33 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:41:31 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 1/6] sched/dl: Improve deadline admission control for
 asymmetric CPU capacities
Message-ID: <20190618164131.GA88066@google.com>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-2-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-2-luca.abeni@santannapisa.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, May 06, 2019 at 06:48:31AM +0200, Luca Abeni wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
>  
>  extern void dl_change_utilization(struct task_struct *p, u64 new_bw);
> @@ -785,6 +786,8 @@ struct root_domain {
>  	unsigned long		max_cpu_capacity;
>  	unsigned long		min_cpu_capacity;
>  
> +	unsigned long           rd_capacity;
>

An easy one: we are already in root_domain, can't we
s/rd_capacity/capacity/g ?

Thanks for the series, looking forward to seeing an updated version
soon. In the meanwhile, I started backporting and testing it.

Cheers,
Alessio
