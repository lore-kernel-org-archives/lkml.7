Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B30C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443F4205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7YFSKSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfDVO3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:29:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44241 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:29:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id s10so1482578qtc.11;
        Mon, 22 Apr 2019 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+3KwgFLNI1DxbNWdLk+UeWpsRkqDazKZnichH+L7dk=;
        b=n7YFSKSw3t+otWf+aVLBd5dsR+PjeiJkEzpbZH9iIMHTb24NfeO6ImkJpTYt/bpV/4
         o/DY21Sqw47Hib8fJ1iMrm3UzB2xzqvhqiOXxu98BGbrKX9fUxkHG9TXTpbhLiXugotN
         hqNaxJsX7UkMbkRT3+qAyizmA+AKpgcXmVBt8OUPW3IleUQoYr7KFssGP0+36XRDMzC9
         oe7nBIGpxbx2R7BHiutx38R4mk6UqPw/93cT8wGTR1piz1unDVuPrruv/zdC4wC64rxx
         j9znbkqXXpcPrcUlFmiTAIUeBeaYEYnElqaInJyCdw2acHzRQZckhmmiRsdYrVCTJZyk
         khTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+3KwgFLNI1DxbNWdLk+UeWpsRkqDazKZnichH+L7dk=;
        b=YiytO9lbcAN87CiO33l2XJXNCz5EJIFiicV/NSfjVj7uMYwiECJ1wOfiUUQ7nTxJRx
         2R5VIr1sbQYLUZnzivo2ud3vRz+rKfd9EhNzP0+M+Z+T27/gVa/aIl4T9oIMq8Z5HXdB
         25oRB7xRR1pUf6Q2jd2E5IRc2b60cbrPIjqceqhB0wDxXrBkULPrsOEhrhPY1IjG0PdI
         onvwPCR49BzeKXLOU7Fexh6PjkJch5lEspWt5j/u3jVnAJ0DV4EZ/d0hgijG/OBWhUbk
         Yf5t+/Tf9Wb+sp7nK53DXTAgLjKnAFYfm8/nMa+g5LkJoZNe/8nAZRiPwYDx1yHXbxcS
         ri6A==
X-Gm-Message-State: APjAAAW7xRT7cDuUEZ3d+dw6wFftBgwFk6Z8hCnmbzgKI8UDkRiNeeZT
        gFjvAmtSaEpL4gSDLACWQXk=
X-Google-Smtp-Source: APXvYqzVFsdDHBaP6Z/GYiaEeq/kC11nlV2bsubD7yco9uy5v3i+8fdPGSiGbb2xBKCYuxzwcvGjrw==
X-Received: by 2002:a0c:b885:: with SMTP id y5mr15693908qvf.25.1555943370529;
        Mon, 22 Apr 2019 07:29:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id s50sm8201865qts.39.2019.04.22.07.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 07:29:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7926F403EB; Mon, 22 Apr 2019 11:29:26 -0300 (-03)
Date:   Mon, 22 Apr 2019 11:29:26 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Bo YU <tsu.yubo@gmail.com>, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf bpf: return value with unlocking in
 perf_env__find_btf()
Message-ID: <20190422142926.GA11750@kernel.org>
References: <20190422080138.10088-1-tsu.yubo@gmail.com>
 <20190422093629.GA1730@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422093629.GA1730@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 22, 2019 at 11:36:29AM +0200, Jiri Olsa escreveu:
> On Mon, Apr 22, 2019 at 04:01:38AM -0400, Bo YU wrote:
> > In perf_env__find_btf(), returning without unlocking
> > "env->bpf_progs.lock". There may be cause lockdep issue.
> > 
> > DEtected by CoversityScan, CID# 1444762:(program hangs(LOCK))
> > 
> > Fixes: 2db7b1e0bd49d: (perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf())
> 
> ugh, sry about that

Brown paper bag on the part of everybody involved indeed :-\
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied.

Thanks,

- Arnaldo
 
> thanks,
> jirka
> 
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
> >  tools/perf/util/env.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 9494f9dc61ec..6a3eaf7d9353 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -115,8 +115,8 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
> >  	}
> >  	node = NULL;
> >  
> > -	up_read(&env->bpf_progs.lock);
> >  out:
> > +	up_read(&env->bpf_progs.lock);
> >  	return node;
> >  }
> >  
> > -- 
> > 2.11.0
> > 

-- 

- Arnaldo
