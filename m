Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA4C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 05:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E102084C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 05:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6f+R3oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfGUFbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 01:31:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46944 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGUFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 01:31:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so17542417plz.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0Le7BqRT6Z0VrMYQMdMrccYxW568r9HQRKBhivo1yJg=;
        b=I6f+R3oqknatK1iJ86QwGrYUdJOvkd9qoPj1qFPvpbX8CZ2XUkdpP/UOZ4yWz/n1c2
         X8WbLycy1TPVvPobwvAkMEz8K/7u1qn6fFx3mAeF3onx8Yxksxk7f9R7QgDLRySrGTVg
         R5gn8KyJiVzpAnt7xK9XSJMjCeTcgw1U2SCs1B4tOPp0X8V5eIHwNG0F9JpY8T7Ki4jz
         Vb4V2DrH42zxoNQU35vboGuRkONu3RuVqanw1W6o80A6E4gxFRYtR20loYVkbRIC0AUu
         NU5vC9vth9zv5iyUmy4AV+PbS6kRJZd76ElnUdD9BUM1OFNUVjjLOec2eUE3o+TZYm6G
         rsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0Le7BqRT6Z0VrMYQMdMrccYxW568r9HQRKBhivo1yJg=;
        b=kXvDQgDTkCxYcc8Yv2zRDwS1gm4NX5WbgVgRJnTWZvpD4IkBd7z08MQ56YGGWwlhAm
         PIO7pLO1RM5MqgGGEuwbTkklH/pMj4XdpV3LGvxGoWdftRXvOaRNDuiuvNYv2KkZpHez
         dVrDAy5Tml4dlO93PxtnehqwOtwlOwz+wu4otFSr7Kzla6A6p24DLI/8acIIVi4c4OPO
         8CZVNu7qbsMSJOgcXbgoYfD0jZRDZg9vUhNAsWGavJMjigwCzJXp3XPS45+6+9lTNm/i
         ISEHOJSMrmwkpr/Ff/iN6WhxZdz2V8FRthnetMw6+Wy8vTMJGVyYZ5bMzEedm4KUt/V2
         4I0Q==
X-Gm-Message-State: APjAAAWW9kSGxn2+Y6wdnUknNoW2LK2E5ubHQfm+m3CHhSvjScn2s23u
        jG4b+AUpa6ucuFVBBUx3X/G+Ew==
X-Google-Smtp-Source: APXvYqz7cWhPAArR1h2ZbpIlwLg5H+HTAbbJ3obPU9AqRwpJljq/4AhW/XlqOV7mF/jgf+1t7haPtQ==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr65141004plr.185.1563687078830;
        Sat, 20 Jul 2019 22:31:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l4sm35574896pff.50.2019.07.20.22.31.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 20 Jul 2019 22:31:18 -0700 (PDT)
Date:   Sat, 20 Jul 2019 22:31:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Waiman Long <longman@redhat.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm, slab: Move memcg_cache_params structure to
 mm/slab.h
In-Reply-To: <20190718180827.18758-1-longman@redhat.com>
Message-ID: <alpine.DEB.2.21.1907202231030.163893@chino.kir.corp.google.com>
References: <20190718180827.18758-1-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019, Waiman Long wrote:

> The memcg_cache_params structure is only embedded into the kmem_cache
> of slab and slub allocators as defined in slab_def.h and slub_def.h
> and used internally by mm code. There is no needed to expose it in
> a public header. So move it from include/linux/slab.h to mm/slab.h.
> It is just a refactoring patch with no code change.
> 
> In fact both the slub_def.h and slab_def.h should be moved into the mm
> directory as well, but that will probably cause many merge conflicts.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>

Thanks Waiman!
