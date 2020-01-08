Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA90C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FB220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBBQ9POk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgAHWJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:09:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47267 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgAHWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578521342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RghvFBEYKLU+bw5SxYFgxub03/mZByKdsXJlp4/RhWA=;
        b=RBBQ9POk3X4bYauHC5EjIHIyqouH0tnXBh22geFmp4bF5PqTyyHh+Wo53Ljssbaq+BV89K
        zXoq1+BZHrCG5VpukQ45G8HGQ9i2tWam4p7vbapP8GkfJ4emh/JFnPddXQ7w5hPgt5fCHl
        zeyeLwC3zv0iORd4uuKs4POldjdJvds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-8yQd7IirPceuiy_8d9ztVQ-1; Wed, 08 Jan 2020 17:08:59 -0500
X-MC-Unique: 8yQd7IirPceuiy_8d9ztVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 414BC800D48;
        Wed,  8 Jan 2020 22:08:57 +0000 (UTC)
Received: from krava (ovpn-204-121.brq.redhat.com [10.40.204.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 740EE65F40;
        Wed,  8 Jan 2020 22:08:54 +0000 (UTC)
Date:   Wed, 8 Jan 2020 23:08:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Message-ID: <20200108220851.GC12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-7-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-7-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:
> Synthesize cgroup events by iterating cgroup filesystem directories.
> The cgroup event only saves the portion of cgroup path after the mount
> point and the cgroup id (which actually is a file handle).
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c        |   5 ++
>  tools/perf/util/cgroup.c           |   3 +-
>  tools/perf/util/cgroup.h           |   1 +
>  tools/perf/util/event.c            |   1 +
>  tools/perf/util/synthetic-events.c | 119 +++++++++++++++++++++++++++++
>  tools/perf/util/synthetic-events.h |   1 +
>  tools/perf/util/tool.h             |   1 +
>  7 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4c301466101b..2802de9538ff 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1397,6 +1397,11 @@ static int record__synthesize(struct record *rec, bool tail)
>  	if (err < 0)
>  		pr_warning("Couldn't synthesize bpf events.\n");
>  
> +	err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
> +					     machine);
> +	if (err < 0)
> +		pr_warning("Couldn't synthesize cgroup events.\n");
> +
>  	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
>  					    process_synthesized_event, opts->sample_address,
>  					    1);
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 4e8ef1db0c94..5147d22b3bda 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -15,8 +15,7 @@ int nr_cgroups;
>  
>  static struct rb_root cgroup_tree = RB_ROOT;
>  
> -static int
> -cgroupfs_find_mountpoint(char *buf, size_t maxlen)
> +int cgroupfs_find_mountpoint(char *buf, size_t maxlen)

out of scope of this change, but could this be added to api/fs/fs.c?
it might need more checks then is currently supported, but would be
nice to have it under same api as the rest

jirka


>  {
>  	FILE *fp;
>  	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
> diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> index 381583df27c7..9a67060723fa 100644
> --- a/tools/perf/util/cgroup.h
> +++ b/tools/perf/util/cgroup.h
> @@ -17,6 +17,7 @@ struct cgroup {
>  
>  extern int nr_cgroups; /* number of explicit cgroups defined */
>  
> +int cgroupfs_find_mountpoint(char *buf, size_t maxlen);
>  struct cgroup *cgroup__get(struct cgroup *cgroup);
>  void cgroup__put(struct cgroup *cgroup);
>  
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 824c038e5c33..28801c867f39 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -33,6 +33,7 @@
>  #include "bpf-event.h"
>  #include "tool.h"
>  #include "../perf.h"
> +#include "cgroup.h"
>  
>  static const char *perf_event__names[] = {
>  	[0]					= "TOTAL",
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index cd336eb8886b..36f122cac44f 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -16,6 +16,7 @@
>  #include "util/synthetic-events.h"
>  #include "util/target.h"
>  #include "util/time-utils.h"
> +#include "util/cgroup.h"
>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> @@ -413,6 +414,124 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  	return rc;
>  }
>  
> +static int perf_event__synthesize_cgroup(struct perf_tool *tool,
> +					 union perf_event *event,
> +					 char *path, size_t mount_len,
> +					 perf_event__handler_t process,
> +					 struct machine *machine)
> +{
> +	size_t event_size = sizeof(event->cgroup) - sizeof(event->cgroup.path);
> +	size_t path_len = strlen(path) - mount_len + 1;
> +	struct {
> +		struct file_handle fh;
> +		uint64_t cgroup_id;
> +	} handle;
> +	int mount_id;
> +
> +	while (path_len % sizeof(u64))
> +		path[mount_len + path_len++] = '\0';
> +
> +	memset(&event->cgroup, 0, event_size);
> +
> +	event->cgroup.header.type = PERF_RECORD_CGROUP;
> +	event->cgroup.header.size = event_size + path_len + machine->id_hdr_size;
> +
> +	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
> +	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
> +		pr_debug("stat failed: %s\n", path);
> +		return -1;
> +	}
> +
> +	event->cgroup.id = handle.cgroup_id;
> +	strncpy(event->cgroup.path, path + mount_len, path_len);
> +	memset(event->cgroup.path + path_len, 0, machine->id_hdr_size);
> +
> +	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
> +		pr_debug("process synth event failed\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
> +					union perf_event *event,
> +					char *path, size_t mount_len,
> +					perf_event__handler_t process,
> +					struct machine *machine)
> +{
> +	size_t pos = strlen(path);
> +	DIR *d;
> +	struct dirent *dent;
> +	int ret = 0;
> +
> +	if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
> +					  process, machine) < 0)
> +		return -1;
> +
> +	d = opendir(path);
> +	if (d == NULL) {
> +		pr_debug("failed to open directory: %s\n", path);
> +		return -1;
> +	}
> +
> +	while ((dent = readdir(d)) != NULL) {
> +		if (dent->d_type != DT_DIR)
> +			continue;
> +		if (!strcmp(dent->d_name, ".") ||
> +		    !strcmp(dent->d_name, ".."))
> +			continue;
> +
> +		if (path[pos - 1] != '/')
> +			strcat(path, "/");
> +		strcat(path, dent->d_name);
> +
> +		ret = perf_event__walk_cgroup_tree(tool, event, path,
> +						   mount_len, process, machine);
> +		if (ret < 0)
> +			break;
> +
> +		path[pos] = '\0';
> +	}
> +
> +	closedir(d);
> +	return ret;
> +}
> +
> +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> +				   perf_event__handler_t process,
> +				   struct machine *machine)
> +{
> +	union perf_event event;
> +	char *cgrp_root;
> +	size_t mount_len;  /* length of mount point in the path */
> +	int ret = -1;
> +
> +	cgrp_root = malloc(PATH_MAX);
> +	if (cgrp_root == NULL)
> +		return -1;
> +
> +	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX) < 0) {
> +		pr_debug("cannot find cgroup mount point\n");
> +		goto out;
> +	}
> +
> +	mount_len = strlen(cgrp_root);
> +	/* make sure the path starts with a slash (after mount point) */
> +	strcat(cgrp_root, "/");
> +
> +	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
> +					 process, machine) < 0)
> +		goto out;
> +
> +	ret = 0;
> +
> +out:
> +	free(cgrp_root);
> +
> +	return ret;
> +}
> +
>  int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
>  				   struct machine *machine)
>  {
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index baead0cdc381..e7a3e9589738 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -45,6 +45,7 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool, perf_event__handl
>  int perf_event__synthesize_mmap_events(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine, bool mmap_data);
>  int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_namespaces(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
> +int perf_event__synthesize_cgroups(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
>  int perf_event__synthesize_stat_config(struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 472ef5eb4068..3fb67bd31e4a 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -79,6 +79,7 @@ struct perf_tool {
>  	bool		ordered_events;
>  	bool		ordering_requires_timestamps;
>  	bool		namespace_events;
> +	bool		cgroup_events;
>  	bool		no_warn;
>  	enum show_feature_header show_feat_hdr;
>  };
> -- 
> 2.24.1.735.g03f4e72817-goog
> 

