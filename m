Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A1C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1E02173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558579005;
	bh=kUNFVjH4be23cyX2XaiQof8NpPNY3Soi3MYZVYreeiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m5/UDdSQm8CJxW+m8NoR9fnRoqLItvvB+x63M+gmjl8iHsJnvZnUBX2VFlohQva9O
	 GyR4yq9DDKGHe3JX6GxJFey5tFb3OZPnMIc3cNMuzYXgLEBSLviPoJf3dUJpkXBVmn
	 y4rnYcRyMNxr5CHKR7PYwpPyfE9WG9pMLqktVtHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfEWCgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:36:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34824 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:36:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id t1so2291797pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TYy9mnGw838Z6ch8hH4W+J8qg+DBgD5PvvxcXV/fJrw=;
        b=Ez83ZcJnZxAbc3c67jAKqZGUKDpO8IL+z/Umj+K7A00qOC2f+8dz2OhjS5rADuxLOM
         L18C9kkeAB4ke26FQq4TK8sak/eym9qz/AoeoQSIVFjvRfIqk1MhW8i/yVY9J2pH1qsd
         85MKzoVbR/cYzxu8wjzBHvob5IvUZtLld+2hgiJrKHdj2szRhWyCO/OsBOxUl97mEfIu
         BauqGWmOgUqxrbLbCtn406wSSr5kh5rRr2Z/7emMgs9LjMcwAq4PRCzFKH3uvtV7CaG2
         wzf4A/cdyk75MJYZzuiZNvXK9qJRI/wPeQHqtxt/laYhkl5pH2jzhhat7E/i0OtDWLS3
         yjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYy9mnGw838Z6ch8hH4W+J8qg+DBgD5PvvxcXV/fJrw=;
        b=FzdwRvXe76Lxtg7U1Z6K1aegjLR9qDcyUjKIalEuftF0xGXEELH6ux2xoaP2zP6mfB
         Dsua0QYbqLfOZ4KNdB/jns3aMPjeUAU8URxWzVIkD4GlZo7l+xNaFz0LKlmlatpf1/mm
         bf+oq41Jjb0qXyt0NYFbdGZWQSP70YT2fHSw86tuNZ1I9Q4E8yWryTLjtYyyn3hKwsxR
         dkLsc2dAGODrhKPguDewxjykRvl1Y/6dTCg7O3iUbB6VBIgutYyxeX3wMw8sstzrsWsN
         KX82Q3//aq7UJX1aNdNFlGGjMOGK+9tq9oKgD802HvWhhau7fRsujV3z7pgFZrd1A1B6
         t+GA==
X-Gm-Message-State: APjAAAXsD8YZf3So/N7LnfTwyBh0kBsvzsWLkz8Leep/p50GavWXFxhy
        trfh3lJYQLUn4U9dUUmuYfw=
X-Google-Smtp-Source: APXvYqwgSCQjm6qqsQ2FVUFP7eAp8i4/6rVj3AInpbf5h+8sjCBrGQM4LzpGB8wfeOaGq3eIYOgohg==
X-Received: by 2002:a63:ff0f:: with SMTP id k15mr92609291pgi.407.1558579003658;
        Wed, 22 May 2019 19:36:43 -0700 (PDT)
Received: from google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id o1sm18555290pfa.66.2019.05.22.19.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 19:36:43 -0700 (PDT)
Date:   Thu, 23 May 2019 11:36:38 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] perf tools: Protect reading thread's namespace
Message-ID: <20190523023636.GA196218@google.com>
References: <20190522053250.207156-1-namhyung@kernel.org>
 <20190522053250.207156-2-namhyung@kernel.org>
 <20190522131832.GB30271@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522131832.GB30271@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, May 22, 2019 at 10:18:32AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 22, 2019 at 02:32:48PM +0900, Namhyung Kim escreveu:
> > It seems that the current code lacks holding the namespace lock in
> > thread__namespaces().  Otherwise it can see inconsistent results.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/thread.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > index 403045a2bbea..b413ba5b9835 100644
> > --- a/tools/perf/util/thread.c
> > +++ b/tools/perf/util/thread.c
> > @@ -133,7 +133,7 @@ void thread__put(struct thread *thread)
> >  	}
> >  }
> >  
> > -struct namespaces *thread__namespaces(const struct thread *thread)
> > +static struct namespaces *__thread__namespaces(const struct thread *thread)
> >  {
> >  	if (list_empty(&thread->namespaces_list))
> >  		return NULL;
> > @@ -141,10 +141,21 @@ struct namespaces *thread__namespaces(const struct thread *thread)
> >  	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
> >  }
> >  
> > +struct namespaces *thread__namespaces(const struct thread *thread)
> > +{
> > +	struct namespaces *ns;
> > +
> > +	down_read((struct rw_semaphore *)&thread->namespaces_lock);
> > +	ns = __thread__namespaces(thread);
> > +	up_read((struct rw_semaphore *)&thread->namespaces_lock);
> > +
> 
> Humm, so we need to change thread__namespaces() to remove that const
> instead of throwing it away with that cast, right?

Yes, that's possible too.  Note that thread__comm_str() has the same issue
as well.

Thanks,
Namhyung
