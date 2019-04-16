Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A124C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EF720656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfDPOez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:34:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56957 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbfDPOez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:34:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24C448666F;
        Tue, 16 Apr 2019 14:34:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4DE411001DE0;
        Tue, 16 Apr 2019 14:34:53 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:34:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree
 lookup
Message-ID: <20190416143452.GB10125@krava>
References: <20190416134151.15282-1-jolsa@kernel.org>
 <20190416142028.GH11294@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416142028.GH11294@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 16 Apr 2019 14:34:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:20:28AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 16, 2019 at 03:41:51PM +0200, Jiri Olsa escreveu:
> > We currently don't return NULL in case we don't find
> > the bpf_prog_info_node, fixing that.
> 
> Can you please try to figure out what was the changeset that introduced
> this problem so that we can have a Fixes: tag that helps me determine if
> this should go to perf/urgent (likely) or (perf/core) and to help the
> stable guys as well?

sry, I keep forgetting this..

Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")

thanks,
jirka

> 
> Thanks,
> 
> - Arnaldo
>  
> > Cc: Song Liu <songliubraving@fb.com>
> > Link: http://lkml.kernel.org/n/tip-bp07cla6dy6ifydl1sfoiorw@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/env.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index c6351b557bb0..34a363f2e71b 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -57,9 +57,11 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
> >  		else if (prog_id > node->info_linear->info.id)
> >  			n = n->rb_right;
> >  		else
> > -			break;
> > +			goto out;
> >  	}
> > +	node = NULL;
> >  
> > +out:
> >  	up_read(&env->bpf_progs.lock);
> >  	return node;
> >  }
> > -- 
> > 2.17.2
> 
> -- 
> 
> - Arnaldo
