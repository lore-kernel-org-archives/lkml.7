Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B599A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eklIOp+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbgAISwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:52:05 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51916 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgAISwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:52:04 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so1508334pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2BBH+3AnXzeFa/U3IS7qGFZcMtEqxZT7wCj3mRBcmeM=;
        b=eklIOp+zakQC1CE30sXqMuWzAwbyxZX8INDxq4BFkauoMMbdQ17lXR/YY65/cbXQ45
         WaN7oI/vJTlxvxToHdamg6mLQomJzQulnRCGUbZceY2CzjGzTD8sJeTKHRgIKWwwEevq
         rYiw6LQC0MJ7yxDH44OqGwqt74Nt03fWbVUE+CV+sFa+mMVT9MXWSPjDJB9QEKeWbMkS
         pu/xIlbtYzrdTy2A0YpgtvbfD6SPFwyDz7bhKJdo/Fqrxw9RrPP9Ya2Lv6KnwMa3B29w
         Q4qCIzysKksxVLY80Wshbr7UR+tk8nkzbwA6lSE1ht7jWyXNE8DH00YJQGQzk4S8T1hZ
         jd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2BBH+3AnXzeFa/U3IS7qGFZcMtEqxZT7wCj3mRBcmeM=;
        b=MHS6feiNFoT6HxofNcox2rpOgGdCJ57q8BfaZ+ZWtLbNAj++VxQZld+qqg/YYF+R62
         vp03aNlsmeGxwtgguyYjO3yRyuv3gKw3blZDn8g3yePIZxoKiDbCnySJO5bU0VZXKAp2
         +WClaBO/gpk/Plbtdbq4j3u0QJxSyCOf1geif3TjDEe8DIfJ7D4HyBoRA2v/Dr9OLACb
         ahXDyOQ67lotmbMw5G/i7iDBfzxIjatmgpZeLFCOczZQRLaR0b++F8s0abJAIyX5pwO6
         Xl2Yt9mUqZJtOjPPATem7pl73yE4iWnGGp0WZrma7FtRnOB/XTaKj7VDCMrYSJ3xIMIR
         Wg/w==
X-Gm-Message-State: APjAAAUzq+pQRQ29E4v7YWGvda9PSYabxYcigbzVd/U/AaRY2zY3X0Xc
        kFE2rBY1hgYLYsw5jbI76liKpw==
X-Google-Smtp-Source: APXvYqzu1AT5fUNssLnQhi7nJ1GkArk3aIGlfIGILpdyhzsUwYdHio63+zgbvvMa4cim9caHMu4yxw==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr12900090plt.185.1578595923103;
        Thu, 09 Jan 2020 10:52:03 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y14sm8351242pfe.147.2020.01.09.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 10:52:02 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:52:01 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200109143054.13203-1-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001091051160.57374@chino.kir.corp.google.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020, Wei Yang wrote:

> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.
> 
> For example, the potential race would be:
> 
>     CPU1                      CPU2
>     mem_cgroup_move_account   split_huge_page_to_list
>       !list_empty
>                                 lock
>                                 !list_empty
>                                 list_del
>                                 unlock
>       lock
>       # !list_empty might not hold anymore
>       list_del_init
>       unlock
> 
> When this sequence happens, the list_del_init() in
> mem_cgroup_move_account() would crash if CONFIG_DEBUG_LIST since the
> page is already been removed by list_del in split_huge_page_to_list().
> 
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Acked-by: David Rientjes <rientjes@google.com>

Thanks Wei!

Andrew, I'd also suggest:

Cc: stable@vger.kernel.org # 5.4+
