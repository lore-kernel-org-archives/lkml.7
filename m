Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D54C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4381820665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZufpK1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfFRDMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 23:12:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36271 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRDMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 23:12:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so6772339pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 20:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VI0mXX44qMQTcdggopeFzQJACf5JIgWC9LKQTwTOBTw=;
        b=eZufpK1gsWkbKpd+SuWUyC+JXE2ign8pMqC1AgBRyzVIsAFpGND/pSj3cXupTz6QcY
         SZ3vSY+Qd8OHs7Zu5XfPey1dCJ8ir5Np31dG1FukqnAKzMlGsHROk2LouNEMgzZBR4sP
         8oj3DPJsobTsapCwSXJBWRW2BACJKBJPdR/TdEBhdIlD1i6ix2aBSk00S++ooNPJHSgG
         7/d0YLTS8ddJl0fNDZmuwCacPSNOz6gTGYSnbpiSQFU4OGywPknt2GqGMdxAoUmJl9Vz
         ticwEyXwAvbZGjXuRd2v4a+caxPxPwFd4zEglmBrBNL3EWNScIFKan2lsgWoC1siZsiZ
         dumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VI0mXX44qMQTcdggopeFzQJACf5JIgWC9LKQTwTOBTw=;
        b=fcHl+YrsZvx+s36vIhHcIMuyqMdks6cC51gRG+3Kpy3y3liyQcGOxwEVYmKzppcK5R
         2yoYMZgVj2F2/WQ39cKLE68xJsHAqW8n3FV0lPs2dZvpWVV+GfgwKdGPwZcv/UamHJ/D
         /72yKcSB5AKR4HuDCnpnyAh91BTqpgLhIFNxK53puB3LOv8fULfHDbaO+M8EhB71NcC5
         +DbYEJH5FXGhnP5fpHCfDX1G209HlZmjJ42Z8IqUGTk5Xm7EpPJP8SNZc4HRbx3p7TW/
         xv0gNkKJ9K/G/YHr6mMsk/biKKjmCUUEl3zHTGIVcz28YO7oE4jd12r2EF6hZAyTGslT
         jctw==
X-Gm-Message-State: APjAAAUlgnEznlOw/zQxQi0N/CC5l+nSkw7XUyS6pUzm9dsFHsmq7DGj
        wjS75DlaTJDh7W6ja8C14LWywA==
X-Google-Smtp-Source: APXvYqxXacCxWSlAAA9Gg3JiEbVwMPxITCDe0C7OP3eKDB6FruOTvFFfKisQnufJ7seIa2hMi+9qyg==
X-Received: by 2002:a63:490a:: with SMTP id w10mr531465pga.6.1560827543282;
        Mon, 17 Jun 2019 20:12:23 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id m20sm662667pjn.16.2019.06.17.20.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 20:12:21 -0700 (PDT)
Date:   Tue, 18 Jun 2019 08:42:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190618031217.63md32da5pzydqia@vireshk-i7>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin>
 <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
 <20190617150204.GG3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617150204.GG3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rafael

On 17-06-19, 17:02, Peter Zijlstra wrote:
> On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> > Hmm, even if the values are same currently I am not sure if we want
> > the same for ever. I will write a patch for it though, if Peter/Rafael
> > feel the same as you.
> 
> Is it really the same variable or just two numbers that happen to be the
> same?

In both cases we are trying to keep the load under 80% of what can be supported.
But I am not sure of the answer to your question.

Maybe Rafael knows :)

-- 
viresh
