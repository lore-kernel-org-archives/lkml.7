Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8C120645
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCIRVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCIRVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:21:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F05C369BC;
        Sat,  9 Mar 2019 17:21:34 +0000 (UTC)
Received: from krava (ovpn-204-64.brq.redhat.com [10.40.204.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 80F7F611B3;
        Sat,  9 Mar 2019 17:21:31 +0000 (UTC)
Date:   Sat, 9 Mar 2019 18:21:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 05/11] perf header: Add DIR_FORMAT feature to describe
 directory data
Message-ID: <20190309172130.GC6378@krava>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-6-jolsa@kernel.org>
 <20190308182435.GF10690@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308182435.GF10690@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 09 Mar 2019 17:21:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:24:35PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 08, 2019 at 02:47:39PM +0100, Jiri Olsa escreveu:
> > The data files layout is described by HEADER_DIR_FORMAT
> > feature.  Currently it holds only version number (1):
> > 
> >      uint64_t version;
> > 
> > The current version holds only version value (1) means
> > that data files:
> >   - follow the 'data.*' name format
> >   - contain raw events data in standard perf format as
> >     read from kernel (and need to be sorted)
> 
> and need to be sorted when multiple files are processed, right?

correct

jirka

> 
> - Arnaldo
>  
> > Future versions are expected to describe different data
> > files layout according to special needs.
> > 
> > Link: http://lkml.kernel.org/n/tip-6l53s3oabwr1r4n6wke21d8g@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-record.c |  2 ++
> >  tools/perf/util/data.c      | 10 +++++++--
> >  tools/perf/util/data.h      |  1 +
> >  tools/perf/util/header.c    | 44 ++++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/header.h    |  5 +++++
> >  5 files changed, 59 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index e983c8d71a79..a468d882e74f 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -837,6 +837,8 @@ static void record__init_features(struct record *rec)
> >  	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
> >  		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
> >  
> > +	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
> > +
> >  	perf_header__clear_feat(&session->header, HEADER_STAT);
> >  }
> >  
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index 498c531e2cb9..41a9f478f0f0 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -14,6 +14,7 @@
> >  #include "data.h"
> >  #include "util.h"
> >  #include "debug.h"
> > +#include "header.h"
> >  
> >  static void close_dir(struct perf_data_file *files, int nr)
> >  {
> > @@ -41,8 +42,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
> >  	if (!files)
> >  		return -ENOMEM;
> >  
> > -	data->dir.files = files;
> > -	data->dir.nr    = nr;
> > +	data->dir.version = PERF_DIR_VERSION;
> > +	data->dir.files   = files;
> > +	data->dir.nr      = nr;
> >  
> >  	for (i = 0; i < nr; i++) {
> >  		struct perf_data_file *file = &files[i];
> > @@ -75,6 +77,10 @@ int perf_data__open_dir(struct perf_data *data)
> >  	if (WARN_ON(!data->is_dir))
> >  		return -EINVAL;
> >  
> > +	/* The version is provided by DIR_FORMAT feature. */
> > +	if (WARN_ON(data->dir.version != PERF_DIR_VERSION))
> > +		return -1;
> > +
> >  	dir = opendir(data->path);
> >  	if (!dir)
> >  		return -EINVAL;
> > diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> > index d342469bdfda..6aef8746469f 100644
> > --- a/tools/perf/util/data.h
> > +++ b/tools/perf/util/data.h
> > @@ -24,6 +24,7 @@ struct perf_data {
> >  	enum perf_data_mode	 mode;
> >  
> >  	struct {
> > +		u64			 version;
> >  		struct perf_data_file	*files;
> >  		int			 nr;
> >  	} dir;
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 01b324c275b9..b0683bf4d9f3 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -861,6 +861,21 @@ static int write_clockid(struct feat_fd *ff,
> >  			sizeof(ff->ph->env.clockid_res_ns));
> >  }
> >  
> > +static int write_dir_format(struct feat_fd *ff,
> > +			    struct perf_evlist *evlist __maybe_unused)
> > +{
> > +	struct perf_session *session;
> > +	struct perf_data *data;
> > +
> > +	session = container_of(ff->ph, struct perf_session, header);
> > +	data = session->data;
> > +
> > +	if (WARN_ON(!perf_data__is_dir(data)))
> > +		return -1;
> > +
> > +	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
> > +}
> > +
> >  static int cpu_cache_level__sort(const void *a, const void *b)
> >  {
> >  	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
> > @@ -1341,6 +1356,17 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
> >  		ff->ph->env.clockid_res_ns * 1000);
> >  }
> >  
> > +static void print_dir_format(struct feat_fd *ff, FILE *fp)
> > +{
> > +	struct perf_session *session;
> > +	struct perf_data *data;
> > +
> > +	session = container_of(ff->ph, struct perf_session, header);
> > +	data = session->data;
> > +
> > +	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
> > +}
> > +
> >  static void free_event_desc(struct perf_evsel *events)
> >  {
> >  	struct perf_evsel *evsel;
> > @@ -2373,6 +2399,21 @@ static int process_clockid(struct feat_fd *ff,
> >  	return 0;
> >  }
> >  
> > +static int process_dir_format(struct feat_fd *ff,
> > +			      void *_data __maybe_unused)
> > +{
> > +	struct perf_session *session;
> > +	struct perf_data *data;
> > +
> > +	session = container_of(ff->ph, struct perf_session, header);
> > +	data = session->data;
> > +
> > +	if (WARN_ON(!perf_data__is_dir(data)))
> > +		return -1;
> > +
> > +	return do_read_u64(ff, &data->dir.version);
> > +}
> > +
> >  struct feature_ops {
> >  	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
> >  	void (*print)(struct feat_fd *ff, FILE *fp);
> > @@ -2432,7 +2473,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
> >  	FEAT_OPN(CACHE,		cache,		true),
> >  	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
> >  	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
> > -	FEAT_OPR(CLOCKID,       clockid,        false)
> > +	FEAT_OPR(CLOCKID,	clockid,	false),
> > +	FEAT_OPN(DIR_FORMAT,	dir_format,	false)
> >  };
> >  
> >  struct header_print_data {
> > diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> > index 0d553ddca0a3..6a231340238d 100644
> > --- a/tools/perf/util/header.h
> > +++ b/tools/perf/util/header.h
> > @@ -39,6 +39,7 @@ enum {
> >  	HEADER_SAMPLE_TIME,
> >  	HEADER_MEM_TOPOLOGY,
> >  	HEADER_CLOCKID,
> > +	HEADER_DIR_FORMAT,
> >  	HEADER_LAST_FEATURE,
> >  	HEADER_FEAT_BITS	= 256,
> >  };
> > @@ -48,6 +49,10 @@ enum perf_header_version {
> >  	PERF_HEADER_VERSION_2,
> >  };
> >  
> > +enum perf_dir_version {
> > +	PERF_DIR_VERSION	= 1,
> > +};
> > +
> >  struct perf_file_section {
> >  	u64 offset;
> >  	u64 size;
> > -- 
> > 2.17.2
> 
> -- 
> 
> - Arnaldo
