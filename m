Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED80C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94BA21726
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Rg3JGm7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392704AbfETRFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:05:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41212 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390006AbfETRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:05:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so7071811pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ZOI+jnwXBptD9UIpostnVMZFPCwcvxnpKvL3qurL40=;
        b=Rg3JGm7cAcDM+AZNutQuRwGkJ3ubXbt1UCwOCgZnkJntyOzhCrWnunCiEjWY7ROSIZ
         kVmBbyBsGGB57A5oVMp546xpWJgwU/oSoyDYqohN31no/hHulLW0cV3TFXQxHRGm3Arh
         oZI0B0sNElaQefwHOOurYmhojHza1z+7f0MdJSYwJgf0UX78I0BFmHNhkkyTJP+ysJgA
         1oq4KvyqLM9FGoFmGF0bhA3gzuw3Xcn/MOZUKRVRWJpoiE+3D/NOeDKnUVfhlEhq8tFr
         ACelj15Q04D4dmGoY8dB6fOkc4qS2Hmb9f4IVHnDWYoNGwTJItV3oZNqdJ6Lf+b5E2oC
         /1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZOI+jnwXBptD9UIpostnVMZFPCwcvxnpKvL3qurL40=;
        b=tdQ0b/McJPpDZIqnN7SeA5ylS0nv3sgIDtu9QiArsGaXyxBBNhnZ2AACfzBHcyPNae
         n00zpRy53G2zZN3PkCKqxxX2KU6bFW1Ksrmn5e0Z1nD3Z7i2hwgrVtVrs9zhsaJidrkE
         AYdSkd/QxDYkmYh65wwIjDHyaOGDXl6HxirjmuJ5E7Cx4MKEoa/ySVnMeOVDpOAf2HWy
         8uWRorsLyk7bhpXWY2NWPoWXCurOMVOnJAefAMyh9QY5xmDN9it33WB7lZfyc1rUQ3SB
         G22RG6ARCxZ27X+Jg6z+9Wnyjlfw1lOKVi0sEOIvcOeHzyxJ35nKY97+bTON+Yjq7SHS
         91sA==
X-Gm-Message-State: APjAAAVdA255nny5gWJcESo7WD9kqre8UdJBcFFpVoxdjNYcmDsz8NCK
        GIrNdtUMo6/NvrqPhtZLMwJFdw==
X-Google-Smtp-Source: APXvYqwYUPMF0FEJQ8SH6f6V9L+pAAf6oW7lozkMuesu1RZqnBX5kL/J9WlcSj5ZD7fx0NEgV+if8A==
X-Received: by 2002:a63:1045:: with SMTP id 5mr32327108pgq.55.1558371931150;
        Mon, 20 May 2019 10:05:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:df5f])
        by smtp.gmail.com with ESMTPSA id u76sm21219972pgc.84.2019.05.20.10.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:05:30 -0700 (PDT)
Date:   Mon, 20 May 2019 13:05:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, memcg: introduce memory.events.local
Message-ID: <20190520170528.GC11665@cmpxchg.org>
References: <20190518001818.193336-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518001818.193336-1-shakeelb@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 05:18:18PM -0700, Shakeel Butt wrote:
> The memory controller in cgroup v2 exposes memory.events file for each
> memcg which shows the number of times events like low, high, max, oom
> and oom_kill have happened for the whole tree rooted at that memcg.
> Users can also poll or register notification to monitor the changes in
> that file. Any event at any level of the tree rooted at memcg will
> notify all the listeners along the path till root_mem_cgroup. There are
> existing users which depend on this behavior.
> 
> However there are users which are only interested in the events
> happening at a specific level of the memcg tree and not in the events in
> the underlying tree rooted at that memcg. One such use-case is a
> centralized resource monitor which can dynamically adjust the limits of
> the jobs running on a system. The jobs can create their sub-hierarchy
> for their own sub-tasks. The centralized monitor is only interested in
> the events at the top level memcgs of the jobs as it can then act and
> adjust the limits of the jobs. Using the current memory.events for such
> centralized monitor is very inconvenient. The monitor will keep
> receiving events which it is not interested and to find if the received
> event is interesting, it has to read memory.event files of the next
> level and compare it with the top level one. So, let's introduce
> memory.events.local to the memcg which shows and notify for the events
> at the memcg level.
> 
> Now, does memory.stat and memory.pressure need their local versions.
> IMHO no due to the no internal process contraint of the cgroup v2. The
> memory.stat file of the top level memcg of a job shows the stats and
> vmevents of the whole tree. The local stats or vmevents of the top level
> memcg will only change if there is a process running in that memcg but
> v2 does not allow that. Similarly for memory.pressure there will not be
> any process in the internal nodes and thus no chance of local pressure.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

This looks reasonable to me. Thanks for working out a clear use case
and also addressing how it compares to the stats and pressure files.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
