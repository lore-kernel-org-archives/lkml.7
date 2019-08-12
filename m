Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C92D206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erYZ3Yjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfHLU3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:29:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46939 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHLU3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:29:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id j15so10612990qtl.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=okQCanS41NVfsqts5AJnKPYxoZvv6fudHvTlcVUrGb4=;
        b=erYZ3YjobyGfzlBoxLc42M3F2RosVw0ZLJ8jT8ORF/CXfU5fuK1ic4KNz8H7G/MZUc
         TpEJqrKmiQoupS4h55fSjKWdfsZ9GTdfueOQ6dPAacplMEouOBo48ORxGA+y88n4dI+l
         +DKmoViQB7lujSgP6zatSKVxGCwL0NPYKdfjB8zbLU38V2osbC9TScaVwcg8aaJgnU2D
         sCA1ifDiEstx71dcNXDT1gs6OgwSb0meF4fm9mv+AZU01XfZa5C9RphIIX4Mhn6T5/38
         AntxHq5JjZ2R2qldCfQuE81uFpKfxjAxLR9OzS8LBgPKduNdddLZ6gtKMhPoVxaEJoBV
         0OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=okQCanS41NVfsqts5AJnKPYxoZvv6fudHvTlcVUrGb4=;
        b=It/o8uhAYcV3vH3srCpelZWPcWxuR/zfmEY2vYOcPnQtam3korOe5ThgG7ew3uZx6T
         y4gYZsZbDJoQ1qf/hmqEr0Y6ylqu6zzBUlozzAIkhD+DtvdbeXSrzjTL+QruWYiC/XZ9
         8OEi3cBhEDP/YQwn1voFUwean+WD/lJFWlilZs4zi/wl2ZU30wgdA9jCZ/5hB+HkofzP
         hrOI4jcIBzUNggRtvMvzJRBn+F6OZtShPO3RpAhy7Bf+MQJ2qKB/y+Tj0e2VYYHTcrPp
         dOHG4WNtPlOTpcHbTBVhFSlxxNFVoRCMbObg8RKfGItCSfO9b3LR7anPvRZIiC5FXugv
         HALQ==
X-Gm-Message-State: APjAAAVherCG6bXTGp8Rdw1E4OG3LJ5A5GJmuMfeP6QQ61RXmS/IaTOU
        EQTJfjcCTzUjwgMOaeHzkww=
X-Google-Smtp-Source: APXvYqwTpsVawcNiJenRqIgzSQZqFPPVYNx449w5EoHaVgkXcuz2UimxK1d9twMADDsK95KCb7HLpQ==
X-Received: by 2002:ac8:6112:: with SMTP id a18mr9255751qtm.272.1565641793538;
        Mon, 12 Aug 2019 13:29:53 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-98-68.3g.claro.net.br. [187.26.98.68])
        by smtp.gmail.com with ESMTPSA id f20sm1343362qtf.68.2019.08.12.13.29.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:29:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6AA6940340; Mon, 12 Aug 2019 17:29:47 -0300 (-03)
Date:   Mon, 12 Aug 2019 17:29:47 -0300
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 4/4] perf: Use CAP_SYS_ADMIN instead of euid==0 with
 ftrace
Message-ID: <20190812202947.GI9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
 <20190812202251.GG9280@kernel.org>
 <20190812202706.GH9280@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812202706.GH9280@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 12, 2019 at 05:27:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Aug 12, 2019 at 05:22:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Aug 07, 2019 at 10:44:17AM -0400, Igor Lubashev escreveu:
> > > @@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> > >  		.events = POLLIN,
> > >  	};
> > >  
> > > -	if (geteuid() != 0) {
> > > +	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> > >  		pr_err("ftrace only works for root!\n");
> > 
> > I guess we should update the error message too? 
> > 
> 
> I.e. I applied this as a follow up patch:
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 01a5bb58eb04..ba8b65c2f9dc 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -284,7 +284,12 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	};
>  
>  	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> -		pr_err("ftrace only works for root!\n");
> +		pr_err("ftrace only works for %s!\n",
> +#ifdef HAVE_LIBCAP_SUPPORT
> +		"users with the SYS_ADMIN capability"
> +#else
> +		"root"
> +#endif

                );

:-)
 
>  		return -1;
>  	}
>  

I've pushed the whole set to my tmp.perf/cap branch, please chec

- Arnaldo
