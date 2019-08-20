Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37945C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DF9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkPgdink"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfHTOQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:16:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36979 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfHTOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:16:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id s14so4605992qkm.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QMyh9ztIFZ0lhgUdkNFIpnrPdlgkiFRw5urtr+XGEug=;
        b=DkPgdinkoPHN6vp2qSkP+LxgOE6TEi2or5IeRLT0we6/LzN98s4DIwPI/sEs3MMpiB
         if7hKIOZH5CFc9s9sn0ftKaJMrMLD5Rk49xHY/KeezFdk9aQQutWV0o5uolycr1pOCTU
         U8SvBXjRhjgE6fWq+dgNUAbp/EIXfvTFCHEeWHEC43ybulldoMQIW6VAQf8TzWXjh/bf
         TI4wp2COStTqTXMYsifz75CpVL/kXi8s3izVkxNCbcxLLZf69AgunW5wDP1qTw0kQiAJ
         5PntVwhaTY/llED6V/DBufL46hf+5fwiJh7gyr7BEduAx4wSsEp6AWLGf9fZS50k/WN5
         sQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QMyh9ztIFZ0lhgUdkNFIpnrPdlgkiFRw5urtr+XGEug=;
        b=YvHJsm+IB6ejRDd304X3iexd/RK+ZtlyLvXx4Ek9c0PuLQUKdRCl85nblFuT8a/Qms
         1sNUyN5S/XlyYg/PUJ09ljgUdD0b7/WYvwPTxEn9VkQJ64D5cgDQq8aZacF7D6IUbLqe
         JKmQo7e03WECGmopbDuYhSQo5aXxxbpysukEd4Kj4av5XgmIJDvRTlMF6fYnXshP18Qa
         mr24zkKRKmzMn1mCmprjbxTV39cPmtmnms35qC9EmbI8XtCjOOO83exabq+OHD1TwXH4
         Ve4N2zfdPSPMSPMxTA+GpJpwTIR98N/oxLW3JkYSyadNhdWr27ngL72F8qilbEhbfdrs
         yZfQ==
X-Gm-Message-State: APjAAAVCUd0Le/f3OkCC6XmV6NQbeNlmpVVuVF9Tow2QHPZ9bIqSpODi
        gBjRV4fXvV7/sqkONIzWxsU=
X-Google-Smtp-Source: APXvYqyC322Aah00uGUIEpVPwei0Cm4Q1TD+AkzhmYplureTiy4+DDec+gHf1LlJ620h5W0su4vyNg==
X-Received: by 2002:a37:4997:: with SMTP id w145mr26973916qka.82.1566310615895;
        Tue, 20 Aug 2019 07:16:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h12sm8321475qkl.63.2019.08.20.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 07:16:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04D7D40340; Tue, 20 Aug 2019 11:16:52 -0300 (-03)
Date:   Tue, 20 Aug 2019 11:16:52 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Joe Mario <jmario@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf c2c: Display proper cpu count in nodes column
Message-ID: <20190820141652.GG24428@kernel.org>
References: <20190820140219.28338-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820140219.28338-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 20, 2019 at 04:02:19PM +0200, Jiri Olsa escreveu:
> There's wrong bitmap considered when checking
> for cpu count of specific node.
> 
> We do the needed computation for 'set' variable,
> but at the end we use the 'c2c_he->cpuset' weight,
> which shows misleading numbers.
> 
> Reported-by: Joe Mario <jmario@redhat.com>

You forgot to add this:

Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")

Can you please confirm that that is the cset being fixed? This helps
with backporters, stable@, etc.

- Arnaldo


> Link: https://lkml.kernel.org/n/tip-9wvrv74n7d4nbgztr74isv5j@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-c2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index f0aae6e13a33..9240c6bf70f5 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1106,7 +1106,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
>  			break;
>  		case 1:
>  		{
> -			int num = bitmap_weight(c2c_he->cpuset, c2c.cpus_cnt);
> +			int num = bitmap_weight(set, c2c.cpus_cnt);
>  			struct c2c_stats *stats = &c2c_he->node_stats[node];
>  
>  			ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
> -- 
> 2.21.0

-- 

- Arnaldo
