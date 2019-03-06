Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD49FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7274620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551888721;
	bh=de3hxMyklibF8vZdKauQbrL40O5VKkFo7YXp6sLEAoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sXUjduFHz/FKRTzKnFzdvfYxZZpobV++v5XnTiIqounIp9R9j9xDPgUXLfwcyT8Kt
	 3WuP+ca0tnbjuEkvawEm2/60DUR70rNYo743Y5zdFF/HfmUmVIlz0O9NqYO4nefjoe
	 nbb6RPTVprndifL9MIlBjQNWRLt3kEYSw55+Fu6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfCFQMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:12:00 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34658 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfCFQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:11:59 -0500
Received: by mail-yw1-f65.google.com with SMTP id u205so10436069ywe.1;
        Wed, 06 Mar 2019 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2ShychGTMUsUT8Zfh0SFhrOWqGhIAMgWTkjKkiV4qg=;
        b=L7gfRNkxcA5vWx7QJVX4sBp0N3pcNjxGTwMViloTi6CFxQyN0OjRLX90j18nNi2Kyn
         itmCaheEvuQKqTP+5l/5PBBRR8GSXDjGrkwxpYcZCFr+K/f3kNa/Wuacyh6M2k/Gr8XX
         g/RgwSGKcBq04OJi++uh7hFLDLhzk7YV4QjXy3ggHqTCzWjLWP00cLz1CWqPl2hArcYm
         pwAZNDuUSxdTbTiS20+K0nFEp9AK8ZG7KcIIlS5cQL7L5qESyGaB248LrhpcceSL1n/P
         sHaSeUdasPc1VDzhNd0N88XQO8z+DnUQtEQl18RwGoUsWYmKzn+bD/WiZC3DuBqpSk2t
         pWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2ShychGTMUsUT8Zfh0SFhrOWqGhIAMgWTkjKkiV4qg=;
        b=jbu6zji1ANPPQlYbnlK7kfGDuG25lnO9fZKYtxa9urL4zjx89tgTdrqaYQ7fibCVpO
         +koGpxVIhvWpcJkxc2vlwghQPhKpN9O6jf/wk0TxSWDm7YVYQsWs/DJlr1tXC2eRNl6K
         ytELYSPqgBezQ6Tcp99GES4iuW9WAevhUkY2033cAuKXBN6Mhu9/toP9aD5UKlC1ovRX
         8qnevYuJ9JA+CZQNtKi4VE6XvTNQGm/5VN0MTLPI71czQyaOd4ToXIAOFrb8pjmmyBY1
         9eZLotXo1uKgUIgmCMxSOWt8qkkCoea+9AeUjRHiGQbhrIwVAwyPRNYFRDuL9xlO32w2
         ukRg==
X-Gm-Message-State: APjAAAVpf6G8vHR/TG9SwZykOu9pSn9OqfIuLq+c8pejdZgErjfkC5fu
        FL5DZlQnher/5ySt2tYsEAg=
X-Google-Smtp-Source: APXvYqw45Pj/yxIPOVcogMnLGlpIQGJpq2XoD0G3omLiY28kcwNQFFiqH0UwUuO0gR7oGSBBYTnxVg==
X-Received: by 2002:a81:4e45:: with SMTP id c66mr6139251ywb.462.1551888718421;
        Wed, 06 Mar 2019 08:11:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6238])
        by smtp.gmail.com with ESMTPSA id n82sm616856ywd.37.2019.03.06.08.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:11:57 -0800 (PST)
Date:   Wed, 6 Mar 2019 08:11:54 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/core: check format and overflows in cgroup2 cpu.max
Message-ID: <20190306161154.GF50184@devbig004.ftw2.facebook.com>
References: <155125520155.293746.7017401430432481979.stgit@buzz>
 <20190305155741.GD50184@devbig004.ftw2.facebook.com>
 <4c0f1d90-b147-e1cd-20c1-0cdd869f4f15@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0f1d90-b147-e1cd-20c1-0cdd869f4f15@yandex-team.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Konstantin.

On Tue, Mar 05, 2019 at 08:03:24PM +0300, Konstantin Khlebnikov wrote:
> >Ditto as the blkio patch.  Unless there is a correctness problem, my
> >preference is towards keeping the parsing functions simple and I don't
> >think the kernel needs to play the role of strict input verifier here
> >as long as the only foot getting shot is the user's own.
> 
> IMHO non-strict interface more likely hides bugs and could cause
> problems for future changes.
> 
> Here is only only one fatal bug - buffer overflow in sscanf because
> %s has no limit.

Ah, indeed.  Can you please post a patch to fix that problem first?

> Strict validation could be done as more strict sscanf variant or
> some kind of extension for format string.

I don't necessarily disagree with you; however, what often ends up
with these manually crafted parsing approach are 1. code which is
unnecessarily difficult to follow 2. different subset of validations
and parsing bugs (of course) everywhere.

Given the above, I tend to lean towards dump sscanf() parsing.  If we
wanna improve the situation, I think the right thing to do is either
improving sscanf or introducing new helpers to parse these things
rather than hand-crafting each site.  It is really error-prone.

Thanks.

-- 
tejun
