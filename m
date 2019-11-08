Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D12C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DC6214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDUbybhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKHOd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:33:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKHOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:33:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so1978883wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7BaDAqye/MZOMNF6OpF3ycCkb/as2uNIb3zQDCiqUjc=;
        b=QDUbybhVv+/bCsU20a1eVquTZ1THt+bnBgZp0dAcfILCl5ZihWETCLOhgHVaP66/1S
         lVTH90Lp9U2khi+RuOelT6cY+SEVlaJ6E1DID/RUjzP0cHilCn9XOicHkZTgsQQlv+dZ
         fqL6/p4fNOj0icjrjB82CW4fyEauM1c5BBLs8MRK9Qoj0nmelpAtMWQnlDsA9lIiwYB5
         D2Pm4oYspSFkzP61huuKqHVhlpih/J6m0MNdez1lq/MDK/QMxihKG3WKUBGcBhOA/szP
         jOcCSPMoDxHXGWQ7pNekb4bJmvFn6EpDAliQwDRbGxhuLP9KhFpf71qipeFKMZo88U2s
         ou2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BaDAqye/MZOMNF6OpF3ycCkb/as2uNIb3zQDCiqUjc=;
        b=tSj2rSz2hirfPcqeUUIWSPWd4IWAiWMsdLk1j09ULc6dz9gpVnv0R6ovZ0oBw9Dswv
         4vPRcwkv25/9h4z3V43e2we+9bKGhqJBzpcrH8lN4XZAbZ0Dk617rOb/S+hzLY0kQDqd
         e30ETsuTPNaaxPUaTZPbilJrwNZJCpK73DHfti8hEYFH96J22PCz5tFn/pxQydE9sCK1
         N2cbD3ezmqUREKP96SRo8bZ4aWndD/4H4yEctMA9dcUZOSk8GLAb5xazxkamx8jm5fGx
         +WxsVKxEkdpDAj37mWpXRFbQgS4mX6n4TXI7y6jj2jrPria26VxEsIProbLlz2M6aUax
         e0pw==
X-Gm-Message-State: APjAAAVAtFXiiXDUe/w9h6oB2mqLcDrp9YM0y9JjhycMIUYeYTqbLD6+
        8QLoz6WMCkDYSk0WTWtSuUyuJA==
X-Google-Smtp-Source: APXvYqz1fLoYAlz2ISDepKyhQE5mLc3+UnCCd/xSITQwQkniF7m4o8VM/9Mu0VxBhIJwcv3IhkCsNQ==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr9089701wru.146.1573223632112;
        Fri, 08 Nov 2019 06:33:52 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id x205sm9432142wmb.5.2019.11.08.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 06:33:51 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:33:48 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH 4/7] sched: Optimize pick_next_task()
Message-ID: <20191108143348.GB123156@google.com>
References: <20191108131553.027892369@infradead.org>
 <20191108131909.603037345@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108131909.603037345@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Nov 2019 at 14:15:57 (+0100), Peter Zijlstra wrote:
> Ever since we moved the sched_class defenitions into their own files,

s/defenitions/definitions

> the constant expression {fair,idle}_sched_class.pick_next_task() is
> not in fact a compile time constant anymore and results in an indirect
> call (barring LTO).
> 
> Fix that by exposing pick_next_task_{fair,idle}() directly, this gets
> rid of the indirect call (and RETPOLINE) on the fast path.
> 
> Also remove the unlikely() from the idle case, it is in fact /the/ way
> we select idle -- and that is a very common thing to do.

I assumed this was to optimize the case where we did find a cfs task to
run. That is, we can afford to hit the unlikely case when there is no
work to do after, but when there is, we shouldn't spend time checking
the idle case. Makes sense ?

Thanks,
Quentin
