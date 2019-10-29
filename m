Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5CCCA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A4F20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVim8Y90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfJ2A1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:27:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43335 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ2A1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:27:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5so6600143ply.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=AiTM/hFzZNrdOB9v4mD66XPt2o1IDEJmA43+q3Xscl4=;
        b=dVim8Y90Dyajv7eOjSYoa9T+ycqr3W9RATP53DHR8qvHal8FTWUnFjjKOGYzC91GIu
         z2XjoBMN0EllhKSi74vfTdzGuwKW6LoRQILzeLXASn/BmnsashLhZqkvIQmZ93zPY2W8
         eXCBG+6tmKgxMwkn2jnPs2ZOa7lBVA7okUXQ6B7mY3IS+SZn75ZDkLmwqxCKUuOkUIeh
         vOb3lzhMuhoxE1RS7wbGTIYHU0Dpfsoo7Dao31Q9hc+QKhjpc1AXAhCAlmh1/7OzVahS
         YWBfnuYMTHpRgxoCNcTp9vYleduPPmX8c4WWU+us6tRUqAUEw9Ow45NsB4clG4M0zSnr
         OXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=AiTM/hFzZNrdOB9v4mD66XPt2o1IDEJmA43+q3Xscl4=;
        b=kmkdXdeXeLbDW7wGmusxZYWpnIzCK2kcDaTiMBsrLXrzthVs2c3nfl9MSfT04nsmXX
         j3yN9Oei6sN6kLJUpAYziIuTCxFFeASFDHuEp9yQvr8SqExo2p61nAaOmTfm5cxP7DAY
         ZAqFDogcMquKQp5IiRD48MPa4KDxxUjCFxqgKRopvKvm82pg9LPTD4Mp/1Livp+Onv2h
         mAS4ZevCsSRNVosQ/mQIUQAvXlpafHwtvcsGrXTTkyvDP5k1cV5XFcvvHLJ0s8cZ81Bb
         p966ZCu4+YGc+AwIaotn7uxHy1sJLj5lWN+kTfQDyO1+8gxGds8nhxO4LAiYBEgSVNjE
         5Dng==
X-Gm-Message-State: APjAAAVvyqw/717R19XK25esZUVTUOL85WVd3ZJ0sZ5m482tJt0kELBR
        Oxzj2VDJIKGY4iE7cR6e2uETctOXfT8=
X-Google-Smtp-Source: APXvYqygLn7Pq3MlrbpOgp3ztQYhCvqUx9AFtRxN+xXp6Zxq3MQnQDnMzOIdk5WMXNf/GfgxLDTmFw==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr870220plq.177.1572308821720;
        Mon, 28 Oct 2019 17:27:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y16sm3469063pfo.62.2019.10.28.17.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 17:27:01 -0700 (PDT)
Date:   Mon, 28 Oct 2019 17:27:00 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: rate-limit allocation failure warnings more
 aggressively
In-Reply-To: <20191028194906.26899-1-hannes@cmpxchg.org>
Message-ID: <alpine.DEB.2.21.1910281725270.114830@chino.kir.corp.google.com>
References: <20191028194906.26899-1-hannes@cmpxchg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Johannes Weiner wrote:

> While investigating a bug related to higher atomic allocation
> failures, we noticed the failure warnings positively drowning the
> console, and in our case trigger lockup warnings because of a serial
> console too slow to handle all that output.
> 
> But even if we had a faster console, it's unclear what additional
> information the current level of repetition provides.
> 
> Allocation failures happen for three reasons: The machine is OOM, the
> VM is failing to handle reasonable requests, or somebody is making
> unreasonable requests (and didn't acknowledge their opportunism with
> __GFP_NOWARN). Having the memory dump, a callstack, and the ratelimit
> stats on skipped failure warnings should provide enough information to
> let users/admins/developers know whether something is wrong and point
> them in the right direction for debugging, bpftracing etc.
> 
> Limit allocation failure warnings to 1 spew every ten seconds.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: David Rientjes <rientjes@google.com>

It feels like the vmalloc warnings should be treated with their own 
ratelimit (pass a struct ratelimit_state * to warn_alloc()) but that's 
outside the scope of this particular change.
