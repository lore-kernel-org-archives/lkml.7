Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC6CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA79217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMXmAqGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfJ3KGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:06:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbfJ3KGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572429967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORz6YHxXSnX3Nk0JC2MQJttNvciBTugo8PSPzS4hohk=;
        b=aMXmAqGkuHQh0hc1GCom4yvA1PTHVg1g8g7Xn+CvD7XgZEyF8cMon1/ehFHT7xEvEF3fHf
        ZQqftFfaaZbv7rwWStvg6f0PYr6Ijc0G/AHkQPKU2cHX2HhvkkavdIfgOim5oUhBVlmPu3
        WMdYNw0IEubsUxgqRqbHtWR11UppUjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-LwXUk6MaOtKPQ0RYuErhZw-1; Wed, 30 Oct 2019 06:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BADC51005500;
        Wed, 30 Oct 2019 10:06:02 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 48D3B3DBB;
        Wed, 30 Oct 2019 10:06:01 +0000 (UTC)
Date:   Wed, 30 Oct 2019 11:06:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 5/7] perf stat: Use affinity for opening events
Message-ID: <20191030100600.GF20826@krava>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-6-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191025181417.10670-6-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LwXUk6MaOtKPQ0RYuErhZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:14:15AM -0700, Andi Kleen wrote:

SNIP

> =20
> +enum counter_recovery {
> +=09COUNTER_SKIP,
> +=09COUNTER_RETRY,
> +=09COUNTER_FATAL,
> +};
> +
> +static enum counter_recovery stat_handle_error(struct evsel *counter)
> +{
> +=09char msg[BUFSIZ];
> +=09/*
> +=09 * PPC returns ENXIO for HW counters until 2.6.37
> +=09 * (behavior changed with commit b0a873e).
> +=09 */
> +=09if (errno =3D=3D EINVAL || errno =3D=3D ENOSYS ||
> +=09    errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP ||
> +=09    errno =3D=3D ENXIO) {
> +=09=09if (verbose > 0)
> +=09=09=09ui__warning("%s event is not supported by the kernel.\n",
> +=09=09=09=09    perf_evsel__name(counter));
> +=09=09counter->supported =3D false;
> +=09=09counter->errored =3D true;
> +
> +=09=09if ((counter->leader !=3D counter) ||
> +=09=09    !(counter->leader->core.nr_members > 1))
> +=09=09=09return COUNTER_SKIP;
> +=09} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
> +=09=09if (verbose > 0)
> +=09=09=09ui__warning("%s\n", msg);
> +=09=09return COUNTER_RETRY;
> +=09} else if (target__has_per_thread(&target) &&
> +=09=09   evsel_list->core.threads &&
> +=09=09   evsel_list->core.threads->err_thread !=3D -1) {
> +=09=09/*
> +=09=09 * For global --per-thread case, skip current
> +=09=09 * error thread.
> +=09=09 */
> +=09=09if (!thread_map__remove(evsel_list->core.threads,
> +=09=09=09=09=09evsel_list->core.threads->err_thread)) {
> +=09=09=09evsel_list->core.threads->err_thread =3D -1;
> +=09=09=09return COUNTER_RETRY;
> +=09=09}
> +=09}
> +
> +=09perf_evsel__open_strerror(counter, &target,
> +=09=09=09=09  errno, msg, sizeof(msg));
> +=09ui__error("%s\n", msg);
> +
> +=09if (child_pid !=3D -1)
> +=09=09kill(child_pid, SIGTERM);
> +=09return COUNTER_FATAL;
> +}

there's lot of code movement and other factoring together with
affinity changes, please separate those into separate patches

thanks,
jirka

> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>  =09int interval =3D stat_config.interval;
> @@ -428,11 +481,15 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>  =09char msg[BUFSIZ];
>  =09unsigned long long t0, t1;
>  =09struct evsel *counter;
> +=09struct perf_cpu_map *cpus;
>  =09struct timespec ts;
>  =09size_t l;
>  =09int status =3D 0;
>  =09const bool forks =3D (argc > 0);
>  =09bool is_pipe =3D STAT_RECORD ? perf_stat.data.is_pipe : false;
> +=09struct affinity affinity;
> +=09int i, cpu;
> +=09bool second_pass =3D false;
> =20
>  =09if (interval) {
>  =09=09ts.tv_sec  =3D interval / USEC_PER_MSEC;
> @@ -457,61 +514,109 @@ static int __run_perf_stat(int argc, const char **=
argv, int run_idx)
>  =09if (group)
>  =09=09perf_evlist__set_leader(evsel_list);
> =20
> -=09evlist__for_each_entry(evsel_list, counter) {
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return -1;
> +
> +=09cpus =3D evlist__cpu_iter_start(evsel_list);
> +=09cpumap__for_each_cpu (cpus, i, cpu) {
> +=09=09affinity__set(&affinity, cpu);
> +
> +=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09if (evlist__cpu_iter_skip(counter, cpu))
> +=09=09=09=09continue;
> +=09=09=09if (counter->reset_group || counter->errored)
> +=09=09=09=09continue;
> +=09=09=09evlist__cpu_iter_next(counter);
>  try_again:
> -=09=09if (create_perf_stat_counter(counter, &stat_config, &target) < 0) =
{
> -
> -=09=09=09/* Weak group failed. Reset the group. */
> -=09=09=09if ((errno =3D=3D EINVAL || errno =3D=3D EBADF) &&
> -=09=09=09    counter->leader !=3D counter &&
> -=09=09=09    counter->weak_group) {
> -=09=09=09=09counter =3D perf_evlist__reset_weak_group(evsel_list, counte=
r);
> -=09=09=09=09goto try_again;
> -=09=09=09}
> +=09=09=09if (create_perf_stat_counter(counter, &stat_config, &target,
> +=09=09=09=09=09=09     counter->cpu_index - 1) < 0) {
> =20
> -=09=09=09/*
> -=09=09=09 * PPC returns ENXIO for HW counters until 2.6.37
> -=09=09=09 * (behavior changed with commit b0a873e).
> -=09=09=09 */
> -=09=09=09if (errno =3D=3D EINVAL || errno =3D=3D ENOSYS ||
> -=09=09=09    errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP ||
> -=09=09=09    errno =3D=3D ENXIO) {
> -=09=09=09=09if (verbose > 0)
> -=09=09=09=09=09ui__warning("%s event is not supported by the kernel.\n",
> -=09=09=09=09=09=09    perf_evsel__name(counter));
> -=09=09=09=09counter->supported =3D false;
> -
> -=09=09=09=09if ((counter->leader !=3D counter) ||
> -=09=09=09=09    !(counter->leader->core.nr_members > 1))
> -=09=09=09=09=09continue;
> -=09=09=09} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg=
))) {
> -                                if (verbose > 0)
> -                                        ui__warning("%s\n", msg);
> -                                goto try_again;
> -=09=09=09} else if (target__has_per_thread(&target) &&
> -=09=09=09=09   evsel_list->core.threads &&
> -=09=09=09=09   evsel_list->core.threads->err_thread !=3D -1) {
>  =09=09=09=09/*
> -=09=09=09=09 * For global --per-thread case, skip current
> -=09=09=09=09 * error thread.
> +=09=09=09=09 * Weak group failed. We cannot just undo this here
> +=09=09=09=09 * because earlier CPUs might be in group mode, and the kern=
el
> +=09=09=09=09 * doesn't support mixing group and non group reads. Defer
> +=09=09=09=09 * it to later.
> +=09=09=09=09 * Don't close here because we're in the wrong affinity.
>  =09=09=09=09 */
> -=09=09=09=09if (!thread_map__remove(evsel_list->core.threads,
> -=09=09=09=09=09=09=09evsel_list->core.threads->err_thread)) {
> -=09=09=09=09=09evsel_list->core.threads->err_thread =3D -1;
> +=09=09=09=09if ((errno =3D=3D EINVAL || errno =3D=3D EBADF) &&
> +=09=09=09=09    counter->leader !=3D counter &&
> +=09=09=09=09    counter->weak_group) {
> +=09=09=09=09=09perf_evlist__reset_weak_group(evsel_list, counter, false)=
;
> +=09=09=09=09=09assert(counter->reset_group);
> +=09=09=09=09=09second_pass =3D true;
> +=09=09=09=09=09continue;
> +=09=09=09=09}
> +
> +=09=09=09=09switch (stat_handle_error(counter)) {
> +=09=09=09=09case COUNTER_FATAL:
> +=09=09=09=09=09return -1;
> +=09=09=09=09case COUNTER_RETRY:
>  =09=09=09=09=09goto try_again;
> +=09=09=09=09case COUNTER_SKIP:
> +=09=09=09=09=09continue;
> +=09=09=09=09default:
> +=09=09=09=09=09break;
>  =09=09=09=09}
> +
>  =09=09=09}
> +=09=09=09counter->supported =3D true;
> +=09=09}
> +=09}
> =20
> -=09=09=09perf_evsel__open_strerror(counter, &target,
> -=09=09=09=09=09=09  errno, msg, sizeof(msg));
> -=09=09=09ui__error("%s\n", msg);
> +=09if (second_pass) {
> +=09=09/*
> +=09=09 * Now redo all the weak group after closing them,
> +=09=09 * and also close errored counters.
> +=09=09 */
> =20
> -=09=09=09if (child_pid !=3D -1)
> -=09=09=09=09kill(child_pid, SIGTERM);
> +=09=09cpus =3D evlist__cpu_iter_start(evsel_list);
> +=09=09cpumap__for_each_cpu (cpus, i, cpu) {
> +=09=09=09affinity__set(&affinity, cpu);
> +=09=09=09/* First close errored or weak retry */
> +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09=09if (!counter->reset_group && !counter->errored)
> +=09=09=09=09=09continue;
> +=09=09=09=09if (evlist__cpu_iter_skip(counter, cpu))
> +=09=09=09=09=09continue;
> +=09=09=09=09perf_evsel__close_cpu(&counter->core, counter->cpu_index);
> +=09=09=09}
> +=09=09=09/* Now reopen weak */
> +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09=09if (!counter->reset_group)
> +=09=09=09=09=09continue;
> +=09=09=09=09if (evlist__cpu_iter_skip(counter, cpu))
> +=09=09=09=09=09continue;
> +=09=09=09=09evlist__cpu_iter_next(counter);
> +try_again_reset:
> +=09=09=09=09pr_debug2("reopening weak %s\n", perf_evsel__name(counter));
> +=09=09=09=09if (create_perf_stat_counter(counter, &stat_config, &target,
> +=09=09=09=09=09=09=09     counter->cpu_index - 1) < 0) {
> +
> +=09=09=09=09=09switch (stat_handle_error(counter)) {
> +=09=09=09=09=09case COUNTER_FATAL:
> +=09=09=09=09=09=09return -1;
> +=09=09=09=09=09case COUNTER_RETRY:
> +=09=09=09=09=09=09goto try_again_reset;
> +=09=09=09=09=09case COUNTER_SKIP:
> +=09=09=09=09=09=09continue;
> +=09=09=09=09=09default:
> +=09=09=09=09=09=09break;
> +=09=09=09=09=09}
> +=09=09=09=09}
> +=09=09=09=09counter->supported =3D true;
> +=09=09=09}
> +=09=09}
> +=09}
> +=09affinity__cleanup(&affinity);
> =20
> -=09=09=09return -1;
> +=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09if (!counter->supported) {
> +=09=09=09perf_evsel__free_fd(&counter->core);
> +=09=09=09continue;
>  =09=09}
> -=09=09counter->supported =3D true;
> +=09=09/* Must have consumed all map indexes */
> +=09=09assert(!counter->errored &&
> +=09=09=09counter->cpu_index =3D=3D counter->core.cpus->nr);
> =20
>  =09=09l =3D strlen(counter->unit);
>  =09=09if (l > stat_config.unit_width)
> diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-time=
s.c
> index 1ee8704e2284..1e8a9f5c356d 100644
> --- a/tools/perf/tests/event-times.c
> +++ b/tools/perf/tests/event-times.c
> @@ -125,7 +125,7 @@ static int attach__cpu_disabled(struct evlist *evlist=
)
> =20
>  =09evsel->core.attr.disabled =3D 1;
> =20
> -=09err =3D perf_evsel__open_per_cpu(evsel, cpus);
> +=09err =3D perf_evsel__open_per_cpu(evsel, cpus, -1);
>  =09if (err) {
>  =09=09if (err =3D=3D -EACCES)
>  =09=09=09return TEST_SKIP;
> @@ -152,7 +152,7 @@ static int attach__cpu_enabled(struct evlist *evlist)
>  =09=09return -1;
>  =09}
> =20
> -=09err =3D perf_evsel__open_per_cpu(evsel, cpus);
> +=09err =3D perf_evsel__open_per_cpu(evsel, cpus, -1);
>  =09if (err =3D=3D -EACCES)
>  =09=09return TEST_SKIP;
> =20
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index aeb82de36043..ca9b06979fc0 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1635,7 +1635,8 @@ void perf_evlist__force_leader(struct evlist *evlis=
t)
>  }
> =20
>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
> -=09=09=09=09=09=09 struct evsel *evsel)
> +=09=09=09=09=09=09 struct evsel *evsel,
> +=09=09=09=09=09=09bool close)
>  {
>  =09struct evsel *c2, *leader;
>  =09bool is_open =3D true;
> @@ -1652,10 +1653,11 @@ struct evsel *perf_evlist__reset_weak_group(struc=
t evlist *evsel_list,
>  =09=09if (c2 =3D=3D evsel)
>  =09=09=09is_open =3D false;
>  =09=09if (c2->leader =3D=3D leader) {
> -=09=09=09if (is_open)
> +=09=09=09if (is_open && close)
>  =09=09=09=09perf_evsel__close(&c2->core);
>  =09=09=09c2->leader =3D c2;
>  =09=09=09c2->core.nr_members =3D 0;
> +=09=09=09c2->reset_group =3D true;
>  =09=09}
>  =09}
>  =09return leader;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index c1deb8ebdcea..d9174d565db3 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -351,5 +351,6 @@ bool perf_evlist__exclude_kernel(struct evlist *evlis=
t);
>  void perf_evlist__force_leader(struct evlist *evlist);
> =20
>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
> -=09=09=09=09=09=09 struct evsel *evsel);
> +=09=09=09=09=09=09 struct evsel *evsel,
> +=09=09=09=09=09=09bool close);
>  #endif /* __PERF_EVLIST_H */
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4451846af93..7106f9a067df 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1569,8 +1569,9 @@ static int perf_event_open(struct evsel *evsel,
>  =09return fd;
>  }
> =20
> -int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
> -=09=09struct perf_thread_map *threads)
> +static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpu=
s,
> +=09=09struct perf_thread_map *threads,
> +=09=09int start_cpu, int end_cpu)
>  {
>  =09int cpu, thread, nthreads;
>  =09unsigned long flags =3D PERF_FLAG_FD_CLOEXEC;
> @@ -1647,7 +1648,7 @@ int evsel__open(struct evsel *evsel, struct perf_cp=
u_map *cpus,
> =20
>  =09display_attr(&evsel->core.attr);
> =20
> -=09for (cpu =3D 0; cpu < cpus->nr; cpu++) {
> +=09for (cpu =3D start_cpu; cpu < end_cpu; cpu++) {
> =20
>  =09=09for (thread =3D 0; thread < nthreads; thread++) {
>  =09=09=09int fd, group_fd;
> @@ -1825,6 +1826,12 @@ int evsel__open(struct evsel *evsel, struct perf_c=
pu_map *cpus,
>  =09return err;
>  }
> =20
> +int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
> +=09=09struct perf_thread_map *threads)
> +{
> +=09return evsel__open_cpu(evsel, cpus, threads, 0, cpus ? cpus->nr : 1);
> +}
> +
>  void evsel__close(struct evsel *evsel)
>  {
>  =09perf_evsel__close(&evsel->core);
> @@ -1832,9 +1839,10 @@ void evsel__close(struct evsel *evsel)
>  }
> =20
>  int perf_evsel__open_per_cpu(struct evsel *evsel,
> -=09=09=09     struct perf_cpu_map *cpus)
> +=09=09=09     struct perf_cpu_map *cpus,
> +=09=09=09     int cpu)
>  {
> -=09return evsel__open(evsel, cpus, NULL);
> +=09return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
>  }
> =20
>  int perf_evsel__open_per_thread(struct evsel *evsel,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 2e3b011ed09e..d5440a928745 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -94,6 +94,8 @@ struct evsel {
>  =09struct evsel=09=09*metric_leader;
>  =09bool=09=09=09collect_stat;
>  =09bool=09=09=09weak_group;
> +=09bool=09=09=09reset_group;
> +=09bool=09=09=09errored;
>  =09bool=09=09=09percore;
>  =09int=09=09=09cpu_index;
>  =09const char=09=09*pmu_name;
> @@ -223,7 +225,8 @@ int evsel__enable(struct evsel *evsel);
>  int evsel__disable(struct evsel *evsel);
> =20
>  int perf_evsel__open_per_cpu(struct evsel *evsel,
> -=09=09=09     struct perf_cpu_map *cpus);
> +=09=09=09     struct perf_cpu_map *cpus,
> +=09=09=09     int cpu);
>  int perf_evsel__open_per_thread(struct evsel *evsel,
>  =09=09=09=09struct perf_thread_map *threads);
>  int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 6822e4ffe224..3aebe732e886 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -463,7 +463,8 @@ size_t perf_event__fprintf_stat_config(union perf_eve=
nt *event, FILE *fp)
> =20
>  int create_perf_stat_counter(struct evsel *evsel,
>  =09=09=09     struct perf_stat_config *config,
> -=09=09=09     struct target *target)
> +=09=09=09     struct target *target,
> +=09=09=09     int cpu)
>  {
>  =09struct perf_event_attr *attr =3D &evsel->core.attr;
>  =09struct evsel *leader =3D evsel->leader;
> @@ -517,7 +518,7 @@ int create_perf_stat_counter(struct evsel *evsel,
>  =09}
> =20
>  =09if (target__has_cpu(target) && !target__has_per_thread(target))
> -=09=09return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
> +=09=09return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
> =20
>  =09return perf_evsel__open_per_thread(evsel, evsel->core.threads);
>  }
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 081c4a5113c6..4c9a7b68c3e7 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -213,7 +213,8 @@ size_t perf_event__fprintf_stat_config(union perf_eve=
nt *event, FILE *fp);
> =20
>  int create_perf_stat_counter(struct evsel *evsel,
>  =09=09=09     struct perf_stat_config *config,
> -=09=09=09     struct target *target);
> +=09=09=09     struct target *target,
> +=09=09=09     int cpu);
>  void
>  perf_evlist__print_counters(struct evlist *evlist,
>  =09=09=09    struct perf_stat_config *config,
> --=20
> 2.21.0
>=20

