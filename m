Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA10C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F24320656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG/dcoVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfDPOgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:36:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44711 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfDPOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:36:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so23469089qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hOgP5PZT9M0IoWZSChtA+gkh0lnXwtLmqLhczjlYKN4=;
        b=bG/dcoVh+3EhxhX5UaWM6/I8I+4SWRWQ+/1ZHMLZPdSqHEQNQ/2Qx2UIpM5Q9cHiBL
         EzpIkRpTW14HSrCVioUWKcBGms7HhuPWEK8XL6NeNzvicbL6rySxprWT1WKTbQZO0QUo
         PEZ9gZCZxUZ1QHPpp7Sm2Zuc1OGzcSQZMvPWavcOXOU9YZSv5rVOaHdSsPmQNOY6s2QG
         +b7kx5jOrW0tm+CBwtiyU80FVwbZY5NQ9Ah0saMHfv7vx1jfqN3+ix0zx+9Vx1JQhtXq
         DL7Oc2NyENaIckSd0NG/iqbWoO++6pThMWlaGxnyeDIqet9+x7+5bToahiMnT0b9b8/J
         mILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOgP5PZT9M0IoWZSChtA+gkh0lnXwtLmqLhczjlYKN4=;
        b=Dj7+K2iqVt//S6XUeGzZMAAmIU0XTmpx9KsbFkxXFxRLU4Bm5uaneNxEG6C5V5hAzA
         +nCc3qgA6Wd3X8ja1OAeB9tzWC88ABjfoQeHVcuZf3YCKVDPW5SPzWslsdIflOFsUBsR
         Kt8BuQ1kaWPwp6btzxqHk36+9Vdxss1nq0JrPiqf5slazJtmkk/E1mr3gV0M3jXOSTh9
         sW4lS2aKe3tvDNmVchDEcwoTSUKt4c6zpucwgpbdjYog1t8Q/ouo3DblvQN/h+i3rhVR
         wFbK1E/2rsxgFWmjcwHNaGVEHszwSGIQ2GwdUoRHTSJpm5+F+XqGB5eVXIOzVUVU5Ykf
         mJQg==
X-Gm-Message-State: APjAAAUoqJBcimt0C2ix0ScfVr0ggNDv4FZhS2fonmmV6fpJc5NgC38J
        dYhExECbi7RWoaWi3E5GBgw=
X-Google-Smtp-Source: APXvYqwYIWTK5uS9FJrRYIJnkBfXdPpF8XrO9NzBsCRb8n60htUZM20ftUMFDbrxSaXLajquIVCemA==
X-Received: by 2002:a0c:d116:: with SMTP id a22mr65995017qvh.32.1555425358872;
        Tue, 16 Apr 2019 07:35:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id y55sm34438229qtk.13.2019.04.16.07.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 07:35:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE5CE4039C; Tue, 16 Apr 2019 11:35:54 -0300 (-03)
Date:   Tue, 16 Apr 2019 11:35:54 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree
 lookup
Message-ID: <20190416143554.GB2459@kernel.org>
References: <20190416134151.15282-1-jolsa@kernel.org>
 <20190416142028.GH11294@kernel.org>
 <20190416143452.GB10125@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416143452.GB10125@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 16, 2019 at 04:34:52PM +0200, Jiri Olsa escreveu:
> On Tue, Apr 16, 2019 at 11:20:28AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Apr 16, 2019 at 03:41:51PM +0200, Jiri Olsa escreveu:
> > > We currently don't return NULL in case we don't find
> > > the bpf_prog_info_node, fixing that.
> > 
> > Can you please try to figure out what was the changeset that introduced
> > this problem so that we can have a Fixes: tag that helps me determine if
> > this should go to perf/urgent (likely) or (perf/core) and to help the
> > stable guys as well?
> 
> sry, I keep forgetting this..
> 
> Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")

I had just added:

Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")

matches, good :-)

At firts I thought hey the look checks for NULL, then, hey, different
variable... good catch!

Thanks,
 
> thanks,
> jirka
> 
> > 
> > Thanks,
> > 
> > - Arnaldo
> >  
> > > Cc: Song Liu <songliubraving@fb.com>
> > > Link: http://lkml.kernel.org/n/tip-bp07cla6dy6ifydl1sfoiorw@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/env.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > > index c6351b557bb0..34a363f2e71b 100644
> > > --- a/tools/perf/util/env.c
> > > +++ b/tools/perf/util/env.c
> > > @@ -57,9 +57,11 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
> > >  		else if (prog_id > node->info_linear->info.id)
> > >  			n = n->rb_right;
> > >  		else
> > > -			break;
> > > +			goto out;
> > >  	}
> > > +	node = NULL;
> > >  
> > > +out:
> > >  	up_read(&env->bpf_progs.lock);
> > >  	return node;
> > >  }
> > > -- 
> > > 2.17.2
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
