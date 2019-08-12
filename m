Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3768C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7570B20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoCeZz04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfHLP47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:56:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39295 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:56:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id 125so4276763qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dAYcwrdHnm3WHIpmKQJvNIk19/9eiJxBUXonG/XecQ=;
        b=MoCeZz04lXIemSspRx0RKGpkTh6ACUFZoRXpvAX3OaRlYhagpW/wryWEq6s2ukOkGw
         dCgmvhPm/8NE5nuaJw9MWSQbEfiuSnUKX6kjEHECVNq3Nxbv/qMMaMArjl4KCwVaChOt
         tt5oxoeyxCj8Ky1+Ay279UCDgCA07m42X/ed40CBAEjd7dtggJol6c0hqQwPqGDFTpyh
         lsqszQ3ixW5OLA2E2sugLTb+82x+AeJV2XEcWMK2Sy64kCArCgHXq3ZyEuNJJ8+j+uNw
         KtttgxDF7oIt7ulNni0fxGmoqiIDcf6OeiSlqmepahuc5zRTLNOKVldZ6vFEaI29Hyte
         j19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dAYcwrdHnm3WHIpmKQJvNIk19/9eiJxBUXonG/XecQ=;
        b=TeiVV0ZrWya83LmTjPlvicjaOfO/3e6w9B5OH06RNQ/t4tMv5zi7x9m+zO9NGGhotQ
         RVgQGPk+WnPGm0npysOBYr2kMdMYQJWHXaOcXZY+Jpc7N7BRHwl2E/HTH9RcAh563kvX
         lGLMnTF8dJlTE8wl8pqzK0xUozWD7vxSlHqN6Tc0yxaZt3cNXyn8fvvMgFINdCdF+GbA
         1af4bVZBoiefgSy6ZMiXmf5O7ANmm5EFgthGArkYVPOvRYkUPFIL3VKD+eUSgLI8L370
         +nmRaVY2iDE5VDWMKYu4WMVoeg/k9A1sykMgjFD39aP18GdoOsRGdPvqDZ29h68l3aNw
         Mf+A==
X-Gm-Message-State: APjAAAUstm21NxWvLbiPs/+c53SbTQmcqnUOqiIPCD4VvREiAE6r7qL6
        sJjY657zW2P4MR0IDgXQ9m+RbcQoTyi8M8ifJtOGLSKQHnh4Sg==
X-Google-Smtp-Source: APXvYqwLR+VOAEvSZJt4gxKNjfm0j/Lcgg403TeUOqeMd7YiKmuTfBSdlLDoWecDE6YrWfaT1DEZhOXXNRSo3FkRHtE=
X-Received: by 2002:a37:660d:: with SMTP id a13mr31192834qkc.36.1565625417274;
 Mon, 12 Aug 2019 08:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190809214642.12078-1-dxu@dxuuu.xyz> <20190809214642.12078-2-dxu@dxuuu.xyz>
In-Reply-To: <20190809214642.12078-2-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Aug 2019 08:56:45 -0700
Message-ID: <CAEf4Bzb0jBmsdeKZ_vN4w-z1tM8M2Ygz_CoBoO_2iV55tgL1Bg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
 ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, peterz@infraded.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 2:47 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It's useful to know [uk]probe's nmissed and nhit stats. For example with
> tracing tools, it's important to know when events may have been lost.
> debugfs currently exposes a control file to get this information, but
> it is not compatible with probes registered with the perf API.
>
> While bpf programs may be able to manually count nhit, there is no way
> to gather nmissed. In other words, it is currently not possible to
> retrieve information about FD-based probes.
>
> This patch adds a new ioctl that lets users query nmissed (as well as
> nhit for completeness). We currently only add support for [uk]probes
> but leave the possibility open for other probes like tracepoint.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/trace_events.h    | 12 ++++++++++++
>  include/uapi/linux/perf_event.h | 19 +++++++++++++++++++
>  kernel/events/core.c            | 20 ++++++++++++++++++++
>  kernel/trace/trace_kprobe.c     | 23 +++++++++++++++++++++++
>  kernel/trace/trace_uprobe.c     | 23 +++++++++++++++++++++++
>  5 files changed, 97 insertions(+)
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 5150436783e8..61558f19696a 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -586,6 +586,12 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
>                                u32 *fd_type, const char **symbol,
>                                u64 *probe_offset, u64 *probe_addr,
>                                bool perf_type_tracepoint);
> +extern int perf_kprobe_event_query(struct perf_event *event, void __user *info);
> +#else
> +int perf_kprobe_event_query(struct perf_event *event, void __user *info)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
>  #ifdef CONFIG_UPROBE_EVENTS
>  extern int  perf_uprobe_init(struct perf_event *event,
> @@ -594,6 +600,12 @@ extern void perf_uprobe_destroy(struct perf_event *event);
>  extern int bpf_get_uprobe_info(const struct perf_event *event,
>                                u32 *fd_type, const char **filename,
>                                u64 *probe_offset, bool perf_type_tracepoint);
> +extern int perf_uprobe_event_query(struct perf_event *event, void __user *info);
> +#else
> +int perf_uprobe_event_query(struct perf_event *event, void __user *info)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
>  extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
>                                      char *filter_str);
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 7198ddd0c6b1..65faa9b2a3b4 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -447,6 +447,24 @@ struct perf_event_query_bpf {
>         __u32   ids[0];
>  };
>
> +/*
> + * Structure used by below PERF_EVENT_IOC_QUERY_PROBE command
> + * to query information about the probe attached to the perf
> + * event. Currently only supports [uk]probes.
> + */
> +struct perf_event_query_probe {
> +       /*
> +        * Set by the kernel to indicate number of times this probe
> +        * was temporarily disabled
> +        */
> +       __u64   nmissed;
> +       /*
> +        * Set by the kernel to indicate number of times this probe
> +        * was hit
> +        */
> +       __u64   nhit;
> +};
> +
>  /*
>   * Ioctls that can be done on a perf event fd:
>   */
> @@ -462,6 +480,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT            _IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF               _IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES       _IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_QUERY_PROBE             _IOR('$', 12, struct perf_event_query_probe *)
>
>  enum perf_event_ioc_flags {
>         PERF_IOC_FLAG_GROUP             = 1U << 0,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 026a14541a38..3e0fe6eaaad0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5060,6 +5060,8 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg);
>  static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
>  static int perf_copy_attr(struct perf_event_attr __user *uattr,
>                           struct perf_event_attr *attr);
> +static int perf_probe_event_query(struct perf_event *event,
> +                                   void __user *info);
>
>  static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
>  {
> @@ -5143,6 +5145,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>
>                 return perf_event_modify_attr(event,  &new_attr);
>         }
> +#if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
> +       case PERF_EVENT_IOC_QUERY_PROBE:
> +               return perf_probe_event_query(event, (void __user *)arg);
> +#endif
>         default:
>                 return -ENOTTY;
>         }
> @@ -8833,6 +8839,20 @@ static inline void perf_tp_register(void)
>  #endif
>  }
>
> +static int perf_probe_event_query(struct perf_event *event,
> +                                   void __user *info)
> +{
> +#ifdef CONFIG_KPROBE_EVENTS
> +       if (event->attr.type == perf_kprobe.type)
> +               return perf_kprobe_event_query(event, (void __user *)info);
> +#endif
> +#ifdef CONFIG_UPROBE_EVENTS
> +       if (event->attr.type == perf_uprobe.type)
> +               return perf_uprobe_event_query(event, (void __user *)info);
> +#endif
> +       return -EINVAL;
> +}
> +
>  static void perf_event_free_filter(struct perf_event *event)
>  {
>         ftrace_profile_free_filter(event);
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9d483ad9bb6c..a734c2d506be 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -196,6 +196,29 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
>         return within_error_injection_list(trace_kprobe_address(tk));
>  }
>
> +int perf_kprobe_event_query(struct perf_event *event, void __user *info)
> +{
> +       struct perf_event_query_probe __user *uquery = info;
> +       struct perf_event_query_probe query = {};
> +       struct trace_event_call *call = event->tp_event;
> +       struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> +       u64 nmissed, nhit;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +       if (copy_from_user(&query, uquery, sizeof(query)))

what about forward/backward compatibility? Didn't you have a size
field for perf_event_query_probe?

> +               return -EFAULT;
> +
> +       nhit = trace_kprobe_nhit(tk);
> +       nmissed = tk->rp.kp.nmissed;
> +
> +       if (put_user(nmissed, &uquery->nmissed) ||
> +           put_user(nhit, &uquery->nhit))

Wouldn't it be nicer to just do one user put for entire struct (or at
least relevant part of it with backward/forward compatibility?).

> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static int register_kprobe_event(struct trace_kprobe *tk);
>  static int unregister_kprobe_event(struct trace_kprobe *tk);
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 1ceedb9146b1..5f50386ada59 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1333,6 +1333,29 @@ static inline void init_trace_event_call(struct trace_uprobe *tu)
>         call->data = tu;
>  }
>
> +int perf_uprobe_event_query(struct perf_event *event, void __user *info)
> +{
> +       struct perf_event_query_probe __user *uquery = info;
> +       struct perf_event_query_probe query = {};
> +       struct trace_event_call *call = event->tp_event;
> +       struct trace_uprobe *tu = (struct trace_uprobe *)call->data;
> +       u64 nmissed, nhit;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +       if (copy_from_user(&query, uquery, sizeof(query)))
> +               return -EFAULT;
> +
> +       nhit = tu->nhit;
> +       nmissed = 0;
> +
> +       if (put_user(nmissed, &uquery->nmissed) ||
> +           put_user(nhit, &uquery->nhit))
> +               return -EFAULT;

same questions as above

> +
> +       return 0;
> +}
> +
>  static int register_uprobe_event(struct trace_uprobe *tu)
>  {
>         init_trace_event_call(tu);
> --
> 2.20.1
>
