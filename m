Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56AAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB10205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5OZvw01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEFQLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:11:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37631 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfEFQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:11:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id o7so3376698qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rcnpY/WIFVK/FPBCViUfADoM+sRIp6prt/atWTfqvXk=;
        b=e5OZvw01SDZXkXWSaqStHn7dXe8ak/ryKAdyZsXZUBmRNtmMsCAebrTHuvU2uPMOXd
         09Mvl5yhsqg49QlDf2sRLYeGhpvwDZrXEWN0YpJveouDezc2PAfIgYT9R+iJ0on1jk38
         krCrIeZLgHRBPPPTCbTLvxB+RIbjG/t/X66E9kpOC8Dj45bOq6QtcrrkBF9/vvEN8bCN
         rwjj+pAK51mxrvy0LJ2jyzggxufpi3wauSSTvrfibQieeGD/cJIsVHHIRtBp/4IjIy3I
         sZgxXbpfifcwraWl6N7jyxMx4oYsbgvvhvjin+hVNTYfKNrIf7uBDZJ76lDc+ueU6OgN
         cSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rcnpY/WIFVK/FPBCViUfADoM+sRIp6prt/atWTfqvXk=;
        b=o4MjZsAmlqq6neIzigzQLmLtsflEuq3SilsqNfTRDRVfJ0IFNToXFyfgthjKoN54RG
         8BvYNQo3FAuagH7mynQdHtLQ9hMY6FMbQvF37PS6pq23aSae6wOttNfEdEt1XMaRZZ+3
         NHNq2EaSbtqwDBuE0ZmYEvRp/NbAQw15nOGVMLQ1Mwb0idHP7Xfbme/189se23OLkIdN
         UXz/476eR17/avdJBK7srzF4n9B20KZzgOXQQhucgGWOLnqEOVeySGHHXmjtVMVEo3kc
         wBBAfJ4V4ny3iajAP1t3IPVqTPvSRjtAIBscChPpf0OR+DDQJn60VmovVIheSChiMRwq
         7jeA==
X-Gm-Message-State: APjAAAWiIahpJXQBdzCab88J4GDuZzwFkTSXKwEZlVp91MzfCCwhR/Xk
        wAHWF657iu0BQ3Li+1HOI2U=
X-Google-Smtp-Source: APXvYqzEUboErIzwlyiC2jvb9AsaZw5lakCa05FDLeg4NZvw/mxX3oYLHazDmD6OWVGqaAWWDsiErA==
X-Received: by 2002:ac8:26e4:: with SMTP id 33mr21675911qtp.388.1557159103213;
        Mon, 06 May 2019 09:11:43 -0700 (PDT)
Received: from llong.remote.csb (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 11sm6429783qtp.88.2019.05.06.09.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:11:42 -0700 (PDT)
Subject: Re: [GIT PULL] locking changes for v5.2
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190506085014.GA130963@gmail.com>
From:   Waiman Long <longman9394@gmail.com>
Message-ID: <a5ee37fe-bdcf-2da7-4f02-6d64b4dcd2d3@gmail.com>
Date:   Mon, 6 May 2019 12:11:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506085014.GA130963@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 4:50 AM, Ingo Molnar wrote:
> Linus,
>
> Please pull the latest locking-core-for-linus git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus
>
>    # HEAD: d671002be6bdd7f77a771e23bf3e95d1f16775e6 locking/lockdep: Remove unnecessary unlikely()
>
> [ Dependency note: this tree depends on commits also in the RCU tree, 
>   please disregard this pull request if you weren't able to pull the RCU 
>   tree for some reason. ]
>
> Here are the locking changes in this cycle:
>
>  - rwsem unification and simpler micro-optimizations to prepare for more 
>    intrusive (and more lucrative) scalability improvements in v5.3
>    (Waiman Long)

Is it possible to pull in also my "locking/rwsem: Prevent decrement of
reader count before  increment" patch for 5.2? The rests can wait until 5.3.

Thanks,
Longman

