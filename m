Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55200C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2280E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552001442;
	bh=K0/CAaGIwXCnvaTwR76JHXuWKgzT4ZivzwonKKeDgMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e6W/5NU+1kYYMcqIFxcXcbB5bZATu6hmk+NBb/ffJyIMxqjHQ99Z84WfIviWjUK0G
	 jgP4eGoyNtlyCV0JEgqeEeXmwZ69/hL9cSMYPvl44v6IUrUOFxlA1lIi2Yj3blNh+3
	 uyqS+BheT1LOfc4dbLoscXNV74vQ65WLGFyLWwbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCGXak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:30:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGXak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:30:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C94E20675;
        Thu,  7 Mar 2019 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552001439;
        bh=K0/CAaGIwXCnvaTwR76JHXuWKgzT4ZivzwonKKeDgMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LWTdcZO5eF9hOnFb9KvojFtsyLW/2Wjh1SFAtEkcWQdpbfkMOjMmA8GYsX82EQsUo
         QQfBjize34dykj7oXS5sYOksXPWz3GBEqB0zm8K66BpiSKvSeHxQrB0GVMyq3TXgGa
         SW1YI6IDAR4yGIhJgt2Rk/slAK9iNFqIvoFoibzY=
Date:   Fri, 8 Mar 2019 08:30:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 02/35] perf probe: Clarify error message about not
 finding kernel modules debuginfo
Message-Id: <20190308083033.cd4aceb08983875d07cabc1a@kernel.org>
In-Reply-To: <20190307174433.28819-3-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
        <20190307174433.28819-3-acme@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 14:44:00 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> 'perf probe' supports using just the kernel module name, but that will
> work only when the module is loaded, or using the full pathname to the
> file with the DWARF debug info, but the warning was cryptic:

Agreed, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Before:
> 
>   # perf probe -m cls_flower -L fl_change
>   Failed to find the path for cls_flower: No such file or directory
>     Error: Failed to show lines.
>   #
> 
> After:
> 
>   # perf probe -m cls_flower -L fl_change
>   Module cls_flower is not loaded, please specify its full path name.
>     Error: Failed to show lines.
>   # perf probe -m /lib/modules/5.0.0-rc7+/kernel/net/sched/cls_flower.ko -L fl_change | head -7
>   <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
>         0  static int fl_change(struct net *net, struct sk_buff *in_skb,
>          		       struct tcf_proto *tp, unsigned long base,
>          		       u32 handle, struct nlattr **tca,
>          		       void **arg, bool ovr, struct netlink_ext_ack *extack)
>         4  {
>         5  	struct cls_fl_head *head = rtnl_dereference(tp->root);
>   #
> 
> The behaviour doesn't change when the module is loaded:
> 
>   # modprobe cls_flower
>   # perf probe -m cls_flower -L fl_change | head -7
>   <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
>         0  static int fl_change(struct net *net, struct sk_buff *in_skb,
>                                struct tcf_proto *tp, unsigned long base,
>                                u32 handle, struct nlattr **tca,
>                                void **arg, bool ovr, struct netlink_ext_ack *extack)
>         4  {
>         5         struct cls_fl_head *head = rtnl_dereference(tp->root);
>   #
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-q4njvk9mshra00jacqjbzfn5@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/probe-event.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 0030f9b9bf7e..a1b8d9649ca7 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -472,9 +472,12 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
>  					strcpy(reason, "(unknown)");
>  			} else
>  				dso__strerror_load(dso, reason, STRERR_BUFSIZE);
> -			if (!silent)
> -				pr_err("Failed to find the path for %s: %s\n",
> -					module ?: "kernel", reason);
> +			if (!silent) {
> +				if (module)
> +					pr_err("Module %s is not loaded, please specify its full path name.\n", module);
> +				else
> +					pr_err("Failed to find the path for the kernel: %s\n", reason);
> +			}
>  			return NULL;
>  		}
>  		path = dso->long_name;
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
