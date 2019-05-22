Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91963C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4002A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfEVVXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:23:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbfEVVXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:23:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 505C481F0D;
        Wed, 22 May 2019 21:23:03 +0000 (UTC)
Received: from krava (ovpn-204-104.brq.redhat.com [10.40.204.104])
        by smtp.corp.redhat.com (Postfix) with SMTP id 824EF600C0;
        Wed, 22 May 2019 21:23:00 +0000 (UTC)
Date:   Wed, 22 May 2019 23:22:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 08/12] perf tools: Preserve eBPF maps when loading kcore
Message-ID: <20190522212259.GA11325@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-9-jolsa@kernel.org>
 <20190522160657.GF30271@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522160657.GF30271@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 22 May 2019 21:23:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:06:57PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 08, 2019 at 03:20:06PM +0200, Jiri Olsa escreveu:
> > We need to preserve eBPF maps even if they are
> > covered by kcore, because we need to access
> > eBPF dso for source data.
> 
> So, I reordered this one with the previous, as to get the output you
> added to 07/12 we need what is in 08/12, and they are otherwise
> completely independent, right?

right

jirka

> 
> - Arnaldo
>  
> > Adding map_groups__merge_in function to do that.
> > It merges map into map_groups by splitting the
> > new map within the existing map regions.
> > 
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Link: http://lkml.kernel.org/n/tip-mlu13e9zl6rbsz4fa00x7mfa@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/symbol.c | 97 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 93 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 5cbad55cd99d..29780fcd049c 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1166,6 +1166,85 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Merges map into map_groups by splitting the new map
> > + * within the existing map regions.
> > + */
> > +static int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
> > +{
> > +	struct map *old_map;
> > +	LIST_HEAD(merged);
> > +
> > +	for (old_map = map_groups__first(kmaps); old_map;
> > +	     old_map = map_groups__next(old_map)) {
> > +
> > +		/* no overload with this one */
> > +		if (new_map->end < old_map->start ||
> > +		    new_map->start >= old_map->end)
> > +			continue;
> > +
> > +		if (new_map->start < old_map->start) {
> > +			/*
> > +			 * |new......
> > +			 *       |old....
> > +			 */
> > +			if (new_map->end < old_map->end) {
> > +				/*
> > +				 * |new......|     -> |new..|
> > +				 *       |old....| ->       |old....|
> > +				 */
> > +				new_map->end = old_map->start;
> > +			} else {
> > +				/*
> > +				 * |new.............| -> |new..|       |new..|
> > +				 *       |old....|    ->       |old....|
> > +				 */
> > +				struct map *m = map__clone(new_map);
> > +
> > +				if (!m)
> > +					return -ENOMEM;
> > +
> > +				m->end = old_map->start;
> > +				list_add_tail(&m->node, &merged);
> > +				new_map->start = old_map->end;
> > +			}
> > +		} else {
> > +			/*
> > +			 *      |new......
> > +			 * |old....
> > +			 */
> > +			if (new_map->end < old_map->end) {
> > +				/*
> > +				 *      |new..|   -> x
> > +				 * |old.........| -> |old.........|
> > +				 */
> > +				map__put(new_map);
> > +				new_map = NULL;
> > +				break;
> > +			} else {
> > +				/*
> > +				 *      |new......| ->         |new...|
> > +				 * |old....|        -> |old....|
> > +				 */
> > +				new_map->start = old_map->end;
> > +			}
> > +		}
> > +	}
> > +
> > +	while (!list_empty(&merged)) {
> > +		old_map = list_entry(merged.next, struct map, node);
> > +		list_del_init(&old_map->node);
> > +		map_groups__insert(kmaps, old_map);
> > +		map__put(old_map);
> > +	}
> > +
> > +	if (new_map) {
> > +		map_groups__insert(kmaps, new_map);
> > +		map__put(new_map);
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int dso__load_kcore(struct dso *dso, struct map *map,
> >  			   const char *kallsyms_filename)
> >  {
> > @@ -1222,7 +1301,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
> >  	while (old_map) {
> >  		struct map *next = map_groups__next(old_map);
> >  
> > -		if (old_map != map)
> > +		/*
> > +		 * We need to preserve eBPF maps even if they are
> > +		 * covered by kcore, because we need to access
> > +		 * eBPF dso for source data.
> > +		 */
> > +		if (old_map != map && !__map__is_bpf_prog(old_map))
> >  			map_groups__remove(kmaps, old_map);
> >  		old_map = next;
> >  	}
> > @@ -1256,11 +1340,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
> >  			map_groups__remove(kmaps, map);
> >  			map_groups__insert(kmaps, map);
> >  			map__put(map);
> > +			map__put(new_map);
> >  		} else {
> > -			map_groups__insert(kmaps, new_map);
> > +			/*
> > +			 * Merge kcore map into existing maps,
> > +			 * and ensure that current maps (eBPF)
> > +			 * stay intact.
> > +			 */
> > +			if (map_groups__merge_in(kmaps, new_map))
> > +				goto out_err;
> >  		}
> > -
> > -		map__put(new_map);
> >  	}
> >  
> >  	if (machine__is(machine, "x86_64")) {
> > -- 
> > 2.20.1
> 
> -- 
> 
> - Arnaldo
