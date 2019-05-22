Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A10BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA927208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LudW1PFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfEVNSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:18:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45339 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfEVNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:18:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id t1so2212065qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F99fJXke87n0K+CLpn2sBD7Xt1XYLxYedr6gbf2zuUQ=;
        b=LudW1PFZQYmSPH1+lMnXyhNKacvYZdRl3KDt7H/Pehx+3lZGGVIeoTL6MTC3RS/z+k
         XBMnUKWKq1FmfXAYip4uOpuZB52p6pylScFcRwO3oTWFfxjzuwearqJt+/Bd0zm3Un7I
         q09LXRH1jknjYYhh6nZyuO/DCAa55ce6hKj2EkWigGtyg8IIDRNxOMOJKtKwFYkSeeXB
         ZSVXmWj1HVgNplYZcR4PlCI3Xmufbndvqiz+asYX9/yRAA5X04NNidZn73fv0F//oC+/
         9YUH4whHvmrfuhfDawPmwQJVcOwOy1QJY6YONRUBgFnzparJ/yh7zG9x/pO2QJm+P0uy
         v7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F99fJXke87n0K+CLpn2sBD7Xt1XYLxYedr6gbf2zuUQ=;
        b=MwzRII2j9vKeL+HfFM/nGmlKFibGt75eWZFd+czXSf+vSRv6zxWp9DGISwu3Ca8dPZ
         bS4YquGNJbh4Mdk8y2MAFkb9caS523I9n3gQCRdOIXZr/AeGGrmpHAJDmPrDjbLuWtFW
         TVOdjfpZWarl0UgOnZrpmQnAiJFAUra4ne7wTE3VUqbdn10lG3nQz4REGV/aZtlJsTGj
         ipc8SNSgcUCFX9NefEl4hayWD22Lxq5oX9zrk637eN+JT3qazhdO4WTe+eZ0gNPpHAuv
         XNrtRjjAY3r5ipNuiAlKH5Hsw3yjvnjx+t9rmfvTxgV2RT3RpLiGuL5d+3wylNALwzyQ
         uCAg==
X-Gm-Message-State: APjAAAVd7hPCa0SPxAd/aE+4tG3W7p+tBSFI4HAhQDe4KWgEt4TOiyio
        t5jnyZdCHP3dp9PfIX9wNZd+QDwg
X-Google-Smtp-Source: APXvYqy5sH307wMiMOP6ed/KVh9lG3mA1OgWNb1vJNuZsHi6UIPq/+fwWoeQYbHP+aJd8XxdLqi8fw==
X-Received: by 2002:a0c:b626:: with SMTP id f38mr16292757qve.223.1558531115661;
        Wed, 22 May 2019 06:18:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.94.38])
        by smtp.gmail.com with ESMTPSA id 22sm7841821qto.92.2019.05.22.06.18.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 06:18:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EF29404A1; Wed, 22 May 2019 10:18:32 -0300 (-03)
Date:   Wed, 22 May 2019 10:18:32 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] perf tools: Protect reading thread's namespace
Message-ID: <20190522131832.GB30271@kernel.org>
References: <20190522053250.207156-1-namhyung@kernel.org>
 <20190522053250.207156-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522053250.207156-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 22, 2019 at 02:32:48PM +0900, Namhyung Kim escreveu:
> It seems that the current code lacks holding the namespace lock in
> thread__namespaces().  Otherwise it can see inconsistent results.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/thread.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 403045a2bbea..b413ba5b9835 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -133,7 +133,7 @@ void thread__put(struct thread *thread)
>  	}
>  }
>  
> -struct namespaces *thread__namespaces(const struct thread *thread)
> +static struct namespaces *__thread__namespaces(const struct thread *thread)
>  {
>  	if (list_empty(&thread->namespaces_list))
>  		return NULL;
> @@ -141,10 +141,21 @@ struct namespaces *thread__namespaces(const struct thread *thread)
>  	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
>  }
>  
> +struct namespaces *thread__namespaces(const struct thread *thread)
> +{
> +	struct namespaces *ns;
> +
> +	down_read((struct rw_semaphore *)&thread->namespaces_lock);
> +	ns = __thread__namespaces(thread);
> +	up_read((struct rw_semaphore *)&thread->namespaces_lock);
> +

Humm, so we need to change thread__namespaces() to remove that const
instead of throwing it away with that cast, right?

- Arnaldo

> +	return ns;
> +}
> +
>  static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
>  				    struct namespaces_event *event)
>  {
> -	struct namespaces *new, *curr = thread__namespaces(thread);
> +	struct namespaces *new, *curr = __thread__namespaces(thread);
>  
>  	new = namespaces__new(event);
>  	if (!new)
> -- 
> 2.21.0.1020.gf2820cf01a-goog

-- 

- Arnaldo
