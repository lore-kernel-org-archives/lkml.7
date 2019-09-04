Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29042C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30FD21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2Y7xKaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfIDUEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:04:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42461 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIDUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:04:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id w22so5543420pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vUq6q5rLq1rpkR2Aq011wdvO0ya+rjWQxpONqV3eZoc=;
        b=r2Y7xKaRnaJsuxJ7d1X1sjgGndZKPqGSY4mHbfjimxEe/js2y0q5xwh5Ofo9PObnOH
         jFpmg3gyfWrbsH37smwNTwt5mtQ7zZl4z1sWxsqmUyy5Mhvg3nE1P2qr78dtqaf+aBQj
         cODk1OIu/HjuyGk/UREUeGXrMX/xOWcIvnAfoHJqX4x+wvkaPVeiOfqtjlNupPrMiCxb
         jOyVP6fHwuS49HdTbhlntrWEDX+6trfxMOhCtErqNnkgNLk8eC/Rsa7iP/dAiUfhR6OI
         YBgVwSjUP+XApsFL96rAT6NYMu7YH6hZXFSpuhRHm3viz0Gbre8xPWQE4PNP1rXjMxmY
         A7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vUq6q5rLq1rpkR2Aq011wdvO0ya+rjWQxpONqV3eZoc=;
        b=tSZNn9N89GHvz8ao3ZRsvy5CmL2Dm5kORTqGUNOzq6KVubsnQFW1DoEWnZpQlwbCet
         M4JPR+yTmZzGS67UH8zJ232XcACSJVEvIRcA3dlniDDueg2uNNFkmJb5SeJ5AG/EK4dQ
         Jh0GqKDXpMShF6PYgU8aopZEL3cLE1kPUzHgFRcv4PCxtoCOd7/BEwiLHjP6FdLMOcGk
         Rlv8Kv1z1lJc76cqY82UfHlBi4PaYv+3RP67qKL0Kf8X9cn3ueJvT/W9j8n/TytMd5U+
         fOOeORyHSSyiGEkU5qRnbnUSIzA6el0IupZzOzKC4nvxXme4C6csbzigesLn5DNEkCgE
         /3yg==
X-Gm-Message-State: APjAAAWWYupXfagGWf/4oGMAgUELU0qAI7HwjnVrn00NW6vb7f/xQptr
        DvZYtOsE0ThoOIgbSCGuoK7mbA==
X-Google-Smtp-Source: APXvYqyqELoTqEWKwQaumCgh6k1NrXvt9u9MsAHYP8pjOnJ1PHEhirUkRFSaBs5dgKx5iMe8RjiwPQ==
X-Received: by 2002:a63:2a41:: with SMTP id q62mr36843166pgq.444.1567627446279;
        Wed, 04 Sep 2019 13:04:06 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m19sm3043700pjv.9.2019.09.04.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:04:05 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:04:04 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
In-Reply-To: <20190904054004.GA3838@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
References: <20190903144512.9374-1-mhocko@kernel.org> <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp> <20190904054004.GA3838@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019, Michal Hocko wrote:

> > > It's primary purpose is
> > > to help analyse oom victim selection decision.
> > 
> > I disagree, for I use the process list for understanding what / how many
> > processes are consuming what kind of memory (without crashing the system)
> > for anomaly detection purpose. Although we can't dump memory consumed by
> > e.g. file descriptors, disabling dump_tasks() loose that clue, and is
> > problematic for me.
> 
> Does anything really prevent you from enabling this by sysctl though? Or
> do you claim that this is a general usage pattern and therefore the
> default change is not acceptable or do you want a changelog to be
> updated?
> 

I think the motivation is that users don't want to need to reproduce an 
oom kill to figure out why: they want to be able to figure out which 
process had higher than normal memory usage.  If oom is the normal case 
then they ceratinly have the ability to disable it by disabling the 
sysctl, but that seems like something better to opt-out of rather than 
need to opt-in to and reproduce.
