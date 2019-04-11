Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33FFC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41FA2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="EqTRBwrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDKRTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:19:12 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44180 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:19:12 -0400
Received: by mail-yb1-f194.google.com with SMTP id u187so2492646ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cyJyq9xBxqcKv8h0VQs22akH4SgmjPKIUCFKPUkzKqQ=;
        b=EqTRBwrHJfArZzz19rJ1yu0nWJBZrywhQAaYqkIgR+Eemxw9LBes2KIk9kITGbiSPH
         K23cbLMim+6mGbba7xndiogldsHAPk9PSrRK94PzAiOXZcQKHv/42dzB+WkLLRxH1DGg
         2SIoDRKdmDs4UYYrYghG6NoocONFk5ugNSSsL9/QpbUldzzsAyXUHT8Sul5Xbsx5tpF/
         EqMvnrchcl4/8l0CukILEamDQz8NU5spc+HA1OLo7K0h6ykbR8b45xxj7NumciQQLroX
         iUNG4kw04OasQi1BECafxLzBmzY8IGmnVDpgyGYfQRDnJwJgY4rNX3nU2M3+CwAdO3kc
         t6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cyJyq9xBxqcKv8h0VQs22akH4SgmjPKIUCFKPUkzKqQ=;
        b=k+zb8vTYu5bF+kZXR5J3Z/klI+rfip/ZZUMO3M7x0tVTaveXJftYB7X2dzp0uQlLDm
         wtT3tZ2Tru1GJ0w9otRoTW1PVhnIPmkNoFy3OBBobAk5x6vz6y6S4Gb59pO2sgDdTspY
         sosrHPMjjiMO1em9QU/GNhwrugKB0WaFsbak7gBhQZK9symyc4q7M08vLcoBm7pYSt82
         dn355ULb1vuzShiof5eEqFF4xfRXTZg3Lyo55P9qOxC1s6s/Z3w4D/Odq58R35apGvtE
         lIeEXn++Evp0CBA9lISDDhonj9dglEG1M1IANMdMGgnwojW1R2egH3QY1D0cRVhOMsoD
         f4bQ==
X-Gm-Message-State: APjAAAVUNZ7Hm6iYkFZjVdsMqf2YuJXYrIuHdooixYvrsAoA+6kulI35
        w7ps5q9NvMQZye7wPw6CoI0rhA==
X-Google-Smtp-Source: APXvYqzn4RYWtX/ATfNEwEVd98+0YcQHPTse8AbadNFkg/MSQ1oUxMXbh2lHxc0VJKkNgADH4uoNNw==
X-Received: by 2002:a25:2d45:: with SMTP id s5mr41609862ybe.272.1555003151188;
        Thu, 11 Apr 2019 10:19:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:2a81])
        by smtp.gmail.com with ESMTPSA id h3sm15971243ywa.61.2019.04.11.10.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 10:19:10 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:19:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        rientjes@google.com, willy@infradead.org,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        penguin-kernel@i-love.sakura.ne.jp, ebiederm@xmission.com,
        shakeelb@google.com, christian@brauner.io, minchan@kernel.org,
        timmurray@google.com, dancol@google.com, joel@joelfernandes.org,
        jannh@google.com, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
Message-ID: <20190411171909.GB5136@cmpxchg.org>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411105111.GR10383@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411105111.GR10383@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:51:11PM +0200, Michal Hocko wrote:
> I would question whether we really need this at all? Relying on the exit
> speed sounds like a fundamental design problem of anything that relies
> on it. Sure task exit might be slow, but async mm tear down is just a
> mere optimization this is not guaranteed to really help in speading
> things up. OOM killer uses it as a guarantee for a forward progress in a
> finite time rather than as soon as possible.

I don't think it's flawed, it's just optimizing the user experience as
best as it can. You don't want to kill things prematurely, but once
there is pressure you want to rectify it quickly. That's valid.

We have a tool that does this, side effect or not, so I think it's
fair to try to make use of it when oom killing from userspace (which
we explictily support with oom_control in cgroup1 and memory.high in
cgroup2, and it's not just an Android thing).

The question is how explicit a contract we want to make with
userspace, and I would much prefer to not overpromise on a best-effort
thing like this, or even making the oom reaper ABI.

If unconditionally reaping killed tasks is too expensive, I'd much
prefer a simple kill hint over an explicit task reclaim interface.
