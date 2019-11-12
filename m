Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E7AC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABDA2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573556899;
	bh=LuK4ZYXLmOoNj5c7uUBukyUIVfCzbY5zWUc51mTkX3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EVMPH+fgcBNRanbwKgLWGlj73umTzGNvL/dz56i+akw0N51fz6ztYjYVb9YXXZ4Qt
	 IbI3+Y+hf/6FBpsWwzHIU3mwQhBEGPtAUtMJAMhniznidYwnQM3YhvIACkWUQbMsuB
	 xItOE46Hf2UXuCW1lgpwxIep59x8Vs8r3ZTng1BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLLIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:08:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41314 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:08:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id o3so19267532qtj.8;
        Tue, 12 Nov 2019 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GWSI5VBMhZqOe6OatG1gmNDzycVYMlsfF+bAeau7Eao=;
        b=W3E7rpmDg+eDNpJ+pAHKPmOlGuWa4xq1Go8GAYnCNGYiY5lWGNiYyB+0sZ94djH+i3
         eTJO2PlAP5GmhMOmqvuyvUT76vgqc/ulvhFV152HpQnKxG0wE7wCkmt9wBfNTTDH9X30
         0r3fomE5p/iZ9j2MphmJ6Yki6NCXfEmAdx8DjPJlfb0sG7o/FB0vlS57KKonya63AiSo
         Bowqqc2WLviwDVpw3nXESI19zH/VZBbMf2bH7pL12w9yTRLTDz7PaJqk339GhYnZyfOk
         fRtS3GmG/pkjN4+UMmSTCIX8mwC0zaLFUPdggJiox5Qm7fmSkJsQvT2qdD9RbSnTdu9T
         tMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GWSI5VBMhZqOe6OatG1gmNDzycVYMlsfF+bAeau7Eao=;
        b=S5Ie9JvTX0/UZHOfvtJZQotQWKG3/rNJhPjiwlw1AUag1Dw8sLwj45yDGSCDJk9OyP
         L2ajExMUgF66+RoUtgiqjBn5mX6QVzgQoLKlFWQSYQQ3hfdgB+QOK4vL4jCyPDO6oLn/
         pxnR9aYh0niHgNP4wZgfeKQg8bp1IKCx92GLIl+LR82KfnJ4MPjHAQfSB/J8XlYuxWO4
         taj7SPWJkvfz+OIY56hU91ocZQzKArTefqEDPJ2tPliV1E8/EwlDiSvgt7o2zeorlOc8
         GqNPV9u/qPesxJCbQ31bEpEfRHcwcFaeXE2xnZ8BqsFCclaDPKF2cPOt9IGhRkSBOq6w
         +ETg==
X-Gm-Message-State: APjAAAXKQVxPUxRkbJG7TgHj7KsPeBVyiyI5fNHn5mUolPjHsJeUVPHJ
        I0PLuh2sv58l+Q0wKYEuN/kO51yI
X-Google-Smtp-Source: APXvYqz3fRD5JT9KcLl3m5/qEY8PdFH7BPwWg9dEzG1Vsb4+27ljHcFFYSybZB66vghVGgU8FqiSMg==
X-Received: by 2002:ac8:53c5:: with SMTP id c5mr31458699qtq.55.1573556895037;
        Tue, 12 Nov 2019 03:08:15 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o195sm8494807qke.35.2019.11.12.03.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:08:14 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:08:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Ian Rogers <irogers@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20191112110809.GA106922@gmail.com>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit d44f821b0e13275735e8f3fe4db8703b45f05d52:
> 
>   perf/core: Optimize perf_init_event() for TYPE_SOFTWARE (2019-10-28 12:53:28 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191107
> 
> for you to fetch changes up to 7fa46cbf20d327d78114b1c8c7e69fabe7c57794:
> 
>   perf report: Sort by sampled cycles percent per block for tui (2019-11-07 10:14:48 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:

>  87 files changed, 22145 insertions(+), 19453 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
