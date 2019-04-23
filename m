Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29625C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED55321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfDWOzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:55:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfDWOzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:55:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1793399DD9;
        Tue, 23 Apr 2019 14:55:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B97160142;
        Tue, 23 Apr 2019 14:55:09 +0000 (UTC)
Date:   Tue, 23 Apr 2019 16:55:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 06/12] perf tools: Do not erase uncovered maps by kcore
Message-ID: <20190423145508.GE1730@krava>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-7-jolsa@kernel.org>
 <5cd0aadb-8bfc-2e97-4260-459b076aba2d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd0aadb-8bfc-2e97-4260-459b076aba2d@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 23 Apr 2019 14:55:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:32:12PM +0300, Adrian Hunter wrote:
> On 16/04/19 7:01 PM, Jiri Olsa wrote:
> > Maps in kcore do not cover bpf maps, so we can't just
> > remove everything. Keeping all kernel maps, which are
> > not covered by kcore maps.
> 
> Memory for jited-bpf is allocated from the same area that is used for
> modules.  In the case of /proc/kcore, that entire area is mapped, so there
> won't be any bpf-maps that are not covered.  For copies of kcore made by
> 'perf buildid-cache' the same would be true for any bpf that got allocated
> in between modules.
> 
> But shouldn't the bpf map supersede the kcore map for the address range that
> it maps?  I guess that would mean splitting the kcore map, truncating the
> first piece and inserting the bpf map in between.

I haven't considered it could get in between modules,
I think you're right and we need to cut kcore maps
in case bpf is mapped within.. I'll submit new version

thanks,
jirka

> 
> > 
> > Link: http://lkml.kernel.org/n/tip-9eytka8wofp0a047ul6lmejk@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/symbol.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 5cbad55cd99d..96738a7a8c14 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1166,6 +1166,18 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
> >  	return 0;
> >  }
> >  
> > +static bool in_kcore(struct kcore_mapfn_data *md, struct map *map)
> > +{
> > +	struct map *iter;
> > +
> > +	list_for_each_entry(iter, &md->maps, node) {
> > +		if ((map->start >= iter->start) && (map->start < iter->end))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  static int dso__load_kcore(struct dso *dso, struct map *map,
> >  			   const char *kallsyms_filename)
> >  {
> > @@ -1222,7 +1234,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
> >  	while (old_map) {
> >  		struct map *next = map_groups__next(old_map);
> >  
> > -		if (old_map != map)
> > +		if (old_map != map && !in_kcore(&md, old_map))
> >  			map_groups__remove(kmaps, old_map);
> >  		old_map = next;
> >  	}
> > 
> 
