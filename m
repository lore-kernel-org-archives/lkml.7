Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4744FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C59D218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/5A5PY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbfGZTKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:10:41 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:39854 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfGZTKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:10:41 -0400
Received: by mail-qt1-f173.google.com with SMTP id l9so53635317qtu.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gX3Eb+Fjvx8r5No+CO4k0lYtNXprjjGKTOuHlUYQHqU=;
        b=Z/5A5PY7jKNpx8muq/lBXWCc/tBIo+d73kBSLnbN1AtOx94n69lUZZJmwNDVOMUqtO
         7CJsl7KfqmBqVVBsdnXHTUJ/zKzLkkHbMkn56EH5ANHwjwucJ7GeSfRvQ1Brd1nuoCX9
         MohYl6xeOveKsfmuY/xFNai6AnVodsRXUgCCfHrQyloPmvnuTHr4SIO+whYeHBG0wPGX
         U3RF8/hVVEABrImG3jd1Tb5qLnQv4zuOclzlum7o1MHz6hQeC41hScHwmqeJHOj5h4fq
         GpWOQvyImtpZRwwnIiAbsFAprlQbwZOzQ0OREzNlhK0+oM10LyjzYKgl49HhgON5ojeO
         DULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gX3Eb+Fjvx8r5No+CO4k0lYtNXprjjGKTOuHlUYQHqU=;
        b=E9JKVJ+YfjMIjARwS3A20jRubg54Xb8SA+BDU6aJn/vAFx2RvL3HWfB/LX/G8SiJNq
         VWS7/tyVdWb6CnLWvadJn5QQR9qz6csMGm8KilTqk1ixz9FxC2YG4JrvMwiUloXK011J
         PH0RbUwkO9rSFK+IieDUzWoX9dSUOY3yxvavXXL9Xf6f7XAwuY8BWAJ7ZAiGrWrAwxhV
         wWKGOrbdZzPkGQNgxduk02MqUQvjB6Tbxb9Ob+vzgcldoQlJB4ucbrKj9mVMlE74m6ZJ
         hHQjfX0aeJVU/eGXhz4MR7AGKdbxicWVo5sjoSsXhLTLev0ucDdwih5OO+LfHBCib6ME
         lQUA==
X-Gm-Message-State: APjAAAVRSSc1V8Lkg36aDDagvltp8pLz0m1kMOYPAfXLt2HlYXQRFyH4
        /XsJtCzN981D8ssJQv8lyVo=
X-Google-Smtp-Source: APXvYqw267p/YeI+cxFK6b9kPG6Z9A5iK6AR+9TjG1o1WqG72vuLi+L9VID4XKne3teQLO0M8Rd02Q==
X-Received: by 2002:ac8:374b:: with SMTP id p11mr66461662qtb.316.1564168240415;
        Fri, 26 Jul 2019 12:10:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p59sm25060392qtd.75.2019.07.26.12.10.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:10:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B95BC40340; Fri, 26 Jul 2019 16:10:37 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:10:37 -0300
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf report segfault with 0-sized strings
Message-ID: <20190726191037.GE20482@kernel.org>
References: <alpine.DEB.2.21.1907251423410.22624@macbook-air>
 <alpine.DEB.2.21.1907251501290.22624@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907251501290.22624@macbook-air>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 25, 2019 at 03:04:32PM -0400, Vince Weaver escreveu:
> 
> probably all perf_header_strings are affected by this.  The fuzzer just 
> tripped up cmdline now, which needs this fix.

I think we have to catch this earlier, i.e. when processing each
feature, lemme check...

- Arnaldo
 
> Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index c24db7f4909c..631aa1911f3a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1427,6 +1430,8 @@ static void print_cmdline(struct feat_fd *ff, FILE *fp)
>  
>  	fprintf(fp, "# cmdline : ");
>  
> +	if (ff->ph->env.cmdline_argv==NULL) return;
> +
>  	for (i = 0; i < nr; i++) {
>  		char *argv_i = strdup(ff->ph->env.cmdline_argv[i]);
>  		if (!argv_i) {

-- 

- Arnaldo
