Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05611C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F992081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkbz4ItK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCGX63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:58:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35495 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCGX63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:58:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id z13so10209662qki.2;
        Thu, 07 Mar 2019 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ej3QdUZytwMLB2OlTb+uhIiTniGAbzO1HN9QTcE8xQ=;
        b=Gkbz4ItKJjHaIhwyjtYhsSIncizExWQVkKcWKEXmZSOBJspw+p+p87QmkBTA5PAJZw
         kFSSPG/wywFCFtiOrV+Iz9QBiPaVzOPx51gcWEAWouAtxImFYnQrT2LZPOZPfM4PzlZO
         9Haaode4ppdfjNVhw8YpToufRlo4rO94tCx6YkH3mp+8RT+lzGzmrnqiMEM2geQ1hb3r
         qJQ6hVkvZuSC2RRaY2ITMmD1/6BF3Ir/IeIUost0rStZq+VEU0CPjHjnZnOlbj1gbHVA
         NXdHfXSOlV7hBaS+IU+vkbK2mdgTrQ4vELztk0LKkFnokBxPSjBQtS0qJzZoI5wuI97d
         rjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ej3QdUZytwMLB2OlTb+uhIiTniGAbzO1HN9QTcE8xQ=;
        b=gIJ5NhxAu/HD9EA7N27ynSkMrJ2oFr3USB/AtaibFtrB7IeWk/1YnuuS1tdCDwNkis
         9zZ/0/wAEd/lFo+MVEgtwPVLQzgIGlrGR/MWHralMoMLGkxXoQw8+TpPdXN/IXuxM5Z/
         Lhe9qHwSFmHueAds8VTcag2AGOQmszMsnAzw2Ssg0J9qatl1YbVa/y3qUwNtL7DKGXxR
         jF241mXSqUb8086uq+jp9hJg27qC1zaqg4o7Rrai2pZ4bZm+dStytegrlJSwYtlLkVev
         CRWsW6jX7RcghTTHrUPVJQUWup2YAxAwExHhuYmVd2G5nDtLIiSnwbv2nQDnWsWC3Trh
         lOiw==
X-Gm-Message-State: APjAAAVHc/027BrRPaaC+rNOuS/WZEKcVqo23uAWUFbi1nqtGUGLCtwa
        P/fD6TUDD5HWfuD9XBqw608=
X-Google-Smtp-Source: APXvYqx6mEB0rND/VJpXRBTRVQx5uy/Lgrotai/r/MkB7wbH+hcL8E75VMZIwdGLyatrMFQGhnNSNg==
X-Received: by 2002:a05:620a:1303:: with SMTP id o3mr12117642qkj.235.1552003107707;
        Thu, 07 Mar 2019 15:58:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j9sm2197422qki.21.2019.03.07.15.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:58:26 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 364934039C; Thu,  7 Mar 2019 20:58:23 -0300 (-03)
Date:   Thu, 7 Mar 2019 20:58:23 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>
Subject: Re: [PATCH 02/35] perf probe: Clarify error message about not
 finding kernel modules debuginfo
Message-ID: <20190307235823.GD32240@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
 <20190307174433.28819-3-acme@kernel.org>
 <20190308083033.cd4aceb08983875d07cabc1a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308083033.cd4aceb08983875d07cabc1a@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 08, 2019 at 08:30:33AM +0900, Masami Hiramatsu escreveu:
> On Thu,  7 Mar 2019 14:44:00 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > 'perf probe' supports using just the kernel module name, but that will
> > work only when the module is loaded, or using the full pathname to the
> > file with the DWARF debug info, but the warning was cryptic:
> 
> Agreed, this looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for checking!

- Arnaldo
 
> Thank you!
> 
> > 
> > Before:
> > 
> >   # perf probe -m cls_flower -L fl_change
> >   Failed to find the path for cls_flower: No such file or directory
> >     Error: Failed to show lines.
> >   #
> > 
> > After:
> > 
> >   # perf probe -m cls_flower -L fl_change
> >   Module cls_flower is not loaded, please specify its full path name.
> >     Error: Failed to show lines.
> >   # perf probe -m /lib/modules/5.0.0-rc7+/kernel/net/sched/cls_flower.ko -L fl_change | head -7
> >   <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
> >         0  static int fl_change(struct net *net, struct sk_buff *in_skb,
> >          		       struct tcf_proto *tp, unsigned long base,
> >          		       u32 handle, struct nlattr **tca,
> >          		       void **arg, bool ovr, struct netlink_ext_ack *extack)
> >         4  {
> >         5  	struct cls_fl_head *head = rtnl_dereference(tp->root);
> >   #
> > 
> > The behaviour doesn't change when the module is loaded:
> > 
> >   # modprobe cls_flower
> >   # perf probe -m cls_flower -L fl_change | head -7
> >   <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
> >         0  static int fl_change(struct net *net, struct sk_buff *in_skb,
> >                                struct tcf_proto *tp, unsigned long base,
> >                                u32 handle, struct nlattr **tca,
> >                                void **arg, bool ovr, struct netlink_ext_ack *extack)
> >         4  {
> >         5         struct cls_fl_head *head = rtnl_dereference(tp->root);
> >   #
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-q4njvk9mshra00jacqjbzfn5@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/probe-event.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 0030f9b9bf7e..a1b8d9649ca7 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -472,9 +472,12 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
> >  					strcpy(reason, "(unknown)");
> >  			} else
> >  				dso__strerror_load(dso, reason, STRERR_BUFSIZE);
> > -			if (!silent)
> > -				pr_err("Failed to find the path for %s: %s\n",
> > -					module ?: "kernel", reason);
> > +			if (!silent) {
> > +				if (module)
> > +					pr_err("Module %s is not loaded, please specify its full path name.\n", module);
> > +				else
> > +					pr_err("Failed to find the path for the kernel: %s\n", reason);
> > +			}
> >  			return NULL;
> >  		}
> >  		path = dso->long_name;
> > -- 
> > 2.20.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
