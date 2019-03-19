Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D572083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCA4icUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCSRlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:41:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39720 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCSRk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:40:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id c189so12387922qke.6;
        Tue, 19 Mar 2019 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UiiziMIoGH7cmPI7+oeMfYKNhrOdtBLJgIU4pPBAR0A=;
        b=MCA4icUAwJX43V11+/Alh/uNd3RdesMltzdQI1EnJBNeLeNbJy0p5hoBMLxgwzINUv
         r6oGvIFMlXnV6Gbrb9xc/80oX8O8aGgNppgN5fwAtajsBIXQVOXCFFdYOk8iNuz+vv7p
         JiXEih5FErUVK2F9wn+9CWFHUuWx1nWz8xZAJGjQMH5h5tTNoqVW+6PMtgWp+rbIrmdh
         zk2AvEvYdZMUmLBsyT+QOTO99Axe74H4X2zWIbDcrepq7Q0P5A+ty74NIPWmSTPn7KEB
         4ymU14HkdAqoXeflU4k8a13depuLluy7vkynqY6hHbVOka5nANrPmOF10gAS38XWc+fm
         0lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiiziMIoGH7cmPI7+oeMfYKNhrOdtBLJgIU4pPBAR0A=;
        b=j5vmlb1d+qIe5FGxznyX+wVVSb8hlPhxfhz/oV+mD5yzsNDJSx8maWU0V0rO8ERbbX
         r7aZQnD+me8mjkjVfVd4vJPwJlqgFdqTvewC0IPbgWbcvAwkSJP/nVWf85qHGpT/QKe0
         7/5xZu9ig/WLNsxF1IZJmQoki1Os0QoJ7zJ/AQzZvUAhafOEI8Yl0tY2MhScjKuQg+sZ
         OqOhCw+OwTjRN8L5W0iIIGzIRbtjMlMXtDctnQhNZjHB2q7o6D7yIg296AXUt3d7A81V
         GIRFCrF/KrZ7/HidujEK/rSK+Mg/Gsix8ROovf3ZeW41HIMr17Uw72q6JQyFgJKkOI/r
         qMzQ==
X-Gm-Message-State: APjAAAW0jQBJnaPEzCqVyotFCctAyK3/jat/el6x4JauFkMZnEzGROsV
        36l/GkelmHBwLE8SB7o5oSTGJs0a
X-Google-Smtp-Source: APXvYqwktDy16RrfqVgONWyQYHKpoFBhC3WsN1nF4fMZ2yc2lJRetDEXyILcI4bS/CrctEElQsFZbg==
X-Received: by 2002:a37:c3ca:: with SMTP id r71mr2981659qkl.101.1553017258285;
        Tue, 19 Mar 2019 10:40:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m52sm9787865qtc.23.2019.03.19.10.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 10:40:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3B924039C; Tue, 19 Mar 2019 14:40:54 -0300 (-03)
Date:   Tue, 19 Mar 2019 14:40:54 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v2 perf,bpf 2/2] perf, bpf: show more BPF program info in
 print_bpf_prog_info()
Message-ID: <20190319174054.GK3029@kernel.org>
References: <20190319165454.1298742-1-songliubraving@fb.com>
 <20190319165454.1298742-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319165454.1298742-3-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 09:54:54AM -0700, Song Liu escreveu:
> This patch enables showing bpf program name, address, and size in the
> header.
> 
> Before the patch:
> 
>   perf report --header-only
>   ...
>   # bpf_prog_info of id 9
>   # bpf_prog_info of id 10
>   # bpf_prog_info of id 13
> 
> After the patch:
> 
>   # bpf_prog_info 9: bpf_prog_7be49e3934a125ba addr 0xffffffffa0024947 size 229
>   # bpf_prog_info 10: bpf_prog_2a142ef67aaad174 addr 0xffffffffa007c94d size 229
>   # bpf_prog_info 13: bpf_prog_47368425825d7384_task__task_newt addr 0xffffffffa0251137 size 369
> index 8cb1189149ec..d9cb4170ae79 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -38,7 +38,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
>  				      struct record_opts *opts);
>  int bpf_event__add_sb_event(struct perf_evlist **evlist,
>  				 struct perf_env *env);
> -
> +void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +				    struct perf_env *env,
> +				    FILE *fp);
>  #else
>  static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  					     union perf_event *event __maybe_unused,
> @@ -61,5 +63,11 @@ static inline int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_un
>  	return 0;
>  }
>  
> +void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,

Missing static inline here, as well as the __maybe_unused, I'm fixing it

> +				    struct perf_env *env,
> +				    FILE *fp)
> +{
> +
> +}
>  #endif // HAVE_LIBBPF_SUPPORT
>  #endif
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 01dda2f65d36..b9e693825873 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1468,8 +1468,9 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
>  
>  		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
>  		next = rb_next(&node->rb_node);
> -		fprintf(fp, "# bpf_prog_info of id %u\n",
> -			node->info_linear->info.id);
> +
> +		bpf_event__print_bpf_prog_info(&node->info_linear->info,
> +					       env, fp);
>  	}
>  
>  	up_read(&env->bpf_progs.lock);
> -- 
> 2.17.1

-- 

- Arnaldo
