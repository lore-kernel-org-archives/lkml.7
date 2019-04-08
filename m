Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E2E2083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbE5FEbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDHTgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:36:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45584 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDHTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:36:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so16870986qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9axrUft3sq8uKSuZJ8UcdqmMh7guZsOelrPSqtkyQo4=;
        b=gbE5FEbOcW/631fQdyIfKxvips/z9BSlVxAxDw6aUY/VgtPwlr256iwlygURU4X+at
         jzk71wSfKiEPmDMYZg8OCPTJFG49yiJGjMD3hGZ56PDZ0vwtX/v6tHYctUuabqObsgnf
         EX2z+w1jQF7TH2Ax6Y18TQPXcvNm0gKztGpE9zbaeT0Qjj8aFpZBbdWykNO4KLrCEz9c
         lB7KnETj3cytrf7QzzLL1CPW4mnWuMzyyhiJkxh8LFrasUCnxKC4LGxn9XfhObQLyanX
         56ib38k41FjGwKkYO9zYXoxfhfn8lRMNzq5fDOyBg75/a52C9EjPY3fAQI3h7wI1GKst
         SSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9axrUft3sq8uKSuZJ8UcdqmMh7guZsOelrPSqtkyQo4=;
        b=SzDsGCrg02TlduLDnDW3Oh4CZweStsXgD05vwYAraJaXlF0ki38Wy9g9OvU3dATBN0
         ucFU+n+EJMfiQ7+YN3bKB4yodoCIfURmTO9U8JzUoj64W0sKeC/QU/s3bZBdm+D6rJGG
         u50wYqJl7lJ6IyTImUKdrsnaT9wTXgBy0OBPRavxAZWvA3cEAG9DJFDvLMWhA6X7EhUJ
         RPClqhapdmJWb2cIQq842b2hQoZj1Aa3cKQ0R7NVeY+b36hPqK2alAYOKsz1CCUEBGhx
         0l8O4hrC6YkHV9NTlyWZUAcOZYZKkUAxELxrPZJbMgMyy6dXSPO3J08akoQh0rmfEgfX
         Sjkw==
X-Gm-Message-State: APjAAAW84DinJ4EDdWXaAlSb1PWBcaBK1ubugwCw0ufwM+IQ/uIbWJk8
        tzWC2zufDrgDLhWLiIflZBg=
X-Google-Smtp-Source: APXvYqzRvUZ1MkQyM/RLew3eNZVqtv+xLpcxX+En/dMHhgSRMFq/fbw2/gV1OyD11+dNaSP4speSdg==
X-Received: by 2002:ac8:17ee:: with SMTP id r43mr26278442qtk.169.1554752160213;
        Mon, 08 Apr 2019 12:36:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id l59sm18462369qte.6.2019.04.08.12.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 12:35:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 113614039C; Mon,  8 Apr 2019 16:35:56 -0300 (-03)
Date:   Mon, 8 Apr 2019 16:35:56 -0300
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf header: Fix lock/unlock imbalances
Message-ID: <20190408193555.GA5796@kernel.org>
References: <20190408173355.GA10501@embeddedor>
 <B581617C-53AD-435A-8352-5E5A74B76B34@fb.com>
 <3867ffda-5d01-412b-ed55-e39ee9db2ceb@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3867ffda-5d01-412b-ed55-e39ee9db2ceb@embeddedor.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 08, 2019 at 01:26:09PM -0500, Gustavo A. R. Silva escreveu:
> 
> 
> On 4/8/19 1:22 PM, Song Liu wrote:
> > 
> > 
> >> On Apr 8, 2019, at 10:33 AM, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> >>
> >> Fix lock/unlock imbalances by refactoring the code a bit and adding
> >> calls to up_write() before return.
> >>
> >> Addresses-Coverity-ID: 1444315 ("Missing unlock")
> >> Addresses-Coverity-ID: 1444316 ("Missing unlock")
> >> Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.data")
> >> Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Acked-by: Song Liu <songliubraving@fb.com>
> > 
> > Thanks for the fix!
> > 
> 
> Glad to help. :)

Super cool, using the same idiom as the kernel and living in the kernel
sources has its advantages 8-)

But see below, 

> >> +++ b/tools/perf/util/header.c
> >> @@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
> >> 		perf_env__insert_bpf_prog_info(env, info_node);
> >> 	}
> >>
> >> +	up_write(&env->bpf_progs.lock);
> >> 	return 0;
> >> out:
> >> 	free(info_linear);
> >> @@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
> >> static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> >> {
> >> 	struct perf_env *env = &ff->ph->env;
> >> +	struct btf_node *node;
> >> 	u32 count, i;
> >> +	int err = -1;

Why are you using this 'err' variable? It is only set here and at the
end, i.e. one write, one read. We could as well have that out: block
return -1 straight away.

Else we could do, see below

> >>
> >> 	if (ff->ph->needs_swap) {
> >> 		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
> >> @@ -2636,31 +2639,33 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> >> 	down_write(&env->bpf_progs.lock);
> >>
> >> 	for (i = 0; i < count; ++i) {
> >> -		struct btf_node *node;
> >> 		u32 id, data_size;
> >>
> >> +		node = NULL;
> >> 		if (do_read_u32(ff, &id))
> >> -			return -1;
> >> +			goto out;
> >> 		if (do_read_u32(ff, &data_size))
> >> -			return -1;
> >> +			goto out;
> >>
> >> 		node = malloc(sizeof(struct btf_node) + data_size);
> >> 		if (!node)
> >> -			return -1;
> >> +			goto out;
> >>
> >> 		node->id = id;
> >> 		node->data_size = data_size;
> >>
> >> -		if (__do_read(ff, node->data, data_size)) {
> >> -			free(node);
> >> -			return -1;
> >> -		}
> >> +		if (__do_read(ff, node->data, data_size))
> >> +			goto out;
> >>
> >> 		perf_env__insert_btf(env, node);
> >> 	}

      err = 0;

> >>

out:

> >> 	up_write(&env->bpf_progs.lock);

      return err;

And delete the rest.

but I see, you used the same pattern in the first #ifdef HAVE_LIBBPF_SUPPORT
block :-)

Anyway, since we're fixing up that other case, we might as well
streamline this, please check the patch below.

> >> 	return 0;

> >> +out:
> >> +	up_write(&env->bpf_progs.lock);
> >> +	free(node);
> >> +	return err;

So, that is what I'm applying, please holler if I introduced some
problem:

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b9e693825873..2d2af2ac2b1e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
+	up_write(&env->bpf_progs.lock);
 	return 0;
 out:
 	free(info_linear);
@@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_env *env = &ff->ph->env;
+	struct btf_node *node = NULL;
 	u32 count, i;
+	int err = -1;
 
 	if (ff->ph->needs_swap) {
 		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
@@ -2636,31 +2639,32 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	down_write(&env->bpf_progs.lock);
 
 	for (i = 0; i < count; ++i) {
-		struct btf_node *node;
 		u32 id, data_size;
 
 		if (do_read_u32(ff, &id))
-			return -1;
+			goto out;
 		if (do_read_u32(ff, &data_size))
-			return -1;
+			goto out;
 
 		node = malloc(sizeof(struct btf_node) + data_size);
 		if (!node)
-			return -1;
+			goto out;
 
 		node->id = id;
 		node->data_size = data_size;
 
-		if (__do_read(ff, node->data, data_size)) {
-			free(node);
-			return -1;
-		}
+		if (__do_read(ff, node->data, data_size))
+			goto out;
 
 		perf_env__insert_btf(env, node);
+		node = NULL;
 	}
 
+	err = 0;
+out:
 	up_write(&env->bpf_progs.lock);
-	return 0;
+	free(node);
+	return err;
 }
 
 struct feature_ops {
