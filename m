Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC2AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BF821D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcOIF8To"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfKGUu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:50:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44346 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfKGUu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:50:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so1573933plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4FmP6QMYk1IkFwbyuKk54A754mIP1LbWO9TYLDO2YAk=;
        b=QcOIF8ToXXUNDLnRYvQMOYyW3Y2152JdCRnI2QGfLcE7DnYHKOAwUpGCas3zVnbdts
         JwFC7ITEwLsE6+Uqwf1opM9ccn2MVaiYuac+5/QQzPHs3j9NAlIK72GHv1lO0ZO5QZDr
         pkj4MpIXLFr4KC+tjvLB+eLNApFrcCgDKhmZblVX8iN4pvjjWPdpqdgF8kDi1OL7YgqD
         fSyH4ifbx+/ZQvlWiJw15XBCkw2T50HDpSDh/MmlH0kuS/34SdRU+9hlWayf/JLTW0AL
         GMn/opEE907sjYT9m7vU2++h8FgKoEMRMH8v8BOIGUMGjpUHrgEKKwN8pmLFdt23oa4t
         wBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4FmP6QMYk1IkFwbyuKk54A754mIP1LbWO9TYLDO2YAk=;
        b=hJL2AM9Sq3Kq5kXkrpXPPyTjjQvuL3fHVOLnsrCFKIwJEkaj8hUYXxH5ObbsRjBHJa
         19O2VY8x9Q8rQdfJxr23kog7bwvCLNiSdcYn3BSWl1AEPtmLPSFcAB4su6PLjU6XB3PQ
         MZnh9CUQcEy+Y3cTdY3KrE03MYAMmWsz1Y5Z0Mceyw88gvTRpUygjL9qiZYIbaVaG0fg
         bcPyf2eRwqktLUMt0gzjBVAR6OVqz1VzDmG5Sp6AnNlgEX8FWM9C0EiqopbRwxLjUjVR
         z83DKy0znfEsHlfQhwMEJHCsX4FHT9KOIDOYHJNOK2vWSBYKgw5QqqVjmDIt7c+bmy+U
         nUhQ==
X-Gm-Message-State: APjAAAWEetXsjfmQC6A8wA+C87bXNd7fqZPqfmw0OuerRYCeCR6xrrgg
        L/XTKlaboKwMMbeJlS0/j2o2YQ==
X-Google-Smtp-Source: APXvYqwO5GehOhU32jz/YkcMlk9BzDZHtY0pqTpMDHcPTzIWyIz6YHuSsyrEGouPkAh50h8K5lebCQ==
X-Received: by 2002:a17:90a:80cc:: with SMTP id k12mr8290533pjw.58.1573159856540;
        Thu, 07 Nov 2019 12:50:56 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id ay16sm9285223pjb.2.2019.11.07.12.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:50:55 -0800 (PST)
Date:   Thu, 7 Nov 2019 12:50:55 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Knut Omang <knut.omang@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
In-Reply-To: <20191107131342.GT8314@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911071249500.88963@chino.kir.corp.google.com>
References: <20191107115404.3030723-1-knut.omang@oracle.com> <20191107115806.GP8314@dhcp22.suse.cz> <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com> <20191107131342.GT8314@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Michal Hocko wrote:

> On Thu 07-11-19 13:26:09, Knut Omang wrote:
> > On Thu, 2019-11-07 at 12:58 +0100, Michal Hocko wrote:
> > > On Thu 07-11-19 12:54:04, Knut Omang wrote:
> > > > With the restructuring done in commit 9adeaa226988
> > > > ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> > > > 
> > > > it is no longer possible for code external to mm to access
> > > > the name of a kmem_cache as struct kmem_cache has effectively become
> > > > opaque. Having access to the cache name is helpful to kernel testing
> > > > infrastructure.
> > > > 
> > > > Expose a new function kmem_cache_name to mitigate that.
> > > 
> > > Who is going to use that symbol? It is preferred that a user is added in
> > > the same patch as the newly added symbol.
> > 
> > Yes, I am aware that that's the normal practice, 
> > we're currently using cache->name directly in the kernel 
> > unit test framework KTF (https://github.com/oracle/ktf/)
> > which we are working (https://lkml.org/lkml/2019/8/13/111) to get 
> > into the kernel in one form or another.
> 
> Please add the export with a patch that really needs it.
> 

Agree, this patch could be added as a predecessor to the series at
https://lkml.org/lkml/2019/8/13/111 which would use it.  If it's obvious 
why using the kmem cache name is useful in that series, acking this will 
be a no brainer.
